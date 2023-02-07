package Model.Type;

import Model.Value.Value;
import Model.Value.StringValue;

public class StringType implements Type{

    public boolean equals(Object another){
        if(another instanceof  StringType)
            return true;
        else
            return false;
    }

    public String toString(){
        return "string";
    }
    @Override
    public Value defaultValue() {
        return new StringValue("");
    }

    @Override
    public Type deepCopy() {
        return new StringType();
    }
}
