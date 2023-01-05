package Controller;

import Exceptions.ControllerException;
import Exceptions.MyException;
import Exceptions.RepositoryException;
import Exceptions.StackException;
import Model.ADTs.MyIStack;
import Model.ADTs.PrgState;
import Model.Statement.IStmt;
import Repository.IRepository;
import Repository.Repository;

import java.io.IOException;

public class Controller implements IController{
    IRepository repo;
    public Controller(IRepository repo){
        this.repo = repo;
    }

    @Override
    public PrgState oneStep(PrgState state) throws MyException, ControllerException, StackException, IOException {
        MyIStack<IStmt> stk = state.getStk();
        if(stk.isEmpty())
            throw new ControllerException("PrgState stack is empty");
        IStmt crtStmt = stk.pop();
        return crtStmt.execute(state);
    }

    @Override
    public void allStep() throws MyException, IOException, ControllerException, StackException, RepositoryException {
        PrgState prg = repo.getCrtPrg();
        repo.logPrgStateExec();
        while(!prg.getStk().isEmpty()){
            oneStep(prg);
            repo.logPrgStateExec();
            // if(flag)
            //   System.out.println(prg.toString());
        }
    }
}
