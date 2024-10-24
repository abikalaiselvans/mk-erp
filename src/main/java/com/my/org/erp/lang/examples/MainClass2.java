package com.my.org.erp.lang.examples;

public class MainClass2 {
	  public static void main(String[] args) {
	    printAll(2, "two", 4, "four", 4.5, "four point five"); 
	    printAll();
	    printAll(25, "Anything goes", true, 4E4, false);
	  }
	  public static void printAll(Object... args) {
	    for (Object arg : args) {
	      System.out.print("  " + arg);
	    }
	    System.out.println();
	  }
	}

