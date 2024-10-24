package com.my.org.erp.employeesort;

import java.util.*;

public class SortTest
{
    public static void main(String args[])
    {
        new SortTest();
    }
 
    public SortTest()
    {
        //fill some employee objects
        ArrayList list = new ArrayList();
        list.add(new Employee(500,"Shifoo",150000));
        list.add(new Employee(504,"Oogway",120000));
        list.add(new Employee(503,"Tigress",100000));
        list.add(new Employee(730,"Mantis",45000));
 
        System.out.println("Initial List :");
        print(list);
        System.out.println("n");
 
        Collections.sort(list,new SortyById());
        System.out.println("Sorted List By Id:");
        print(list);
        System.out.println("n");
 
        Collections.sort(list,new SortyByName());
        System.out.println("Sorted List By Name:");
        print(list);
        System.out.println("n");
 
        Collections.sort(list,new SortyBySalary());
        System.out.println("Sorted List By Salary:");
        print(list);
        System.out.println("n");
 
    }
 
    public void print(ArrayList list)
    {
        Iterator it = list.iterator();
        while(it.hasNext())
        {
            Employee emp = (Employee) it.next();
            System.out.println(emp);
        }
    }
}
 
class Employee
{
    public int id;
    public String name;
    public double salary;
 
    public Employee(int id, String name,double salary )
    {
        this.id = id;
        this.name = name;
        this.salary = salary;
    }
 
    public String toString()
    {
        return this.id +", "+this.name+", "+this.salary;
    }
}
 
//scenario | strategy - I
class SortyById implements Comparator
{
    public int compare(Object object1, Object object2)
    {
        int value=0;
 
        Employee emp1 = (Employee) object1;
        Employee emp2 = (Employee) object2;
 
        if(emp1.id > emp2.id)
            value = 1;
        else if(emp1.id < emp2.id)
            value = -1;
        else if(emp1.id == emp2.id)
            value = 0;
 
        return value;
    }
}
 
//scenario | strategy - II
class SortyByName implements Comparator
{
    public int compare(Object object1, Object object2)
    {
        Employee emp1 = (Employee) object1;
        Employee emp2 = (Employee) object2;
 
        return emp1.name.compareTo(emp2.name);
    }
}
 
//scenario | strategy - III
class SortyBySalary implements Comparator
{
    public int compare(Object object1, Object object2)
    {
        int value=0;
 
        Employee emp1 = (Employee) object1;
        Employee emp2 = (Employee) object2;
 
        if(emp1.salary > emp2.salary)
            value = 1;
        else if(emp1.salary < emp2.salary)
            value = -1;
        else if(emp1.salary == emp2.salary)
            value = 0;
 
        return value;
    }
}