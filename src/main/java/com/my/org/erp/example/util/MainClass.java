package com.my.org.erp.example.util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;
import java.util.ListIterator;
import java.util.Set;
import java.util.TreeSet;

class MainClass 
{
  public static void main(String[] args)
  {
    String[] coins = { "Penny", "nickel", "dime", "Quarter", "dollar" };

    Set set = new TreeSet();
    for (int i = 0; i < coins.length; i++)
      set.add(coins[i]);

    System.out.println(Collections.min(set));
    System.out.println(Collections.min(set, String.CASE_INSENSITIVE_ORDER));

    System.out.println("");

    System.out.println(Collections.max(set));
    System.out.println(Collections.max(set, String.CASE_INSENSITIVE_ORDER));

    List list = new ArrayList();

    Collections.shuffle(list);
    
    String[] coins1 = { "A", "B", "C", "D", "E" };

    List l = new ArrayList();
    for (int i = 0; i < coins1.length; i++)
      l.add(coins1[i]);

    ListIterator liter = l.listIterator();

    while (liter.hasNext())
      System.out.println(liter.next());

    Collections.reverse(l);

    liter = l.listIterator();

    while (liter.hasNext())
      System.out.println(liter.next());
    
    
    
    
    
    
    
    
    
    

    List src = new LinkedList();
    for (int i = 0; i < coins.length; i++)
      src.add(coins[i]);

    List dst = new ArrayList();
    for (int i = 0; i < coins.length; i++)
      dst.add("");

    Collections.copy(dst, src);

    liter = dst.listIterator();

    while (liter.hasNext())
      System.out.println(liter.next());

    Collections.fill(src, "no coins");

    liter = src.listIterator();

    while (liter.hasNext())
      System.out.println(liter.next());
    
    
    
    
  
  }
}
