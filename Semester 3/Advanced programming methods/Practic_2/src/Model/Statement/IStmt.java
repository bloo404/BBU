package Model.Statement;

import Exceptions.HeapException;
import Exceptions.MyException;
import Exceptions.PairException;
import Exceptions.StackException;
import Model.ADTs.MyIDictionary;
import Model.ADTs.PrgState;
import Model.Type.Type;

import java.io.IOException;

public interface IStmt {
	public PrgState execute(PrgState state) throws MyException, IOException, HeapException, StackException, PairException;

	MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException;

	public IStmt deepCopy();
}
