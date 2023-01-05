package Model.Statement;

import Exceptions.MyException;
import Model.ADTs.IFileTable;
import Model.ADTs.MyIDictionary;
import Model.ADTs.MyIStack;
import Model.ADTs.PrgState;
import Model.Expression.Exp;
import Model.Type.IntType;
import Model.Value.IntValue;
import Model.Value.StringValue;
import Model.Value.Value;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

public class readFile implements IStmt{

    Exp exp;
    String varName;

    public readFile(Exp e, String name){
        this.varName = name;
        this.exp = e;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException, IOException {
        MyIStack<IStmt> stk = state.getStk();
        MyIDictionary<String, Value> symTbl = state.getSymTable();
        IFileTable<StringValue, BufferedReader> fileTbl = state.getFileTable();

        if (symTbl.isDefined(varName) && symTbl.lookup(varName).getType().equals(new IntType())) {
            StringValue s = (StringValue) exp.eval(symTbl);
            // System.out.println(s.toString());
            BufferedReader objReader = new BufferedReader(new FileReader(s.getStr()));
            String line = objReader.readLine();
            if (line == null) {
                IntValue v = new IntValue(0);
            } else {
                IntValue val = new IntValue(0);
                val.setVal(Integer.parseInt(line));
                symTbl.update(varName, val);
            }
        } else {
            throw new MyException("Variable not in symTbl");
        }

        return state;
    }

    @Override
    public IStmt deepCopy() {
        return null;
    }

    @Override
    public String toString() {
        return exp.toString() + " " + varName;
    }
}
