package Model.ADTs;

import Exceptions.DictionaryException;
import Exceptions.MyException;
import Model.Value.Value;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class MyDictionary<K,V> implements MyIDictionary<K,V> {
    HashMap<K,V> dict;
    public MyDictionary(){
        this.dict = new HashMap<>();
    }

    @Override
    public void add(K key,V value) {
        dict.put(key,value);
    }

    @Override
    public V remove(K key) throws MyException, DictionaryException {
        if(dict.size()==0)
            throw new DictionaryException("Empty dictionary.");
        return dict.remove(key);
    }

    @Override
    public boolean isDefined(K id) {
        for(K key: dict.keySet()){
            if(key==id)
                return true;
        }
        return false;
    }

    @Override
    public V lookup(K id) {
        return dict.get(id);
    }

    @Override
    public String toString() {
        String result = "";
        Iterator dictAtor = dict.entrySet().iterator();
        for(K key: dict.keySet())
            result = result + key.toString() + dict.get(key).toString() + "\n";

        return result;
    }

    @Override
    public void update(K key, V value) {
        dict.replace(key,value);
    }

    @Override
    public HashMap<K,V> getContent() {
            return dict;
    }
}
