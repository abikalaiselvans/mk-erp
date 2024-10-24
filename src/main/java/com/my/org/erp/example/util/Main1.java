package com.my.org.erp.example.util;
import java.util.Collection;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Iterator;

public class Main1 {
  public static void main(String[] args) {
    Hashtable<String, String> ht = new Hashtable<String,String>();
    ht.put("1", "One");
    ht.put("2", "Two");
    ht.put("3", "Three");

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
  }
}