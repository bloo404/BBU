package Model.ADTs;

import Exceptions.MyException;
import Exceptions.StackException;
import Model.Statement.IStmt;

import java.util.List;

public interface MyIStack<T>{
    T pop() throws MyException, StackException;
    void push(T v);
    boolean isEmpty();

    List<T> getReversed();
}
