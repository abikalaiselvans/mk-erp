package com.my.org.erp.tax;

public class RecurringDeposit {

	/**
	 * @param args
	 */
	public static void main(String[] args) 
	{
		 
		System.out.println("---------------");
		double amount=4000.00;
		double annualinterest =11.5;
		double monthinterst = (annualinterest/12)/100;
		int noofyear=5;
		int noofmonth = noofyear*12;
		noofmonth= 30;
		double a1=0;
		double a2=0;
		double a3=0;
		for(int u=1;u<=noofmonth;u++)
		{
			a1= amount+a3;
			a2=a1*monthinterst;
			a3 = a1+a2;
			System.out.println(u +"===="+Math.round(a1) +"---"+Math.round(a2)+"-----"+Math.round(a3)+"<br>");
		}
	}

}




/*Maturity Value of the Recurring Deposits  - based on  Quarterly Compounding)



M =R [ (1+i)n – 1]
         --------------------    
         1- (1+i) -1/3

 M = Maturity value
R = Monthly installment
n = Number of quarters
i = Rate of interest/400 
*/
