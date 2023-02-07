package Controller;

import Exceptions.*;
import Model.ADTs.PrgState;

import java.io.IOException;
import java.util.List;

public interface IController {
  //  PrgState oneStep(PrgState state) throws MyException, ControllerException, StackException, IOException, HeapException; /// exceptii
    void allStep() throws MyException, IOException, ControllerException, StackException, RepositoryException, HeapException, InterruptedException;

    public List<PrgState> removeCompletedPrg(List<PrgState> inPrgList);

}
