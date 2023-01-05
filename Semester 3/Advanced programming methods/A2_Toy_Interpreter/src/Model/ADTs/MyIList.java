package Model.ADTs;

import Exceptions.ListException;
import Exceptions.MyException;

public interface MyIList<T>{
    void remove() throws MyException, ListException;
    void add(T e);
}
