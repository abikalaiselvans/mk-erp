package com.my.org.erp.example.util.hashmap;

import java.util.Calendar;
import java.util.Hashtable;

public class HashTableExample 
{

	/**
	 * @param args
	 */
	public static void main(String[] args) 
	{
		 
		Hashtable<Address,Object> ht = new Hashtable<Address,Object>();
		ht.put(new Address("A",23), "kalai");
		ht.put(new Address("A",23), "kalai");
		ht.put(new Address("A",23), new Address("A",23));
		ht.put(new Address("A",23), new Address("A",23));
		ht.put(new Address("A",23), new Address("A",23));
		System.out.println(ht);
		
		Hashtable h = new Hashtable();
		h.put(new Integer("11"), "1");
		h.put(new Integer(11), "2");
		h.put(11, "2");
		h.put("001234", "");
		h.put("004464", "3");
		
		System.out.println(h);
		
		Calendar now = Calendar.getInstance();
		String[] monthName = { "January", "February", "March", "April", "May", "June", "July","August", "September", "October", "November", "December" };

		int year = now.get(Calendar.YEAR);
		int month = now.get(Calendar.MONTH);
		int date = now.get(Calendar.DATE);
		
		System.out.println(year);
		System.out.println(monthName[month]);
		System.out.println(date);
	}

}
