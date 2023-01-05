package Model.ADTs;

import Exceptions.MyException;
import Exceptions.StackException;

public interface MyIStack<T>{
    T pop() throws MyException, StackException;
    void push(T v);
    boolean isEmpty();

}
