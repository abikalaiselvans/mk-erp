package com.my.org.erp.example.util;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class HASHTABLE {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		 

		
		 Hashtable<String, String> ht = new Hashtable<String, String>();
		    ht.put("1", "One");
		    ht.put("2", "Two");
		    ht.put("3", "Three");

		    boolean blnExists = ht.containsKey("2");
		    System.out.println("2 exists in Hashtable ? : " + blnExists);
		    
		    blnExists = ht.contains("Two");
		    System.out.println("Two exists in Hashtable ? : " + blnExists);
		    
		    
		    Collection c = ht.values();
		    Iterator itr = c.iterator();
		    while (itr.hasNext()){
		      System.out.println(itr.next());
		    }
		    c.remove("One");

		    Enumeration e = ht.elements();

		    while (e.hasMoreElements()){
		      System.out.println(e.nextElement());
		    }
		    
		    
		    Hashtable<String,String> htq = new Hashtable<String,String>();
		    System.out.println("Size of Hashtable : " + htq.size());
		    htq.put("1", "One");
		    htq.put("2", "Two");
		    htq.put("3", "Three");
		    System.out.println(htq.size());
		   // Object obj = htq.remove("2");
		    //System.out.println(htq.size());
		    
		    System.out.println();
		    e = htq.keys();
		    while (e.hasMoreElements()){
		      System.out.println(e.nextElement());
		    }
		    
		    //ht.clear();
		    //System.out.println(ht.size());
		    System.out.println();
		    Enumeration keys = ht.keys();
		    while (keys.hasMoreElements()) {
		      Object key = keys.nextElement();
		      Object value = ht.get(key);
		      
		      System.out.println(key+" : "+value);
		    }
		    
		    
		    
		    //Object obj = ht.remove("2");
		    //System.out.println(obj + " was Removed ");
		    e = ht.elements();
		    while (e.hasMoreElements()){
		      System.out.println(e.nextElement());
		    }
		    
		    
		    Hashtable<String, String> h = new Hashtable<String, String>();
		    h.put("a", "b");
		    h.put("c", "d");
		    h.put("e", "f");
		    for (String str : h.keySet()) {
		      System.out.println(str);
		    }
		    List<String> v = new ArrayList<String>(h.keySet());
		    Collections.sort(v);
		    for (String str : v) {
		      System.out.println(str + " " + (String) h.get(str));
		    }
		    
		    
		    String names[] = { "Mercury", "Venus", "Earth", "Mars", "Jupiter",
		            "Saturn", "Uranus", "Neptune", "Pluto" };
		        float diameters[] = { 4800f, 12103.6f, 12756.3f, 6794f, 142984f,
		            120536f, 51118f, 49532f, 2274f };
		        Hashtable hash = new Hashtable();
		        for (int i = 0, n = names.length; i < n; i++) {
		          hash.put(names[i], new Float(diameters[i]));
		        }
		        e = hash.keys();
		        Object obj;
		        while (e.hasMoreElements()) {
		          obj = e.nextElement();
		          System.out.println(obj + ": " + hash.get(obj));
		        }
		        
		        
		    
		        
		        
		        Map map = new HashMap();

		        // The hash maps from company name to address.
		        // In real life this might map to an Address object...
		        map.put("Adobe", "Mountain View, CA");
		        map.put("IBM", "White Plains, NY");
		        map.put("Learning Tree", "Los Angeles, CA");
		        map.put("Microsoft", "Redmond, WA");
		        map.put("Netscape", "Mountain View, CA");
		        map.put("O'Reilly", "Sebastopol, CA");
		        map.put("Sun", "Mountain View, CA");

		        // List the entries using entrySet()
		        Set entries = map.entrySet();
		        Iterator it = entries.iterator();
		        while (it.hasNext()) {
		          Map.Entry entry = (Map.Entry) it.next();
		          System.out.println(entry.getKey() + "-->" + entry.getValue());
		        }
		    
	}

}
