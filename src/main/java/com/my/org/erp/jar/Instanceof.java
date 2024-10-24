package com.my.org.erp.jar;

import java.util.ArrayList;
import java.util.Vector;


class Parent {
	  public Parent() {

	  }
	}

	class Child extends Parent {
	  public Child() {
	    super();
	  }
	}

	
	
	class Animal {
		  public String toString() {
		    return "This is an animal ";
		  }
		}
		class Dog extends Animal {
		  public void sound() {
		    System.out.println("Woof Woof");
		  }
		}

		
		
	
public class Instanceof {
	  public static void main(String[] a) {

	    String s = "Hello";

	    if (s instanceof java.lang.String) {
	      System.out.println("is a String");
	    }
	    
	    
	    
	    Child child = new Child();
	    if (child instanceof Parent) {
	      System.out.println("true");
	    }

	    
	    
	    
	    Dog aDog = new Dog();
	    if (aDog instanceof Animal) {
	      Animal ani = (Animal) aDog;
	      System.out.println(ani);
	    }
	    
	   
	    
	    
	    Object testObject = new Vector();
	    if (testObject instanceof Vector)
	      System.out.println("Object was an instance of the class java.util.Vector");
	    else if (testObject instanceof ArrayList)
	      System.out.println("Object was an instance of the class java.util.ArrayList");
	    else
	      System.out.println("Object was an instance of the " + testObject.getClass());

	    
	    
	  }

	}

