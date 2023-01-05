package Model.Value;

import Model.Type.Type;
import Model.Type.RefType;

public class RefValue implements Value{
    int address;
    Type locationType;

    public RefValue(int address, Type locationType){
        this.address = address;
        this.locationType = locationType;
    }

    @Override
    public Type getType() {
        return new RefType(locationType);
    }

    public int getAddress(){
        return address;
    }

    public Type getLocationType(){
        return locationType;
    }

    @Override
    public Value deepCopy() {
        return new RefValue(address, locationType.deepCopy());
    }

    public String toString() {
        return String.format("(%d, %s)", address, locationType);
    }
}
