package com.my.org.erp.SmartMailtemplates;

import com.my.org.erp.common.CommonFunctions;

public class Footer 
{
	public static String  footerContent(String branchid)
    {
    	String content="";
    	try
    	{
    		
    		String ssql = " SELECT b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_STREET,e.CHR_CITYNAME,d.CHR_STATENAME,a.INT_PINCODE,a.CHR_PHONE,  ";
    		ssql = ssql +" a.CHR_FAX,a.CHR_EMAIL, a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO,a.CHR_LOCALTAXNO,a.CHR_PANNO, "; 
    		ssql = ssql +" a.CHR_SERVICETAX ,d1.CHR_DISTRICT,a.CHR_CIN_NUMBER FROM com_m_branch a , com_m_company b ,com_m_country c, com_m_state d, com_m_district d1, com_m_city e ";
    		ssql = ssql +" WHERE  a.INT_CITYID = e.INT_CITYID ";
    		ssql = ssql +" AND a.INT_COUNTRYID = c.INT_COUNTRYID ";
    		ssql = ssql +" AND a.INT_STATEID =d.INT_STATEID AND a.INT_DISTRICTID =d1.INT_DISTRICTID  ";
    		ssql = ssql +" AND a.INT_COMPANYID = b.INT_COMPANYID  ";
    		ssql = ssql +" AND a.INT_BRANCHID = "+ branchid;
    		System.out.println(ssql);
    		String cpydata[][]=CommonFunctions.QueryExecute(ssql);
    		if(cpydata.length>0)
    		{
    			content = content + "<strong>"+cpydata[0][0]+"</strong><br> ";
    			 if(!"-".equals(cpydata[0][2]))
    				 content = content + ""+cpydata[0][2]+" | ";
    			 if(!"-".equals(cpydata[0][3]))	
    				 content = content + ""+cpydata[0][3]+" | ";
    			 if(!"-".equals(cpydata[0][16]))	
    				 content = content + ""+cpydata[0][16]+" | ";
    			 if(!"-".equals(cpydata[0][4]))
    				 content = content + ""+cpydata[0][4]+"<br> ";
    			 //if(!"-".equals(cpydata[0][5]))
    				 //content = content + "Pincode : "+cpydata[0][5]+"<br> <br>";
    		}
    	content = content + "<br>Note :- This is an automatically generated email. Please do not reply to this message.<br><br> ";
    	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return content;
	}
	
	public static String  footerContent( )
    {
    	String content="";
    	try
    	{
    		
    		String ssql = " SELECT a.CHR_NAME,a.CHR_ADDRESS1,a.CHR_ADDRESS2,e.CHR_CITYNAME,d.CHR_STATENAME,a.INT_PINCODE,a.CHR_PHONE, ";  
    		ssql = ssql + " a.CHR_FAX,a.CHR_EMAIL, d1.CHR_DISTRICT  ";
    		ssql = ssql + " FROM m_company a,com_m_country c, com_m_state d, com_m_district d1, com_m_city e ";  
    		ssql = ssql + "  WHERE  a.INT_CITYID = e.INT_CITYID  ";
    		ssql = ssql + "  AND a.INT_COUNTRYID = c.INT_COUNTRYID "; 
    		ssql = ssql + "  AND a.INT_STATEID =d.INT_STATEID AND a.INT_DISTRICTID =d1.INT_DISTRICTID ";  
    		System.out.println(ssql);
    		String cpydata[][]=CommonFunctions.QueryExecute(ssql);
    		if(cpydata.length>0)
    		{
    			content = content + "<strong>"+cpydata[0][0]+"</strong><br> ";
    			if(!"-".equals(cpydata[0][1]))
   				 content = content + ""+cpydata[0][1]+" | ";
   			 	if(!"-".equals(cpydata[0][2]))
    				 content = content + ""+cpydata[0][2]+" | ";
    			 if(!"-".equals(cpydata[0][3]))	
    				 content = content + ""+cpydata[0][3]+" | ";
    			 if(!"-".equals(cpydata[0][9]))
    				 content = content + ""+cpydata[0][9]+"<br> ";
    			 if(!"-".equals(cpydata[0][4]))
    				 content = content + ""+cpydata[0][4]+"<br> ";
    			 
    		}
    	content = content + "<br>Note :- This is an automatically generated email. Please do not reply to this message.<br><br> ";
    	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return content;
	}
}
