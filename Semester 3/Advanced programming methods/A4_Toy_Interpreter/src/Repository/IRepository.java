package Repository;

import Exceptions.MyException;
import Exceptions.RepositoryException;
import Model.ADTs.PrgState;

import java.io.IOException;
import java.util.List;

public interface IRepository {
    // PrgState getCrtPrg();
    String getLogFilePath();

    public List<PrgState> getPrgList();
    public void setPrgList(List<PrgState> program);

    public void logPrgStateExec(PrgState prgState) throws IOException, RepositoryException;

    public void emptyLogFile() throws IOException;
}
