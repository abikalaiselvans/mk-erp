package com.my.org.erp.example;

import java.util.HashMap;
class A
{
	
}

public class HashMapExample 
{
	public static void main(String[] args) 
	{
		
		String action="";
		HashMap  obMap = new HashMap();
		obMap.put(null, "Bharat");
		obMap.put(null, "Gyan");
		obMap.put(null, "Gyan");
		obMap.put(action, new A());
		obMap.put(action, new A());
		System.out.println("Elements in HashMap : \n" + obMap);
		
		String s = null;
		s = "1234";
		System.out.println(s.hashCode());
		s = s+"sdfd";
		System.out.println(s.hashCode());
	}
}
