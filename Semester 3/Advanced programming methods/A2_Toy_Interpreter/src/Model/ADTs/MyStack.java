package Model.ADTs;

import Exceptions.MyException;
import Exceptions.StackException;

import java.util.Iterator;
import java.util.Stack;

public class MyStack<T> implements MyIStack<T>{
    Stack<T> stack;

    public MyStack(){
        this.stack = new Stack<>();
    }

    @Override
    public T pop() throws MyException, StackException {
        if(stack.size()==0)
            throw new StackException("Stack empty.");
        return stack.pop();
    }

    @Override
    public void push(T v) {
        stack.push(v);
    }

    @Override
    public String toString() {
        String result = "";
        Iterator value = stack.iterator();
        while (value.hasNext()) {
            result = result + value.next().toString() + "\n";
        }
        return result;
    }

    @Override
    public boolean isEmpty() {
        return stack.isEmpty();
    }
}
