package Controller;

import Exceptions.ControllerException;
import Exceptions.MyException;
import Exceptions.RepositoryException;
import Exceptions.StackException;
import Model.ADTs.PrgState;

import java.io.IOException;

public interface IController {
    PrgState oneStep(PrgState state) throws MyException, ControllerException, StackException, IOException; /// exceptii
    void allStep() throws MyException, IOException, ControllerException, StackException, RepositoryException;
}
