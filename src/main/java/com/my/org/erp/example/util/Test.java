package com.my.org.erp.example.util;



public class Test {

	/**
	 * @param args
	 */
	int b=0;
	public static void main(String[] args) 
	{
		try 
		{
			 
			//float a = 9/0;
			//System.out.println(b);
			
			Integer a = new Integer(2); 
			Integer b = new Integer(2); 
			System.out.println(""+(a==b));
			System.out.println(""+(a.equals(b)));
			
			int a1 = 5;
			double a2 = (float)a1;
			/*CallableStatement call = conn.prepareCall(
			"{CALL doubleMyInt(?)}");
			//	 for inout parameters, it is good practice to
			//	 register the outparameter before setting the input value
				call.registerOutParameter(1, Types.INTEGER);
				call.setInt(1,10);
				call.execute();
				int retval = call.getInt(1);*/
		}
		catch (RuntimeException e) 
		{
			 
			 System.out.println(e.getMessage());
		}
	}

}
