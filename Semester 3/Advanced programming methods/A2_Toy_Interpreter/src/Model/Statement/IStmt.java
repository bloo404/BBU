package Model.Statement;

import Exceptions.MyException;
import Model.ADTs.PrgState;

import java.io.IOException;

public interface IStmt {
	public PrgState execute(PrgState state) throws MyException, IOException;

	public IStmt deepCopy();
}
