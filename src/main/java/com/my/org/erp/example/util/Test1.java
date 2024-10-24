package com.my.org.erp.example.util;

import java.util.regex.Pattern;

interface I
{
	int i=0;
}

class A implements I
{
	int i = I.i+1;;
}


public class Test1 extends A
{
	
	int i = I.i+2;
	static void printAll(A obj)
	{
		System.out.println(obj.i);
	}
	public static void main(String[] args) 
	{
		 
		String pattern = ".*Q[^u]\\d+\\..*";
	    String line = "Order QT300. Now!";
	    if (Pattern.matches(pattern, line)) {
	      System.out.println(line + " matches \"" + pattern + "\"");
	    } else {
	      System.out.println("NO MATCH");
	    }
	     
	    Pattern p = Pattern.compile(" ");
	    String tmp = "this is the String I want to split up";

	    String[] tokens = p.split(tmp);

	    for (int i = 0; i < tokens.length; i++) {
	      System.out.println(tokens[i]);
	    }
 
	}
}
