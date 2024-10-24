package com.my.org.erp.example.util;

import java.util.Arrays;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.Vector;

public class EnumerationIterator1 
{
  public static Iterator iterator(final Enumeration e) 
  {
	  return new Iterator() 
						  	{
							  public boolean hasNext() 
							  {
								  return e.hasMoreElements();
							  }
					
							  public Object next() 
							  {
								  return e.nextElement();
							  }
					
							  public void remove() 
							  {
								  throw new UnsupportedOperationException();
							  }
						  	};
  }

  public static void main(String args[]) 
  {
    String elements[] = { "Java", "Source", "and", "Support", "." };
    Vector v = new Vector(Arrays.asList(elements));
    Enumeration e = v.elements();
    Iterator itor = EnumerationIterator1.iterator(e);
    while (itor.hasNext()) 
    {
      System.out.println(itor.next());
    }
  }
}