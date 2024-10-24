package com.my.org.erp.examples;

public class Breaker {

	static String o = "";
	 public static void main(String[] args) {
	 
	 
	 try {
		 args = null;
		  args[0] = "test";
		 System.out.println(args[0]);
		 } catch (Exception ex) {
		 System.out.println("Exception");
		 }  
		  
		 
	 
	 }
}
