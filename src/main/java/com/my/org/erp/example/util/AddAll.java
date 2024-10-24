package com.my.org.erp.example.util;



import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;

public class AddAll {
  public static void main(String args[]) throws Exception {

    List<String> list = new ArrayList<String>();
    list.add("A");
    list.add("B");
    list.add("C");
    List<String> list2 = new ArrayList<String>();
    list2.add("X");
    list2.add("Y");
    list2.add("Z");
    list.addAll(list2);
    list.addAll(1, list2);

    System.out.println(list);
    //list.clear();
    System.out.println(list);
    
    System.out.println("List contains X: " + list.contains("X"));
    
    System.out.println("List contains X: " + list.indexOf("X"));
    
    
    
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
    System.out.println("List contains " + myList.size() + " elements");
    for (int i = 10; i < 15; i++) {
      myList.add(new Integer(i));
    }
    System.out.println("List contains " + myList.size() + " elements");
    (myList.subList(5, 9)).clear();
    System.out.println("List- " + myList.size() + " elements");
    myList.trimToSize();

    System.out.println("List contains " + myList.size() + " elements");
    System.out.println(myList);
    
    
    List list1 = Arrays.asList(new String[] { "A", "B", "C", "D" });
    List list21 = Arrays.asList(new String[] { "A", "B", "C" });

    System.out.println(list.equals(list21));
    
    System.out.println(list1.size());
    System.out.println(list1.isEmpty());
    
    
    
    
    System.out.print("Original contents of al: ");
    Iterator<String> itr = list.iterator();
    while (itr.hasNext()) {
      String element = itr.next();
      System.out.print(element + " ");
    }
    System.out.println();

    ListIterator<String> litr = list.listIterator();
    while (litr.hasNext()) {
      String element = litr.next();
      litr.set(element + "+");
    }

    // Now, display the list backwards.
    System.out.print("Modified list backwards: ");
    while (litr.hasPrevious()) {
      String element = litr.previous();
      System.out.print(element + " ");
    }
    
    
    System.out.println();

    
    
    
    
    
    
    
    System.out.println(list1.lastIndexOf("A"));
    
    String orig[] = { "1st", "2nd", "3rd", "4th", "5th", "1st", "2nd", "3rd",
            "4th", "5th" };
        String act[] = { "2nd", "3rd", "6th" };
        List origList = new ArrayList(Arrays.asList(orig));
        List actList = Arrays.asList(act);
        System.out.println();
        
        System.out.println(origList.retainAll(actList));
        System.out.println(origList);
        
        
        
        ArrayList<String> nums = new ArrayList<String>();
        nums.clear();
        nums.add("One");
        nums.add("Two");
        nums.add("Three");

        System.out.println(nums);
        nums.set(0, "Uno");
        nums.set(1, "Dos");
        nums.set(2, "Tres");
        System.out.println(nums);
        
        
        ArrayList<Integer> al = new ArrayList<Integer>();


        al.add(1);
        al.add(2);
        al.add(3);
        al.add(4);

        System.out.println("Contents of al: " + al);

        Integer ia[] = new Integer[al.size()];
        ia = al.toArray(ia);

        int sum = 0;

        for (int i : ia)
          sum += i;

        System.out.println("Sum is: " + sum);
  }
}