package Model.Expression;

import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.ADTs.MyIHeap;
import Model.Value.Value;

public interface Exp {
	Value eval(MyIDictionary<String,Value> tbl, MyIHeap heap) throws MyException;

	public Exp deepCopy();
}
