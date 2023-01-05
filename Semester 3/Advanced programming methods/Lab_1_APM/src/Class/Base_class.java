package Class;

public class Base_class {
	private String name;
	
	/* 		Daca e static apartine de clasa si oricare obicet da nr++ o sa creasca acelasi nr
		la toate obiectele, e un nr universal
	*/
	private static Integer nr=0;  
	
	/// Constructor
	public Base_class(String name) {
		this.name = name;
	}
	
	public String toString() {
		return this.name + " " + nr;
	}
	
	static void increment() {
		nr+=1;
	}

}
