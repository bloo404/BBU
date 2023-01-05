package Model;

public class Car implements IVehicle{
	private String color;
	
	public Car(String color){
		this.color	=	color;
	}
	
	public String toString() {
		return "Car | Color: "	+	this.color;
	}
	
	public boolean isRed(String color) {
		return (this.color.compareTo(color)	==	0); // like a strstr
	}

}