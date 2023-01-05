package Model.Value;

import Model.Type.IntType;
import Model.Type.Type;

public class IntValue implements Value{

	int val;
	public IntValue(int v){
		val = v;
	}
	
	public int getVal() {
		return val;
	}

	public void setVal(int val1){this.val = val1;}
	
	public String toString() {
		return "int:" + val;
	}

	public boolean equals(Object another){
		if(another instanceof IntValue)
			return true;
		return false;
	}

	@Override
	public Type getType() {
		return new IntType();
	}

	@Override
	public Value deepCopy() {
		return new IntValue(val);
	}

}
