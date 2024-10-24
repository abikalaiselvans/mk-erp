package com.my.org.erp.common;

import java.sql.Connection;

import DBConnection.DBCon;
import com.my.org.erp.common.CommonFunctions;
public class StockFunctions 
{

	
	public static String purchaseNumber() 
	 {
		try 
	 	{
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql ="SELECT (COUNT(*)) FROM con_inv_m_startingpurchaseno";
			if(CommonFunctions.RecordExist(co, sql))
			{
				sql ="SELECT (MAX(INT_PURCHASENUMBER)+1) FROM con_inv_m_startingpurchaseno";
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
	
	
	
	public static String AccountYear() 
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
			String accountyear="";
			String years[][] =CommonFunctions.RecordSetArray(co,sql);
			int year = Integer.parseInt(years[0][0]);
			int year1= year+1;
			accountyear=((""+year).substring(2))+"-"+((""+year1).substring(2));
			return accountyear;
	 	}
	 	catch (Exception e) 
	 	{
	 		
	 	}
	 	return null;
	 }

	public static String invoiceLocation(String branch) 
	 {
		try 
	 	{
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			return CommonFunctions.RecordSetArray(co ," SELECT  CHR_OFFICESHORTNAME  FROM  com_m_office   WHERE INT_OFFICEID=(select INT_OFFICEID FROM com_m_branch WHERE INT_BRANCHID="+branch+")")[0][0];
			 
	 	}
	 	catch (Exception e) 
	 	{
	 		
	 	}
	 	return null;
	 }
	
	public static String invoiceDivision(String divisionid) 
	 {
		try 
	 	{
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			return CommonFunctions.RecordSetArray(co," select CHR_DIVISHORTNAME FROM con_inv_m_division WHERE INT_DIVIID="+divisionid)[0][0];
			
	 	}
	 	catch (Exception e) 
	 	{
	 		
	 	}
	 	return null;
	 }
	
	
	//	Invoice Number
	public static String invoiceNumber() 
	 {
		try 
	 	{
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql ="SELECT (COUNT(*)) FROM con_inv_m_startingsalesno";
			if(CommonFunctions.RecordExist(co, sql))
			{
				sql ="SELECT (MAX(INT_SALENUMBER)+1) FROM con_inv_m_startingsalesno";
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
	
//	Quotation Number
	public static String quotationNumber() 
	 {
		try 
	 	{
			Connection co=null;	
			DBCon con = new DBCon();
			co = con.getConnection();
			String sql ="SELECT (COUNT(*)) FROM con_inv_m_startingquotationno";
			if(CommonFunctions.RecordExist(co, sql))
			{
				sql ="SELECT (MAX(INT_QUOTATIONNUMBER)+1) FROM con_inv_m_startingquotationno";
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
