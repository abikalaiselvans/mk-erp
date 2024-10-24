package com.my.org.erp.example.util;

import java.util.Hashtable;

public class Main {
  public static void main(String[] args) {
    Hashtable<String, String> ht = new Hashtable<String, String>();
    ht.put("1", "One");
    ht.put("2", "Two");
    ht.put("3", "Three");

    boolean blnExists = ht.containsKey("2");
    System.out.println("2 exists in Hashtable ? : " + blnExists);
  }
}