package Repository;

import Exceptions.MyException;
import Exceptions.RepositoryException;
import Model.ADTs.PrgState;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

public class Repository implements IRepository{
    PrgState crtState;
    String logFilePath;

    public Repository(PrgState state, String logFilePath){
        this.crtState = state;
        this.logFilePath = logFilePath;
    }

    @Override
    public String toString() {
        return "Repository{" +
                "crtState=" + crtState +
                ", logFilePath='" + logFilePath + '\'' +
                '}';
    }

    @Override
    public PrgState getCrtPrg() {
        return crtState;
    }

    @Override
    public String getLogFilePath() {
        return logFilePath;
    }

    @Override
    public void logPrgStateExec() throws IOException, RepositoryException {
        PrintWriter logFile;
        logFile = new PrintWriter(new BufferedWriter(new FileWriter(logFilePath, true))); // open
        logFile.write(getCrtPrg().toString()); // write
        logFile.close();
    }

    public PrgState getCrtState() {
        return crtState;
    }

    public void setCrtState(PrgState crtState) {
        this.crtState = crtState;
    }

    public void setLogFilePath(String logFilePath) {
        this.logFilePath = logFilePath;
    }

    @Override
    public void emptyLogFile() throws IOException {
        // to do
    }
}
