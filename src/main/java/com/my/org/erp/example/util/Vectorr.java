package com.my.org.erp.example.util;


	import java.util.Vector;

	public class Vectorr {

	  public static final int MaxSize = 100000;

	  public static final int NTRIES = 10;

	  public static void main(String[] args) {
	    Vector v = new Vector();

	    long start = System.currentTimeMillis();
	    for (int i = 0; i < MaxSize; i++)
	      v.add(new Integer(i));
	    long end = System.currentTimeMillis();
	    System.out.println("Allocating vector elements: " + (end - start)
	        + " milliseconds");

	    Integer[] integerArray = new Integer[1];
	    start = System.currentTimeMillis();
	    for (int i = 0; i < MaxSize; i++) {
	      if (i >= integerArray.length) {
	        Integer[] b = new Integer[i * 2];
	        System.arraycopy(integerArray, 0, b, 0, integerArray.length);
	        integerArray = b;
	      }
	      integerArray[i] = new Integer(i);
	    }
	    end = System.currentTimeMillis();
	    System.out.println("Allocating array elements:  " + (end - start)
	        + " milliseconds");

	    start = System.currentTimeMillis();
	    for (int j = 0; j < NTRIES; j++)
	      for (int i = 0; i < MaxSize; i++) {
	        Integer r = (Integer) v.get(i);
	        v.set(i, new Integer(r.intValue() + 1));
	      }
	    end = System.currentTimeMillis();
	    System.out.println("Accessing vector elements:  " + (end - start)
	        + " milliseconds");

	    start = System.currentTimeMillis();
	    for (int j = 0; j < NTRIES; j++)
	      for (int i = 0; i < MaxSize; i++) {
	        Integer r = integerArray[i];
	        integerArray[i] = new Integer(r.intValue() + 1);
	      }
	    end = System.currentTimeMillis();
	    System.out.println("Accessing array elements:   " + (end - start)
	        + " milliseconds");
	  }
	}
	           