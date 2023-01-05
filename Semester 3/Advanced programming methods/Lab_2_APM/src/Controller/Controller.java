package Controller;

import Model.IVehicle;
import Repository.IRepository;

public class Controller {
	private IRepository repository;
	
	public Controller(IRepository repository) {
		this.repository = repository;
	}
	
	public void add(IVehicle vehicle) {
		this.repository.add(vehicle);
	}
	
	public void print_solution(String color) {
		IVehicle[] vehicles = repository.get_all();
		for(int i=0;i<vehicles.length;i++) {
			if(vehicles[i].isRed(color)) {
				System.out.println(vehicles[i].toString());
			}
		}
	}
}