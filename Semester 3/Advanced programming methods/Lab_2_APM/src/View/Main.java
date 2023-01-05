package View;

import Controller.*;
import Model.*;
import Repository.*;

public class Main {
	public static void main(String args[]) {
		IVehicle v1=new Car("pink");
		IVehicle v2=new Bike("red");
		IVehicle v3=new Car("red");
		IVehicle v4=new Bike("red");
	
		IRepository repository=new Repository(3);
		
		Controller controller=new Controller(repository);
		
		controller.add(v1);
		controller.add(v2);
		controller.add(v3);
		controller.add(v4);
		
		controller.print_solution("red");
	}
}
