package com.my.org.erp.Date;

public class Sample {

	/**
	 * @param args
	 */
	public static void main(String[] args) 
	{
		 
		int daysinaMonth = Day.getDaysInMonth(1,2013);
		String s="";
		for(int d=1;d<=31;d++)
			if(d <=daysinaMonth)
				s= s+Day.displayDayname(d,1,2013,"2")+",";
			else
				s = s+",";
		
		
		System.out.println("------"+s);
		

	}

}
