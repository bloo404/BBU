package Model.Value;

import Model.Type.Type;
import Model.Type.StringType;

public class StringValue implements Value {
    String str;

    public StringValue(String text){str = text;}

    public String getStr(){return str;}

    public String toString(){
        return "string:" + str;
    }

    public boolean equals(Object another){
        if(another instanceof StringValue)
            return true;
        return false;
    }

    @Override
    public Type getType() {
        return new StringType();
    }

    @Override
    public Value deepCopy() {
        return new StringValue(str);
    }
}
