package Class;

public class Class_1 {
	public static void main(String[] args) {
		/// Printing Hello
		System.out.println("Hello!");
		System.out.println("-------------------------------");
		
		/// Printing 1 2 3
		System.out.println(args[0]);
		System.out.println(args[1]);
		System.out.println(args[2]);
		
		/// Printing 1 from string to integer
		System.out.println("-------------------------------");
		String nr = args[0];	
		Integer nr_int = Integer.parseInt(nr);
		System.out.println(nr_int);
		System.out.println("-------------------------------");
		
		/// Printing average 
		Integer sum=0;
		Integer leng = args.length;
		for(int i=0;i<leng;i++) {
			sum += Integer.parseInt(args[i]);
		}
		System.out.println(sum/leng);
		System.out.println("-------------------------------");
		
		/// Working with Base_class
		Base_class baclava = new Base_class("baclavaua 1 <3");
		System.out.println(baclava); /// Printing the object of Base_class
		/** System.out.println(baclava.name); /// Printing the name **/
		System.out.println(baclava.toString()); /// Printing the method toString from Base_class
		System.out.println("-------------------------------");
		
		/// Working with DerivedClass
		DerivedClass derivata = new DerivedClass("b");
		System.out.println(derivata.toString());
		System.out.println("-------------------------------");
		
		/// Working with override, increment of Base_class
		Base_class alta_baclava = new Base_class("baclavaua 2 <3");
		System.out.println(baclava.toString());
		//baclava.increment();
		System.out.println(baclava.toString());
	//	alta_baclava.increment();
		System.out.println(alta_baclava.toString());
		Base_class.increment();
		System.out.println("-------------------------------");
		
		/// Exceptions
		try {
		//	int a=5/0;
		}catch(Exception e) {
			System.out.println(e.toString());
			e.printStackTrace(); /// cu rosu si zice si unde e eroarea si linia
		}
		
		
	}
	
}