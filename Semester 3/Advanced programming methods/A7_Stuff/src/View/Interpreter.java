package View;

import Controller.Controller;
import Exceptions.*;
import Model.ADTs.*;
import Model.Expression.*;
import Model.Statement.*;
import Model.Type.BoolType;
import Model.Type.IntType;
import Model.Type.RefType;
import Model.Value.BoolValue;
import Model.Value.IntValue;
import Model.Value.StringValue;
import Model.Value.Value;
import Repository.IRepository;
import Repository.Repository;

import java.io.BufferedReader;
import java.io.IOException;

public class Interpreter {
 public static void main(String[] args) throws MyException, IOException, ControllerException, RepositoryException, StackException, HeapException, InterruptedException {

  ///ex 13:      int v; Ref int a; v=10; new(a, 22); Fork(wH(a, 30); v=32; print(v); Fork(wH(a, 100); v=50; print(v)); print(rH(a)); print(v); print(rH(a))) - Lab8

  ///ex 1:       int v; v=2;Print(v)   - Lab3
  IStmt ex1 = new CompStmt(new VarDeclStmt("v", new IntType()),
          new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(2))), new PrintStmt(new VarExp("v"))));
  /// TYPE CHECK 1
  try {
   MyIDictionary typeEnv1 = new MyDictionary<>();
   ex1.typecheck(typeEnv1);
  } catch (MyException e) {
   System.out.println("ERROR: Type checker " + e.toString()); 
  }
  ;
  /// CREATION OF ELEMENTS
  MyIStack stk1 = new MyStack();
  MyIDictionary<String, Value> symTbl1 = new MyDictionary<>();
  MyIList<Value> ot1 = new MyList<>();
  IFileTable<StringValue, BufferedReader> ft1 = new FileTable<>();
  MyIHeap hp1 = new MyHeap();
  PrgState prg1 = new PrgState(stk1, symTbl1, ot1, ft1, hp1, ex1);
  IRepository repo1 = new Repository(prg1, "log1.txt");
  /// CREATION OF PROGRAM
  Controller ctr1 = new Controller(repo1);
  ctr1.allStep();


  ///ex 2:       int a;int b; a=2+3*5;b=a+1;Print(b)                              - Lab3
  IStmt ex2 = new CompStmt(new VarDeclStmt("a", new IntType()),
          new CompStmt(new VarDeclStmt("b", new IntType()), new CompStmt(new AssignStmt("a", new ArithExp('+',
                  new ValueExp(new IntValue(2)), new ArithExp('*', new ValueExp(new IntValue(3)), new ValueExp(new IntValue(5))))),
                  new CompStmt(new AssignStmt("b", new ArithExp('+', new VarExp("a"), new ValueExp(new IntValue(1)))), new PrintStmt(new VarExp("b"))))));
  /// TYPE CHECK 2
  try {
   MyIDictionary typeEnv2 = new MyDictionary<>();
   ex2.typecheck(typeEnv2);
  } catch (MyException e) {
   System.out.println("ERROR: Type checker " + e.toString());
  }
  ;
  /// CREATION OF ELEMENTS
  MyIStack stk2 = new MyStack();
  MyIDictionary<String, Value> symTbl2 = new MyDictionary<>();
  MyIList<Value> ot2 = new MyList<>();
  IFileTable<StringValue, BufferedReader> ft2 = new FileTable<>();
  MyIHeap hp2 = new MyHeap();
  PrgState prg2 = new PrgState(stk2, symTbl2, ot2, ft2, hp2, ex2);
  IRepository repo2 = new Repository(prg2, "log2.txt");
  /// CREATION OF PROGRAM
  Controller ctr2 = new Controller(repo2);
  ctr2.allStep();

  ///ex 3:       bool a; int v; a=true;(If a Then v=2 Else v=3);Print(v)          - Lab3
  IStmt ex3 = new CompStmt(new VarDeclStmt("a", new BoolType()),
          new CompStmt(new VarDeclStmt("v", new IntType()), new CompStmt(new AssignStmt("a", new ValueExp(new BoolValue(true))),
                  new CompStmt(new IfStmt(new VarExp("a"), new AssignStmt("v", new ValueExp(new IntValue(2))), new AssignStmt("v", new ValueExp(new IntValue(3)))), new PrintStmt(new VarExp("v"))))));
  /// TYPE CHECK 3
  try {
   MyIDictionary typeEnv3 = new MyDictionary<>();
   ex3.typecheck(typeEnv3);
  } catch (MyException e) {
   System.out.println("ERROR: Type checker " + e.toString());
  }
  ;
  /// CREATION OF ELEMENTS
  MyIStack stk3 = new MyStack();
  MyIDictionary<String, Value> symTbl3 = new MyDictionary<>();
  MyIList<Value> ot3 = new MyList<>();
  IFileTable<StringValue, BufferedReader> ft3 = new FileTable<>();
  MyIHeap hp3 = new MyHeap();
  PrgState prg3 = new PrgState(stk3, symTbl3, ot3, ft3, hp3, ex3);
  IRepository repo3 = new Repository(prg3, "log3.txt");
  /// CREATION OF PROGRAM
  Controller ctr3 = new Controller(repo3);
  ctr3.allStep();
/*
  ///ex 4:       varf varc....                                                    - Lab5
  IStmt ex4 = new CompStmt(new VarDeclStmt("varf", new StringType()),new CompStmt(new AssignStmt("varf",
          new ValueExp(new StringValue("test4.in"))), new CompStmt(new openRFile(new VarExp("varf")),
          new CompStmt(new VarDeclStmt("varc", new IntType()), new CompStmt(new readFile(new VarExp("varf"), "varc"),
                  new CompStmt(new PrintStmt(new VarExp("varc")), new CompStmt(new readFile(new VarExp("varf"), "varc"),
                          new CompStmt(new PrintStmt(new VarExp("varc")), new closeRFile(new VarExp("varf"))))))))));

  /// TYPE CHECK 4
  MyIDictionary typeEnv4 = new MyDictionary<>();
  ex4.typecheck(typeEnv4);
  /// CREATION OF ELEMENTS
  MyIStack stk4 = new MyStack();
  MyIDictionary<String, Value> symTbl4 = new MyDictionary<>();
  MyIList<Value> ot4 = new MyList<>();
  IFileTable<StringValue, BufferedReader> ft4 = new FileTable<>();
  MyIHeap hp4 = new MyHeap();
  PrgState prg4 = new PrgState(stk4, symTbl4, ot4, ft4, hp4, ex4);
  /// CREATION OF PROGRAM
  IRepository repo4 = new Repository(prg4, "log4.txt");
  Controller ctr4 = new Controller(repo4);
  ctr4.allStep();
*/

  ///ex 5:       int a; a = 25; int b; b = 30; IF (a > b) THEN print(a) ELSE print(b)         - Lab
  ///ex 6:       Ref int v;new(v,20);Ref Ref int a; new(a,v);print(v);print(a)                - Lab7
  ///ex 7:       Ref int v;new(v,20);Ref Ref int a; new(a,v);print(rH(v));print(rH(rH(a))+5)  - Lab7
  IStmt ex7 = new CompStmt(new VarDeclStmt("v", new RefType(new IntType())), new CompStmt(
          new NewStmt("v", new ValueExp(new IntValue(20))), new CompStmt(new VarDeclStmt("a", new RefType(new RefType(new IntType()))),
          new CompStmt(new NewStmt("a", new VarExp("v")), new CompStmt(new PrintStmt(new ReadHeapExp(new VarExp("v"))),
                  new PrintStmt(new ArithExp('+', new ReadHeapExp(new ReadHeapExp(new VarExp("a"))), new ValueExp(new IntValue(5)))))))));
  /// TYPE CHECK 7
  try {
   MyIDictionary typeEnv7 = new MyDictionary<>();
   ex7.typecheck(typeEnv7);
  } catch (MyException e) {
   System.out.println("ERROR: Type checker " + e.toString());
  }
  ;
  /// CREATION OF ELEMENTS
  MyIStack stk7 = new MyStack();
  MyIDictionary<String, Value> symTbl7 = new MyDictionary<>();
  MyIList<Value> ot7 = new MyList<>();
  IFileTable<StringValue, BufferedReader> ft7 = new FileTable<>();
  MyIHeap hp7 = new MyHeap();
  PrgState prg7 = new PrgState(stk7, symTbl7, ot7, ft7, hp7, ex7);
  /// CREATION OF PROGRAM
  IRepository repo7 = new Repository(prg7, "log7.txt");
  Controller ctr7 = new Controller(repo7);
  ctr7.allStep();

  ///ex 8:       Ref int v;new(v,20);print(rH(v)); wH(v,30);print(rH(v)+5);                   - Lab7
  IStmt ex8 = new CompStmt(new VarDeclStmt("v", new RefType(new IntType())),
          new CompStmt(new NewStmt("v", new ValueExp(new IntValue(20))),
                  new CompStmt(new PrintStmt(new ReadHeapExp(new VarExp("v"))),
                          new CompStmt(new WriteHeapStmt("v", new ValueExp(new IntValue(30))),
                                  new PrintStmt(new ArithExp('+', new ReadHeapExp(new VarExp("v")), new ValueExp(new IntValue(5))))))));
  /// TYPE CHECK 8
  try {
   MyIDictionary typeEnv8 = new MyDictionary<>();
   ex8.typecheck(typeEnv8);
  } catch (MyException e) {
   System.out.println("ERROR: Type checker " + e.toString());
  }
  ;
  /// CREATION OF ELEMENTS
  MyIStack stk8 = new MyStack();
  MyIDictionary<String, Value> symTbl8 = new MyDictionary<>();
  MyIList<Value> ot8 = new MyList<>();
  IFileTable<StringValue, BufferedReader> ft8 = new FileTable<>();
  MyIHeap hp8 = new MyHeap();
  PrgState prg8 = new PrgState(stk8, symTbl8, ot8, ft8, hp8, ex8);
  /// CREATION OF PROGRAM
  IRepository repo8 = new Repository(prg8, "log8.txt");
  Controller ctr8 = new Controller(repo8);
  ctr8.allStep();

  ///ex 9:       Ref int v;new(v,20);Ref Ref int a; new(a,v); new(v,30);print(rH(rH(a)))      - Lab7
  IStmt ex9 = new CompStmt(new VarDeclStmt("v", new RefType(new IntType())),
          new CompStmt(new NewStmt("v", new ValueExp(new IntValue(20))),
                  new CompStmt(new VarDeclStmt("a", new RefType(new RefType(new IntType()))),
                          new CompStmt(new NewStmt("a", new VarExp("v")),
                                  new CompStmt(new NewStmt("v", new ValueExp(new IntValue(30))),
                                          new PrintStmt(new ReadHeapExp(new ReadHeapExp(new VarExp("a")))))))));
  /// TYPE CHECK 9
  try {
   MyIDictionary typeEnv9 = new MyDictionary<>();
   ex9.typecheck(typeEnv9);
  } catch (MyException e) {
   System.out.println("ERROR: Type checker " + e.toString());
  }
  ;
  /// CREATION OF ELEMENTS
  MyIStack stk9 = new MyStack();
  MyIDictionary<String, Value> symTbl9 = new MyDictionary<>();
  MyIList<Value> ot9 = new MyList<>();
  IFileTable<StringValue, BufferedReader> ft9 = new FileTable<>();
  MyIHeap hp9 = new MyHeap();
  PrgState prg9 = new PrgState(stk9, symTbl9, ot9, ft9, hp9, ex9);
  /// CREATION OF PROGRAM
  IRepository repo9 = new Repository(prg9, "log9.txt");
  Controller ctr9 = new Controller(repo9);
  ctr9.allStep();

  ///ex 10:      int v; v=4; (while (v>0) print(v);v=v-1);print(v)                            - Lab7
  IStmt  ex10 = new CompStmt(new VarDeclStmt("v", new IntType()),
          new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(4))),
                  new CompStmt(new WhileStmt(new RelExp(">", new VarExp("v"), new ValueExp(new IntValue(0))),
                          new CompStmt(new PrintStmt(new VarExp("v")), new AssignStmt("v",new ArithExp('-', new VarExp("v"), new ValueExp(new IntValue(1)))))),
                          new PrintStmt(new VarExp("v")))));
  /// TYPE CHECK 10
  try {
   MyIDictionary typeEnv10 = new MyDictionary<>();
   ex10.typecheck(typeEnv10);
  } catch (MyException e) {
   System.out.println("ERROR: Type checker " + e.toString());
  }
  ;
  /// CREATION OF ELEMENTS
  MyIStack stk10 = new MyStack();
  MyIDictionary<String, Value> symTbl10 = new MyDictionary<>();
  MyIList<Value> ot10 = new MyList<>();
  IFileTable<StringValue, BufferedReader> ft10 = new FileTable<>();
  MyIHeap hp10 = new MyHeap();
  PrgState prg10 = new PrgState(stk10, symTbl10, ot10, ft10, hp10, ex10);
  /// CREATION OF PROGRAM
  IRepository repo10 = new Repository(prg10, "log10.txt");
  Controller ctr10 = new Controller(repo10);
  ctr10.allStep();


  ///ex 11:      int v; Ref int a; v=10;new(a,22); fork(wH(a,30);v=32;print(v);print(rH(a))); - Lab8
  IStmt decl = new CompStmt(new VarDeclStmt("v", new IntType()), new CompStmt(new VarDeclStmt("a", new RefType(new IntType())),
          new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(10))), new NewStmt("a", new ValueExp(new IntValue(22))))));
  IStmt fork = new forkStmt(new CompStmt(new WriteHeapStmt("a", new ValueExp(new IntValue(30))),
          new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(32))), new CompStmt(new PrintStmt(new VarExp("v")),
                  new PrintStmt(new ReadHeapExp(new VarExp("a")))))));
  IStmt ex11 = new CompStmt(decl, new CompStmt(fork, new CompStmt(new PrintStmt(new VarExp("v")), new PrintStmt(new ReadHeapExp(new VarExp("a"))))));
  /// TYPE CHECK 11
  try {
   MyIDictionary typeEnv11 = new MyDictionary<>();
   ex11.typecheck(typeEnv11);
  } catch (MyException e) {
   System.out.println("ERROR: Type checker " + e.toString());
  }
  ;
  /// CREATION OF ELEMENTS
  MyIStack stk11 = new MyStack();
  MyIDictionary<String, Value> symTbl11 = new MyDictionary<>();
  MyIList<Value> ot11 = new MyList<>();
  IFileTable<StringValue, BufferedReader> ft11 = new FileTable<>();
  MyIHeap hp11 = new MyHeap();
  PrgState prg11 = new PrgState(stk11, symTbl11, ot11, ft11, hp11, ex11);
  /// CREATION OF PROGRAM
  IRepository repo11 = new Repository(prg11, "log11.txt");
  Controller ctr11 = new Controller(repo11);
  ctr11.allStep();

  ///ex 12:      int v; Ref int  a; v=10; new(a, 22); Fork( wH(a, 30); v=32; print(v); print(rH(a)); (Fork( v=16; print(v)); (print(v); print(rH(a))) - Lab8
  IStmt ex = new CompStmt(new VarDeclStmt("v", new RefType(new IntType())),
          new CompStmt(new NewStmt("v", new ValueExp(new IntValue(20))),
                  new CompStmt(new VarDeclStmt("a", new RefType(new RefType(new IntType()))),
                          new CompStmt(new NewStmt("a", new VarExp("v")),
                                  new CompStmt(new NewStmt("v", new ValueExp(new IntValue(30))),
                                          new PrintStmt(new ReadHeapExp(new ReadHeapExp(new VarExp("a")))))))));

  IStmt ex12 = new CompStmt(decl, new CompStmt(fork, new CompStmt(new PrintStmt(new VarExp("v")), new PrintStmt(new ReadHeapExp(new VarExp("a"))))));
  /// TYPE CHECK 12
  try {
   MyIDictionary typeEnv12 = new MyDictionary<>();
   ex12.typecheck(typeEnv12);
  } catch (MyException e) {
   System.out.println("ERROR: Type checker " + e.toString());
  }
  ;
  /// CREATION OF ELEMENTS
  MyIStack stk12 = new MyStack();
  MyIDictionary<String, Value> symTbl12 = new MyDictionary<>();
  MyIList<Value> ot12 = new MyList<>();
  IFileTable<StringValue, BufferedReader> ft12 = new FileTable<>();
  MyIHeap hp12 = new MyHeap();
  PrgState prg12 = new PrgState(stk12, symTbl12, ot12, ft12, hp12, ex12);
  /// CREATION OF PROGRAM
  IRepository repo12 = new Repository(prg12, "log12 .txt");
  Controller ctr12 = new Controller(repo12);
  ctr12.allStep();

  TextMenu menu = new TextMenu();
  menu.addCommand(new ExitCommand("0", "exit"));
  menu.addCommand(new RunExample("1", ex1.toString(), ctr1));
  menu.addCommand(new RunExample("2", ex2.toString(), ctr2));
  menu.addCommand(new RunExample("3", ex3.toString(), ctr3));
  // menu.addCommand(new RunExample("4", ex4.toString(),ctr4));
  // menu.addCommand(new RunExample("5", ex5.toString(),ctr5));
  // menu.addCommand(new RunExample("6", ex6.toString(),ctr6));
  menu.addCommand(new RunExample("7", ex7.toString(), ctr7));
  menu.addCommand(new RunExample("8", ex8.toString(), ctr8));
  menu.addCommand(new RunExample("9", ex9.toString(), ctr9));
  menu.addCommand(new RunExample("10", ex10.toString(), ctr10));
  menu.addCommand(new RunExample("11", ex11.toString(), ctr11));
  menu.addCommand(new RunExample("12", ex12.toString(), ctr12));
  menu.show();

 }
}