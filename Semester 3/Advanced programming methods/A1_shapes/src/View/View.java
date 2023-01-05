package View;

import java.util.Objects;

import Controller.Controller;
import Exceptions.InputException;
import Model.IGeometricBody;

public class View {
	private final Controller controller;
	
	public View(Controller controller) {
		this.controller = controller;
	}
	
	private static void menu() {
		System.out.println("----------------------------------");
		System.out.println("---------------MENU---------------");
		System.out.println("----------------------------------");
		System.out.println("1. View all geometric bodies");
        System.out.println("2. Add a geometric bodies");
        System.out.println("3. Remove a geometric body");
        System.out.println("4. See all bodies > 25 cm^3 ");
        System.out.println("0. Exit");
        System.out.println("----------------------------------");
        System.out.println("----------------------------------");
        System.out.println("");
	}
	
	private void print_bodies() {
		IGeometricBody[] bodies = this.controller.getAll();
		if(this.controller.getSize()==0)
			System.out.println("ERROR 404: No geometric body found.");
		else {
			for(int i=0;i<this.controller.getSize();i++) {
				System.out.println((i+1) + " | " + bodies[i].toString());
			}
		}
	}
	
	private void addBody(String type, float volume) throws InputException{
		if (type=="cube" || type== "sphere" || type=="cylinder") {
            if (volume <= 0) {
                throw new InputException("Volume cannot be negative.");
            } else {
                this.controller.add(type, volume);
            }
        } else {
            throw new InputException("ERROR 404: that type is not in our database.");
        }
	}
	
	private void deleteBody(int index) throws InputException {
	        if (this.controller.getSize() != 0) {
	            if (index - 1 >= 0 && index - 1 < this.controller.getSize()) {
	                this.controller.delete(index - 1);
	            } else {
	                throw new InputException("Index out of range.");
	            }
	        } else {
	            throw new InputException("There are no geometric bodies in the list.");
	        }
	    }
	
	 private void showBodiesWithCondition(float volume) throws InputException {
	        if (volume <= 0) {
	            throw new InputException("Volume cannot be negative.");
	        } else {
	            if (this.controller.getSize() != 0) {
	                IGeometricBody[] bodies = this.controller.isVolumeBiggerThan25cm3(volume);
	                if (bodies.length == 0) {
	                    System.out.println("There are no bodies with the given volume.");
	                } else {
	                    int index;
	                    for (index = 0; index < bodies.length; index++) {
	                        System.out.println((index + 1) + " | " + bodies[index].toString());
	                    }
	                }
	            } else {
	                throw new InputException("No geometric bodies found.");
	            }
	        }
	    }
	 
	 public void start() {
	        boolean done = false;
	       
	            	IGeometricBody[] bodies = new IGeometricBody[10];
	            	try {
						addBody("cube",(float) 0);
					} catch (InputException e5) {
						// TODO Auto-generated catch block
						e5.printStackTrace();
					}
	            	try {
						addBody("sphere",(float) 25);
					} catch (InputException e5) {
						// TODO Auto-generated catch block
						e5.printStackTrace();
					}
	            	try {
						addBody("cylinder",(float) 23);
					} catch (InputException e5) {
						// TODO Auto-generated catch block
						e5.printStackTrace();
					}
	            	try {
						addBody("cube",(float) 28);
					} catch (InputException e5) {
						// TODO Auto-generated catch block
						e5.printStackTrace();
					}
	            	try {
						addBody("cube",(float) 30);
					} catch (InputException e5) {
						// TODO Auto-generated catch block
						e5.printStackTrace();
					}
	            	try {
						addBody("sphere",(float) 36);
					} catch (InputException e5) {
						// TODO Auto-generated catch block
						e5.printStackTrace();
					}
	            	try {
						addBody("sphere",(float) 19);
					} catch (InputException e6) {
						// TODO Auto-generated catch block
						e6.printStackTrace();
					}
	            	try {
						addBody("cube",(float) 9);
					} catch (InputException e5) {
						// TODO Auto-generated catch block
						e5.printStackTrace();
					}
	            	try {
						addBody("sphere",(float) 12);
					} catch (InputException e5) {
						// TODO Auto-generated catch block
						e5.printStackTrace();
					}
	            	try {
						addBody("cylinder",(float) 14);
					} catch (InputException e5) {
						// TODO Auto-generated catch block
						e5.printStackTrace();
					}
	            	
	            	System.out.println("Showing all bodies.");
	            	System.out.println();
	            	
	            	print_bodies();
	            	
	            	System.out.println();
	            	
	            	try {
						deleteBody(4);
					} catch (InputException e4) {
						// TODO Auto-generated catch block
						e4.printStackTrace();
					}
	            	
	            	System.out.println("Now deleting something.");
	            	System.out.println("Showing all bodies.");
	            	System.out.println();
	            	
	            	print_bodies();
	            	
	            	System.out.println();
	            	System.out.println("Showing all bodies with the given condition (v>25)");
	            	System.out.println();
	            	
	            	
	            	try {
						showBodiesWithCondition(25);
					} catch (InputException e3) {
						// TODO Auto-generated catch block
						e3.printStackTrace();
					}
	            	
	            	System.out.println();
	            	System.out.println("Now deleting something.");
	            	System.out.println("Showing bodies after deletion.");
	            	System.out.println();
	            	
	            	try {
						deleteBody(3);
					} catch (InputException e2) {
						// TODO Auto-generated catch block
						e2.printStackTrace();
					}
	            	
	            	print_bodies();
	            	
	            	System.out.println();
	            	
	            	System.out.println("Showing bodies with volume higher than 30.");
	            	
	            	try {
						showBodiesWithCondition(30);
					} catch (InputException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
	            	
	            	System.out.println();
	            	
	            	System.out.println("Bodies with volume higher than 5.");
	            	
	            	try {
						showBodiesWithCondition(5);
					} catch (InputException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
	            	
	            	System.out.println();
	            	
	            	done = true;
	 }
}
