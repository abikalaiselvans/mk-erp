package com.my.org.erp.example.util.hashmap;

import java.util.HashMap;
import java.util.Hashtable;

public class HashMapExample 
{

	public static void main(String[] arr) 
	{

		/* Create object of HashMap */
		
		HashMap<Address, String> obMap = new HashMap<Address, String>();
		
		/* Add value in HashMap */
		
		obMap.put(new Address("A",23), "kalai");
		obMap.put(new Address("A",23), "Bharat");
		obMap.put(new Address("A",23), "Gyan");
		obMap.put(new Address("A",23), "Vrishti");
		obMap.put(new Address("A",23), "Sarika");
		obMap.put(new Address("A",23), "Rohit");
		obMap.put(new Address("A",23), "Parineeta");
		obMap.put(new Address("A",23), "kalai");
		obMap.put(null, "A");
		obMap.put(null, "B");
		
		HashMap h = new HashMap();
		h.put("11", "11");
		h.put("11", "11");
		h.put(11, null);
		h.put(null, null);
		/* Display value of HashMap */
		
		System.out.println("Elements in HashMap : \n" + obMap);
		System.out.println(h);

	}

} 