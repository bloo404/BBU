package Model.ADTs;

import Exceptions.HeapException;
import Model.Value.Value;

import java.util.HashMap;
import java.util.Set;

public interface MyIHeap {
    int getFreeValue();

    HashMap<Integer, Value> getContent();

    public void setContent(HashMap<Integer, Value> newMap);

    int add(Value value);

    void update(Integer position, Value value) throws HeapException;

    Value get(Integer position) throws HeapException;

    boolean containsKey(Integer position);

    void remove(Integer key) throws HeapException;

    Set<Integer> keySet();

    boolean isDefined(Integer addr);


    Value lookup(Integer addr);

    public void setHeap(HashMap<Integer, Value> heap);

    public HashMap<Integer, Value> getHeap();

    public void setFreeLocationValue(Integer freeLocationValue);

    public Integer getFreeLocationValue();
}
