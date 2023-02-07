package Model.Statement;

import Exceptions.HeapException;
import Exceptions.MyException;
import Exceptions.StackException;
import Model.ADTs.*;
import Model.Type.Type;
import Model.Value.Value;

import java.io.IOException;
import java.util.Map;

public class forkStmt implements IStmt{
    IStmt stmt;

    public forkStmt(IStmt statement){
        this.stmt = statement;
    }

    @Override
    public String toString() {
        return "forkStmt{" +
                "stmt=" + stmt +
                '}';
    }

    @Override
    public PrgState execute(PrgState state) throws MyException, IOException, HeapException, StackException {
        MyIStack<IStmt> stk = new MyStack<>();
        stk.push(this.stmt);
        MyIDictionary<String, Value> newSymTbl = new MyDictionary<>();
        for(Map.Entry<String,Value> entry: state.getSymTable().getContent().entrySet()){
            newSymTbl.add(entry.getKey(),entry.getValue().deepCopy());
        }
        PrgState newState = new PrgState(stk,newSymTbl,state.getOut(),state.getFileTable(), state.getHeap(), stk.pop(), state.getBar());
        return newState;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        stmt.typecheck(typeEnv.deepCopy());
        return typeEnv;
    }

    @Override
    public IStmt deepCopy() {
        return null;
    }
}
