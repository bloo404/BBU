package Model;

public interface IGeometricBody {
	
	public float volume = 0;
	public boolean isVolumeBiggerThan25cm3(float volume);
	public float getVolume();
	void setVolume(float volume);
	String toString();

}