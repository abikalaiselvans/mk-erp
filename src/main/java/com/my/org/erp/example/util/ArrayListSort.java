package com.my.org.erp.example.util;
import java.util.ArrayList;
import java.util.Collections;
public class ArrayListSort {

	/**
	 * @param args
	 */
	public static void main(String[] args) 
	{
		 
		ArrayList insects = new ArrayList();
		insects.add("mosquito");
		insects.add("butterfly");
		insects.add("dragonfly");
		insects.add("fly");

		int size = insects.size();
		for (int i=0; i<size; i++) {
		  System.out.println("insect " + i + " : " + (String) insects.get(i));
		}

		Collections.sort(insects);

		for (int i=0; i<size; i++) {
		  System.out.println("insect " + i + " : " + (String) insects.get(i));
		}
	}

}
