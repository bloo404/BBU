package Model.Statement;

import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.ADTs.PrgState;
import Model.Type.Type;

public class NopStmt implements IStmt{

	@Override
	public PrgState execute(PrgState state) throws MyException {
		return null;
	}

	@Override
	public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
		return typeEnv;
	}

	@Override
	public IStmt deepCopy() {
		return new NopStmt();
	}

	@Override
	public String toString() {
		return "nop;";
	}
}
