package com.my.org.erp.example;

public class Stringcomparison {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		 
		try
		{
			String s  = "1234";
			String s2 = new String("1234");
			String s3 = new String("1234");
			String s4  = "1234";
			if(s==s2)
				System.out.println("true");
			else
				System.out.println("false");
			
			if(s2==s3)
				System.out.println("true");
			else
				System.out.println("false");
			
			if(s==s4)
				System.out.println("true");
			else
				System.out.println("false");
		}
		finally
		{
			System.out.println("completed....");
		}
	}

}
