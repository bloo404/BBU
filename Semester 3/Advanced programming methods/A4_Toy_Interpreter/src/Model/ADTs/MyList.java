package Model.ADTs;

import Exceptions.ListException;
import Exceptions.MyException;

import java.util.Iterator;
import java.util.Queue;
import java.util.LinkedList;

public class MyList<T> implements MyIList<T>{
    Queue<T> list;

    public MyList(){
        this.list = new LinkedList<>();
    }

    @Override
    public void remove() throws MyException, ListException {
        if(list.size()==0)
            throw new ListException("List empty.");
        list.remove();
    }

    @Override
    public String toString() {
        String result = "";
        Iterator value = list.iterator();
        while(value.hasNext())
            result = result + value.next() + "\n";
        return result;
    }

    @Override
    public void add(T e) {
        list.add(e);
    }
}
