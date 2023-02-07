package Model.Type;

import Model.Value.Value;

public interface Type {
    public String toString();
    Value defaultValue();
    Type deepCopy();
}
