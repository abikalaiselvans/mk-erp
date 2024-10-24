package com.my.org.erp.example.util;
import java.util.ArrayList;

public class ArrayList7 {
  public static void main(String[] args) {
    
	  int[] numbers1 = {1,2,3,4,5,6,7,8,9,10};
	  int[] numbers2 = {1,2,3,4,5,6,7,8,9,10};
	  
	  System.arraycopy(numbers1,4, numbers2,1,15);
	  for(int h: numbers2)
		  System.out.println(h);
	  
	  System.out.println();
	  ArrayList myList = new ArrayList(5);
    for (int i = 0; i < 5; i++) {
      myList.add(new Integer(i));
    }
    System.out.println("List contains " + myList.size() + " elements");

    Integer int2 = new Integer(2);
    System.out.println("List contains Integer(2): " + myList.contains(int2));
    System.out.println("Integer(2) is at index " + myList.indexOf(int2));

    myList.set(2, new Integer(99));
    System.out.println("Get element at index 2: " + myList.get(2));

    myList.ensureCapacity(15);
    for (int i = 10; i < 15; i++) {
      myList.add(new Integer(i));
    }

    myList.subList(10, 15).clear();
    myList.trimToSize();


    System.out.println(myList);
  }
}
