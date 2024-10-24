package com.my.org.erp.SmartAMC;

import java.sql.Connection;

import DBConnection.DBCon;

import com.my.org.erp.common.CommonFunctions;

public class AMCFunctions 
{
	public static String serviceAMCNumber() 
	 {
		try 
	 	{
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql ="SELECT (COUNT(*)) FROM inv_m_serviceamcnumbergenerate";
			if(CommonFunctions.RecordExist(co, sql))
			{
				sql ="SELECT (MAX(INT_AMCID)+1) FROM inv_m_serviceamcnumbergenerate";
				String Invno[][] =CommonFunctions.RecordSetArray(co,sql);
				return Invno[0][0].trim();
			}
			else
				return "1";
	 	}
	 	catch (Exception e) 
	 	{
	 		
	 	}
	 	return null;
	 }

	public static String AMCCallBookingNumber() 
	 {
		try 
	 	{
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql ="SELECT (COUNT(*)) FROM inv_m_serviceamccallbookingnumbergenerate";
			if(CommonFunctions.RecordExist(co, sql))
			{
				sql ="SELECT (MAX(INT_AMCID)+1) FROM inv_m_serviceamccallbookingnumbergenerate";
				String Invno[][] =CommonFunctions.RecordSetArray(co,sql);
				return Invno[0][0].trim();
			}
			else
				return "1";
	 	}
	 	catch (Exception e) 
	 	{
	 		
	 	}
	 	return null;
	 }
	
	
}
