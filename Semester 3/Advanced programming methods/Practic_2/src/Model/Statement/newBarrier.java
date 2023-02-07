package Model.Statement;

import Exceptions.HeapException;
import Exceptions.MyException;
import Exceptions.StackException;
import Model.ADTs.MyICycBar;
import Model.ADTs.MyIDictionary;
import Model.ADTs.MyIStack;
import Model.ADTs.PrgState;
import Model.Expression.Exp;
import Model.Expression.ValueExp;
import Model.Expression.VarExp;
import Model.Type.IntType;
import Model.Type.Type;
import Model.Value.IntValue;
import Model.Value.Value;
import javafx.util.Pair;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.locks.ReentrantLock;

public class newBarrier implements IStmt{
    String var;
    Exp exp;
    ReentrantLock rl = new ReentrantLock();

    public newBarrier(String v, Exp e){
        this.var = v;
        this.exp = e;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException, IOException, HeapException, StackException {
        MyIStack<IStmt> s = state.getStk();
        MyIDictionary<String, Value> symTbl = state.getSymTable();
        MyICycBar bar = state.getBar();
        Value number = exp.eval(symTbl, state.getHeap());
        IntValue nr = (IntValue) number;
        if (number.getType() instanceof IntType) {
            Integer n = nr.getVal();
            List<Integer> newList = new LinkedList<>();
            Pair<Integer, List<Integer>> p = new Pair<>(n, newList);
            bar.add(p);
            if (symTbl.isDefined(var)) {
                IntValue spot = new IntValue(bar.getFreeSpot());
                symTbl.update(var, spot);
            } else {
                rl.lock();
                try {
                    IntValue spot = new IntValue(bar.getFreeSpot());
                    symTbl.add(var, spot);
                } finally {
                    rl.unlock();
                }
            }
        }
        else{
            throw new MyException("New barrier: Type not int.");
        }
        return null;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        exp.typecheck(typeEnv);
        VarExp varExp = new VarExp(var);
        varExp.typecheck(typeEnv);
        return typeEnv;
    }

    @Override
    public IStmt deepCopy() {
        return new newBarrier(var,exp.deepCopy());
    }

    @Override
    public String toString() {
        return "newBarrier{" +
                "var='" + var + '\'' +
                ", exp=" + exp +
                ", rl=" + rl +
                '}';
    }
}
