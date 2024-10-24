package com.my.org.erp.example.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;

public class HASHMAP {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		 

		
		
		HashMap<String, String> hMap = new HashMap<String, String>();
	    hMap.put("1", "One");
	    hMap.put("2", "Two");
	    hMap.put("3", "Three");

	    Collection c = hMap.values();
	    Iterator itr = c.iterator();
	    while (itr.hasNext()) {
	      System.out.println(itr.next());
	    }
	    
	    HashMap hashMap = new HashMap();
	    Map map = Collections.synchronizedMap(hashMap);
	    
	    boolean blnExists = hMap.containsKey("3");
	    System.out.println("3 exists in HashMap ? : " + blnExists);
	    
	    
	    
	    Set st = hMap.keySet();
	    itr = st.iterator();

	    while (itr.hasNext())
	      System.out.println(itr.next());

	    // remove 2 from Set
	    //st.remove("2");

	    System.out.println(hMap.containsKey("2"));
	    
	    
	    System.out.println("Size of HashMap after addition : " + hMap.size());

	    // remove one element from HashMap
	    //System.out.println(hMap.remove("2"));
	    
	    //Object obj = hMap.remove("2");
	   // System.out.println(obj + " Removed from HashMap");
	    
	   // hMap.clear();
	   // System.out.println(hMap.size());
	    System.out.println("-----");
	    Hashtable<String, String> ht = new Hashtable<String, String>();
	    ht.put("1", "REPLACED !!");
	    ht.put("4", "Four");

	    Enumeration e = ht.elements();
	    while (e.hasMoreElements()){
	      System.out.println(e.nextElement());
	    }      

	    System.out.println("--------");
	    ht.putAll(hMap);
	    e = ht.elements();

	    while (e.hasMoreElements()){
	      System.out.println(e.nextElement());
	    }      
	    
	    
	    
	    Map<String, String> yourMap = new HashMap<String, String>();
	    yourMap.put("1", "one");
	    yourMap.put("2", "two");
	    yourMap.put("3", "three");

	    Map<String, String> sortedMap = new TreeMap<String, String>(yourMap);

	    System.out.println(sortedMap);
	    
	    System.out.println();
	    Map maps = new HashMap();

	   
	    
	    for (Iterator it = hMap.keySet().iterator(); it.hasNext();) {
	      String  key = (String)it.next();
	      System.out.println(key );
	    }
	    
	    
	    
	    for (Iterator it = hMap.values().iterator(); it.hasNext();) {
		      String  key = (String)it.next();
		      System.out.println(key );
		    }
	    
	    
	    for (Iterator it = hMap.entrySet().iterator(); it.hasNext();) {
		    Map.Entry  me= (Map.Entry) it.next();
		     System.out.println(me.getKey()  +"-" +me.getValue());
		      
		    }
	    
	    
	    System.out.println();
	    
	    
	    
	     map = new HashMap();

	    // Create int wrapper object
	    Integer refInt = new Integer(123);

	    // Store int in map
	    map.put("key", refInt);

	    // Get int value from map
	    refInt = (Integer) map.get("key");

	    // Get the integer value from wrapper object
	    int i = refInt.intValue();
	    System.out.println(i);
	    
	    List stuff = Arrays.asList(new String[] { "a", "b" });
	    List list = new ArrayList(stuff);
	    List list2 = new LinkedList(list);
	    Set set = new HashSet(stuff);
	    Set set2 = new TreeSet(set);
	    Map mapq = new HashMap();
	    Map map2 = new TreeMap(mapq);
	
	    System.out.println(list);
	    System.out.println(list2);
	    System.out.println(set);
	    System.out.println(set2);
	    System.out.println(mapq);
	    
	    System.out.println();
	    
	    
	    Map errors = new HashMap();

	    errors.put("404", "A.");
	    errors.put("403", "B.");
	    errors.put("500", "C.");

	    String errorDesc = (String) errors.get("404");
	    System.out.println("Error 404: " + errorDesc);

	    Iterator iterator = errors.keySet().iterator();
	    while (iterator.hasNext()) {
	      String key = (String) iterator.next();
	      System.out.println("Error " + key + " means " + errors.get(key));
	    }
	    
	    
	    
	    
	    Map<String, Integer> m = new HashMap<String, Integer>();
	    m.put("404", 12);
	    m.put("403", 122);
	    m.put("500", 1222);
        // Initialize frequency table from command line
        for (String a : args) {
            Integer freq = m.get(a);
            m.put(a, (freq == null) ? 1 : freq + 1);
        }

        System.out.println(m.size() + " distinct words:");
        System.out.println(m);
	    
        
        
        
        
        
        
        Map<Integer, String> map1 = new HashMap<Integer, String>();

        map1.put(new Integer(1), "One");
        map1.put(new Integer(2), "Two");
        map1.put(new Integer(3), "Three");
        map1.put(new Integer(4), "Four");
        map1.put(new Integer(5), "Five");

        System.out.println("Map Values Before: ");
        Set keys = map1.keySet();
        for (Iterator i1 = keys.iterator(); i1.hasNext();) {
          Integer key = (Integer) i1.next();
          String value = (String) map1.get(key);
          System.out.println(key + " = " + value);
        }

        System.out.println("\nRemove element with key 6");
        map1.remove(new Integer(1));

        System.out.println("\nMap Values After: ");
        keys = map1.keySet();
        for (Iterator i1 = keys.iterator(); i1.hasNext();) {
          Integer key = (Integer) i1.next();
          String value = (String) map1.get(key);
          System.out.println(key + " = " + value);
        }
        
	    /*System.out.println();
	    System.out.println();
	    System.out.println();
	    System.out.println();
	    System.out.println();
	    System.out.println();
	    System.out.println();
	    System.out.println();
	    System.out.println();
	    System.out.println();
	    System.out.println();
	    System.out.println();
	    System.out.println();
	    System.out.println();
	    System.out.println();
	    System.out.println();
	    System.out.println();
	    System.out.println();
	    System.out.println();
	    System.out.println();
	    System.out.println();
	    System.out.println();*/
	    
	    
	    
	    
	}

}
