package Model.Statement;

import Exceptions.MyException;
import Model.ADTs.IFileTable;
import Model.ADTs.MyIDictionary;
import Model.ADTs.MyIStack;
import Model.ADTs.PrgState;
import Model.Expression.Exp;
import Model.Value.StringValue;
import Model.Value.Value;

import java.io.BufferedReader;
import java.io.IOException;

public class closeRFile implements IStmt{

    Exp exp;

    public closeRFile(Exp exp) {
        this.exp = exp;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException, IOException {
        MyIStack<IStmt> stk = state.getStk();
        MyIDictionary<String, Value> symTbl = state.getSymTable();
        IFileTable<StringValue, BufferedReader> fileTbl = state.getFileTable();

        //stk.pop();
        Value val = exp.eval(symTbl);
        StringValue s = new StringValue("");

        if(val.getType().equals(s.getType())){
            s = (StringValue) val;
            if(fileTbl.isDefined(s)){
                BufferedReader obj = fileTbl.lookup(s);
                fileTbl.remove(s);
                obj.close();
            } else {
                throw new MyException("No entry for value");
            }
        } else {
            throw new MyException("Not a string value");
        }

        return state;
    }

    @Override
    public IStmt deepCopy() {
        return null;
    }

    @Override
    public String toString() {
        return exp.toString();
    }
}
