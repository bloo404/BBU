package Model.Expression;

import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.ADTs.MyIHeap;
import Model.Value.Value;

public class LogicExp implements Exp {
	Exp e1;
	Exp e2;
	int op;

	public LogicExp(int op, Exp e1, Exp e2) {
		this.op = op;
		this.e1 = e1;
		this.e2 = e2;
	}

	@Override
	public Value eval(MyIDictionary<String, Value> tbl, MyIHeap heap) throws MyException {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Exp deepCopy() {
		return new LogicExp(op, e1.deepCopy(),e2.deepCopy());
	}

	@Override
	public String toString() {
		return "LogicExp{" +
				"e1=" + e1 +
				", e2=" + e2 +
				", op=" + op +
				'}';
	}
}
