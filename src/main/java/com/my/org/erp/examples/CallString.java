package com.my.org.erp.examples;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

public class CallString {

	/**
	 * @param args
	 */
	public static void main(String[] args) 
	{
		 

		
		
		List  l = new ArrayList();
		l.add("1");
		l.add("2");
		l.add("3");
		l.add("4");
		List  l1  = (l);
		l1.add("5");
		System.out.println(l.contains("5"));
		
		System.out.println(l);
		 
		function1(l);
		System.out.println(l); 
	}

	public static void  function1(List s)
	{
		s.add("dsds");
		System.out.println(s);
		
	}
	
}
