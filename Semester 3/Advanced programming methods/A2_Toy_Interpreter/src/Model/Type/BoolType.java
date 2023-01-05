package Model.Type;

import Model.Value.BoolValue;
import Model.Value.Value;

public class BoolType implements Type{

    public boolean equals(Object another){
        if(another instanceof BoolType)
            return true;
        return false;
    }
    @Override
    public Value defaultValue() {
        return new BoolValue(false);
    }

    @Override
    public String toString() {
        return "BoolType{}";
    }

    @Override
    public Type deepCopy() {
        return new BoolType();
    }
}
