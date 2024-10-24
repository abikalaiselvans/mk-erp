package com.my.org.erp.example;

import java.io.Console;

public class Test {

	/**
	 * @param args
	 */
	int counter =0;
	public static void main(String[][]...  args) {
		// TODO Auto-generated method stub

		String s=null;
		 
		new Test().display();
		
		 Boolean test = new Boolean(true);
		 int x = 343;
		 Integer y = new Test().go(test, x);
		 System.out.println(y);
 		  
		 
	}

	public  void display()
	{
		System.out.println("display method");
	}
	
	
	
	int go(Boolean b, int i) 
	{
	  if(b) return i = 0;;
	  return (i/49);
	 }
	 
	
}
