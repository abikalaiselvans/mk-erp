package com.my.org.erp.example.util;

public class AbstractSample {

	/**
	 * @param args
	 */
	public static void main(String[] args) 
	{
		 

		Cat c = new Cat();
		c.checkup();
	}

}



abstract class Animal 
{
	
	Animal()
	{
		System.out.println("Super class Constructor");
	}
	
	public abstract void checkup() throws Exception;
	{
		//System.out.println("Kalaiselvan");
	}
}

class Dog extends Animal 
{
	Dog()
	{
		System.out.println("Constructor");
	}
	public void checkup() throws Exception
	{ 
		// implement Dog-specific code
		System.out.println("Karuppaiah");
	}
	
}
	
class Cat extends Dog 
{
	public void checkup() throws ArithmeticException 
	{ 
		// implement Cat-specific code
		System.out.println("Kamalam");
	}
}

