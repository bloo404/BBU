package Repository;

import Model.IGeometricBody;

public class Repository implements IRepository{
	
	private IGeometricBody[] geometricBodies;
	private int number_of_geometric_bodies;
	
	public Repository(int size) {
	        if (size <= 0) {
	            throw new ArithmeticException("Size is too small.");
	        }
	        this.geometricBodies = new IGeometricBody[size];
	        this.number_of_geometric_bodies = 0;
	    }
	
	@Override
	public void add(IGeometricBody geometricBody) {
		try {
			this.geometricBodies[this.number_of_geometric_bodies] = geometricBody;
			this.number_of_geometric_bodies++;
		}
		catch(Exception e){
			System.out.println(e.toString());
		}
	}
	
	@Override
	public void delete(int index) {
		try {
			int x=0;
			IGeometricBody[] bodies = new IGeometricBody[this.number_of_geometric_bodies - 1];
	        for (int i = 0; i < this.number_of_geometric_bodies; i++) {
	            if (i != index) {
	            	bodies[x] = this.geometricBodies[i];
	                x++;
	            }
	        }
	        this.geometricBodies = bodies;
	        this.number_of_geometric_bodies--;
		}
		catch(Exception e) {
			System.out.println(e.toString());
		}
	}
	
	@Override
	public IGeometricBody[] getAll() {
		return this.geometricBodies;
	}


	@Override
	public int getSize() {
		return this.number_of_geometric_bodies;
	}
	
}