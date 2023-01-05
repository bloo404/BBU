package Repository;

import Exceptions.MyException;
import Exceptions.RepositoryException;
import Model.ADTs.PrgState;

import java.io.IOException;

public interface IRepository {
    PrgState getCrtPrg();
    String getLogFilePath();

    public void logPrgStateExec() throws IOException, RepositoryException;

    public void emptyLogFile() throws IOException;
}
