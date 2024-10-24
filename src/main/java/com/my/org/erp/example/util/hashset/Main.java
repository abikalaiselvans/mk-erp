package com.my.org.erp.example.util.hashset;

import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashSet;
import java.util.TreeSet;

/**
 *
 * @author tunatore
 */
public class Main {

    /**
     * Collection is the super interface for the Set interface
     *
     * Set is an interface
     * (public interface Set extends Collection)
     * SortedSet is a sub interface for the Set interface
     * (public interface SortedSet extends Set)
     *
     * Implementing classes for the Set interface are:
     * AbstractSet, HashSet, LinkedHashSet, TreeSet
     *
     * TreeSet is the only implementing class for the SortedSet interface
     *
     */
    public static void main(String[] args) {

       Car car1 = new Car();
       Car car2 = new Car();
       Car car3 = new Car();
       Car car4 = new Car();
       Car car5 = new Car();

       car1.setName("1-SUBARU");
       car1.setModelYear(2000);
       car1.setMotorPower(3000);
      
       car2.setName("2-HONDA");
       car2.setModelYear(1999);
       car2.setMotorPower(2000);
       
       car3.setName("3-TOYOTA");
       car3.setModelYear(2004);
       car3.setMotorPower(1600);
       
       car4.setName("4-NISSAN");
       car4.setModelYear(2005);
       car4.setMotorPower(1200);
       
       car5.setName("5-HUNDAI");
       car5.setModelYear(2008);
       car5.setMotorPower(1400);

       System.out.println("\nTreeSet Example Starts\n");

       TreeSet<Car> carsTreeSet = new TreeSet<Car>();
       carsTreeSet.add(car1);
       carsTreeSet.add(car2);
       carsTreeSet.add(car3);
       carsTreeSet.add(car4);
       carsTreeSet.add(car5);
       
       //dublicate elements are not allowed in SETs
       //this statement will be ignored there will be only
       //one car5 element will be exist inside TreeSet
       carsTreeSet.add(car5);

        //Cars inside TreeSet will be sorted according to their motor power
        //Comparing objects will be done inside Car class by calling compareTo(Car carToCompare)
        //method internally from TreeSet collection class
       
        for (Iterator<Car> it = carsTreeSet.iterator(); it.hasNext();) {
            Car car = (Car) it.next();
            System.out.println("CAR name --> " + car.getName()
                    + " Motor Power --> " + car.getMotorPower());
        }

     /*  System.out.println("\nDESCENDING order\n");
       
       //if you need to get descending order use descending iterator

        for (Iterator<Car> it = carsTreeSet..descendingIterator(); it.hasNext();) {
            Car car = it.next();
            System.out.println("CAR name --> " + car.getName()
                    + " Motor Power --> " + car.getMotorPower());
        }
*/

       System.out.println("\nHashSet Example Starts\n");

       //HashSet Does not guarantee the order of its elements

       HashSet<Car> carHashSet = new HashSet<Car>();
       carHashSet.add(car1);
       carHashSet.add(car2);
       carHashSet.add(car3);
       carHashSet.add(car4);
       carHashSet.add(car5);
       //dublication of elements still not allowed
       carHashSet.add(car5);

        for (Iterator<Car> it = carHashSet.iterator(); it.hasNext();) {
            Car car = it.next();
            System.out.println("CAR name --> " + car.getName()
                    + " Motor Power --> " + car.getMotorPower());
        }

       System.out.println("\nLinkedHashSet Example Starts\n");
       
       //LinkedHashSet will maintain the order of Car elements 
       //Car1 will be followed by car2,car3  ... car5
       //the ordering will be maintained according to the insertion order
       LinkedHashSet<Car> carLinkedHashSet = new LinkedHashSet<Car>();
       carLinkedHashSet.add(car1);
       carLinkedHashSet.add(car2);
       carLinkedHashSet.add(car3);
       carLinkedHashSet.add(car4);
       carLinkedHashSet.add(car5);

        for (Iterator<Car> it = carLinkedHashSet.iterator(); it.hasNext();) {
            Car car = it.next();
            System.out.println("CAR name --> " + car.getName()
                    + " Motor Power --> " + car.getMotorPower());
        }


    }

}
