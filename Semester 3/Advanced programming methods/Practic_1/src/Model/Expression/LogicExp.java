package Model.Expression;

import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.ADTs.MyIHeap;
import Model.Type.BoolType;
import Model.Type.IntType;
import Model.Type.Type;
import Model.Value.BoolValue;
import Model.Value.IntValue;
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
		Value v1, v2;
		v1 = e1.eval(tbl,heap);

		if(v1.getType().equals(new BoolType())){
			v2 = e2.eval(tbl,heap);
			if(v2.getType().equals(new BoolType())){

				BoolValue i1 = (BoolValue) v1;
				BoolValue i2 = (BoolValue) v2;

				boolean n1, n2;

				n1 = i1.getVal();
				n2 = i2.getVal();

				if(op == 1) return new BoolValue(n1 == n2);
				if(op == 2) return new BoolValue(n1 != n2);
				if(op == 3) return new BoolValue(n1 && n2);
				if(op == 4) return new BoolValue(n1 || n2);

			} else {
				throw new MyException("LOGIC EXP: eval: second operand not a bool");
			}
		} else {
			throw new MyException("LOGIC EXP: eval: first operand not a bool");
		}
		return new BoolValue(false);
	}

	@Override
	public Type typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
		Type typ1, typ2;
		typ1 = e1.typecheck(typeEnv);
		typ2 = e2.typecheck(typeEnv);
		if (typ1.equals(new BoolType())) {
			if (typ2.equals(new BoolType())) {
				return new BoolType();
			} else
				throw new MyException("second operand is not an boolean");
		}else throw new MyException("first operand is not an boolean");
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

	String convertOperation(int op){
		if(op == 1) return "==";
		if(op == 2) return "!=";
		if(op == 3) return "&&";
		if(op == 4) return "||";

		return "";
	}
}
