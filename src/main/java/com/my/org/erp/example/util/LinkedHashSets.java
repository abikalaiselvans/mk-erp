package com.my.org.erp.example.util;

import java.util.*;

class LinkedHashSets 
{
   public static void main(String args[]) 
   {
      // create a hash set
      LinkedHashSet hs = new LinkedHashSet();
      // add elements to the hash set
      hs.add("B");
      hs.add("F");
      hs.add("A");
      hs.add("D");
      hs.add("E");
      hs.add("C");
      hs.add("F");
      System.out.println(hs);
   }
}