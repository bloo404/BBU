package Model.Statement;

import Exceptions.HeapException;
import Exceptions.MyException;
import Exceptions.PairException;
import Exceptions.StackException;
import Model.ADTs.MyIDictionary;
import Model.ADTs.MyIHeap;
import Model.ADTs.PrgState;
import Model.Expression.Exp;
import Model.Type.BoolType;
import Model.Type.Type;
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
	public PrgState execute(PrgState state) throws MyException, IOException, HeapException, StackException, PairException {
		MyIDictionary<String, Value> symTbl = state.getSymTable();
		MyIHeap heap = state.getHeap();
		BoolValue v = (BoolValue) exp.eval(symTbl,heap);
		boolean val = v.getVal();
		if(val)
			thenS.execute(state);
		else
			elseS.execute(state);
		return null;
	}

	@Override
	public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
		Type typexp = exp.typecheck(typeEnv);
		if (typexp.equals(new BoolType())) {
			thenS.typecheck(typeEnv.deepCopy());
			elseS.typecheck(typeEnv.deepCopy());
			return typeEnv;
		} else
			throw new MyException("The condition of IF has not the type bool");
	}

	@Override
	public IStmt deepCopy() {
		return new IfStmt(exp.deepCopy(),thenS.deepCopy(),elseS.deepCopy());
	}

}
