package GUI;

import Model.Value.StringValue;
import Model.Value.Value;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.scene.control.*;
import javafx.scene.input.MouseEvent;


import Controller.*;
import Exceptions.*;
import GUI.*;
import Repository.*;

import Model.ADTs.*;
import Model.Expression.ValueExp;
import Model.Expression.VarExp;
import Model.Statement.*;
import Model.Type.IntType;
import Model.Value.IntValue;


import java.io.BufferedReader;
import java.util.*;
import java.util.stream.Collectors;

class Pair<T1, T2> {
    T1 first;
    T2 second;

    public Pair(T1 first, T2 second) {
        this.first = first;
        this.second = second;
    }
}

public class ExecuteProgram {
    private Controller controller;

    @FXML
    private TextField numberOfPrgStatesTextField;

    @FXML
    private TableView<Pair<Integer, Value>> heapTableView;

    @FXML
    private TableColumn<Pair<Integer, Value>, Integer> addressColumn;

    @FXML
    private TableColumn<Pair<Integer, Value>, String> valueColumn;

    @FXML
    private ListView<String> outputListView;

    @FXML
    private ListView<String> fileTableListView;

    @FXML
    private ListView<Integer> PrgStateIdentifiersListView;

    @FXML
    private TableView<Pair<String, Value>> symbolTableView;

    @FXML
    private TableColumn<Pair<String, Value>, String> variableNameColumn;

    @FXML
    private TableColumn<Pair<String, Value>, String> variableValueColumn;

    @FXML
    private ListView<String> executionStackListView;

    @FXML
    private Button runOneStepButton;

    public void setController(Controller controller) {
        this.controller = controller;
        populate();
    }

    @FXML
    public void initialize() {
        PrgStateIdentifiersListView.getSelectionModel().setSelectionMode(SelectionMode.SINGLE);
        addressColumn.setCellValueFactory(p -> new SimpleIntegerProperty(p.getValue().first).asObject());
        valueColumn.setCellValueFactory(p -> new SimpleStringProperty(p.getValue().second.toString()));
        variableNameColumn.setCellValueFactory(p -> new SimpleStringProperty(p.getValue().first));
        variableValueColumn.setCellValueFactory(p -> new SimpleStringProperty(p.getValue().second.toString()));
    }

    private PrgState getCurrentPrgState() {
        if (controller.getProgramStates().size() == 0)
            return null;
        else {
            int currentId = PrgStateIdentifiersListView.getSelectionModel().getSelectedIndex();
            if (currentId == -1)
                return controller.getProgramStates().get(0);
            else
                return controller.getProgramStates().get(currentId);
        }
    }

    private void populate() {
        populateHeapTableView();
        populateOutputListView();
        populateFileTableListView();
        populatePrgStateIdentifiersListView();
        populateSymbolTableView();
        populateExecutionStackListView();
    }

    @FXML
    private void changePrgState(MouseEvent event) {
        populateExecutionStackListView();
        populateSymbolTableView();
    }

    private void populateNumberOfPrgStatesTextField() {
        List<PrgState> PrgStates = controller.getProgramStates();
        numberOfPrgStatesTextField.setText(String.valueOf(PrgStates.size()));
    }

    private void populateHeapTableView() {
        PrgState PrgState = getCurrentPrgState();
        MyIHeap heap = Objects.requireNonNull(PrgState).getHeap();
        ArrayList<Pair<Integer, Value>> heapEntries = new ArrayList<>();
        for(Map.Entry<Integer, Value> entry: heap.getContent().entrySet()) {
            heapEntries.add(new Pair<>(entry.getKey(), entry.getValue()));
        }
        heapTableView.setItems(FXCollections.observableArrayList(heapEntries));
    }

    private void populateOutputListView() {
        PrgState PrgState = getCurrentPrgState();
        List<String> output = new ArrayList<>();
        List<Value> outputList = Objects.requireNonNull(PrgState).getOut().getList();
        int index;
        for (index = 0; index < outputList.size(); index++){
            output.add(outputList.get(index).toString());
        }
        outputListView.setItems(FXCollections.observableArrayList(output));
    }

    private void populateFileTableListView() {
        PrgState PrgState = getCurrentPrgState();
        IFileTable<StringValue, BufferedReader> ft = new FileTable<>();
        ft = Objects.requireNonNull(PrgState).getFileTable();
        ArrayList<String> files = new ArrayList<>();
        for(Map.Entry<StringValue, BufferedReader> entry: ft.getContent().entrySet()){
            files.add(entry.getKey().toString());
        }
        fileTableListView.setItems(FXCollections.observableList(files));
    }

    private void populatePrgStateIdentifiersListView() {
        List<PrgState> PrgStates = controller.getProgramStates();
        List<Integer> idList = PrgStates.stream().map(PrgState::getId).collect(Collectors.toList());
        PrgStateIdentifiersListView.setItems(FXCollections.observableList(idList));
        populateNumberOfPrgStatesTextField();
    }

    private void populateSymbolTableView() {
        PrgState PrgState = getCurrentPrgState();
        MyIDictionary<String, Value> symbolTable = Objects.requireNonNull(PrgState).getSymTable();
        ArrayList<Pair<String, Value>> symbolTableEntries = new ArrayList<>();
        for (Map.Entry<String, Value> entry: symbolTable.getContent().entrySet()) {
            symbolTableEntries.add(new Pair<>(entry.getKey(), entry.getValue()));
        }
        symbolTableView.setItems(FXCollections.observableArrayList(symbolTableEntries));
    }

    private void populateExecutionStackListView() {
        PrgState PrgState = getCurrentPrgState();
        List<String> executionStackToString = new ArrayList<>();
        if (PrgState != null)
            for (IStmt statement: PrgState.getExeStack().getReversed()) {
                executionStackToString.add(statement.toString());
            }
        executionStackListView.setItems(FXCollections.observableList(executionStackToString));
    }

    @FXML
    private void runOneStep(MouseEvent mouseEvent) {
        if (controller != null) {
            try {
                List<PrgState> PrgStates = Objects.requireNonNull(controller.getProgramStates());
                if (PrgStates.size() > 0) {
                    controller.oneStep();
                    populate();
                    PrgStates = controller.removeCompletedPrg(controller.getProgramStates());
                    controller.setProgramStates(PrgStates);
                    populatePrgStateIdentifiersListView();
                } else {
                    Alert alert = new Alert(Alert.AlertType.ERROR);
                    alert.setTitle("ERROR");
                    alert.setHeaderText("AN ERROR HAS OCCURED");
                    alert.setContentText("Nothing left to execute.");
                    alert.showAndWait();
                }
            } catch (RuntimeException |  InterruptedException e) {
                Alert alert = new Alert(Alert.AlertType.ERROR);
                alert.setTitle("CAN'T EXECUTE");
                alert.setHeaderText("AN ERROR HAS OCCURED");
                alert.setContentText(e.getMessage());
                alert.showAndWait();
            }
        } else {
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setTitle("ERROR");
            alert.setHeaderText("AN ERROR HAS OCCURED");
            alert.setContentText("Select a program: no program has been selected.");
            alert.showAndWait();
        }
    }
}