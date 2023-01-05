package Model.Statement;

import Exceptions.MyException;
import Model.ADTs.*;
import Model.Expression.Exp;
import Model.Expression.VarExp;
import Model.Value.Value;

public class PrintStmt implements IStmt{
	Exp exp;

    public PrintStmt(Exp v) {
		this.exp = v;
    }

    public String toString(){
		return "print(" + exp.toString() + ")";
	}
	
	public PrgState execute(PrgState state) throws MyException{
		MyIStack<IStmt> stk = state.getStk();
		MyIDictionary<String, Value> symTbl = state.getSymTable();
		MyIList<Value> out = state.getOut();
		MyIHeap hp = state.getHeap();
		Exp e = this.exp;
		out.add(e.eval(symTbl,hp));
//		System.out.println(symTbl.lookup(e.toString()));
		return state;
	}

	@Override
	public IStmt deepCopy() {
		return new PrintStmt(exp.deepCopy());
	}

}
