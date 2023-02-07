package GUI;

import Model.ADTs.*;
import Model.Expression.*;
import Model.Statement.*;
import Model.Type.BoolType;
import Model.Type.IntType;
import Model.Type.RefType;
import Model.Type.StringType;
import Model.Value.BoolValue;
import Model.Value.IntValue;
import Model.Value.StringValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.*;

import Controller.*;
import Exceptions.*;
import Repository.*;

import java.util.ArrayList;
import java.util.List;

public class ChooseProgram {
    private ExecuteProgram executor;

    public void setExecuteProgram(ExecuteProgram executor) {
        this.executor = executor;
    }

    @FXML
    private ListView<IStmt> programsListView;

    @FXML
    private Button displayButton;

    @FXML
    public void initialize() {
        programsListView.setItems(getAllStatements());
        programsListView.getSelectionModel().setSelectionMode(SelectionMode.SINGLE);
    }

    @FXML
    private void displayProgram(ActionEvent actionEvent) {
        IStmt selectedStatement = programsListView.getSelectionModel().getSelectedItem();
        if (selectedStatement == null) {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("ERROR");
            alert.setContentText("STATEMENT NOT CHOSEN");
            alert.showAndWait();
        } else {
            int id = programsListView.getSelectionModel().getSelectedIndex();
            try {
                selectedStatement.typecheck(new MyDictionary<>());
                PrgState programState = new PrgState(new MyStack<>(), new MyDictionary<>(), new MyList<>(), new FileTable<>(), new MyHeap(), selectedStatement, new MyCycBar());
                IRepository repository = new Repository(programState, "log" + (id + 1) + ".txt");
                Controller controller = new Controller(repository);
                this.executor.setController(controller);
            } catch (MyException e) {
                Alert alert = new Alert(Alert.AlertType.ERROR);
                alert.setTitle("CAN'T EXECUTE");
                alert.setHeaderText("EXECUTION ERROR");
                alert.setContentText(e.getMessage());
                alert.showAndWait();

            }
        }
    }

    @FXML
    private ObservableList<IStmt> getAllStatements() {
        List<IStmt> allStatements = new ArrayList<>();
/*
        ///ex 1:       int v; v=2;Print(v)   - Lab3
        IStmt ex1 = new CompStmt(new VarDeclStmt("v", new IntType()),
                new CompStmt(new AssignStmt("v", new ValueExp(new StringValue("a"))), new PrintStmt(new VarExp("v"))));

        ///ex 2:       int a;int b; a=2+3*5;b=a+1;Print(b)                              - Lab3
        IStmt ex2 = new CompStmt(new VarDeclStmt("a", new IntType()),
                new CompStmt(new VarDeclStmt("b", new IntType()), new CompStmt(new AssignStmt("a", new ArithExp('+',
                        new ValueExp(new IntValue(2)), new ArithExp('*', new ValueExp(new IntValue(3)), new ValueExp(new IntValue(5))))),
                        new CompStmt(new AssignStmt("b", new ArithExp('+', new VarExp("a"), new ValueExp(new IntValue(1)))), new PrintStmt(new VarExp("b"))))));

        ///ex 3:       bool a; int v; a=true;(If a Then v=2 Else v=3);Print(v)          - Lab3
        IStmt ex3 = new CompStmt(new VarDeclStmt("a", new BoolType()),
                new CompStmt(new VarDeclStmt("v", new IntType()), new CompStmt(new AssignStmt("a", new ValueExp(new BoolValue(true))),
                        new CompStmt(new IfStmt(new VarExp("a"), new AssignStmt("v", new ValueExp(new IntValue(2))), new AssignStmt("v", new ValueExp(new IntValue(3)))), new PrintStmt(new VarExp("v"))))));

        ///ex 7:       Ref int v;new(v,20);Ref Ref int a; new(a,v);print(rH(v));print(rH(rH(a))+5)  - Lab7
        IStmt ex7 = new CompStmt(new VarDeclStmt("v", new RefType(new IntType())), new CompStmt(
                new NewStmt("v", new ValueExp(new IntValue(20))), new CompStmt(new VarDeclStmt("a", new RefType(new RefType(new IntType()))),
                new CompStmt(new NewStmt("a", new VarExp("v")), new CompStmt(new PrintStmt(new ReadHeapExp(new VarExp("v"))),
                        new PrintStmt(new ArithExp('+', new ReadHeapExp(new ReadHeapExp(new VarExp("a"))), new ValueExp(new IntValue(5)))))))));

        ///ex 8:       Ref int v;new(v,20);print(rH(v)); wH(v,30);print(rH(v)+5);                   - Lab7
        IStmt ex8 = new CompStmt(new VarDeclStmt("v", new RefType(new IntType())),
                new CompStmt(new NewStmt("v", new ValueExp(new IntValue(20))),
                        new CompStmt(new PrintStmt(new ReadHeapExp(new VarExp("v"))),
                                new CompStmt(new WriteHeapStmt("v", new ValueExp(new IntValue(30))),
                                        new PrintStmt(new ArithExp('+', new ReadHeapExp(new VarExp("v")), new ValueExp(new IntValue(5))))))));

        ///ex 9:       Ref int v;new(v,20);Ref Ref int a; new(a,v); new(v,30);print(rH(rH(a)))      - Lab7
        IStmt ex9 = new CompStmt(new VarDeclStmt("v", new RefType(new IntType())),
                new CompStmt(new NewStmt("v", new ValueExp(new IntValue(20))),
                        new CompStmt(new VarDeclStmt("a", new RefType(new RefType(new IntType()))),
                                new CompStmt(new NewStmt("a", new VarExp("v")),
                                        new CompStmt(new NewStmt("v", new ValueExp(new IntValue(30))),
                                                new PrintStmt(new ReadHeapExp(new ReadHeapExp(new VarExp("a")))))))));

        ///ex 10:      int v; v=4; (while (v>0) print(v);v=v-1);print(v)                            - Lab7
        IStmt  ex10 = new CompStmt(new VarDeclStmt("v", new IntType()),
                new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(4))),
                        new CompStmt(new WhileStmt(new RelExp(">", new VarExp("v"), new ValueExp(new IntValue(0))),
                                new CompStmt(new PrintStmt(new VarExp("v")), new AssignStmt("v",new ArithExp('-', new VarExp("v"), new ValueExp(new IntValue(1)))))),
                                new PrintStmt(new VarExp("v")))));

        ///ex 11:      int v; Ref int a; v=10;new(a,22); fork(wH(a,30);v=32;print(v);print(rH(a))); - Lab8
        IStmt decl = new CompStmt(new VarDeclStmt("v", new IntType()), new CompStmt(new VarDeclStmt("a", new RefType(new IntType())),
                new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(10))), new NewStmt("a", new ValueExp(new IntValue(22))))));
        IStmt fork = new forkStmt(new CompStmt(new WriteHeapStmt("a", new ValueExp(new IntValue(30))),
                new CompStmt(new AssignStmt("v", new ValueExp(new IntValue(32))), new CompStmt(new PrintStmt(new VarExp("v")),
                        new PrintStmt(new ReadHeapExp(new VarExp("a")))))));
        IStmt ex11 = new CompStmt(decl, new CompStmt(fork, new CompStmt(new PrintStmt(new VarExp("v")), new PrintStmt(new ReadHeapExp(new VarExp("a"))))));

        ///ex 12:      int v; Ref int  a; v=10; new(a, 22); Fork( wH(a, 30); v=32; print(v); print(rH(a)); (Fork( v=16; print(v)); (print(v); print(rH(a))) - Lab8
        IStmt ex12 = new CompStmt(new VarDeclStmt("v", new RefType(new IntType())),
                new CompStmt(new NewStmt("v", new ValueExp(new IntValue(20))),
                        new CompStmt(new VarDeclStmt("a", new RefType(new RefType(new IntType()))),
                                new CompStmt(new NewStmt("a", new VarExp("v")),
                                        new CompStmt(new NewStmt("v", new ValueExp(new IntValue(30))),
                                                new PrintStmt(new ReadHeapExp(new ReadHeapExp(new VarExp("a")))))))));

        ///ex FileTable
        IStmt ex13 = new CompStmt(new VarDeclStmt("varf", new StringType()),new CompStmt(new AssignStmt("varf",
                new ValueExp(new StringValue("test.in"))), new CompStmt(new openRFile(new VarExp("varf")),
                new CompStmt(new VarDeclStmt("varc", new IntType()), new CompStmt(new readFile(new VarExp("varf"), "varc"),
                        new CompStmt(new PrintStmt(new VarExp("varc")), new CompStmt(new readFile(new VarExp("varf"), "varc"),
                                new CompStmt(new PrintStmt(new VarExp("varc")), new closeRFile(new VarExp("varf"))))))))));

        allStatements.add(ex1);
        allStatements.add(ex2);
        allStatements.add(ex3);
        allStatements.add(ex7);
        allStatements.add(ex8);
        allStatements.add(ex9);
        allStatements.add(ex10);
        allStatements.add(ex11);
        allStatements.add(ex12);
        allStatements.add(ex13);
        */

        //ex BARRIER

        IStmt barrier_declare = new CompStmt(
                new CompStmt(
                        new CompStmt(
                                new VarDeclStmt("v1", new RefType(new IntType())),
                                new VarDeclStmt("v2", new RefType(new IntType()))
                        ),
                        new VarDeclStmt("v3", new RefType(new IntType()))
                ),
                new VarDeclStmt("cnt", new IntType())
        );

        IStmt barrier_new =
                new CompStmt(
                        new CompStmt(
                                new CompStmt(
                                        new NewStmt("v1", new ValueExp(new IntValue(2))),
                                        new NewStmt("v2", new ValueExp(new IntValue(3)))
                                ),
                                new NewStmt("v3", new ValueExp(new IntValue(4)))
                        ),
                        new newBarrier("cnt", new ReadHeapExp(new VarExp("v2")))
                );

        IStmt barrier_fork_1 = new forkStmt(
                new CompStmt(
                        new CompStmt(
                                new awaitStmt("cnt"),
                                new WriteHeapStmt("v1", new ArithExp('*', new ReadHeapExp(new VarExp("v1")), new ValueExp(new IntValue(10))))
                        ),
                        new PrintStmt(new ReadHeapExp(new VarExp("v1")))
                ));

        IStmt barrier_fork_2 = new forkStmt(new CompStmt(
                new CompStmt(
                        new CompStmt(
                                new awaitStmt("cnt"),
                                new WriteHeapStmt("v2", new ArithExp('*', new ReadHeapExp(new VarExp("v2")), new ValueExp(new IntValue(10))))
                        ),
                        new WriteHeapStmt("v2", new ArithExp('*', new ReadHeapExp(new VarExp("v2")), new ValueExp(new IntValue(10))))
                ),
                new PrintStmt(new ReadHeapExp(new VarExp("v2")))

        ));

        IStmt barrier_final = new CompStmt(
                new awaitStmt("cnt"),
                new PrintStmt(new ReadHeapExp(new VarExp("v3")))
        );

        IStmt baruru = new CompStmt(
                new CompStmt(
                        new CompStmt(
                                new CompStmt(
                                        barrier_declare,
                                        barrier_new),
                                barrier_fork_1),
                        barrier_fork_2),
                barrier_final
        );

        allStatements.add(baruru);

        return FXCollections.observableArrayList(allStatements);
    }
}