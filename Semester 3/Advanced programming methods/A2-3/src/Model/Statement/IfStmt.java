package Model.Statement;

import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.ADTs.PrgState;
import Model.Expression.Exp;
import Model.Value.BoolValue;
import Model.Value.Value;

import java.io.IOException;

public class IfStmt implements IStmt{
	Exp exp;
	IStmt thenS;
	IStmt elseS;
	
	public IfStmt(Exp e, IStmt t, IStmt el){
		exp=e;
		thenS=t;
		elseS=el;
	}
	
	public String toString() {
		return "(IF(" + exp.toString() + ")THEN(" + thenS.toString()
		+ ")ELSE(" + elseS.toString() + "))";
	}

	@Override
	public PrgState execute(PrgState state) throws MyException, IOException {
		MyIDictionary<String, Value> symTbl = state.getSymTable();
		BoolValue v = (BoolValue) exp.eval(symTbl);
		boolean val = v.getVal();
		if(val)
			thenS.execute(state);
		else
			elseS.execute(state);
		return state;
	}

	@Override
	public IStmt deepCopy() {
		return new IfStmt(exp.deepCopy(),thenS.deepCopy(),elseS.deepCopy());
	}

}
