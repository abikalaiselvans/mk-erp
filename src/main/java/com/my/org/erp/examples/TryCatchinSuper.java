package com.my.org.erp.examples;

public class TryCatchinSuper {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
	 
		
	}

	class A
	{
		protected void display() 
		{
			try
			{
				
			}
			catch(Exception e)
			{
				System.out.println(e.getMessage());
			}
		}
	}
	
	class B extends A
	{
		public void display()
		{
			
		}
	}
}
