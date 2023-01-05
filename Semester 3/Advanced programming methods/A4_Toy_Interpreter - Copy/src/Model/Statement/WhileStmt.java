package Model.Statement;

import Exceptions.HeapException;
import Exceptions.MyException;
import Exceptions.StackException;
import Model.ADTs.*;
import Model.Expression.Exp;
import Model.Type.BoolType;
import Model.Value.BoolValue;
import Model.Value.StringValue;
import Model.Value.Value;

import java.io.BufferedReader;
import java.io.IOException;

public class WhileStmt implements IStmt{
    Exp exp;

    public WhileStmt(Exp e){
        this.exp = e;
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
                stk.pop();
                stack2 = stk;
            } else {
                stack2 = stk;
                IStmt popped = stk.pop();
                stack2.push(popped);
                stack2.push(new WhileStmt(exp));
                stack2.push(popped);
            }
        } else {
            throw new MyException("Condition exp is not a boolean");
        }
        state.setExeStack(stack2);

        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new WhileStmt(exp.deepCopy());
    }

    @Override
    public String toString() {
        return "while(" + exp + ")";
    }
}