package Model;

public class Cube implements IGeometricBody{

	private float volume;
	
	public Cube(float volume) {
		this.volume = volume;
	}
	
	@Override
	public String toString() {
		return "Cube | Volume: " + this.volume;
	}
	
	@Override
	public void setVolume(float volume) {
		this.volume = volume;
	}
	
	@Override
	public boolean isVolumeBiggerThan25cm3(float volume) {
		if (this.volume > volume)
			return true;
		return false;
	}

	@Override
	public float getVolume() {
		return this.volume;
	}

}
