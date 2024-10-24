package com.my.org.erp.example.util;
import java.lang.reflect.Array;

import java.util.Arrays;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.Enumeration;
import java.util.List;
import java.util.Vector;

import org.apache.commons.lang.ArrayUtils;

/**
 * Demonstrate use of Arrays.sort on Booleans(!). Try it, you'll get a
 * ClassCastException, as there is no ordering of Booleans
 * 
 * @version $Id: SortBooleans.java,v 1.2 2003/06/22 23:19:13 ian Exp $
 */
public class SortBooleans {
  public static void main(String[] unused)
  {
    Boolean[] data = { new Boolean(true), new Boolean(false),
        new Boolean(false), new Boolean(true), };
    Arrays.sort(data); // EXPECT RUNTIME ERROR
    for (int i = 0; i < data.length; i++)
      System.out.println(data[i]);
    
    
    
    
    Object[] a1d = { "Hello World", new Date(), Calendar.getInstance(), };
    // Arrays.asList(Object[]) --> List
    List l = Arrays.asList(a1d);

    // Vector contstructor takes Collection
    // List is a subclass of Collection
    Vector v;
    v = new Vector(l);

    // Or, more simply:
    v = new Vector(Arrays.asList(a1d));

    // Just to prove that it worked.
    Enumeration e = v.elements();
    while (e.hasMoreElements()) {
      System.out.println(e.nextElement());
    }
    
    
    
    
    
    
    
    
    Integer[] numbers = { 1, 1, 2, 3, 5, 8, 13, 21, 34, 55 };

    List list = Arrays.asList(numbers);

    for (int i = 0; i < list.size(); i++) {
      System.out.print(list.get(i) + ", ");
    }
    
    
    
    
    
    
    Integer[] integers = { new Integer(1), new Integer(2), new Integer(3), new Integer(5),
            new Integer(8), new Integer(13), new Integer(21), new Integer(34), new Integer(55) };

        int[] fibbos = ArrayUtils.toPrimitive(integers);
        System.out.println(ArrayUtils.toString(fibbos));
    
    
    
    
        String[] abc = { "a", "b", "c", "d" };
        String[] xyz = { "A", "b", "c", "s" };
        String[] java = { "Java", "Dot", "Com" };

        System.out.println(Arrays.equals(abc, xyz));
        System.out.println(Arrays.equals(abc, java));
        
        
        int array[] = new int[10];
        Arrays.fill(array, 100);
        for (int i=0, n=array.length; i<n; i++) {
          System.out.println(array[i]);
        }
        System.out.println();
        Arrays.fill(array, 3, 6, 50);
        for (int i=0, n=array.length; i<n; i++) {
          System.out.println(array[i]);
        }
        byte array2[] = new byte[10];
        Arrays.fill(array2, (byte)4);

        System.out.println();
        Date array3[] = new Date[10];
        Date anObject = new Date();
        Arrays.fill(array3, new Date());
        anObject.setYear(102);
        for (int i=0, n=array3.length; i<n; i++) {
          System.out.println(array3[i]);
        }
        
        
        String[] letters = { "A", "I", "U", "E", "O" };

        String[] results = new String[3];

        System.arraycopy(letters, 2, results, 0, 3);

        for (int i = 0; i < results.length; i++) {
          System.out.println("result = " + results[i]);
        }
        
        System.out.println();
        byte[] b1 = new byte[] { 3, 2, 5, 4, 1 };
        for (byte b: b1){
          System.out.println(b);
        }
        System.out.println();
        Arrays.sort(b1);
        for (byte b: b1){
          System.out.println(b);
        }
        System.out.println();
        byte[] b2 = new byte[] { 5, 2, 3, 1, 0 };
        Arrays.sort(b2, 1, 4);

        for (byte b: b2){
          System.out.println(b);
        }
      

        
        
        char[] c1 = new char[] { 'c', 'h', 'a', 'r', 's' };
        for (char ch: c1){
          System.out.print(ch);
        }
        Arrays.sort(c1);
        System.out.println();
        for (char ch: c1){
          System.out.print(ch);
        }
        System.out.println();
        char[] c2 = new char[] { 'c', 'h', 'a', 'r', 's' };
        Arrays.sort(c2, 1, 4);
        for (char ch: c2){
          System.out.print(ch);
        }
        
        System.out.println();
        double[] d1 = new double[] { 3.1, 2.1, 5.1, 4.1, 1.1 };
        for (double d: d1){
          System.out.print(" " +d);
        }
        Arrays.sort(d1);
        System.out.println();
        for (double d: d1){
          System.out.print(" " +d);
        }
        System.out.println();
        double[] d2 = new double[] { 5, 2, 3, 1, 4 };
        Arrays.sort(d2, 1, 4);
        for (double d: d2){
          System.out.print(" " +d);
        } 
        System.out.println();
        
        
        
        float[] f1 = new float[] { 3.1f, 2.1f, 5.1f, 4.1f, 1.1f };

        for (float f: f1){
          System.out.print(" " + f);
        }
        Arrays.sort(f1);
        System.out.println();
        for (float f: f1){
          System.out.print(" " + f);
        }
        System.out.println();
        float[] f2 = new float[] { 5.1f, 2.1f, 3.1f, 1.1f, 4.1f };
        Arrays.sort(f2, 1, 4);

        for (float f: f2){
          System.out.print(" " + f);
        }
        
        System.out.println();
        
        
        
        //Expanding an Array
        int[] array1 = { 1, 2, 3 };
        Object newArray = Array.newInstance(array1.getClass().getComponentType(),
            Array.getLength(array1) * 2);
        System.arraycopy(array1, 0, newArray, 0, Array.getLength(array1));
        
        System.out.println();
        
        boolean b = Arrays.equals(new byte[] { 0 }, new byte[] { 0 });
        System.out.println(b);
        
        System.out.println();
        
        
        b = Arrays.equals(new char[] { 'a' }, new char[] { 'A' });
        System.out.println(b);
        
        
        
        System.out.println();
        boolean[] booleanArr = new boolean[10];
        boolean booleanFillValue = false;
        Arrays.fill(booleanArr, booleanFillValue);
        for (int i = 0; i < booleanArr.length; i++)
            System.out.println(booleanArr[i]);
        
        for(boolean i:booleanArr)
        	System.out.println(i);
        
        System.out.println();
        int[] intArr = new int[10];
        int intFillValue = -1;
        Arrays.fill(intArr, intFillValue);
        for(int i:intArr)
        	System.out.println(i);
        
        System.out.println();
        String[] StringArr = new String[5];
        String StringFillValue = "mythra";
        Arrays.fill(StringArr, StringFillValue);
        for(String  i:StringArr)
        	System.out.println(i);
        
        System.out.println();
        
        
        int startIndex = 0;
        int endIndex = 4;

        boolean[] booleanArr1 = new boolean[10];
        for(boolean i:booleanArr1)
        	System.out.println(i);
        System.out.println();
        boolean booleanFillValue1 = true;
        Arrays.fill(booleanArr, startIndex, endIndex, booleanFillValue);
        for(boolean i:booleanArr1)
        	System.out.println(i);
        
        System.out.println();
        
         startIndex = 0;
         endIndex = 4;

        long[] longArr = new long[10];
        long longFillValue = 1;

        Arrays.fill(longArr, startIndex, endIndex, longFillValue);
        for(long i:longArr)
        	System.out.println(i);
        System.out.println();
        
        List<String> lists = Arrays.asList("A", "B", "C", "E", "F");
        for (String s : lists)
            System.out.println(s);
            
        System.out.println();
        
        
        
        String[] stringArr = new String[10];
        String stringFillValue = "1";

        Arrays.fill(stringArr, startIndex, endIndex, stringFillValue);
        for (String s : stringArr)
            System.out.println(s);
        
        
         
        
        
        Integer[] numbers1 = { 8, 2, 6, 7, -12, 1, 4, 9, 5, 3 };

        int min = (int) Collections.min(Arrays.asList(numbers1));
        int max = (int) Collections.max(Arrays.asList(numbers1));

        System.out.println("Min number: " + min);
        System.out.println("Max number: " + max);
        System.out.println();
        
        
        
        String[] alphabets = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J" };

        List<String> listw = Arrays.asList(alphabets);

        Collections.shuffle(listw);

        for (String alpha : listw) {
          System.out.print(alpha + " ");
        }
        
        
        int[] arrayq = { 1, 2, 3 };
        
        System.arraycopy(arrayq, 0, arrayq, 1, arrayq.length - 1);
        System.out.println(Arrays.toString(arrayq));
        
        System.arraycopy(arrayq, 1, arrayq, 0, arrayq.length - 1);
        System.out.println(Arrays.toString(arrayq));
        
        String s[] = {"a", "b", "c", "d"};
        double d [][]= {
            {0.50, 0.20,  0.20, 0.30},
            {0.50, 1.10,  0.50, 0.80},
            {0.50, 0.70,  0.40},
            {0.50, 0.70},
            {0.50},
        };
        System.out.println(Arrays.toString(s));
        System.out.println(Arrays.deepToString(d));
   
        
        

        b = Arrays.equals(new String[] { "a" }, new String[] { "a" });
        System.out.println(b);
        b = Arrays.equals(new String[] { null }, new String[] { null });
        System.out.println(b);
        b = Arrays.equals(new String[] { "a" }, new String[] { null });
        System.out.println(b);
        
  }
}