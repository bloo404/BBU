package Model.Expression;

import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.ADTs.MyIHeap;
import Model.Type.Type;
import Model.Value.IntValue;
import Model.Value.Value;

public class ValueExp implements Exp {
	Value e;

    public ValueExp(Value intValue) {
		this.e = intValue;
    }

    @Override
	public Value eval(MyIDictionary<String, Value> tbl, MyIHeap heap) throws MyException {
		return e;
	}

	@Override
	public Type typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
		return e.getType();
	}

	@Override
	public String toString() {
		return "ValueExp{" +
				"e=" + e +
				'}';
	}

	public Exp deepCopy(){
		return new ValueExp(e.deepCopy());
	}
}
