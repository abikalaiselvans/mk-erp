package com.my.org.erp.image;

import java.io.File;
import java.io.FileInputStream;

import java.io.InputStream;

import java.sql.Connection;


import DBConnection.DBCon;



public class Image   
{
	public static void insertStaffImage(String Path, String filename,String empid) 
	{
 		try 
		{
	
			String fs =Path+"StaffPhoto/"+filename;
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
			String sql="UPDATE com_m_staffaddressproof SET IMG_IMAGE=? WHERE CHR_EMPID=?";	
			pstm = co.prepareStatement(sql);
			pstm.setObject(1,bytes);
			pstm.setString(2,empid);
			pstm.execute();
 
			
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());
		}
		
	}
	
	
	
	public static void insertAddressProof(String Path, String filename,String empid) 
	{
 		try 
		{
 			com.my.org.erp.common.CommonFunction.ErrorWrite("asdasdasdasdasd");
			String fs =Path+""+filename;
			String proofid[]= filename.split("_");
			String proofColumn= proofid[1];
			com.my.org.erp.common.CommonFunction.ErrorWrite(""+fs);
			
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
		    if(com.my.org.erp.common.CommonFunction.RecordExist("SELECT COUNT(*) FROM com_m_staffaddressproof WHERE CHR_EMPID='"+empid+"'"))
		    {
		    	String sql="UPDATE com_m_staffaddressproof SET "+proofColumn+"=? WHERE CHR_EMPID=?";	
				pstm = co.prepareStatement(sql);
				pstm.setObject(1,bytes);
				pstm.setString(2,empid);
				com.my.org.erp.common.CommonFunction.ErrorWrite(""+pstm);
				
				pstm.execute();
		    }
		    else
		    {
		    	String sql="INSERT INTO com_m_staffaddressproof (CHR_EMPID,"+proofColumn+",CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ) VALUES (" +
		    			"?,?,?,DATE(NOW()),? )";	
				pstm = co.prepareStatement(sql);
				pstm.setString(1,empid);
				pstm.setObject(2,bytes);
				pstm.setString(3,"ADMIN");
				pstm.setString(4,"Y");
				com.my.org.erp.common.CommonFunction.ErrorWrite(""+pstm);
				pstm.execute();
		    }
 
			
		} 
		catch (Exception e) 
		{
			com.my.org.erp.common.CommonFunction.ErrorWrite(""+e.getMessage());
		}
		
	}
	
}	