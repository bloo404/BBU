package Model.ADTs;

import Exceptions.MyException;
import Model.Value.Value;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class FileTable<K, V> implements IFileTable<K, V> {

    HashMap<K, V> dict;

    public FileTable(){
        this.dict = new HashMap<>();
    }

    public HashMap<K, V> getDict() {
        return dict;
    }

    public void setDict(HashMap<K, V> dict) {
        this.dict = dict;
    }

    @Override
    public V remove(K key) throws MyException {
        if(dict.size() == 0)
            throw new MyException("Empty dictionary");
        return dict.remove(key);
    }

    @Override
    public void add(K key, V val) {
        dict.put(key,val);
    }

    @Override
    public boolean isDefined(K id) {
        for(K key: dict.keySet())
            if(key == id)
                return true;
        return false;
    }

    @Override
    public V lookup(K id) {
        return dict.get(id);
    }

    public String toString() {

        String result = "";

        Iterator dictIterator = dict.entrySet().iterator();

        for(K key: dict.keySet())
            result = result + key.toString() + " " + dict.get(key).toString() + "\n";

        return result;
    }

    @Override
    public void update(K id, V val) {
        dict.replace(id,val);
    }

}
