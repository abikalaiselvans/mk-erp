package com.my.org.erp.example.util;

import java.util.HashMap;
import java.util.Hashtable;

public class Hashtable1 {

	/**
	 * @param args
	 * 
	 * Hashtable is basically a datastructure to retain values of key-value pair.

    It didn’t allow null for both key and value. You will get NullPointerException 
    if you add null value.
    It is synchronized. So it comes with its cost. Only one thread can access in one time

	 */
	public static void main(String[] args) {
		try {
			 
			Hashtable cityTable = new Hashtable();
			String s=null ;
			cityTable.put(1, "Lahore");
			cityTable.put(2, "Karachi");
			cityTable.put(3, "Karachi");
			cityTable.put(4, "111");
			cityTable.put("", "");
			 
			//cityTable.put(3, null); /* NullPointerEcxeption at runtime*/
			 System.out.println(new df());
			 System.out.println(new String());
			 System.out.println(cityTable.size());
			System.out.println(cityTable);
  
			
			HashMap productMap = new HashMap();
			productMap.put(1, "Keys");
			productMap.put(2, null);
			productMap.put(null, null);
			productMap.put(null, "");
			productMap.put("", null);
			productMap.put("", "");
			
			System.out.println(productMap);
		} catch (Exception e) {
			
			e.printStackTrace();
			System.out.println(e.getMessage());
		}
		
	}

	
}
class df
{

}