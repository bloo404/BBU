package View;/*package View;

import Controller.IController;
import Controller.Controller;
import Exceptions.ControllerException;
import Exceptions.MyException;
import Exceptions.StackException;
import Model.ADTs.*;
import Model.Expression.ArithExp;
import Model.Expression.ValueExp;
import Model.Expression.VarExp;
import Model.Statement.*;
import Model.Type.BoolType;
import Model.Type.IntType;
import Model.Value.BoolValue;
import Model.Value.IntValue;
import Model.Value.Value;
import Repository.IRepository;
import Repository.Repository;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Scanner;

public class main {
    public static void main(String args[]) throws IOException, MyException, ControllerException, StackException {
        while(true){

            System.out.println("What program would you like to run?");
            System.out.println("1. int v; v=2;Print(v)");
            System.out.println("2. int a;int b; a=2+3*5;b=a+1;Print(b)");
            System.out.println("3. bool a; int v; a=true;(If a Then v=2 Else v=3);Print(v)");

            BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
            System.out.print("Enter option: ");
            String s = br.readLine();

            System.out.println("You can print the statements when solving a solution. Would you like to? ");
            System.out.println("1 - yes");
            System.out.println("0 - no");

            String a_flag;
            a_flag = br.readLine();
            boolean flag;

            flag = a_flag.equals("1");

            System.out.println("Input the logFilePath of where you want the information to be saved");
            String logFilePath;
            Scanner scanner = new Scanner(System.in);

            logFilePath = scanner.nextLine();

            if(s.equals("1")){

                IStmt ex1 = new CompStmt(new VarDeclStmt("v", new IntType()),
                        new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(2))), new PrintStmt(new
                                VarExp("v"))));

                MyIStack stk = new MyStack();
                MyIDictionary<String, Value> symtbl = new MyDictionary<>();
                MyIList<Value> ot = new MyList<>();
                PrgState program = new PrgState(stk, symtbl, ot, ex1);

                IRepository repo = new Repository(program,logFilePath);
                IController ctrl = new Controller(repo);
                ctrl.allStep();

            }else if(s.equals("2")){

                IStmt ex2 = new CompStmt( new VarDeclStmt("a", new IntType()),
                        new CompStmt( new VarDeclStmt("b", new IntType()),
                                new CompStmt(new AssignStmt("a", new ArithExp('+', new ValueExp(new IntValue(2)),
                                        new ArithExp('*', new ValueExp(new IntValue(3)), new ValueExp(new IntValue(5))))),
                                        new CompStmt(new AssignStmt("b", new ArithExp('+', new VarExp("a"), new ValueExp(new
                                                IntValue(1)))), new PrintStmt(new VarExp("b"))))));

                MyIStack stk = new MyStack();
                MyIDictionary<String, Value> symtbl = new MyDictionary<>();
                MyIList<Value> ot = new MyList<>();
                PrgState program = new PrgState(stk, symtbl, ot, ex2);

                IRepository repo = new Repository(program,logFilePath);
                IController ctrl = new Controller(repo);

                ctrl.allStep();

            }else if(s.equals("3")){

                IStmt ex3 = new CompStmt(new VarDeclStmt("a", new BoolType()),
                        new CompStmt(new VarDeclStmt("v", new IntType()),
                                new CompStmt(new AssignStmt("a", new ValueExp(new BoolValue(true))),
                                        new CompStmt(new IfStmt(new VarExp("a"), new AssignStmt("v", new ValueExp(new
                                                IntValue(2))), new AssignStmt("v", new ValueExp(new IntValue(3)))),
                                                new PrintStmt(new VarExp("v"))))));

                MyIStack stk = new MyStack();
                MyIDictionary<String, Value> symtbl = new MyDictionary<>();
                MyIList<Value> ot = new MyList<>();
                PrgState program = new PrgState(stk, symtbl, ot, ex3);

                IRepository repo = new Repository(program,logFilePath);
                IController ctrl = new Controller(repo);

                ctrl.allStep();

            }else{
                System.out.println("Invalid choice\n");
            }
        }
    }
}*/
