package Model.Statement;

import Exceptions.MyException;
import Model.ADTs.PrgState;

public class NopStmt implements IStmt{

	@Override
	public PrgState execute(PrgState state) throws MyException {
		return state;
	}

	@Override
	public IStmt deepCopy() {
		return new NopStmt();
	}

	public String toString(){return super.toString();}
	
}
