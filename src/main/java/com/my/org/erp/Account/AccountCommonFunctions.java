package com.my.org.erp.Account;
import java.sql.SQLException;
import com.my.org.erp.ServiceLogin.DateUtil;

public class AccountCommonFunctions   
{	
	
	public static boolean dayDifference(String date1, String date2) throws SQLException, ClassNotFoundException
	 {
		try 
	 	{
	 		String sql = "SELECT datediff( '"+DateUtil.FormateDateSQL(date1)+"','"+DateUtil.FormateDateSQL(date2)+"')";
			int daydiff= Integer.parseInt(com.my.org.erp.common.CommonFunctions.QueryExecute(sql)[0][0]);
			if((daydiff == 365) || (daydiff == 364)) 
				return true;
			else
				return false;
			
	 	}
	 	catch (Exception e) 
	 	{
	 	}
	 	return false;
	 }

	 
	public static String  currentBalance(String branch)
	 {
		
		try 
	 	{
			
			String fyear = com.my.org.erp.common.CommonFunctions.CurrentFinancialYear();
			String y[] = fyear.split("-");
			String fyear1= y[0];
			String fyear2= y[1];
			double amt1=0;
			double amt2=0;
			
			String fsql = " SELECT SUM(DOU_AMOUNT) FROM    acc_t_receipts  ";
			fsql = fsql +" WHERE  DAT_DATE>='"+fyear1+"-04-01' ";
			fsql = fsql +" AND DAT_DATE<='"+fyear2+"-03-31' ";
			fsql = fsql +" AND INT_BRANCHID="+branch;
			String b1 =com.my.org.erp.common.CommonFunctions.QueryExecute(fsql)[0][0];
			if(!"-".equals(b1))
				amt1 = Double.parseDouble(b1);
			
			fsql = " SELECT SUM(DOU_AMOUNT)  FROM   acc_t_payments  ";
			fsql = fsql +" WHERE  DAT_DATE>='"+fyear1+"-04-01' ";
			fsql = fsql +" AND DAT_DATE<='"+fyear2+"-03-31' ";
			fsql = fsql +" AND INT_BRANCHID="+branch;
			String b2 =com.my.org.erp.common.CommonFunctions.QueryExecute(fsql)[0][0];
			if(!"-".equals(b2))
				amt2 = Double.parseDouble(b2);
			
			
			
			return ""+(amt1-amt2);
	 	}
	 	catch (Exception e) 
	 	{
	 	}
	 	return null;
	 }
	
	
	
	
	public static double  transactionAmount(String branch,String tablename)
	 {
		
		try 
	 	{
			
			String fyear = com.my.org.erp.common.CommonFunctions.CurrentFinancialYear();
			String y[] = fyear.split("-");
			String fyear1= y[0];
			String fyear2= y[1];
			
			double amt1=0;
			
			String fsql = " SELECT SUM(DOU_AMOUNT) FROM    "+tablename;
			fsql = fsql +" WHERE  DAT_DATE>='"+fyear1+"-04-01' ";
			fsql = fsql +" AND DAT_DATE<='"+fyear2+"-03-31' ";
			fsql = fsql +" AND INT_BRANCHID="+branch;
			String b1[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(fsql);
			if(b1.length>0)
				if(!"-".equals(b1))
					amt1 = Double.parseDouble(b1[0][0]);
				else
					amt1=0;
			 
			return amt1;
	 	}
	 	catch (Exception e) 
	 	{
	 	}
	 	return 0;
	 }
	
	
	public static int accountYear(String month, String year)
	{
		@SuppressWarnings("unused")
		int value=0;
		try
		{
			value=0;
			
			
			/*switch(Integer.parseInt(month))
			{
				case 1:
				case 2:
				case 3:
				case 4:
				case 5:
				case 6:
				case 7:
				case 8:
				case 9:
				case 10:
				case 11:
				case 12:	
					
					
			}*/
		}
		catch(Exception e)
		{
			
		}
		return 0;
	}
	
 }



	
	

