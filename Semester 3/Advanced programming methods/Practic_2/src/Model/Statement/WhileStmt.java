package Model.Statement;

import Exceptions.HeapException;
import Exceptions.MyException;
import Exceptions.StackException;
import Model.ADTs.*;
import Model.Expression.Exp;
import Model.Type.BoolType;
import Model.Type.Type;
import Model.Value.BoolValue;
import Model.Value.StringValue;
import Model.Value.Value;

import java.io.BufferedReader;
import java.io.IOException;

public class WhileStmt implements IStmt{
    Exp exp;
    IStmt stmt;

    public WhileStmt(Exp e, IStmt s){
        this.exp = e;
        this.stmt = s;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException, IOException, StackException {
        MyIStack<IStmt> stk = state.getStk();
        MyIDictionary<String, Value> symTbl = state.getSymTable();
        MyIList<Value> out = state.getOut();
        MyIHeap hp = state.getHeap();
        IFileTable<StringValue, BufferedReader> ft = state.getFileTable();
        Value val = exp.eval(symTbl, hp);
        MyIStack<IStmt> stack2 = new MyStack<>();

        if(val instanceof BoolValue){
            if(!((BoolValue) val).getVal()){
                // stk.pop();
                stack2 = stk;
            } else {
                stack2 = stk;
                stack2.push(new WhileStmt(exp, stmt));
                stack2.push(stmt);
            }
        } else {
            throw new MyException("WHILESTMT: Exp is not boolean.");
        }
        state.setExeStack(stack2);

        return null;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type typexp = exp.typecheck(typeEnv);
        if(typexp.equals(new BoolType())) {
            return typeEnv;
        } else throw new MyException("while: no bool given");
    }

    @Override
    public IStmt deepCopy() {
        return new WhileStmt(exp.deepCopy(), stmt.deepCopy());
    }

    @Override
    public String toString() {
        return "WhileStmt{" +
                "exp=" + exp +
                ", stmt=" + stmt +
                '}';
    }
}