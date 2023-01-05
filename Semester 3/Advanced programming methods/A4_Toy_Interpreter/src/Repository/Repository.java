package Repository;

import Exceptions.MyException;
import Exceptions.RepositoryException;
import Model.ADTs.PrgState;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

public class Repository implements IRepository{
    List<PrgState> PrgStateList;
    String logFilePath;

    public Repository(PrgState state, String logFilePath){
        this.PrgStateList = new LinkedList<>();
        this.PrgStateList.add(state);
        this.logFilePath = logFilePath;
    }

    @Override
    public String toString() {
        return "Repository{" +
                "PrgStateList=" + PrgStateList +
                ", logFilePath='" + logFilePath + '\'' +
                '}';
    }

    /* @Override
    public PrgState getCrtPrg() {
        return crtState;
    }*/

    @Override
    public String getLogFilePath() {
        return logFilePath;
    }

    @Override
    public List<PrgState> getPrgList() {
        return PrgStateList;
    }

    @Override
    public void setPrgList(List<PrgState> program) {
        this.PrgStateList = program;
    }

    @Override
    public void logPrgStateExec(PrgState prgState) throws IOException, RepositoryException {
        PrintWriter logFile;
        logFile = new PrintWriter(new BufferedWriter(new FileWriter(logFilePath, true))); // open
        logFile.write(prgState.toString()); // write
        logFile.close();
    }
/*
    public PrgState getCrtState() {
        return crtState;
    }

    public void setCrtState(PrgState crtState) {
        this.crtState = crtState;
    }

 */

    public void setLogFilePath(String logFilePath) {
        this.logFilePath = logFilePath;
    }

    @Override
    public void emptyLogFile() throws IOException {
        // to do
    }
}
