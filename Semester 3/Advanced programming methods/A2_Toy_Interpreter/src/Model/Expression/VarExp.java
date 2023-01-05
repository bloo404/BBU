package Model.Expression;

import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.Value.Value;

public class VarExp implements Exp {
	String id;

    public VarExp(String v) {
		this.id = v;
    }

    @Override
	public Value eval(MyIDictionary<String, Value> tbl) throws MyException {
		if(!tbl.isDefined(id))
			throw new MyException("Var not defined");
		return tbl.lookup(id);
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return id;
	}

	public Exp deepCopy(){
		return new VarExp(id);
	}
}
