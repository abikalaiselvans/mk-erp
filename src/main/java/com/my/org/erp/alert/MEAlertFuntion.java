package com.my.org.erp.alert;

import java.sql.Connection;

import DBConnection.DBCon;
 
import com.my.org.erp.Date.Day;
import com.my.org.erp.common.*;

/**
* @author Mythra Kalaiselvan 
* @SmartERP version 1.2
*/

public class MEAlertFuntion {

	public MEAlertFuntion() 
	{
		
	}

	public static double  METargetAlert(String empid) 
	 {
		try 
	 	{
	 		Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql =" select month(now())";
			 
			String months[][] =CommonFunctions.RecordSetArray(co,sql);
			int month = Integer.parseInt(months[0][0]);
			if(month<4)
				sql = "select (year(now())-1)";
			else
				sql = "select year(now())";
			
			String years[][] =CommonFunctions.RecordSetArray(co,sql);
			int year = Integer.parseInt(years[0][0]);
			double target=0.0;
			sql = " SELECT count(*) FROM inv_t_targetassign WHERE CHR_EMPID='"+empid+"' AND INT_YEAR ="+year;
			if(CommonFunctions.RecordExist(co, sql))
			{
				sql = " SELECT ";
				if(month==1)
					sql = sql+" INT_JAN ";
				else if(month==2)
					sql = sql+" INT_FEB ";
				else if(month==3)
					sql = sql+" INT_MAR ";
				else if(month==4)
					sql = sql+" INT_APR ";
				else if(month==5)
					sql = sql+" INT_MAY ";
				else if(month==6)
					sql = sql+" INT_JUN ";
				else if(month==7)
					sql = sql+" INT_JUL ";
				else if(month==8)
					sql = sql+"  INT_AUG ";
				else if(month==9)
					sql = sql+" INT_SEP  ";
				else if(month==10)
					sql = sql+" INT_OCT  ";
				else if(month==11)
					sql = sql+" INT_NOV  ";
				else if(month==12)
					sql = sql+"  INT_DEC ";
				sql = sql +" FROM inv_t_targetassign WHERE CHR_EMPID='"+empid+"' AND INT_YEAR ="+year;	
				String data[][] =CommonFunctions.RecordSetArray(co,sql);
				target = Double.parseDouble(data[0][0]);
			}
			else
				target=0;
			
			 
			return target;
	 	}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	 	return 0;
	 }

	
	public static double  METargetCollection(String empid) 
	 {
		try 
	 	{
	 		Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			double target=0.0;
			String sql ="  SELECT COUNT(*) FROM inv_t_directsales WHERE CHR_CANCEL ='N' AND ( CHR_REF='"+empid+"' OR  CHR_REF1='"+empid+"' OR  CHR_REF2='"+empid+"' )  AND month(DAT_SALESDATE) =Month(now()) AND year(DAT_SALESDATE) =year(now()) AND CHR_PAYMENTSTATUS !='S' AND  CHR_CANCEL ='N' AND  INT_SALESSTATUS=1  ";
			if(CommonFunctions.RecordExist(co, sql))
			{
				sql = "  SELECT (SUM(DOU_AMOUNT)*(IF( CHR_REF='"+empid+"' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='"+empid+"',INT_REF_PERCENTAGE2,IF(CHR_REF2='"+empid+"',INT_REF_PERCENTAGE3,0) ) )/100 )) FROM inv_t_directsales WHERE CHR_CANCEL ='N' AND ( CHR_REF='"+empid+"' OR  CHR_REF1='"+empid+"' OR  CHR_REF2='"+empid+"' ) AND month(DAT_SALESDATE) =Month(now()) AND year(DAT_SALESDATE) =year(now()) AND CHR_PAYMENTSTATUS !='S' AND  CHR_CANCEL ='N' AND  INT_SALESSTATUS=1 ";	
				String data[][] =CommonFunctions.RecordSetArray(co,sql);
				target = Double.parseDouble(data[0][0]);
				
				
				/*
				SELECT (SUM(DOU_AMOUNT)*(IF( CHR_REF='CISJUN2003000319' ,INT_REF_PERCENTAGE1,IF(CHR_REF1='CISJUN2003000319',INT_REF_PERCENTAGE2,IF(CHR_REF2='CISJUN2003000319',INT_REF_PERCENTAGE3,0) ) )/100 ))  FROM inv_t_directsales 
  				WHERE CHR_CANCEL ='N' AND ( CHR_REF='CISJUN2003000319' OR  CHR_REF1='CISJUN2003000319' OR  CHR_REF2='CISJUN2003000319' ) 
  				AND month(DAT_SALESDATE) =Month(now()) AND year(DAT_SALESDATE) =year(now()) 
  				AND CHR_PAYMENTSTATUS !='S' AND  CHR_CANCEL ='N' AND  INT_SALESSTATUS=1  
 
				*/
				
				
				
			}
			else
				target=0;
			
			 
			return target;
	 	}
	 	catch (Exception e) 
	 	{
	 		 
	 	}
	 	return 0;
	 }

	
}
