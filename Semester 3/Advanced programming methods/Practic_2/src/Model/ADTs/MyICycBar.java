package Model.ADTs;

import Exceptions.PairException;
import javafx.util.Pair;

import java.util.HashMap;
import java.util.List;
import java.util.Set;

public interface MyICycBar {
    HashMap<Integer, Pair<Integer, List<Integer>>> getContent();
    public void setContent(HashMap<Integer, Pair<Integer, List<Integer>>> newMap);
    public int newSpot();
    int add(Pair<Integer, List<Integer>> pair);
    void update(Integer position, Pair<Integer, List<Integer>> pair) throws PairException;
    Pair<Integer, List<Integer>> get(Integer position) throws PairException;
    boolean containsKey(Integer position);
    void remove(Integer pos) throws PairException;
    Set<Integer> keySet();
    boolean isDefined(Integer pos);
    Pair<Integer, List<Integer>> lookup(Integer pos);
    public void setCycBar(HashMap<Integer, Pair<Integer, List<Integer>>> chickBar);
    public HashMap<Integer, Pair<Integer, List<Integer>>> getBar();
    public Integer getFreeSpot();
    public void setFreeSpot(Integer pos);
}
