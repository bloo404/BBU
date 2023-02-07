package Model.ADTs;

import Exceptions.HeapException;
import Model.Value.Value;

import java.util.HashMap;
import java.util.Set;

public class MyHeap implements MyIHeap{
    HashMap<Integer, Value> heap;
    Integer freeLocationValue;

    public int newValue() {
        freeLocationValue = freeLocationValue + 1;
        while(freeLocationValue == 0 || heap.containsKey(freeLocationValue))
            freeLocationValue = freeLocationValue + 1;
        return freeLocationValue;
    }

    public MyHeap() {
        this.heap = new HashMap<>();
        freeLocationValue = 1;
    }

    @Override
    public int getFreeValue() {
        return freeLocationValue;
    }

    @Override
    public HashMap<Integer, Value> getContent() {
        return heap;
    }

    @Override
    public void setContent(HashMap<Integer, Value> newMap) {
        this.heap = newMap;
    }

    @Override
    public int add(Value value) {
        heap.put(freeLocationValue, value);
        Integer toReturn = freeLocationValue;
        freeLocationValue = newValue();
        return toReturn;
    }

    @Override
    public void update(Integer position, Value value) throws HeapException {
        if (!heap.containsKey(position))
            throw new HeapException(String.format("%d is not present in the heap", position));
        heap.put(position, value);
    }

    @Override
    public Value get(Integer position) throws HeapException {
        if (!heap.containsKey(position))
            throw new HeapException(String.format("%d is not present in the heap", position));
        return heap.get(position);
    }

    @Override
    public boolean containsKey(Integer position) {
        return this.heap.containsKey(position);
    }

    @Override
    public void remove(Integer key) throws HeapException {
        if (!containsKey(key))
            throw new HeapException(key + " is not defined.");
        freeLocationValue = key;
        this.heap.remove(key);
    }

    @Override
    public Set<Integer> keySet() {
        return heap.keySet();
    }

    @Override
    public boolean isDefined(Integer addr) {
        for(Integer addr2: heap.keySet()){
            if(addr2 == addr)
                return true;
        }
        return false;
    }

    @Override
    public Value lookup(Integer addr) {
        return heap.get(addr);
    }

    public String toString(){
        StringBuilder heapStringBuilder = new StringBuilder();
        for (int key: heap.keySet()) {
            heapStringBuilder.append(String.format("%d -> %s\n", key, heap.get(key)));
        }
        return heapStringBuilder.toString();
    }

    public HashMap<Integer, Value> getHeap() {
        return heap;
    }

    public void setHeap(HashMap<Integer, Value> heap) {
        this.heap = heap;
    }

    public Integer getFreeLocationValue() {
        return freeLocationValue;
    }

    public void setFreeLocationValue(Integer freeLocationValue) {
        this.freeLocationValue = freeLocationValue;
    }
}
