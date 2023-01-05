package Repository;

import Model.IVehicle;

public class Repository implements IRepository{

	private IVehicle[] vehicles;
	private int current_size;

	public Repository(int max_size) {
		this.current_size=0;
		this.vehicles = new IVehicle[max_size]; // nu e musai this.vehicles, vehicles e musai
	}
	
	public void add(IVehicle vehicle) {
		try {
		this.vehicles[this.current_size]=vehicle;
		this.current_size++;}
		catch(Exception e){
			System.out.println(e.toString());
		}
	}
	
	public IVehicle[] get_all() {
		return this.vehicles;
	}
	
}