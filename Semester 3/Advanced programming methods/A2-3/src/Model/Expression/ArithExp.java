package Model.Expression;

import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.Type.IntType;
import Model.Value.IntValue;
import Model.Value.Value;

public class ArithExp implements Exp {
	Exp e1;
	Exp e2;
	int op; // 1-plus, 2-minus, 3-product, 4-divide

	public char convertOperation(int op){
		if(op == 1) return '+';
		if(op == 2) return '-';
		if(op == 3) return '*';
		if(op == 4) return '/';
		return ' ';
	}
    public ArithExp(char c, Exp valueExp, Exp valueExp1) {
		if(c == '+')
			this.op = 1;
		if(c == '-')
			this.op = 2;
		if(c == '*')
			this.op = 3;
		if(c == '/')
			this.op = 4;
		this.e1 = valueExp;
		this.e2 = valueExp1;
    }

    public Value eval(MyIDictionary<String, Value> tbl) throws MyException {
		Value v1,v2;
		v1 = e1.eval(tbl);
		if(v1.getType().equals(new IntType())) {
			v2 = e2.eval(tbl);
			if(v2.getType().equals(new IntType())) {
				IntValue i1 = (IntValue)v1;
				IntValue i2 = (IntValue)v2;
				int n1,n2;
				n1 = i1.getVal();
				n2 = i2.getVal();
				if(op==1) return new IntValue(n1 + n2);
				if(op==2) return new IntValue(n1 - n2);
				if(op==3) return new IntValue(n1 * n2);
				if(op==4) 
					if(n2!=0)
						return new IntValue(n1 / n2);
					else throw new MyException("division by zero");
			}
			else throw new MyException("second operand is not an integer");
		}
		else throw new MyException("first operand is not an integer");
		return v1;
	}

	@Override
	public String toString() {
		return "ArithExp{" +
				"e1=" + e1 +
				", e2=" + e2 +
				", op=" + op +
				'}';
	}

	public Exp deepCopy(){
		return new ArithExp(convertOperation(op),e1.deepCopy(),e2.deepCopy());
	}
}
