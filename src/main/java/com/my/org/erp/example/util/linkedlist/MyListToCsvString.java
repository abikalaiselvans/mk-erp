package com.my.org.erp.example.util.linkedlist;

import java.util.LinkedList;
import java.util.List;
 
public class MyListToCsvString {
 
    public String getListAsCsvString(List<String> list){
         
        StringBuilder sb = new StringBuilder();
        for(String str:list){
            if(sb.length() != 0){
                sb.append(",");
            }
            sb.append(str);
        }
        return sb.toString();
    }
     
    public static void main(String a[]){
         
        List<String> li1 = new LinkedList<String>(){
            {
                this.add("animal");
                this.add("nuts");
                this.add("java");
            }
        };
        MyListToCsvString mtc = new MyListToCsvString();
        System.out.println(mtc.getListAsCsvString(li1));
        List<String> li2 = new LinkedList<String>(){
            {
                this.add("java");
                this.add("unix");
                this.add("c++");
            }
        };
        System.out.println(mtc.getListAsCsvString(li2));
    }
}