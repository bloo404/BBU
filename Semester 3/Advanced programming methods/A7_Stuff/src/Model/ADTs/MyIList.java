package Model.ADTs;

import Exceptions.ListException;
import Exceptions.MyException;
import java.util.Queue;

import java.util.List;

public interface MyIList<T>{
    void remove() throws MyException, ListException;
    void add(T e);

    List<T> getList();
}
