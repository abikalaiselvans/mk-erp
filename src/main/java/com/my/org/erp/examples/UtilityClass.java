package com.my.org.erp.examples;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class UtilityClass {

	/**
	 * @param args
	 */
	public static void main(String[] args) 
	{
		 
		 Object[] array = new Object[]{"12","23","34"};
		 java.util.List list = Arrays.asList(array);
		 System.out.println(list);
		 List<String> items = Arrays.asList("".split("\\s*,\\s*"));
		 System.out.println(items);
		 @SuppressWarnings("unused")
		List<String> list1 = new ArrayList<String>(Arrays.asList("".split(" , ")));
	}

}
