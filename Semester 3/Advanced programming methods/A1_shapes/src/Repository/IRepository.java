package Repository;

import Model.IGeometricBody;

public interface IRepository {

	public void add(IGeometricBody body); // create & add
	public void delete(int index); // delete
	
	public IGeometricBody[] getAll();
	int getSize();
	
}
