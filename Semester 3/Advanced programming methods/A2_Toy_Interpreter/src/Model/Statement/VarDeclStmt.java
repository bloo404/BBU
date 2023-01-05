package Model.Statement;

import Exceptions.MyException;
import Model.ADTs.MyIDictionary;
import Model.ADTs.MyIStack;
import Model.ADTs.PrgState;
import Model.Type.IntType;
import Model.Type.Type;
import Model.Value.Value;

public class VarDeclStmt implements IStmt{
	String name;
	Type typ;

	public VarDeclStmt(String v, Type intType) {
		this.name = v;
		this.typ = intType;
	}

	@Override
	public PrgState execute(PrgState state) throws MyException {
		MyIStack<IStmt> stk = state.getStk();
		MyIDictionary<String, Value> symTbl = state.getSymTable();
		symTbl.add(this.getName(), this.typ.defaultValue());
		return state;
	}

	@Override
	public IStmt deepCopy() {
		return new VarDeclStmt(name,typ.deepCopy());
	}

	@Override
	public String toString() {
		return typ + " " + name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Type getTyp() {
		return typ;
	}

	public void setTyp(Type typ) {
		this.typ = typ;
	}

	private String getName() {
		return this.name;
	}
}
