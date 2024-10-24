package com.my.org.erp.example.util;

import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Set;

public class Main2 {
  public static void main(String[] args) {
    Hashtable<String,String> ht = new Hashtable<String,String>();

    ht.put("1", "One");
    ht.put("2", "Two");
    ht.put("3", "Three");

    Set st = ht.keySet();

    Iterator itr = st.iterator();

    while (itr.hasNext()){
      System.out.println(itr.next());
    }
    st.remove("2");

    Enumeration e = ht.keys();
    while (e.hasMoreElements()){
      System.out.println(e.nextElement());      
    }
  }
}
