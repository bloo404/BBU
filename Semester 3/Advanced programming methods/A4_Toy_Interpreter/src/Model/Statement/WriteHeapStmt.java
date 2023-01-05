package Model.Statement;

import Exceptions.HeapException;
import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.ADTs.MyIHeap;
import Model.ADTs.PrgState;
import Model.Expression.Exp;
import Model.Value.RefValue;
import Model.Value.Value;

import java.io.IOException;

public class WriteHeapStmt implements IStmt{

    String varName;
    Exp expression;

    public WriteHeapStmt(String varName, Exp expression) {
        this.varName = varName;
        this.expression = expression;
    }

    @Override
    public PrgState execute(PrgState state) throws MyException, IOException, HeapException {
        MyIDictionary<String, Value> symTable = state.getSymTable();
        MyIHeap heap = state.getHeap();
        if (!symTable.isDefined(varName))
            throw new MyException(String.format("%s not present in the symTable", varName));
        Value value = symTable.lookup(varName);
        if (!(value instanceof RefValue))
            throw new MyException(String.format("%s not of RefType", value));
        RefValue refValue = (RefValue) value;
        Value evaluated = expression.eval(symTable, heap);
        if (!evaluated.getType().equals(refValue.getLocationType()))
            throw new MyException(String.format("%s not of %s", evaluated, refValue.getLocationType()));
        heap.update(refValue.getAddress(), evaluated);
        state.setHeap(heap);
        return null;
    }

    @Override
    public IStmt deepCopy() {
        return new WriteHeapStmt(varName, expression.deepCopy());
    }

    public String toString() {
        return String.format("WriteHeap(%s, %s)", varName, expression);
    }
}
