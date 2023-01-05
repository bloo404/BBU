package Model.Statement;

import Controller.Controller;
import Exceptions.MyException;
import Model.ADTs.*;
import Model.Expression.Exp;
import Model.Type.RefType;
import Model.Type.Type;
import Model.Value.RefValue;
import Model.Value.StringValue;
import Model.Value.Value;
import Repository.IRepository;

import java.io.BufferedReader;
import java.io.IOException;

public class NewStmt implements IStmt{
    String varName;
    Exp ex;

    public NewStmt(String varName, Exp expression){
        this.varName = varName;
        this.ex = expression;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException, IOException {
        MyIStack<IStmt> stk = state.getStk();
        MyIDictionary<String, Value> symTbl = state.getSymTable();
        MyIHeap hp = state.getHeap();

        Type varType = (symTbl.lookup(varName)).getType();

        if (symTbl.isDefined(varName) && varType instanceof RefType) {
            Value v = ex.eval(symTbl, hp);
            Type valType = v.getType();

            RefValue refv = (RefValue) symTbl.lookup(varName);
            Type reft = refv.getLocationType();

            if (reft.equals(valType)) {
                Integer addr = hp.getFreeLocationValue();
                hp.add(v);
                valType = v.getType();
                RefValue newAddr = new RefValue(addr, valType);
                symTbl.update(varName, newAddr);
            } else {
                throw new MyException("Variables not of the same type");
            }
        } else {
            throw new MyException("Variable not declared or not of Ref type");
        }
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return null;
    }

    @Override
    public String toString() {
        return "NewStmt{" +
                "varName='" + varName + '\'' +
                ", ex=" + ex +
                '}';
    }
}
