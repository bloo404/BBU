package Model.Value;

import Model.Type.BoolType;
import Model.Type.Type;

public class BoolValue implements Value{

	boolean b;
	public BoolValue(boolean b) {
		this.b = b;
	}

	public boolean equals(Object another){
		if(another instanceof BoolValue)
			return true;
		return false;
	}

	@Override
	public String toString() {
		return b + "";
	}

	public boolean getVal(){
		return this.b;
	}

	@Override
	public Type getType() {
		return new BoolType();
	}

	@Override
	public Value deepCopy() {
		return new BoolValue(b);
	}

}
