package com.my.org.erp.example.util;
import java.util.Hashtable;

public class Main4 {
  public static void main(String[] args) {
    Hashtable<String,String> ht = new Hashtable<String,String>();

    System.out.println("Size of Hashtable : " + ht.size());

    ht.put("1", "One");
    ht.put("2", "Two");
    ht.put("3", "Three");

    System.out.println(ht.size());

    Object obj = ht.remove("2");

    System.out.println(ht.size());
  }
}
