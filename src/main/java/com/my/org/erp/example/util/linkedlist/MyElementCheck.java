package com.my.org.erp.example.util.linkedlist;

import java.util.LinkedList;
import java.util.List;
 
public class MyElementCheck {
 
    public static void main(String a[]){
         
        LinkedList<String> arrl = new LinkedList<String>();
        arrl.add("First");
        arrl.add("Second");
        arrl.add("Third");
        arrl.add("Random");
        List<String> list = new LinkedList<String>();
        list.add("Second");
        list.add("Random");
        System.out.println("Does LinkedList contains all list elements?: "
                                +arrl.containsAll(list));
        list.add("one");
        System.out.println("Does LinkedList contains all list elements?: "
                                +arrl.containsAll(list));
    }
}