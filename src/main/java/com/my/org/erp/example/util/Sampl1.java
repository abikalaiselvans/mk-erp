package com.my.org.erp.example.util;

import java.text.DateFormat;
import java.text.NumberFormat;
import java.util.Date;
import java.util.Formatter;
import java.util.Locale;

public class Sampl1 {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		 

		
		char chara[] = {'I', '4', 'U'};
		String str = new String(chara);
		String str1 = new String("I4U");
		System.out.println(str.equals(str1));
		System.out.println(str.hashCode() +"/"+str1.hashCode());
		str = "adasd";
		System.out.println(str.equals(str1));
		System.out.println(str.hashCode() +"/"+str1.hashCode());
		
		
		double amount = 1276789.342122;
		double percent = 0.95;
		Locale india= new Locale("en", "IN");
		
		NumberFormat nfIndia = NumberFormat.getNumberInstance(india);
		nfIndia.setMaximumFractionDigits(3);
		
		
		System.out.println(nfIndia.format(amount));
		
		nfIndia = NumberFormat.getCurrencyInstance(india);
		
		System.out.println(nfIndia.format(amount));
		
		nfIndia = NumberFormat.getPercentInstance(india);
		
		System.out.println(nfIndia.format(percent));
		
		
		 System.out.println();
		 
		 Date today = new Date();
		 india= new Locale("en", "IN");
		 DateFormat nf  = DateFormat.getDateInstance(DateFormat.DEFAULT, india);
		 System.out.println(nf.format(today));
		 
		 
		 
		 Formatter formatter = new Formatter();
		 System.out.println(formatter.format("%c", 33).toString());
		 System.out.println(formatter.format("%8.2f", 420.23).toString());
		 System.out.println(formatter.format("%8.2f", new
		 Double(4234.23)).toString());
		 System.out.println(formatter.format("%5b", " ").toString());
		 System.out.println(formatter.format("%20d", 42042042).toString());
		 System.out.println(formatter.format("%,20d", 42042042).toString());
		 System.out.println(formatter.toString());
		 
		 	   	
		
	}

}
