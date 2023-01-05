package Model.Statement;

import Exceptions.MyException;
import Model.ADTs.MyIStack;
import Model.ADTs.PrgState;

public class CompStmt implements IStmt {
	IStmt first;
	IStmt second;

    public CompStmt(IStmt v, IStmt v1) {
		this.first = v;
		this.second = v1;
    }

	public String toString() {
		return "(" + first.toString() + ";" + second.toString() + ")"; 
	} 
	
	@Override
	public PrgState execute(PrgState state)  throws MyException{
		MyIStack<IStmt> stk=state.getStk();
		stk.push(second);          
		stk.push(first);
		return state;
	}

	@Override
	public IStmt deepCopy() {
		return new CompStmt(first.deepCopy(),second.deepCopy());
	}


}
