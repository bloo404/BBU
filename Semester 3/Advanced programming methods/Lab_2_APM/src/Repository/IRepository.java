package Repository;

import Model.IVehicle;

public interface IRepository {
	
	public void add(IVehicle vehicle);
	public IVehicle[] get_all();
	
}
