package com.my.org.erp.example.util;

import java.util.Arrays;
import java.util.Set;
import java.util.TreeSet;

public class Person implements Comparable {
  String firstName, lastName;

  public Person(String f, String l) {
    this.firstName = f;
    this.lastName = l;
  }

  public String getFirstName() {
    return firstName;
  }

  public String getLastName() {
    return lastName;
  }

  public String toString() {
    return "[dept=" + firstName + ",name=" + lastName + "]";
  }

  public int compareTo(Object obj) {
    Person emp = (Person) obj;
    int deptComp = firstName.compareTo(emp.getFirstName());

    return ((deptComp == 0) ? lastName.compareTo(emp.getLastName())
        : deptComp);
  }

  public boolean equals(Object obj) {
    if (!(obj instanceof Person)) {
      return false;
    }
    Person emp = (Person) obj;
    return firstName.equals(emp.getFirstName())
        && lastName.equals(emp.getLastName());
  }

  public static void main(String args[]) {
    Person emps[] = { new Person("Debbie", "Degree"),
        new Person("Geri", "Grade"), new Person("Ester", "Extent"),
        new Person("Mary", "Measure"),
        new Person("Anastasia", "Amount") };
    Set set = new TreeSet(Arrays.asList(emps));
    System.out.println(set);
  }
}
           
         
    