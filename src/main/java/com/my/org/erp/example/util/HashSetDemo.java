package com.my.org.erp.example.util;

import java.util.*;

public class HashSetDemo 
{
        public static void main(String args[]) 
        {

        	/*
        	 * A HashSet is a collection set that neither allows duplicate elements 
        	 * nor order or position its elements.

				This class implements the Set interface and extends AbstractSet. 
				It creates a collection that uses a hash table for storage. 
				Hash table stores information by using a mechanism called hashing. 
				In hashing, the informational content of a key is used to determine a unique value, 
				called its hash code. The hash code is then used as an index at which
				 the data associated with the key is stored. The transformation of key 
				 into its hash code is performed automatically.HashSet is not synchronized. 
				 It makes no guarantees as to the iteration order of the set; in particular, 
				 it does not guarantee that the order will remain constant over time. 
				 This class permits the null element. 
				 
				     HashSet allows at most one null element.
    HashSet is faster than other implementations of Set, TreeSet and LinkedHashSet.
        	 */
                HashSet HSet = new HashSet();
                HSet.add("C");
                HSet.add("A");
                HSet.add("B");
                HSet.add("E");
                HSet.add(null);
                HSet.add("D");
                HSet.add("C");
                HSet.add("A");
                HSet.add("B");
                HSet.add("E");
                HSet.add(null);
                HSet.add("D");
                System.out.println(""+HSet.add("D") );
                System.out.println("The HashSet elements are: " + HSet);
                
                
                String[] name1 = { "kalai", "selvan", "arun", "kumar", "manjula" };
                String[] name2 = { "mythra", "aarthi", "dharani", "sandhiya", "Alexi" };
                String[] name3 = { "Adel", "Aaron", "Amy", "James", "Alice" };
                Set<String> letter = new HashSet<String>();
                for (int i = 0; i < name1.length; i++)
                  letter.add(name1[i]);
                for (int j = 0; j < name2.length; j++)
                  letter.add(name2[j]);
                for (int k = 0; k < name3.length; k++)
                  letter.add(name3[k]);
                System.out.println(letter.size() + " letters must be sent to: " + letter);

                
                
                String elements[] = { "A", "B", "C", "D", "E" };
                Set set = new HashSet(Arrays.asList(elements));
                System.out.println(set);
                
                
                String elements1[] = { "A", "B", "C", "D", "E" };
                Set set1 = new HashSet(Arrays.asList(elements1));
                set1.add("Z");
                System.out.println(set1);
                
                
                String elements2[] = { "A", "B", "C", "D", "E" };
                Set set2 = new HashSet(Arrays.asList(elements2));
                elements2 = new String[] { "E", "F" };
                set2.addAll(Arrays.asList(elements2));
                System.out.println(set2);
        }
}