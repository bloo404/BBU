package Model.Expression;

import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.ADTs.MyIHeap;
import Model.Type.RefType;
import Model.Type.Type;
import Model.Value.RefValue;
import Model.Value.Value;

public class ReadHeapExp implements Exp {
    Exp exp;

    public ReadHeapExp(Exp exp1) {
        this.exp = exp1;
    }

    @Override
    public Value eval(MyIDictionary<String, Value> tbl, MyIHeap heap) throws MyException {
        Value v = exp.eval(tbl, heap);
        if (v instanceof RefValue) {
            RefValue val = (RefValue) v;
            int addr = val.getAddress();
            if (heap.isDefined(addr)) {
                return heap.lookup(addr);
            } else {
                throw new MyException("Variable not defined.");
            }
        } else {
            throw new MyException("Value not a Ref Value");
        }
    }

    @Override
    public Type typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
        Type typ = exp.typecheck(typeEnv);
        if (typ instanceof RefType) {
            RefType reft = (RefType) typ;
            return reft.getInner();
        } else throw new MyException("the rH argument is not a Ref Type");
    }

    @Override
    public Exp deepCopy() {
        return new ReadHeapExp(exp.deepCopy());
    }

    @Override
    public String toString() {
        return "ReadHeapExp{" +
                "exp=" + exp +
                '}';
    }
}
