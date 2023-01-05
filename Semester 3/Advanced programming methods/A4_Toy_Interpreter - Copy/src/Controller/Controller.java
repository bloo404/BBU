package Controller;

import Exceptions.*;
import Model.ADTs.MyIStack;
import Model.ADTs.PrgState;
import Model.Statement.IStmt;
import Model.Value.RefValue;
import Model.Value.Value;
import Repository.IRepository;
import Repository.Repository;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class Controller implements IController{
    IRepository repo;
    public Controller(IRepository repo){
        this.repo = repo;
    }

    @Override
    public PrgState oneStep(PrgState state) throws MyException, ControllerException, StackException, IOException, HeapException {
        MyIStack<IStmt> stk = state.getStk();
        if(stk.isEmpty())
            throw new ControllerException("PrgState stack is empty");
        IStmt crtStmt = stk.pop();
        return crtStmt.execute(state);
    }

    @Override
    public void allStep() throws MyException, IOException, ControllerException, StackException, RepositoryException, HeapException {
        PrgState prg = repo.getCrtPrg();
        repo.logPrgStateExec();
        while(!prg.getStk().isEmpty()){
            oneStep(prg);
            repo.logPrgStateExec();
            prg.getHeap().setContent((HashMap<Integer, Value>) safeGarbageCollector(getAddrFromSymTable(prg.getSymTable().getContent().values()),
                    getAddrFromHeapTable(prg.getHeap().getContent().values()),
                    prg.getHeap().getContent()));
            /* if(flag)
              System.out.println(prg.toString());
             */
        }
    }

    Map<Integer, Value> unsafeGarbageCollector(List<Integer> symTableAddr, Map<Integer, Value> heap){
        return heap.entrySet().stream()
                .filter(e->symTableAddr.contains(e.getKey()))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
    }

    List<Integer> getAddrFromSymTable(Collection<Value> symTableValues){
        return symTableValues.stream()
                .filter(v->v instanceof RefValue)
                .map(v-> {RefValue v1 = (RefValue) v; return v1.getAddress();})
                .collect(Collectors.toList());
    }

    List<Integer> getAddrFromHeapTable(Collection<Value> heapTableValues){
        return heapTableValues.stream()
                .filter(v->v instanceof RefValue)
                .map(v-> {RefValue v1 = (RefValue) v; return  v1.getAddress();})
                .collect(Collectors.toList());
    }

    Map<Integer, Value> safeGarbageCollector(List<Integer> symTableAddr, List<Integer> heapTableAddr, Map<Integer, Value> heap){
        return heap.entrySet().stream()
                .filter(e->symTableAddr.contains(e.getKey()) || heapTableAddr.contains(e.getKey()))
                .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
    }

}
