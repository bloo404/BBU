package Model;

public class Bike implements IVehicle{
	private String color;
	
	public Bike(String color) {
		this.color=color;
	}
	
	public String toString() {
		return "Bike | Color:"+this.color;
	}
	
	public boolean isRed(String color) {
		return (this.color.compareTo(color)==0); // like a strstr
	}
	
}
