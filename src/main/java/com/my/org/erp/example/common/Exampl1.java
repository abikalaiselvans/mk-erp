package com.my.org.erp.example.common;

public class Exampl1 {

	/**
	 * @param args
	 */
	public static void main(String[] args) 
	{
		 

		String s="";
		if(s.length()==0 || s.equals(null))
			System.out.println("string is empty");
		else
			System.out.println("string is not empty");
			
		 
		System.out.println(Math.signum(1233));
		String ss="";
		ss.concat("sss");
		//System.out.println(ss);
		
		Derived d = new Derived();
		Base b = new Base();
		
		b = new Derived();
		
	 
	}

}
