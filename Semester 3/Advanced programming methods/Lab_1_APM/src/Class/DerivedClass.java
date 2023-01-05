package Class;

public class DerivedClass extends Base_class{
	public DerivedClass(String name) {
		super(name);
	//	Integer a = 1;
	}
	@Override
	public String toString() {
		return "DC:" + super.toString();
	}
}