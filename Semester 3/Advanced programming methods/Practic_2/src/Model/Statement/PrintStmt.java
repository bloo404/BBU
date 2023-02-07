package Model.Statement;

import Exceptions.MyException;
import Model.ADTs.*;
import Model.Expression.Exp;
import Model.Expression.VarExp;
import Model.Type.Type;
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
		state.setOut(out);
		return null;
	}

	@Override
	public MyIDictionary<String, Type> typecheck(MyIDictionary<String, Type> typeEnv) throws MyException {
		exp.typecheck(typeEnv);
		return typeEnv;
	}

	@Override
	public IStmt deepCopy() {
		return new PrintStmt(exp.deepCopy());
	}

}
