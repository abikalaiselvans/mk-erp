package com.my.org.erp.example.util;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.SequenceInputStream;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Enumeration;
import java.util.List;
import java.util.Vector;

public class FindVector {

  public static void main(String args[]) throws Exception {
    String data[] = { "Java", "Source", "and", "Support", "."};
    
    Vector v = new Vector();
    for (int i = 0, n = data.length; i < n; i++) {
      v.add(data[i]);
    }
    System.out.println(v);
    System.out.println("Contains Java?: " + v.contains("Java"));
    System.out.println("Contains Java2s?: " + v.contains("Java2s"));
    System.out.println("Where's and?: " + v.indexOf("and"));
    System.out.println("Where's Source?: " + v.indexOf("Source"));
    System.out.println("Where's Java from end?: "
        + v.lastIndexOf("Java"));
    
    
    
    
    
    v = new Vector(Arrays.asList(data));
    ByteArrayOutputStream b = new ByteArrayOutputStream();
    ObjectOutputStream o = new ObjectOutputStream(b);
    o.writeObject(v);
    o.close();
    
    ByteArrayInputStream bb = new ByteArrayInputStream(b.toByteArray());
    ObjectInputStream oo = new ObjectInputStream(bb);
    Vector v2 = (Vector) oo.readObject();
    Enumeration e = v.elements();
    while (e.hasMoreElements()) {
      System.out.println(e.nextElement());
    }
    
    System.out.println();
    
    
    v = new Vector(Arrays.asList(args));
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    ObjectOutputStream oos = new ObjectOutputStream(baos);
    oos.writeObject(v);
    oos.close();
    ByteArrayInputStream bais = new ByteArrayInputStream(baos.toByteArray());
    ObjectInputStream ois = new ObjectInputStream(bais);
    v2 = (Vector) ois.readObject();
   e = v.elements();
    while (e.hasMoreElements()) {
      System.out.println(e.nextElement());
    }
    
    System.out.println();
    
    
    v = new Vector(0);
    System.out.println(v.capacity());
    v.addElement("Hello");
    System.out.println(v.capacity());
    v.addElement("Hello");
    System.out.println(v.capacity());
    v.addElement("Hello");
    System.out.println(v.capacity());
    v.addElement("Hello");
    System.out.println(v.capacity());
    v.addElement("Hello");
    System.out.println(v.capacity());
    
    System.out.println(removeAll(v, "Hello"));
    System.out.println(v);
    System.out.println();
   
    Add(v, "kalaiselvan");
    //System.out.println(Add(v, "kalaiselvan"));
    System.out.println(v);
    System.out.println(v.size());
    
    
    System.out.println();
    
    v = new Vector(3);
    v.add(new FileInputStream("c:/k1.txt"));
    v.add(new FileInputStream("c:/k2.txt"));
    e = v.elements();
    SequenceInputStream sis = new SequenceInputStream(e);
    InputStreamReader isr = new InputStreamReader(sis);
    BufferedReader br = new BufferedReader(isr);
    String line;
    while ((line = br.readLine()) != null) {
      System.out.println(line);
    }
    br.close();
    
    
    System.out.println();
    
    
    
    Vector<String> v1 = new Vector<String>();
    v1.add("1");
    v1.add("2");
    v1.add("3");

    Vector<String> v20 = new Vector<String>();
    v20.add("One");
    v20.add("Two");
    v20.add("Three");
    v20.add("Four");
    v20.add("Five");

    System.out.println(v20);
    Collections.copy(v20, v1);

    System.out.println(v20);
    
    
    
    
    Vector<Double> v10 = new Vector<Double>();

    v10.add(new Double("3.4324"));
    v10.add(new Double("3.3532"));
    v10.add(new Double("3.342"));
    v10.add(new Double("3.349"));
    v10.add(new Double("2.3"));

    Object obj = Collections.max(v10);
    System.out.println(obj);
    
      obj = Collections.min(v10);
    System.out.println(obj);
    
    
    
    v = new Vector<String>();

    v.add("1");
    v.add("2");
    v.add("3");
    v.add("4");
    v.add("5");

    System.out.println(v);
    Collections.shuffle(v);
    System.out.println(v);
    
    
    
    
  v = new Vector<String>();

    v.add("1");
    v.add("2");
    v.add("3");
    v.add("4");
    v.add("5");

    System.out.println(v);
    Collections.swap(v, 0, 4);
    System.out.println(v);
    
    
    
   v = new Vector<String>();

    v.add("1");
    v.add("2");
    v.add("3");
    v.add("4");
    v.add("5");

    Comparator comparator = Collections.reverseOrder();
    System.out.println(v);

    Collections.sort(v, comparator);
    System.out.println(v);
    
    
    
    
    v = new Vector<String>();
    v.add("1");
    v.add("2");
    v.add("3");

    ArrayList<String> arrayList = new ArrayList<String>();
    arrayList.add("4");
    arrayList.add("5");

    v.addAll(arrayList);

    for (int i = 0; i < v.size(); i++){
      System.out.println(v.get(i));
    }
    
    
    System.out.println();
    Object[] objArray = new Object[5];

    v.copyInto(objArray);

    for (Object obj0: objArray){
      System.out.println(obj0);
    }
    
    
    System.out.println();
    
    Vector<String> wv = new Vector<String>();
    wv.add("1");
    wv.add("2");
    wv.add("3");
    wv.add("4");
    wv.add("5");

    List lst = wv.subList(1, 3);

    for (String str : wv) {
      System.out.println("Vector "+str);
    }
    
    System.out.println();
    for (Object str : lst) {
        System.out.println("OBJECT "+ str);
      }
    
    System.out.println();
    obj = lst.remove(0);
    for (String str : wv) {
      System.out.println(str);
    }
    
    
    System.out.println();
    
    v = new Vector<String>();
    v.add("1");
    v.add("2");
    v.add("3");

    arrayList = new ArrayList<String>();
    arrayList.add("4");
    arrayList.add("5");
    
    v.addAll(1, arrayList);
    for (Object str: v)
      System.out.println(str);
    
    
    
    
    v = new Vector<String>();
    v.add("1");
    v.add("2");
    v.add("3");
    v.add("4");
    v.add("5");

    obj = v.remove(1);

    System.out.println(obj + " is removed from Vector");
    for (Object str: v)
      System.out.println(str);

    v.removeElementAt(2);
    for (Object str: v)
      System.out.println(str);
    
    System.out.println();
    
    
    v = new Vector<String>();
    v.add("1");
    v.add("2");
    v.add("3");
    v.add("4");
    v.add("5");

    System.out.println(v.remove("2"));

    for (Object str: v){
      System.out.println(str);
    }
    System.out.println(v.removeElement("3"));
    for (Object str: v){
      System.out.println(str);
    }
    
    System.out.println();
     v = new Vector<String>();
    v.add("1");
    v.add("2");
    v.add("3");
    
    v.set(1, "REPLACED ELEMENT");

    for (Object str: v){
        System.out.println(str);
      }
    
    System.out.println();
    System.out.println(v.contains("3"));
    System.out.println(v.indexOf("5"));
    System.out.println(v.lastIndexOf("2"));
    
    System.out.println();
    
    System.out.println(v.indexOf("1", 0));
    System.out.println(v.lastIndexOf("2", 0));
    
    System.out.println();
    v = new Vector<String>();

    v.add("1");
    v.add("2");
    v.add("3");
    v.add("4");
    v.add("5");

    v.setSize(3);

    for (Object str : v) {
      System.out.println(str);
    }
    v.setSize(5);
    for (Object str : v) {
      System.out.println(str);
    }
    
    
    
  }
  
 
	  static boolean removeAll(Vector v, Object e) {
	    Vector v1 = new Vector();
	    v1.add(e);
	    return v.removeAll(v1);
	  }

	  
	  static void Add(Vector v, Object e) {
		    v.add(e);
		    v = null;
		   
		    //return v;
		  }
}


