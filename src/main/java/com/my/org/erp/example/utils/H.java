package com.my.org.erp.example.utils;

import java.util.* ;
public class H
{
    static HashMap first = new HashMap();
    static
    {
        first.put("20030120" , new Integer (56));
        first.put("20030118" , new Integer (19));
        first.put("20030125" , new Integer (25));
        first.put("20030122" , new Integer (32));
        first.put("20030117" , new Integer (67));
        first.put("20030123" , new Integer (34));
        first.put("20030124" , new Integer (42));
        first.put("20030121" , new Integer (19));
        first.put("20030119" , new Integer (98));
    }
    public static void main( String[] args )
    {
        ArrayList as = new ArrayList( first.entrySet() );
         
        Collections.sort( as , new Comparator() {
            public int compare( Object o1 , Object o2 )
            {
                Map.Entry e1 = (Map.Entry)o1 ;
                Map.Entry e2 = (Map.Entry)o2 ;
                Integer first = (Integer)e1.getValue();
                Integer second = (Integer)e2.getValue();
                return first.compareTo( second );
            }
        });
         
        Iterator i = as.iterator();
        while ( i.hasNext() )
        {
            System.out.println( (Map.Entry)i.next() );
        }
    }
}