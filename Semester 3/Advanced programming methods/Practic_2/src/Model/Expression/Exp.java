package Model.Expression;

import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.ADTs.MyIHeap;
import Model.Type.Type;
import Model.Value.Value;

public interface Exp {
	Value eval(MyIDictionary<String,Value> tbl, MyIHeap heap) throws MyException;

	Type typecheck(MyIDictionary<String,Type> typeEnv) throws MyException;

	public Exp deepCopy();
}
