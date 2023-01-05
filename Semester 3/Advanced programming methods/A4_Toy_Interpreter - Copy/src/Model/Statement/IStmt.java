package Model.Statement;

import Exceptions.HeapException;
import Exceptions.MyException;
import Exceptions.StackException;
import Model.ADTs.PrgState;

import java.io.IOException;

public interface IStmt {
	public PrgState execute(PrgState state) throws MyException, IOException, HeapException, StackException;

	public IStmt deepCopy();
}
