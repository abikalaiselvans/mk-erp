package com.my.org.erp.example.util;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.ListIterator;

class Employee implements Comparable {
  private String name;

  private double salary;

  Employee(String name, double salary) {
    this.name = name;
    this.salary = salary;
  }

  String getName() {
    return name;
  }

  double getSalary() {
    return salary;
  }

  public String toString() {
    return "Name = " + getName() + ", Salary = " + getSalary();
  }

  public int compareTo(Object o) 
  {
	  	if (!(o instanceof Employee)) throw new ClassCastException();
    	Employee e = (Employee) o;
    	return name.compareTo(e.getName());
  }

  
  static class SalaryComparator implements Comparator 
  {
    public int compare(Object o1, Object o2) 
    {
      if (!(o1 instanceof Employee) || !(o2 instanceof Employee)) throw new ClassCastException();
      Employee e1 = (Employee) o1;
      Employee e2 = (Employee) o2;
      return (int) (e1.getSalary() - e2.getSalary());
    }
  }
  
  
}

class UtilDemo4 {
  public static void main(String[] args) {
    
	String[] names = { "kalai", "nandhu", "bala", "kannan" };
    double[] salaries = { 2000.0, 5000.0, 6000.0, 4000.0 };
    List l = new ArrayList();
    for (int i = 0; i < names.length; i++)
      l.add(new Employee(names[i], salaries[i]));

    System.out.println();
    Collections.sort(l);
    ListIterator liter = l.listIterator();
    while (liter.hasNext())
      System.out.println(liter.next());

    
  
    System.out.println();
    Collections.sort(l, new Employee.SalaryComparator());
    liter = l.listIterator();
    while (liter.hasNext())
      System.out.println(liter.next());
    
  
    
    System.out.println();
    List list = Collections.nCopies(5, "A");
    Iterator itr = list.iterator();
    while (itr.hasNext())
      System.out.println(itr.next());
    
    //IMMUTABLE COLLECTION
    List<Character> ll = new ArrayList<Character>();

    ll.add('X');

    //System.out.println("Element added to list: " + ll.get(0));

    //Collection<Character> immutableCol = Collections.unmodifiableCollection(ll);

    //immutableCol.add('Y');
    
    
    
    
    //Sort and Search a LinkedList.
    List<Character> ll1 = new LinkedList<Character>();

    for (char n = 'A'; n <= 'Z'; n++)
      ll1.add(n);

    Collections.shuffle(ll1);

    for (Character x : ll1)
      System.out.print(x + " ");
    Collections.sort(ll1);

    for (Character x : ll1)
      System.out.print(x + " ");

    System.out.println("Searching for F.");
    int i = Collections.binarySearch(ll1, 'F');

    if (i >= 0) {
      System.out.println("Found at index " + i);
      System.out.println("Object is " + ll1.get(i));
    }
    
    
    //Finding an Element in a Sorted List
    List<String> sortedList = new LinkedList<String>();
    sortedList.addAll(Arrays.asList(new String[] { "a", "b", "c", "d" }));

    int index = Collections.binarySearch(sortedList, "c");
    System.out.println(index);

    index = Collections.binarySearch(sortedList, "e");
    System.out.println(index);
    
  
    
    
    
    List<Character> ll2 = new LinkedList<Character>();

    for (char n = 'A'; n <= 'F'; n++)
      ll2.add(n);

    System.out.println("Here is the original list: ");
    for (Character x : ll2)
      System.out.print(x + " ");
    System.out.println();
    Collections.reverse(ll2);

    System.out.println("Here is the reversed list: ");
    for (Character x : ll2)
      System.out.print(x + " ");
    System.out.println();
    Collections.rotate(ll2, 3);

    for (Character x : ll2)
      System.out.print(x + " ");
    System.out.println();
    Collections.shuffle(ll2);

    System.out.println("Here is the randomized list:");
    for (Character x : ll2)
      System.out.print(x + " ");
    
    
  }
}
