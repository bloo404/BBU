package View;

import Controller.Controller;
import Exceptions.*;

import java.io.IOException;

public class RunExample extends Command {
    private Controller ctr;

    public RunExample(String key, String desc, Controller ctr) {
        super(key, desc);
        this.ctr = ctr;
    }

    @Override
    public void execute() {
        try {
            ctr.allStep();
        }catch (MyException | IOException | ControllerException | RepositoryException | StackException e) {
            throw new RuntimeException(e);
        } catch (HeapException e) {
            throw new RuntimeException(e);
        }
    }
}
