package Model.Statement;

import Exceptions.MyException;
import Model.ADTs.*;
import Model.Expression.Exp;
import Model.Type.StringType;
import Model.Type.Type;
import Model.Value.StringValue;
import Model.Value.Value;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;

public class openRFile implements IStmt{

    Exp exp;

    public openRFile(Exp exp1) {
        this.exp = exp1;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException, FileNotFoundException {
        MyIStack<IStmt> stk = state.getStk();
        MyIDictionary<String, Value> symTbl = state.getSymTable();
        IFileTable<StringValue, BufferedReader> fileTbl = state.getFileTable();
        MyIHeap heap = state.getHeap();
        Value val = exp.eval(symTbl,heap);
        StringValue s = new StringValue("");

        if(val.getType().equals(s.getType())){
            s = (StringValue) val;
            BufferedReader fd = new BufferedReader(new FileReader(s.getStr()));
            if(!fileTbl.isDefined(s)){
                fileTbl.add(s, fd);
                state.setFileTable(fileTbl);
            } else{
                throw new MyException("String already in sym table");
            }
        }else{
            throw new MyException("Not a string type");
        }
        return null;
    }

    @Override
    public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        if (exp.typecheck(typeEnv).equals(new StringType()))
            return typeEnv;
        else
            throw new MyException("openRFfile exception: The file must have a string name. Try again.");
    }

    @Override
    public String toString() {
        return "(openFile " + exp.toString() + ")";
    }

    @Override
    public IStmt deepCopy() {
        return new openRFile(exp.deepCopy());
    }
}
