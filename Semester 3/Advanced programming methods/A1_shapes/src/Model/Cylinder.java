package Model;

public class Cylinder implements IGeometricBody{
	
	private float volume;
	
	public Cylinder(float volume) {
		this.volume = volume;
	}
	
	@Override
	public String toString() {
		return "Cylinder | Volume: " + this.volume;
	}
	
	@Override
	public void setVolume(float volume) {
		this.volume = volume;
	}
	
	@Override
	public boolean isVolumeBiggerThan25cm3(float volume) {
		if(this.volume > volume)
			return true;
		return false;
	}

	@Override
	public float getVolume() {
		return this.volume;
	}
	
}
