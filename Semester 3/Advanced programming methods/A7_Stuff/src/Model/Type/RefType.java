package Model.Type;

import Model.Value.RefValue;
import Model.Value.Value;

public class RefType implements Type{
    Type inner;

    public RefType(Type inner){
        this.inner = inner;
    }

    public Type getInner(){
        return this.inner;
    }

    public void setInner(Type inner) {
        this.inner = inner;
    }

    public boolean equals(Object anotherType) {
        if (anotherType instanceof RefType)
            return inner.equals(((RefType) anotherType).getInner());
        else
            return false;
    }
    @Override
    public Value defaultValue() {
        return new RefValue(0, inner);
    }

    @Override
    public Type deepCopy() {
        return new RefType(inner.deepCopy());
    }

    public String toString() {
        return String.format("Ref(%s)", inner);
    }
}
