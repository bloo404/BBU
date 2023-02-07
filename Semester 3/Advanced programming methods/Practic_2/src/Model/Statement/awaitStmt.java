package Model.Statement;

import Exceptions.HeapException;
import Exceptions.MyException;
import Exceptions.PairException;
import Exceptions.StackException;
import Model.ADTs.MyIDictionary;
import Model.ADTs.MyIStack;
import Model.ADTs.PrgState;
import Model.Expression.VarExp;
import Model.Type.IntType;
import Model.Type.Type;
import Model.Value.IntValue;
import Model.Value.Value;
import javafx.util.Pair;

import java.io.IOException;
import java.util.List;
import java.util.concurrent.locks.ReentrantLock;


public class awaitStmt implements IStmt{

    String var;
    ReentrantLock rl = new ReentrantLock();

    public awaitStmt(String v){
        this.var = v;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException, IOException, HeapException, StackException, PairException {
        MyIStack<IStmt> da_stash = state.getStk();
        /// no need to pop because the pop is done in prgState
        Value foundIndex = state.getSymTable().lookup(var);
        IntValue val = (IntValue) foundIndex;
        if (foundIndex.getType() instanceof IntType) {
            Integer nr = val.getVal();
            if (!state.getSymTable().isDefined(var))
                throw new MyException("AWAIT STMT: Var is not defined in symtable");
            else if (!state.getBar().isDefined(nr))
                throw new MyException("AWAIT STMT: Var not defined in barrier!");
            else {
                Pair<Integer, List<Integer>> element = state.getBar().get(nr);
                Integer nl = element.getValue().size();
                if (element.getKey() > nl) {
                    if (element.getValue().contains(state.getId())) {
                        da_stash.push(new awaitStmt(var));
                    } else {
                        element.getValue().add(state.getId());
                        da_stash.push(new awaitStmt(var));
                    }
                }
            }
        } else { throw new MyException("awaitStmt: not int.");

        }
        return null;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        VarExp ourVar = new VarExp(var);
        ourVar.typecheck(typeEnv);
        return typeEnv;
    }

    @Override
    public IStmt deepCopy() {
        return null;
    }

    @Override
    public String toString() {
        return "awaitStmt{" +
                "var='" + var + '\'' +
                ", rl=" + rl +
                '}';
    }
}
