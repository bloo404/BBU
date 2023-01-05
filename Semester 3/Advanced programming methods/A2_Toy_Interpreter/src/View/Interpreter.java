package View;

import Controller.Controller;
import Exceptions.*;
import Model.Statement.*;
import Model.Type.*;
import Model.Value.*;
import Model.Expression.*;
import Model.ADTs.*;
import Repository.IRepository;
import Repository.Repository;

import java.io.BufferedReader;
import java.io.IOException;

public class Interpreter {
    public static void main(String[] args) throws MyException, IOException, ControllerException, RepositoryException, StackException {

        IStmt ex = new CompStmt(new VarDeclStmt("varf", new StringType()),new CompStmt(new AssignStmt("varf",
                new ValueExp(new StringValue("test.in"))), new CompStmt(new openRFile(new VarExp("varf")),
                new CompStmt(new VarDeclStmt("varc", new IntType()), new CompStmt(new readFile(new VarExp("varf"), "varc"),
                        new CompStmt(new PrintStmt(new VarExp("varc")), new CompStmt(new readFile(new VarExp("varf"), "varc"),
                                new CompStmt(new PrintStmt(new VarExp("varc")), new closeRFile(new VarExp("varf"))))))))));

        MyIStack stk = new MyStack();
        MyIDictionary<String, Value> symTbl = new MyDictionary<>();
        MyIList<Value> ot = new MyList<>();
        IFileTable<StringValue, BufferedReader> ft = new FileTable<>();
        PrgState prg = new PrgState(stk, symTbl, ot, ft, ex);
        IRepository repo = new Repository(prg, "log4.txt");
        Controller ctr = new Controller(repo);
        ctr.allStep();

        IStmt ex1 = new CompStmt(new VarDeclStmt("v", new IntType()),
                new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(2))), new PrintStmt(new
                        VarExp("v"))));

        MyIStack stk1 = new MyStack<>();
        MyIDictionary<String, Value> symtbl1 = new MyDictionary<>();
        MyIList<Value> ot1 = new MyList<>();
        IFileTable<StringValue, BufferedReader> ft1 = new FileTable<>();
        PrgState prg1 = new PrgState(stk1, symtbl1, ot1, ft1, ex1);

        IRepository repo1 = new Repository(prg1, "log1.txt");
        Controller ctr1 = new Controller(repo1);

        IStmt ex2 = new CompStmt( new VarDeclStmt("a", new IntType()),
                new CompStmt( new VarDeclStmt("b", new IntType()),
                        new CompStmt(new AssignStmt("a", new ArithExp('+', new ValueExp(new IntValue(2)),
                                new ArithExp('*', new ValueExp(new IntValue(3)), new ValueExp(new IntValue(5))))),
                                new CompStmt(new AssignStmt("b", new ArithExp('+', new VarExp("a"), new ValueExp(new
                                        IntValue(1)))), new PrintStmt(new VarExp("b"))))));

        MyIStack stk2 = new MyStack<>();
        MyIDictionary<String, Value> symtbl2 = new MyDictionary<>();
        MyIList<Value> ot2 = new MyList<>();
        IFileTable<StringValue, BufferedReader> ft2 = new FileTable<>();
        PrgState prg2 = new PrgState(stk2, symtbl2, ot2, ft2, ex2);

        IRepository repo2 = new Repository(prg2, "log2.txt");
        Controller ctr2 = new Controller(repo2);

        IStmt ex3 = new CompStmt(new VarDeclStmt("a", new BoolType()),
                new CompStmt(new VarDeclStmt("v", new IntType()),
                        new CompStmt(new AssignStmt("a", new ValueExp(new BoolValue(true))),
                                new CompStmt(new IfStmt(new VarExp("a"), new AssignStmt("v", new ValueExp(new
                                        IntValue(2))), new AssignStmt("v", new ValueExp(new IntValue(3)))),
                                        new PrintStmt(new VarExp("v"))))));

        MyIStack stk3 = new MyStack<>();
        MyIDictionary<String, Value> symtbl3 = new MyDictionary<>();
        MyIList<Value> ot3 = new MyList<>();
        IFileTable<StringValue, BufferedReader> ft3 = new FileTable<>();
        PrgState prg3 = new PrgState(stk3, symtbl3, ot3, ft3, ex3);

        IRepository repo3 = new Repository(prg3, "log3.txt");
        Controller ctr3 = new Controller(repo3);

        TextMenu menu = new TextMenu();
        menu.addCommand(new ExitCommand("0", "exit"));
        menu.addCommand(new RunExample("1", ex1.toString(),ctr1));
        menu.addCommand(new RunExample("2", ex2.toString(),ctr2));
        menu.addCommand(new RunExample("3", ex3.toString(),ctr3));
        menu.show();
    }
}