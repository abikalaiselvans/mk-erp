package com.my.org.erp.examples;

public class StringExamples {


	public static void main(String[] args) {
		
		try 
		{
			String s="welcome";
			String s1="welcome";
			String s2= new String("welcome");
			String s3= new String("welcome");
			String s4 = s3.intern();
			System.out.println(""+(s==s1));
			System.out.println(""+(s==s2));
			System.out.println(""+(s2==s3));
			System.out.println(""+(s3==s4) +s4);
		} 
		catch (RuntimeException e) 
		{
		}
		 
		
		
	}

}
