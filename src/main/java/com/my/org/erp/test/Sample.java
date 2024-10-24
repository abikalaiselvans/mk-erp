package com.my.org.erp.test;

 
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
 

class A {
	public void diaplay() {
		System.out.println("IN A CLASS");
	}
}

class B extends A {
	public void diaplay() {
		System.out.println("IN B CLASS");
	}

	public void diaplay1() {
		System.out.println("IN C CLASS");
	}
}

public class Sample {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		 
		A a = new B();
		HashMap<Object, String> newmap = new HashMap();

		// populate hash map
		newmap.put(null, "null");
		newmap.put(1, null);
		newmap.put(new A(), "calaa A");

		newmap.put(2, "point");
		// newmap.put(1, "point");
		newmap.put(null, "null");
		newmap.put(3, "is best");
		newmap.put(new A(), "calaa A");
		 
		Set set = newmap.entrySet();
		// Get an iterator
		Iterator i = set.iterator();
		// Display elements
		while (i.hasNext()) {
			Map.Entry me = (Map.Entry) i.next();
			System.out.print(me.getKey() + ": ");
			System.out.println(me.getValue());
		}
		System.out.println();
		a.diaplay();

	}
}
