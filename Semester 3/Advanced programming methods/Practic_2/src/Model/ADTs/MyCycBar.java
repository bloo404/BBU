package Model.ADTs;

import Exceptions.PairException;
import javafx.util.Pair;

import java.util.HashMap;
import java.util.List;
import java.util.Set;
import java.util.concurrent.locks.ReentrantLock;

public class MyCycBar implements MyICycBar {
    HashMap<Integer, Pair<Integer, List<Integer>>> cyclicBarrier;
    ReentrantLock rl = new ReentrantLock();
    Integer freeSpot=0;

    public MyCycBar(){
        this.cyclicBarrier = new HashMap<>();
    }

    @Override
    public HashMap<Integer, Pair<Integer, List<Integer>>> getContent() {
        return this.cyclicBarrier;
    }

    @Override
    public void setContent(HashMap<Integer, Pair<Integer, List<Integer>>> newMap) {
        this.cyclicBarrier = newMap;
    }

    @Override
    public int newSpot() {
        freeSpot = freeSpot + 1;
        while(freeSpot == 0 || cyclicBarrier.containsKey(freeSpot))
            freeSpot = freeSpot + 1;
        return freeSpot;
    }

    @Override
    public int add(Pair<Integer, List<Integer>> pair) {
        freeSpot = newSpot();
        cyclicBarrier.put(freeSpot,pair);
        Integer result = freeSpot;
        return result;
    }

    @Override
    public void update(Integer position, Pair<Integer, List<Integer>> pair) throws PairException {
        if(!cyclicBarrier.containsKey(position))
            throw new PairException((String.format("MyCycBarr update exception: %d does not appear into the CyclicBarrier.",position)));
        cyclicBarrier.put(position,pair);
    }

    @Override
    public Pair<Integer, List<Integer>> get(Integer position) throws PairException {
        if(!cyclicBarrier.containsKey(position))
            throw new PairException((String.format("MyCycBarr get exception: %d does not appear into the CyclicBarrier. ",position)));
        return cyclicBarrier.get(position);
    }

    @Override
    public boolean containsKey(Integer position) {
        return this.cyclicBarrier.containsKey(position);
    }

    @Override
    public void remove(Integer pos) throws PairException {
        if(!containsKey(pos))
            throw new PairException((String.format("%d does not appear into the cyclic barrier.",pos)));
        freeSpot = pos;
        this.cyclicBarrier.remove(pos);
    }

    @Override
    public Set<Integer> keySet() {
        return cyclicBarrier.keySet();
    }

    @Override
    public boolean isDefined(Integer pos) {
        for(Integer pos2: cyclicBarrier.keySet())
            if(pos == pos2)
                return true;
        return false;
    }

    @Override
    public Pair<Integer, List<Integer>> lookup(Integer pos) {
        rl.lock();
        try {
            return cyclicBarrier.get(pos);
        } finally {
            rl.unlock();
        }
    }

    @Override
    public void setCycBar(HashMap<Integer, Pair<Integer, List<Integer>>> chickBar) {
        this.cyclicBarrier = chickBar;
    }

    @Override
    public HashMap<Integer, Pair<Integer, List<Integer>>> getBar() {
        return this.cyclicBarrier;
    }

    @Override
    public Integer getFreeSpot() {
        return this.freeSpot;
    }

    @Override
    public void setFreeSpot(Integer pos) {
        this.freeSpot = pos;
    }

    @Override
    public String toString() {
        return "MyCycBar{" +
                "cyclicBarrier=" + cyclicBarrier +
                ", rl=" + rl +
                ", freeSpot=" + freeSpot +
                '}';
    }
}
