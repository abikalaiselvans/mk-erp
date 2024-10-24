package com.my.org.erp.example.util.linkedlist;

import java.util.LinkedList;

public class MyFirstElement {
 
    public static void main(String a[]){
         
        LinkedList<String> arrl = new LinkedList<String>();
        arrl.add("First");
        arrl.add("Second");
        arrl.add("Third");
        arrl.add("Random");
        System.out.println("First Element: "+arrl.element());
        System.out.println("First Element: "+arrl.getFirst());
        System.out.println("First Element: "+arrl.peek());
         
    }
}