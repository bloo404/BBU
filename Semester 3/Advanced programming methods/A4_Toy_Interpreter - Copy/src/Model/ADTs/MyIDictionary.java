package Model.ADTs;

import Exceptions.DictionaryException;
import Exceptions.MyException;

import java.util.HashMap;
import java.util.Map;

public interface MyIDictionary<K,V> {
    void add(K key, V value);
    V remove(K key) throws MyException, DictionaryException;
    boolean isDefined(K id);
    V lookup(K id);
    void update(K key, V value);

    public HashMap<K, V> getContent();
}
