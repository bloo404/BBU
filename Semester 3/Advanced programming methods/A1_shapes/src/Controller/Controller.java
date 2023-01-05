package Controller;

import java.util.Objects;

import Model.Cube;
import Model.Cylinder;
import Model.IGeometricBody;
import Model.Sphere;
import Repository.IRepository;

public class Controller {
	private IRepository repository;
	
	public Controller(IRepository repository) {
		this.repository = repository;
	}
	
	public void add(String type, float volume) {
		if(type== "cube") {
			Cube cube = new Cube(volume);
			this.repository.add(cube);
		}
		else if (type=="sphere") {
			Sphere sphere = new Sphere(volume);
			this.repository.add(sphere);
		}
		else if (type== "cylinder") {
			Cylinder cylinder = new Cylinder(volume);
			this.repository.add(cylinder);
		}
	}
	
	public void delete(int index) {
		this.repository.delete(index);
	}
	
	public IGeometricBody[] getAll() {
		return this.repository.getAll();
	}
	
	public int getSize() {
		return this.repository.getSize();
	}
	
	public IGeometricBody[] isVolumeBiggerThan25cm3(float volume) {
		IGeometricBody[] body = new IGeometricBody[this.repository.getSize()];
		int size = 0;
		for(IGeometricBody a_body: this.repository.getAll()) {
			if(a_body!=null)
				if(a_body.getVolume() > volume)
					body[size++] = a_body;
		}
		IGeometricBody[] result = new IGeometricBody[size];
		System.arraycopy(body, 0, result, 0, size);
		return result;
	}
}
