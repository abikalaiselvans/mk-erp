package com.my.org.erp.lang.examples;

import java.io.File;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLClassLoader;

class MainClass5 {
	  static void vaTest(int... v) {
	    System.out.print("vaTest(int ...): " + "Number of args: " + v.length + " Contents: ");

	    for (int x : v)
	      System.out.print(x + " ");

	    System.out.println();
	  }

	  static void vaTest(boolean... v) {
	    System.out.print("vaTest(boolean ...) " + "Number of args: " + v.length + " Contents: ");

	    for (boolean x : v)
	      System.out.print(x + " ");

	    System.out.println();
	  }

	  static void vaTest(String msg, int... v) {
	    System.out.print("vaTest(String, int ...): " + msg + v.length + " Contents: ");

	    for (int x : v)
	      System.out.print(x + " ");

	    System.out.println();
	  }

	  public static void main(String args[]) throws ClassNotFoundException {
	    vaTest(1, 2, 3);
	    vaTest("Testing: ", 10, 20);
	    vaTest(true, false, false);
	    
	    File file1 = new File("a");
	    File file2 = new File("a");
	    File file3 = new File("b");

	    int hc1 = file1.hashCode();
	    System.out.println(hc1);
	    int hc2 = file2.hashCode();
	    System.out.println(hc2);
	    int hc3 = file3.hashCode();
	    System.out.println(hc3);
	    
	    
	    
	    int ihc1 = System.identityHashCode(file1);
	    System.out.println(ihc1);
	    int ihc2 = System.identityHashCode(file2);
	    System.out.println(ihc2);
	    int ihc3 = System.identityHashCode(file3);
	    System.out.println(ihc3);

	    
	    File filew = new File("c:\\class\\");
	    URL url;
		try {
			url = filew.toURI().toURL();
		URL[] urls = new URL[] { url };
	    ClassLoader loader = new URLClassLoader(urls);
	    Class cls = loader.loadClass("user.informatin.Class");
		
		} catch (MalformedURLException e) {
			 
			 System.out.println(e.getMessage());
		} 
	    
	    
	  }
	}