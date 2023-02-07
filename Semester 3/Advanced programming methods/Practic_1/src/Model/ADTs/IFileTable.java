package Model.ADTs;

import Exceptions.MyException;

import java.util.Map;

public interface IFileTable<K, V> {
    V remove(K key) throws MyException;

    void add(K key, V val);

    boolean isDefined(K id);

     public V lookup(K id);

    void update(K id,V val);

    Map<K, V> getContent();
}