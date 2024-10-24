package com.my.org.erp.example.util.linkedlist;

import java.util.LinkedList;

public class MyBasicOperations {
 
    public static void main(String a[]){
         
        LinkedList<String> ll = new LinkedList<String>();
        ll.add("Orange");
        ll.add("Apple");
        ll.add("Grape");
        ll.add("Banana");
        System.out.println(ll);
        System.out.println("Size of the linked list: "+ll.size());
        System.out.println("Is LinkedList empty? "+ll.isEmpty());
        System.out.println("Does LinkedList contains 'Grape'? "+ll.contains("Grape"));
    }
}
