package Model.Statement;

import Exceptions.HeapException;
import Exceptions.MyException;
import Exceptions.StackException;
import Model.ADTs.MyIDictionary;
import Model.ADTs.MyIStack;
import Model.ADTs.PrgState;
import Model.Expression.Exp;
import Model.Expression.LogicExp;
import Model.Expression.RelExp;
import Model.Expression.ValueExp;
import Model.Type.BoolType;
import Model.Type.Type;
import Model.Value.BoolValue;
import Model.Value.IntValue;

import java.io.IOException;

public class repeatUntilStmt implements IStmt{

    IStmt action;
    Exp condition;

    public repeatUntilStmt(IStmt act, Exp cond){
        this.condition = cond;
        this.action = act;
    };

    @Override
    public PrgState execute(PrgState state) throws MyException, IOException, HeapException, StackException {
        MyIStack<IStmt> mother = state.getStk();
        //ex the pope is in prgState in OneStep so it is not needed here anymore
        IStmt child = new CompStmt(action, new WhileStmt(new LogicExp(2,condition,new ValueExp(new BoolValue(true))),action));
        mother.push(child);
        return null;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type type1 = condition.typecheck(typeEnv);
        if (type1.equals(new BoolType())) {
            action.typecheck(typeEnv);
            return typeEnv;
        } else throw new MyException("REPEAT UNTIl: typechecker: EXPression not bull");
    }

    @Override
    public IStmt deepCopy() {
        return new repeatUntilStmt(action.deepCopy(), condition.deepCopy());
    }

    @Override
    public String toString() {
        return "repeatStmt{" +
                "action=" + action +
                ", condition=" + condition +
                '}';
    }
}
