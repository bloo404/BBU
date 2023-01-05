package Model.ADTs;

import Exceptions.ControllerException;
import Exceptions.HeapException;
import Exceptions.MyException;
import Exceptions.StackException;
import Model.Statement.IStmt;
import Model.Value.StringValue;
import Model.Value.Value;

import java.io.BufferedReader;
import java.io.IOException;

public class PrgState {
    MyIStack<IStmt> exeStack;
    MyIDictionary<String, Value> symTable;
    MyIList<Value> out;
    IStmt originalProgram;
    IFileTable<StringValue, BufferedReader> fileTable;
    MyIHeap heap;

    int id;

    static int newId = 0;

    public PrgState(MyIStack<IStmt> exeStack, MyIDictionary<String, Value> symTable, MyIList<Value> out,IFileTable<StringValue, BufferedReader> fileTbl,MyIHeap heap, IStmt originalProgram) {
        this.exeStack = exeStack;
        this.symTable = symTable;
        this.out = out;
        this.fileTable = fileTbl;
        this.heap = heap;
        this.originalProgram = deepCopy(originalProgram);
        exeStack.push(this.originalProgram);
        this.id = setId();
    }

    public MyIStack<IStmt> getStk() {
        return exeStack;
    }

    public void setExeStack(MyIStack<IStmt> exeStack) {
        this.exeStack = exeStack;
    }

    public MyIDictionary<String, Value> getSymTable() {
        return symTable;
    }

    public void setSymTable(MyIDictionary<String, Value> symTable) {
        this.symTable = symTable;
    }

    public MyIList<Value> getOut() {
        return out;
    }

    public void setOut(MyIList<Value> out) {
        this.out = out;
    }

    public IStmt getOriginalProgram() {
        return originalProgram;
    }

    public void setOriginalProgram(IStmt originalProgram) {
        this.originalProgram = originalProgram;
    }

    @Override
    public String toString() {
        return "----------------\n" + "Id: " + id + "\n" +  "ExeStack:\n" + exeStack.toString() + "SymTable:\n" + symTable.toString() + "Out:\n" + out.toString() + "FileTable:\n" + fileTable.toString()
                + "Heap:\n" + heap.toString() + "\n";
    }

    public MyIStack<IStmt> getExeStack() {
        return exeStack;
    }

    public IFileTable<StringValue, BufferedReader> getFileTable() {
        return fileTable;
    }

    public void setFileTable(IFileTable<StringValue, BufferedReader> fileTable) {
        this.fileTable = fileTable;
    }

    public MyIHeap getHeap() {
        return heap;
    }

    public void setHeap(MyIHeap heap) {
        this.heap = heap;
    }

    private IStmt deepCopy(IStmt prg){return prg;}

    public Boolean isNotCompleted(){
        return !exeStack.isEmpty();
    }

    public static synchronized int setId(){
        newId++;
        return newId;
    }

    public PrgState oneStep() throws MyException, ControllerException, StackException, IOException, HeapException {
        if(exeStack.isEmpty())
            throw new ControllerException("PrgState stack is empty");
        IStmt crtStmt = exeStack.pop();
        return crtStmt.execute(this);
    }
}
