package Model.Statement;

import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.ADTs.MyIStack;
import Model.ADTs.PrgState;
import Model.Type.Type;

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
		return null;
	}

	@Override
	public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
		   // MyIDictionary<String,Type> typEnv1 = first.typecheck(typeEnv);
		   // MyIDictionary<String,Type> typEnv2 = second.typecheck(typEnv1);
		   // return typEnv2;
		   return second.typecheck(first.typecheck(typeEnv));
	}

	@Override
	public IStmt deepCopy() {
		return new CompStmt(first.deepCopy(),second.deepCopy());
	}


}
