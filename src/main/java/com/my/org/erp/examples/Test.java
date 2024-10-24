package com.my.org.erp.examples;

public class Test {
	public enum Dogs {collie, harrier, shepherd};
	public static void main(String [] args) {
	 Dogs myDog = Dogs.shepherd;
	 switch (myDog) {
	 case collie:
	 System.out.print("collie ");
	 default:
	 System.out.print("retriever ");
	 case harrier:
	 System.out.print("harrier ");
	  }
	  }
	  }
	 