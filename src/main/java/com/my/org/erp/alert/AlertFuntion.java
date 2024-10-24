package com.my.org.erp.alert;

 
 

import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunction;
/**
* @author Mythra Kalaiselvan 
* @SmartERP version 1.2
*/

public class AlertFuntion {

	public AlertFuntion() 
	{
		
	}

	public static String  ScrollingMessage()
	{
		 
		try
		{
			String sql= "SELECT b.CHR_COMPANYNAME,c.CHR_BRANCHNAME,a.CHR_STAFFNAME,a.CHR_EMPID, a.CHR_MOBILE ,a.CHR_EMAILID ";
			sql = sql +" FROM  com_m_staff a ,com_m_company b, com_m_branch c WHERE a.INT_BRANCHID = c.INT_BRANCHID ";
			sql = sql +" AND a.INT_COMPANYID = b.INT_COMPANYID AND day(DT_ACTUAL_DOB)  = (select day(now())) ";
			sql = sql +" AND MONTH(DT_ACTUAL_DOB) =(select month(now()))  AND a.CHR_TYPE !='T' AND a.CHR_HOLD!='Y' ";
			//System.out.println(sql);
			String birthdata[][] = CommonFunction.RecordSetArray(sql);
			String message="";
			if(birthdata.length>0)
			{
				message = message+" Birth day wishes to " ;
				for(int u=0;u<birthdata.length;u++)
				{
					message = message+birthdata[u][2]+" / " +birthdata[u][3] +"&nbsp;";
					 
				}
				
			}	
			
			sql = " SELECT b.CHR_COMPANYNAME,c.CHR_BRANCHNAME,a.CHR_STAFFNAME,a.CHR_EMPID,a.CHR_MOBILE ,a.CHR_EMAILID ";
			sql = sql +" FROM  com_m_staff a ,com_m_company b, com_m_branch c WHERE a.INT_BRANCHID = c.INT_BRANCHID";
			sql = sql +" AND a.INT_COMPANYID = b.INT_COMPANYID AND day(DT_WEDDATE)  = (select day(now())) ";
			sql = sql +" AND MONTH(DT_WEDDATE) =(select month(now()))   AND a.CHR_TYPE !='T' AND a.CHR_HOLD!='Y' ";
			//System.out.println(sql);
			String weddata[][] = CommonFunction.RecordSetArray(sql);
			if(weddata.length>0)
			{
				message = message+" Wedding day wishes to " ;
				for(int u=0;u<weddata.length;u++)
				{
					message = message+weddata[u][2]+" / " +weddata[u][3] +" &nbsp;&nbsp;-";
					 
				}	
			}
			
			sql = " SELECT  b.CHR_COMPANYNAME,c.CHR_BRANCHNAME,a.CHR_STAFFNAME,a.CHR_EMPID,a.CHR_MOBILE ,a.CHR_EMAILID ,a.DT_DOB ";
			sql = sql+" FROM  com_m_staff a ,com_m_company b, com_m_branch c WHERE a.INT_BRANCHID = c.INT_BRANCHID ";
			sql = sql+" AND a.INT_COMPANYID = b.INT_COMPANYID AND ((day(DT_ACTUAL_DOB)))  = (SELECT day(DATE_ADD(now(),INTERVAL 1 DAY))) ";
			sql = sql+" AND MONTH(DT_ACTUAL_DOB) =(SELECT month(DATE_ADD(now(),INTERVAL 1 DAY)))  AND a.CHR_TYPE !='T' AND a.CHR_HOLD!='Y' ";
			//System.out.println(sql);
			String advancebirth[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if(advancebirth.length>0)
			{
				message = message+" &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Advance Birth day wishes to " ;
				for(int u=0;u<advancebirth.length;u++)
				{
					message = message+"<font color='red'><b>"+advancebirth[u][2]+" / " +advancebirth[u][3] +"</b></font>&nbsp;";
					 
				}	
			}	
			
			sql = " SELECT b.CHR_COMPANYNAME,c.CHR_BRANCHNAME,a.CHR_STAFFNAME,a.CHR_EMPID,a.CHR_MOBILE ,a.CHR_EMAILID  ";
			sql = sql+" FROM  com_m_staff a ,com_m_company b, com_m_branch c WHERE a.INT_BRANCHID = c.INT_BRANCHID ";
			sql = sql+" AND a.INT_COMPANYID = b.INT_COMPANYID AND day(DT_WEDDATE)  = (SELECT day(DATE_ADD(now(),INTERVAL 1 DAY)))"; 
			sql = sql+" AND MONTH(DT_WEDDATE) =(SELECT month(DATE_ADD(now(),INTERVAL 1 DAY)))   AND a.CHR_TYPE !='T' AND a.CHR_HOLD!='Y'  ";
			//System.out.println(sql);
			String advancewedd[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			if(advancewedd.length>0)
			{
				message = message+" Advance Wedding day wishes to " ;
				for(int u=0;u<advancewedd.length;u++)
				{
					message = message+"<font color='red'><b>"+advancewedd[u][2]+" / " +advancewedd[u][3] +"</b></font< &nbsp;&nbsp;-";
					 
				}	
			}
			 
			return message;
		}
		catch(Exception e)
		{
			
		}
		return null;
	}
	
	
	
	
	public static String  YearCompletionList()
	{ 
		String stringValue = "";
		try 
		{
			String sql="";
			for(int x=1;x<20;x++)
			{	
				sql=" SELECT CHR_EMPID,CHR_STAFFNAME,DT_DOJCOLLEGE FROM com_m_staff WHERE CHR_TYPE!='T' AND CHR_HOLD !='Y' AND ((datediff(now(),DT_DOJCOLLEGE) >="+((365*x)-1)+") AND  (datediff(now(),DT_DOJCOLLEGE) <="+(5+(365*x))+"))  ORDER BY DT_DOJCOLLEGE";
				//System.out.println(sql);
				String year1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				if(year1.length>0)
				{
					for(int u=0;u<year1.length;u++)
						if(u%2==0)	
							stringValue=stringValue+year1[u][0]+" / "+year1[u][1]+" -  "+DateUtil.FormateDateSys(year1[u][2]) +" ( "+x+" - Year Completed )  &nbsp;&nbsp;&nbsp;&nbsp;"; 
						else
							stringValue=stringValue+year1[u][0]+" / "+year1[u][1]+" -  "+DateUtil.FormateDateSys(year1[u][2]) +" ( "+x+" - Year Completed )  &nbsp;&nbsp;&nbsp;&nbsp;";;					 
				}
			}
			// System.out.println(stringValue);
			return stringValue;
		} 
		catch (Exception e) 
		{
			 
		}
		return stringValue;
	}
}
