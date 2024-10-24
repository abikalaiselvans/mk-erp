package com.my.org.erp.common;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import DBConnection.DBCon;
 
public class ImageFunctions   
{ 
	
	
	
	
	
	
	
	
	
	
	

	public static void updateHRMApplicantImage(String filename,String applicantid) 
	{
		try 
		{

			String fs =filename;
			File f = new File(fs);
			InputStream is = new FileInputStream(f);
		    long length = f.length();
		    byte[] bytes = new byte[(int)length];
		    int offset = 0;
		    int numRead = 0;
		    while (offset < bytes.length && (numRead=is.read(bytes, offset,	bytes.length-offset)) >= 0) 
		    {
		        offset += numRead;
		    }
		    is.close();
		    Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
		    java.sql.PreparedStatement pstm ;
			String sql=" UPDATE hrm_m_application  SET IMG_IMAGE=? WHERE INT_APPID=? ";	
			pstm = co.prepareStatement(sql);
			pstm.setObject(1,bytes);
			pstm.setString(2,applicantid);
			pstm.execute();
	 
			
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());
		}
		
	}



	public static void updateHRMApplicantProfile(String filename,String applicantid) 
	{
			try 
		{

			String fs =filename;
			File f = new File(fs);
			InputStream is = new FileInputStream(f);
		    long length = f.length();
		    byte[] bytes = new byte[(int)length];
		    int offset = 0;
		    int numRead = 0;
		    while (offset < bytes.length && (numRead=is.read(bytes, offset,	bytes.length-offset)) >= 0) 
		    {
		        offset += numRead;
		    }
		    is.close();
		    Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
		    java.sql.PreparedStatement pstm ;
			String sql="UPDATE hrm_m_application SET IMG_PROFILE=? WHERE INT_APPID=?";	
			pstm = co.prepareStatement(sql);
			pstm.setObject(1,bytes);
			pstm.setString(2,applicantid);
			pstm.execute();
	 
			
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());
		}
		
	}



	
	
	public static void updateStaffImage(String filename,String empid) 
	{
		try 
		{
 			 
			if(!CommonFunction.RecordExist("SELECT COUNT(*) FROM com_m_staffaddressproof WHERE CHR_EMPID='"+empid+"'"))
				CommonFunctions.Execute(" INSERT INTO com_m_staffaddressproof (CHR_EMPID ) VALUES ('"+empid+"') ");
				
			String fs =filename;
			File f = new File(fs);
			InputStream is = new FileInputStream(f);
		    long length = f.length();
		    byte[] bytes = new byte[(int)length];
		    int offset = 0;
		    int numRead = 0;
		    while (offset < bytes.length && (numRead=is.read(bytes, offset,	bytes.length-offset)) >= 0) 
		    {
		        offset += numRead;
		    }
		    is.close();
		    Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
		    java.sql.PreparedStatement pstm ;
			String sql=" UPDATE com_m_staffaddressproof  SET IMG_IMAGE=? WHERE CHR_EMPID=? ";	
			pstm = co.prepareStatement(sql);
			pstm.setObject(1,bytes);
			pstm.setString(2,empid);
			System.out.println(pstm);
			pstm.execute();
			
			sql=" UPDATE com_m_staff   SET INT_PROGRESSBAR=(INT_PROGRESSBAR+10) WHERE CHR_EMPID=? ";	
			pstm = co.prepareStatement(sql);
			pstm.setString(1,empid);
			System.out.println(pstm);
			pstm.execute();
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());
		}
		
	}

	
	
	public static void updateInvoiceImage(String filename,String invoicenumber, String invoicetype ) 
	{
		try 
		{

			
			String fs =filename;
			File f = new File(fs);
			InputStream is = new FileInputStream(f);
		    long length = f.length();
		    byte[] bytes = new byte[(int)length];
		    int offset = 0;
		    int numRead = 0;
		    while (offset < bytes.length && (numRead=is.read(bytes, offset,	bytes.length-offset)) >= 0) 
		    {
		        offset += numRead;
		    }
		    is.close();
		    Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
		    java.sql.PreparedStatement pstm ;
		    String sql ="";
		    if("DirectPurchase".equals(invoicetype.trim()))
		    {
		    	sql="UPDATE inv_t_directpurchase SET IMG_INVOICE=? WHERE CHR_PURCHASEORDERNO=?";	
				pstm = co.prepareStatement(sql);
				pstm.setObject(1,bytes);
				pstm.setString(2,invoicenumber.replaceAll("_", "/"));
				pstm.execute();
				pstm.close();
			}
		    else if("DirectSales".equals(invoicetype.trim()))
		    {
		    	sql="UPDATE inv_t_directsales SET IMG_INVOICE=? WHERE CHR_SALESNO=?";		
				pstm = co.prepareStatement(sql);
				pstm.setObject(1,bytes);
				pstm.setString(2,invoicenumber.replaceAll("_", "/"));
				pstm.execute();
				pstm.close();
			}
		    else if("ServiceBilling".equals(invoicetype.trim()))
		    {
		    	sql=" UPDATE inv_t_servicebilling SET IMG_INVOICE=? WHERE CHR_SALESNO=?";			
				pstm = co.prepareStatement(sql);
				pstm.setObject(1,bytes);
				pstm.setString(2,invoicenumber.replaceAll("_", "/"));
				pstm.execute();
				pstm.close();
				
		    }
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());
		}
		
	}
	
	
	public static void certificateImage(String filename,String empid) 
	{
		try 
		{

			String fs =filename;
			File f = new File(fs);
			InputStream is = new FileInputStream(f);
		    long length = f.length();
		    byte[] bytes = new byte[(int)length];
		    int offset = 0;
		    int numRead = 0;
		    while (offset < bytes.length && (numRead=is.read(bytes, offset,	bytes.length-offset)) >= 0) 
		    {
		        offset += numRead;
		    }
		    is.close();
		    Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
		    java.sql.PreparedStatement pstm ;
			String sql=" UPDATE com_m_staffaddressproof  SET IMG_CERTIFICATE=? WHERE CHR_EMPID=? ";	
			pstm = co.prepareStatement(sql);
			pstm.setObject(1,bytes);
			pstm.setString(2,empid);
			pstm.execute();
			
			sql=" UPDATE com_m_staff   SET INT_PROGRESSBAR=(INT_PROGRESSBAR+20) WHERE CHR_EMPID=? ";	
			pstm = co.prepareStatement(sql);
			pstm.setObject(1, empid);
			pstm.execute();
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());
		}
		
	}

	
	public static void insertStaffProfile(String filename,String empid) 
	{
			try 
		{

			String fs =filename;
			File f = new File(fs);
			InputStream is = new FileInputStream(f);
		    long length = f.length();
		    byte[] bytes = new byte[(int)length];
		    int offset = 0;
		    int numRead = 0;
		    while (offset < bytes.length && (numRead=is.read(bytes, offset,	bytes.length-offset)) >= 0) 
		    {
		        offset += numRead;
		    }
		    is.close();
		    Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
		    java.sql.PreparedStatement pstm ;
			String sql="UPDATE com_m_staffaddressproof SET IMG_PROFILE=? WHERE CHR_EMPID=?";	
			pstm = co.prepareStatement(sql);
			pstm.setObject(1,bytes);
			pstm.setString(2,empid);
			pstm.execute();
			
			sql=" UPDATE com_m_staff   SET INT_PROGRESSBAR=(INT_PROGRESSBAR+10) WHERE CHR_EMPID=? ";	
			pstm = co.prepareStatement(sql);
			pstm.setString(1,empid);
			pstm.execute();
			
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());
		}
		
	}

	public static void updateStaffInformationFile(String filename,String empid) 
	{
			try 
		{

			String fs =filename;
			File f = new File(fs);
			InputStream is = new FileInputStream(f);
		    long length = f.length();
		    byte[] bytes = new byte[(int)length];
		    int offset = 0;
		    int numRead = 0;
		    while (offset < bytes.length && (numRead=is.read(bytes, offset,	bytes.length-offset)) >= 0) 
		    {
		        offset += numRead;
		    }
		    is.close();
		    Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
		    java.sql.PreparedStatement pstm ;
			String sql="UPDATE com_m_staffaddressproof SET IMG_ADDRESSPROOF=? WHERE CHR_EMPID=?";	
			pstm = co.prepareStatement(sql);
			pstm.setObject(1,bytes);
			pstm.setString(2,empid);
			pstm.execute();
			
			sql=" UPDATE com_m_staff   SET INT_PROGRESSBAR=100 WHERE CHR_EMPID=? ";	
			pstm = co.prepareStatement(sql);
			pstm.setObject(1,60);
			pstm.setString(2,empid);
			pstm.execute();
			
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());
		}
		
	}


	public static void insertAddressProof(String Path, String empid,String proofColumn ) 
	{
		try 
		{
			String fs =Path+"/uploadfiles/Addressproof/"+empid+"_"+proofColumn+".jpg";
			System.out.println(fs);
			File f = new File(fs);
			InputStream is = new FileInputStream(f);
		    long length = f.length();
		    byte[] bytes = new byte[(int)length];
		    int offset = 0;
		    int numRead = 0;
		    while (offset < bytes.length && (numRead=is.read(bytes, offset,	bytes.length-offset)) >= 0) 
		    {
		        offset += numRead;
		    }
		    is.close();
		    Connection co = null;
			DBCon con = new DBCon();
			co = con.getConnection();
		    java.sql.PreparedStatement pstm ;
		    
		    String sql="UPDATE com_m_staffaddressproof SET "+proofColumn+"=? WHERE CHR_EMPID=?";	
			pstm = co.prepareStatement(sql);
			pstm.setObject(1,bytes);
			pstm.setString(2,empid);
			pstm.execute();
			CommonFunctions.Execute("UPDATE com_m_staff SET CHR_ADDRESSPROOFSTATUS='Y',INT_PROGRESSBAR=(INT_PROGRESSBAR+10)  WHERE CHR_EMPID='"+empid+"'");
	     
			
		} 
		catch (Exception e) 
		{
			System.out.println(""+e.getMessage());
		}
		
	}


	
	
}
	

