package com.my.org.erp.Account;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
public class AccountMethod extends HttpServlet
{
   
	private static final long serialVersionUID = 1L;


public static void LoadGroup(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 
    	 		String startLetter=request.getParameter("startLetter");
    	 		String group=request.getParameter("group");
    	 		String sql="";
    	 		sql =" SELECT INT_GROUPID, CHR_GROUPNAME,CHR_GROUP FROM acc_m_group WHERE INT_GROUPID >0 ";
    	 		if(!"0".equals(group))
    	 			if("D".equals(group))
    	 				sql = sql + " AND CHR_GROUP !='C' ";
    	 			else
    	 				sql = sql + " AND CHR_GROUP !='D' ";	
    	 		
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND CHR_GROUPNAME LIKE '"+startLetter+"%' ";
    	 		sql = sql +" ORDER BY CHR_GROUPNAME";
    	 		
    	 		
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    	 		if(readData.length>0)
    	 		{	
    	 			
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +readData[u][1].toUpperCase() + "</Name>");  
	 					if("C".equals(readData[u][2]))
	 						sb.append("<Group>Credit</Group>");
	 					else if("D".equals(readData[u][2]))
	 						sb.append("<Group>Debit</Group>");
	 					else
	 						sb.append("<Group>Credit/Debit</Group>");
	 					sb.append("</Row>");
	 				}	
	 				sb.toString();
	 				response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }
    
    
    
    
    public static void LoadIncome(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String month=request.getParameter("month");
    	 		String year=request.getParameter("year");
    	 		String branch=request.getParameter("branch");
    	 		String sql="";
    	 		sql =" SELECT  a.INT_INCOMEID,b.CHR_GROUPNAME,a.CHR_DESC,date_format(a.DAT_DATE,'%d-%m-%Y'),a.DOU_AMOUNT  FROM   acc_t_receipts   a,acc_m_group b WHERE a.INT_GROUPID=b.INT_GROUPID ";
    	 		sql = sql + " AND  month(a.DAT_DATE)="+month;
    	 		sql = sql + " AND  year(a.DAT_DATE)="+year;
    	 		sql = sql + " AND  INT_BRANCHID="+branch;
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND b.CHR_CATNAME LIKE '"+startLetter+"%' ";
    	 		sql = sql + " ORDER BY a.DAT_DATE ";
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			 
    	 		if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Field1>" +readData[u][0]+ "</Field1>");
	 					sb.append("<Field2>" +readData[u][1]+ "</Field2>");
	 					sb.append("<Field3>" +readData[u][2]+ "</Field3>");
	 					sb.append("<Field4>" +readData[u][3]+ "</Field4>");
	 					sb.append("<Field5>" +readData[u][4]+ "</Field5>");
	 					
	 					sb.append("</Row>");
	 				}	
	 				sb.toString();
    	 			response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }
    
    
    public static void LoadExpense(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String month=request.getParameter("month");
    	 		String year=request.getParameter("year");
    	 		String sql="";
    	 		sql =" SELECT  a.INT_EXPENSEID,b.CHR_GROUPNAME,a.CHR_DESC,date_format(a.DAT_DATE,'%d-%m-%Y'),a.DOU_AMOUNT  FROM  acc_t_payments  a,acc_m_group b WHERE a.INT_GROUPID=b.INT_GROUPID ";
    	 		sql = sql + " AND  month(a.DAT_DATE)="+month;
    	 		sql = sql + " AND  year(a.DAT_DATE)="+year;
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND b.CHR_GROUPNAME LIKE '"+startLetter+"%' ";
    	 		sql = sql + " ORDER BY a.DAT_DATE ";
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Field1>" +readData[u][0]+ "</Field1>");
	 					sb.append("<Field2>" +readData[u][1]+ "</Field2>");
	 					sb.append("<Field3>" +readData[u][2]+ "</Field3>");
	 					sb.append("<Field4>" +readData[u][3]+ "</Field4>");
	 					sb.append("<Field5>" +readData[u][4]+ "</Field5>");
	 					sb.append("</Row>");
	 				}	
	 				sb.toString();
    	 			response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }
    
    public static void LoadBranchess(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		HttpSession session = request.getSession();
    		String branch = ""+session.getAttribute("BRANCHID");	
    		String type = ""+session.getAttribute("USRTYPE");
    		String acccompany=""+request.getParameter("acccompany");
 			int id = Integer.parseInt( acccompany);
 			String sql="";
 			sql = " SELECT  b.INT_BRANCHID,a.CHR_COMPANYNAME,b.CHR_BRANCHNAME FROM com_m_company a ,com_m_branch b ";
 			sql = sql +" WHERE a.INT_COMPANYID=b.INT_COMPANYID ";
 			sql = sql +" AND a.INT_COMPANYID="+id;
 			if(!"F".equals(type))
 				sql = sql +" AND b.INT_BRANCHID="+branch;
 			StringBuffer sb = new StringBuffer();
 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 			if (readData.length > 0)
 	 		{	
 	 			for(int u=0; u<readData.length;u++)
 	 			{	
 	 				sb.append("<branch>");
 	 				sb.append("<Branchid>" + readData[u][0]+ "</Branchid>"); 
 	 				sb.append("<CompanyName>" + readData[u][1]+ "</CompanyName>");
                    sb.append("<BranchName>" + readData[u][2]+ "</BranchName>");
                    sb.append("</branch>");	             
 	 			}
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<branches>" + sb.toString() + "</branches>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	
    
    
    
    public static void LoadDayDifference(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 
    		 
    		String d1=""+request.getParameter("d1");
    		String d2=""+request.getParameter("d2");
    		StringBuffer sb = new StringBuffer();
    		String sql = "SELECT datediff( '"+DateUtil.FormateDateSQL(d2)+"','"+DateUtil.FormateDateSQL(d1)+"')";
 			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 			if (readData.length > 0)
 	 		{	
 	 			for(int u=0; u<readData.length;u++)
 	 			{	
 	 				sb.append("<daydiff>");
 	 				int daydiff= Integer.parseInt(readData[u][0]);
 	 				if((daydiff == 365) || (daydiff == 364)) 
 	 					sb.append("<values>True</values>");
 	 				else
 	 					sb.append("<values>False</values>");
 	 				sb.append("</daydiff>");	             
 	 			}
 	 			response.setContentType("text/xml");
 	            response.setHeader("Cache-Control", "no-cache");
 		        response.getWriter().write("<daydiffs>" + sb.toString() + "</daydiffs>");
 			} 
 	 		else 
 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
			 System.out.println(e.getMessage());
		 } 
    }	
    
    
    public static void LoadAccountGroup(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String sql="";
    	 		sql =" SELECT INT_ACCOUNTGROUPID, CHR_ACCOUNTGROUPNAME FROM acc_m_accountgroup WHERE INT_ACCOUNTGROUPID >0 ";
    	 		 
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND CHR_ACCOUNTGROUPNAME LIKE '"+startLetter+"%' ";
    	 		sql = sql +" ORDER BY CHR_ACCOUNTGROUPNAME";
    	 		
    	 		
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +readData[u][1].toUpperCase() + "</Name>");  
	 					sb.append("</Row>");
	 					
	 				}	
	 				sb.toString();
	 				
    	 			response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }
    
	
    
    
    public static void LoadAccountMaster(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String accountgroup=request.getParameter("accountgroup");
    	 		
    	 		
    	 		String sql="";
    	 		sql =" SELECT INT_ACCOUNTMASTERID,CHR_NAME,CHR_PHONE,CHR_MOBILE,CHR_EMAIL,CHR_CONTACTPERSON,CHR_ITPAN CHR_LST,CHR_GST,CHR_TIN  FROM  acc_m_accountmaster  WHERE INT_ACCOUNTMASTERID>=1";
    	 		if(!"0".equals(accountgroup))
        	 		sql = sql +" AND INT_ACCOUNTGROUPID= "+accountgroup;
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND CHR_NAME LIKE '"+startLetter+"%' ";
    	 		if(!"0".equals(accountgroup))
    	 		sql = sql +" ORDER BY CHR_NAME ";
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +readData[u][1].toUpperCase() + "</Name>");
	 					sb.append("<Phone>" +readData[u][2]+ "</Phone>");
	 					sb.append("<Mobile>" +readData[u][3]+ "</Mobile>");
	 					sb.append("<Email>" +readData[u][4]+ "</Email>");
	 					sb.append("<Person>" +readData[u][5]+ "</Person>");
	 					sb.append("<LST>" +readData[u][6]+ "</LST>");
	 					sb.append("<GST>" +readData[u][7]+ "</GST>");
	 					sb.append("<TIN>" +readData[u][8]+ "</TIN>");
	 					sb.append("</Row>");
	 					
	 				}	
    	 			sb.toString();
	 				response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }
    
    
    

    public static void LoadVouchers(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String accountgroup=request.getParameter("accountgroup");
    	 		String sql="";
    	 		sql =" SELECT INT_VOUCGERID,CHR_VOUCHERNAME,CHR_NARRATION,CHR_TYPE FROM accc_m_vouchers WHERE INT_VOUCGERID>=1 ";
    	 	 	if(!"0".equals(startLetter))
    	 			sql = sql + " AND CHR_VOUCHERNAME LIKE '"+startLetter+"%' ";
    	 		if(!"0".equals(accountgroup))
    	 		sql = sql +" ORDER BY CHR_VOUCHERNAME ";
    	 		
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +readData[u][1].toUpperCase() + "</Name>");
	 					sb.append("<Narration>" +readData[u][2].replaceAll("&"," AND ")+ "</Narration>");
	 					if("C".equals(readData[u][3]))
	 						sb.append("<Type>Credit</Type>");
	 					else
	 						sb.append("<Type>Debit</Type>");
	 					sb.append("</Row>");
	 					
	 				}	
    	 			sb.toString();
	 				response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }
    

    public static void LoadSales(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String month=request.getParameter("month");
    	 		String customer=request.getParameter("customer");
    	 		HttpSession session = request.getSession();
    	 		String branchid=(String)session.getAttribute("ACCBRANCH");
    	 		String acyear =""+session.getAttribute("ACCYEAR");
    	 		int ayear = Integer.parseInt(acyear);
    	 		int reqmonth = Integer.parseInt(month);
    	 		if(reqmonth<4)
    	 			ayear = ayear+1;
    	 		
    	 		
    	 		String year = ""+ayear;
    	 		String sql="";
    	 		sql =" SELECT a.INT_SALESID,a.CHR_SALESNO,b.CHR_CUSTOMERNAME,a.DOU_AMOUNT,DATE_FORMAT(a.DAT_DATE,'%d-%m-%Y') FROM acc_t_salesentry a,acc_m_customer b ";
    	 		sql = sql + " WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND INT_BRANCHID="+branchid;
    	 		
    	 		if(!"0".equals(customer))
    	 			sql = sql + " AND  a.INT_CUSTOMERID =  "+customer;
    	 		
    	 		if(!"0".equals(month))
    	 			sql = sql + " AND  MONTH(a.DAT_DATE) =  "+month;
    	 		
    	 		if(!"0".equals(year))
    	 			sql = sql + " AND  YEAR(a.DAT_DATE) =  "+year;
    	 		
    	 		
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND b.CHR_CUSTOMERNAME  LIKE '"+startLetter+"%' ";
    	 		
    	 	 	 
    	 		sql = sql +" ORDER BY b.CHR_CUSTOMERNAME ";
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Sales>" +readData[u][1] + "</Sales>");
	 					sb.append("<Name>" +readData[u][2].toUpperCase() + "</Name>");
	 					sb.append("<Amount>" +readData[u][3]+ "</Amount>");
	 					sb.append("<Date>" +readData[u][4]+ "</Date>");
	 					sb.append("</Row>");
	 					
	 				}	
    	 			sb.toString();
	 				response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }
    
    
    public static void LoadPurchase(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String customer=request.getParameter("customer");
    	 		
    	 		String month=request.getParameter("month");
    	 		String year=request.getParameter("year");
    	 		HttpSession session = request.getSession();
    	 		String branchid=(String)session.getAttribute("ACCBRANCH");
    	 		String sql="";
    	 		sql =" SELECT a.INT_PURCHASEID,a.CHR_PURCHASENO,b.CHR_CUSTOMERNAME,a.DOU_AMOUNT,DATE_FORMAT(a.DAT_DATE,'%d-%m-%Y') FROM acc_t_purchaseentry a,acc_m_customer b ";
    	 		sql = sql + " WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND INT_BRANCHID="+branchid;
    	 		
    	 		if(!"0".equals(customer))
    	 			sql = sql + " AND  a.INT_CUSTOMERID =  "+customer;
    	 		
    	 		if(!"0".equals(month))
    	 			sql = sql + " AND  MONTH(a.DAT_DATE) =  "+month;
    	 		
    	 		if(!"0".equals(year))
    	 			sql = sql + " AND  YEAR(a.DAT_DATE) =  "+year;
    	 		
    	 		
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND b.CHR_CUSTOMERNAME  LIKE '"+startLetter+"%' ";
    	 		
    	 	 	 
    	 		sql = sql +" ORDER BY b.CHR_CUSTOMERNAME ";
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Purchase>" +readData[u][1] + "</Purchase>");
	 					sb.append("<Name>" +readData[u][2].toUpperCase()  + "</Name>");
	 					sb.append("<Amount>" +readData[u][3]+ "</Amount>");
	 					sb.append("<Date>" +readData[u][4]+ "</Date>");
	 					sb.append("</Row>");
	 					
	 				}	
    	 			sb.toString();
	 				response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }
    
    
    
    
    public static void LoadPurchaseReturn(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String customer=request.getParameter("customer");
    	 		String month=request.getParameter("month");
    	 		String year=request.getParameter("year");
    	 		HttpSession session = request.getSession();
    	 		String branchid=(String)session.getAttribute("ACCBRANCH");
    	 		String sql="";
    	 		sql =" SELECT a.INT_PURCHASERETURNID,a.CHR_PURCHASERETURNNO,b.CHR_CUSTOMERNAME,a.DOU_AMOUNT,DATE_FORMAT(a.DAT_DATE,'%d-%m-%Y') FROM acc_t_purchasereturnentry a,acc_m_customer b ";
    	 		sql = sql + " WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND INT_BRANCHID="+branchid;
    	 		
    	 		if(!"0".equals(customer))
    	 			sql = sql + " AND  a.INT_CUSTOMERID =  "+customer;
    	 		
    	 		if(!"0".equals(month))
    	 			sql = sql + " AND  MONTH(a.DAT_DATE) =  "+month;
    	 		
    	 		if(!"0".equals(year))
    	 			sql = sql + " AND  YEAR(a.DAT_DATE) =  "+year;
    	 		
    	 		
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND b.CHR_CUSTOMERNAME  LIKE '"+startLetter+"%' ";
    	 		
    	 	 	 
    	 		sql = sql +" ORDER BY b.CHR_CUSTOMERNAME ";
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Purchase>" +readData[u][1] + "</Purchase>");
	 					sb.append("<Name>" +readData[u][2].toUpperCase()  + "</Name>");
	 					sb.append("<Amount>" +readData[u][3]+ "</Amount>");
	 					sb.append("<Date>" +readData[u][4]+ "</Date>");
	 					sb.append("</Row>");
	 					
	 				}	
    	 			sb.toString();
	 				response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }
    

    
    public static void LoadSalesReturn(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String customer=request.getParameter("customer");
    	 		String month=request.getParameter("month");
    	 		String year=request.getParameter("year");
    	 		HttpSession session = request.getSession();
    	 		String branchid=(String)session.getAttribute("ACCBRANCH");
    	 		String sql="";
    	 		sql =" SELECT a.INT_SALESRETURNID,a.CHR_SALESRETURNNO,b.CHR_CUSTOMERNAME,a.DOU_AMOUNT,DATE_FORMAT(a.DAT_DATE,'%d-%m-%Y') FROM acc_t_salesreturnentry a,acc_m_customer b ";
    	 		sql = sql + " WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND INT_BRANCHID="+branchid;
    	 		
    	 		if(!"0".equals(customer))
    	 			sql = sql + " AND  a.INT_CUSTOMERID =  "+customer;
    	 		
    	 		if(!"0".equals(month))
    	 			sql = sql + " AND  MONTH(a.DAT_DATE) =  "+month;
    	 		
    	 		if(!"0".equals(year))
    	 			sql = sql + " AND  YEAR(a.DAT_DATE) =  "+year;
    	 		
    	 		
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND b.CHR_CUSTOMERNAME  LIKE '"+startLetter+"%' ";
    	 		sql = sql +" ORDER BY b.CHR_CUSTOMERNAME ";
    	 		
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Sales>" +readData[u][1] + "</Sales>");
	 					sb.append("<Name>" +readData[u][2].toUpperCase()  + "</Name>");
	 					sb.append("<Amount>" +readData[u][3]+ "</Amount>");
	 					sb.append("<Date>" +readData[u][4]+ "</Date>");
	 					sb.append("</Row>");
	 					
	 				}	
    	 			
    	 			sb.toString();
	 				response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }
    


    
    public static void LoadPaymentsEntry(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String customer=request.getParameter("customer");
    	 		String month=request.getParameter("month");
    	 		String year=request.getParameter("year");
    	 		HttpSession session = request.getSession();
    	 		String branchid=(String)session.getAttribute("ACCBRANCH");
    	 		String sql="";
    	 		sql =" SELECT a.INT_PAYMENTID,b.CHR_CUSTOMERNAME,a.DOU_AMOUNT,DATE_FORMAT(a.DAT_DATE,'%d-%m-%Y') FROM acc_t_mpayments a,acc_m_customer b ";
    	 		sql = sql + " WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND INT_BRANCHID="+branchid;
    	 		
    	 		if(!"0".equals(customer))
    	 			sql = sql + " AND  a.INT_CUSTOMERID =  "+customer;
    	 		
    	 		if(!"0".equals(month))
    	 			sql = sql + " AND  MONTH(a.DAT_DATE) =  "+month;
    	 		
    	 		if(!"0".equals(year))
    	 			sql = sql + " AND  YEAR(a.DAT_DATE) =  "+year;
    	 		
    	 		
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND b.CHR_CUSTOMERNAME  LIKE '"+startLetter+"%' ";
    	 		sql = sql +" ORDER BY b.CHR_CUSTOMERNAME ";
    	 		
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +readData[u][1].toUpperCase()  + "</Name>");
	 					sb.append("<Amount>" +readData[u][2]+ "</Amount>");
	 					sb.append("<Date>" +readData[u][3]+ "</Date>");
	 					sb.append("</Row>");
	 					
	 				}	
    	 			
    	 			sb.toString();
	 				response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }



    
    public static void LoadReceiptsEntry(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String customer=request.getParameter("customer");
    	 		String month=request.getParameter("month");
    	 		String year=request.getParameter("year");
    	 		HttpSession session = request.getSession();
    	 		String branchid=(String)session.getAttribute("ACCBRANCH");
    	 		String sql="";
    	 		sql =" SELECT a.INT_RECEIPTID,b.CHR_CUSTOMERNAME,a.DOU_AMOUNT,DATE_FORMAT(a.DAT_DATE,'%d-%m-%Y') FROM acc_t_mrecipts a,acc_m_customer b ";
    	 		sql = sql + " WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND INT_BRANCHID="+branchid;
    	 		
    	 		if(!"0".equals(customer))
    	 			sql = sql + " AND  a.INT_CUSTOMERID =  "+customer;
    	 		
    	 		if(!"0".equals(month))
    	 			sql = sql + " AND  MONTH(a.DAT_DATE) =  "+month;
    	 		
    	 		if(!"0".equals(year))
    	 			sql = sql + " AND  YEAR(a.DAT_DATE) =  "+year;
    	 		
    	 		
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND b.CHR_CUSTOMERNAME  LIKE '"+startLetter+"%' ";
    	 		sql = sql +" ORDER BY b.CHR_CUSTOMERNAME ";
    	 		
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +readData[u][1].toUpperCase()  + "</Name>");
	 					sb.append("<Amount>" +readData[u][2]+ "</Amount>");
	 					sb.append("<Date>" +readData[u][3]+ "</Date>");
	 					sb.append("</Row>");
	 					
	 				}	
    	 			
    	 			sb.toString();
	 				response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }




    public static void LoadJournel(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String customer=request.getParameter("customer");
    	 		String month=request.getParameter("month");
    	 		String year=request.getParameter("year");
    	 		HttpSession session = request.getSession();
    	 		String branchid=(String)session.getAttribute("ACCBRANCH");
    	 		String sql="";
    	 		sql =" SELECT a.INT_JOURNELID,b.CHR_CUSTOMERNAME,a.DOU_AMOUNT,DATE_FORMAT(a.DAT_DATE,'%d-%m-%Y') FROM acc_t_journel a,acc_m_customer b ";
    	 		sql = sql + " WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND INT_BRANCHID="+branchid;
    	 		
    	 		if(!"0".equals(customer))
    	 			sql = sql + " AND  a.INT_CUSTOMERID =  "+customer;
    	 		
    	 		if(!"0".equals(month))
    	 			sql = sql + " AND  MONTH(a.DAT_DATE) =  "+month;
    	 		
    	 		if(!"0".equals(year))
    	 			sql = sql + " AND  YEAR(a.DAT_DATE) =  "+year;
    	 		
    	 		
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND b.CHR_CUSTOMERNAME  LIKE '"+startLetter+"%' ";
    	 		sql = sql +" ORDER BY b.CHR_CUSTOMERNAME ";
    	 		
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +readData[u][1].toUpperCase()  + "</Name>");
	 					sb.append("<Amount>" +readData[u][2]+ "</Amount>");
	 					sb.append("<Date>" +readData[u][3]+ "</Date>");
	 					sb.append("</Row>");
	 					
	 				}	
    	 			
    	 			sb.toString();
	 				response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }


    public static void LoadContra(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String customer=request.getParameter("customer");
    	 		String month=request.getParameter("month");
    	 		String year=request.getParameter("year");
    	 		HttpSession session = request.getSession();
    	 		String branchid=(String)session.getAttribute("ACCBRANCH");
    	 		String sql="";
    	 		sql =" SELECT a.INT_CONTRAID,b.CHR_CUSTOMERNAME,a.DOU_AMOUNT,DATE_FORMAT(a.DAT_DATE,'%d-%m-%Y') FROM acc_t_contra a,acc_m_customer b ";
    	 		sql = sql + " WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND INT_BRANCHID="+branchid;
    	 		
    	 		if(!"0".equals(customer))
    	 			sql = sql + " AND  a.INT_CUSTOMERID =  "+customer;
    	 		
    	 		if(!"0".equals(month))
    	 			sql = sql + " AND  MONTH(a.DAT_DATE) =  "+month;
    	 		
    	 		if(!"0".equals(year))
    	 			sql = sql + " AND  YEAR(a.DAT_DATE) =  "+year;
    	 		
    	 		
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND b.CHR_CUSTOMERNAME  LIKE '"+startLetter+"%' ";
    	 		sql = sql +" ORDER BY b.CHR_CUSTOMERNAME ";
    	 		
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +readData[u][1].toUpperCase()  + "</Name>");
	 					sb.append("<Amount>" +readData[u][2]+ "</Amount>");
	 					sb.append("<Date>" +readData[u][3]+ "</Date>");
	 					sb.append("</Row>");
	 					
	 				}	
    	 			
    	 			sb.toString();
	 				response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }

    public static void LoadDebit(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String customer=request.getParameter("customer");
    	 		String month=request.getParameter("month");
    	 		String year=request.getParameter("year");
    	 		HttpSession session = request.getSession();
    	 		String branchid=(String)session.getAttribute("ACCBRANCH");
    	 		String sql="";
    	 		sql =" SELECT a.INT_DEBITID,b.CHR_CUSTOMERNAME,a.DOU_AMOUNT,DATE_FORMAT(a.DAT_DATE,'%d-%m-%Y') FROM acc_t_debit a,acc_m_customer b ";
    	 		sql = sql + " WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND INT_BRANCHID="+branchid;
    	 		
    	 		if(!"0".equals(customer))
    	 			sql = sql + " AND  a.INT_CUSTOMERID =  "+customer;
    	 		
    	 		if(!"0".equals(month))
    	 			sql = sql + " AND  MONTH(a.DAT_DATE) =  "+month;
    	 		
    	 		if(!"0".equals(year))
    	 			sql = sql + " AND  YEAR(a.DAT_DATE) =  "+year;
    	 		
    	 		
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND b.CHR_CUSTOMERNAME  LIKE '"+startLetter+"%' ";
    	 		sql = sql +" ORDER BY b.CHR_CUSTOMERNAME ";
    	 		
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +readData[u][1].toUpperCase()  + "</Name>");
	 					sb.append("<Amount>" +readData[u][2]+ "</Amount>");
	 					sb.append("<Date>" +readData[u][3]+ "</Date>");
	 					sb.append("</Row>");
	 					
	 				}	
    	 			
    	 			sb.toString();
	 				response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }

    public static void LoadCredit(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String customer=request.getParameter("customer");
    	 		String month=request.getParameter("month");
    	 		String year=request.getParameter("year");
    	 		HttpSession session = request.getSession();
    	 		String branchid=(String)session.getAttribute("ACCBRANCH");
    	 		String sql="";
    	 		sql =" SELECT a.INT_CREDITID,b.CHR_CUSTOMERNAME,a.DOU_AMOUNT,DATE_FORMAT(a.DAT_DATE,'%d-%m-%Y') FROM acc_t_credit a,acc_m_customer b ";
    	 		sql = sql + " WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND INT_BRANCHID="+branchid;
    	 		
    	 		if(!"0".equals(customer))
    	 			sql = sql + " AND  a.INT_CUSTOMERID =  "+customer;
    	 		
    	 		if(!"0".equals(month))
    	 			sql = sql + " AND  MONTH(a.DAT_DATE) =  "+month;
    	 		
    	 		if(!"0".equals(year))
    	 			sql = sql + " AND  YEAR(a.DAT_DATE) =  "+year;
    	 		
    	 		
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND b.CHR_CUSTOMERNAME  LIKE '"+startLetter+"%' ";
    	 		sql = sql +" ORDER BY b.CHR_CUSTOMERNAME ";
    	 		
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +readData[u][1].toUpperCase()  + "</Name>");
	 					sb.append("<Amount>" +readData[u][2]+ "</Amount>");
	 					sb.append("<Date>" +readData[u][3]+ "</Date>");
	 					sb.append("</Row>");
	 					
	 				}	
    	 			
    	 			sb.toString();
	 				response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }


    public static void LoadType(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String sql="";
    	 		sql =" SELECT INT_TYPEID,CHR_TYPENAME FROM accc_m_type ";
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " WHERE  CHR_TYPENAME LIKE '"+startLetter+"%' ";
    	 		else
    	 			sql = sql + " WHERE  CHR_TYPENAME LIKE '%' ";
    	 		sql = sql +" ORDER BY CHR_TYPENAME ";
    	 		
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +readData[u][1].toUpperCase()  + "</Name>");
	 					sb.append("</Row>");
	 				}	
    	 			sb.toString();
	 				response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }
    
    
    public static void LoadTypeGroup(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String type=request.getParameter("type");
    	 		
    	 		String sql="";
    	 		sql =" select a.INT_TYPEGROUPID,a.CHR_TYPEGROUPNAME ,b.CHR_TYPENAME FROM accc_m_typegroups a , accc_m_type b WHERE a.INT_TYPEID = b.INT_TYPEID ";
    	 		
    	 		if(!"0".equals(type))
    	 			sql = sql + " AND  a.INT_TYPEID="+type+" ";
    	 		
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND  a.CHR_TYPEGROUPNAME LIKE '"+startLetter+"%' ";
    	 		else
    	 			sql = sql + " AND  a.CHR_TYPEGROUPNAME LIKE '%' ";
    	 		sql = sql +" ORDER BY a.CHR_TYPEGROUPNAME ";
    	 		

    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +readData[u][1].toUpperCase()  + "</Name>");
	 					sb.append("<Type>" +readData[u][2].toUpperCase()  + "</Type>");
	 					sb.append("</Row>");
	 				}	
    	 			sb.toString();
	 				response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }
    
    
    public static void LoadTypeSubGroup(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String group=request.getParameter("groups");
    	 		
    	 		String sql="";
    	 		sql ="SELECT a.INT_TYPESUBGROUPID ,a.CHR_TYPESUBGROUPNAME ,b.CHR_TYPEGROUPNAME FROM  accc_m_typesubgroups a , accc_m_typegroups b  WHERE a.INT_TYPEGROUPID =b.INT_TYPEGROUPID ";

    	 		if(!"0".equals(group))
    	 			sql = sql + " AND  a.INT_TYPEGROUPID="+group+" ";
    	 		
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND  a.CHR_TYPESUBGROUPNAME LIKE '"+startLetter+"%' ";
    	 		else
    	 			sql = sql + " AND  a.CHR_TYPESUBGROUPNAME LIKE '%' ";
    	 		sql = sql +" ORDER BY a.CHR_TYPESUBGROUPNAME ";
    	 		
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +readData[u][1].toUpperCase()  + "</Name>");
	 					sb.append("<Group>" +readData[u][2].toUpperCase()  + "</Group>");
	 					sb.append("</Row>");
	 				}	
    	 			sb.toString();
	 				response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }
    
    
    
    
    
    public static void LoadTypeSubsidiaryGroup(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String group=request.getParameter("groups");
    	 		
    	 		String sql="";
    	 		sql ="SELECT a.INT_TYPESUBSIDIARYID,a.CHR_TYPESUBSIDIARYNAME  ,b.CHR_TYPESUBGROUPNAME FROM accc_m_typesubsidiarygroup a ,accc_m_typesubgroups b WHERE a.INT_TYPESUBGROUPID=b.INT_TYPESUBGROUPID ";

    	 		if(!"0".equals(group))
    	 			sql = sql + " AND  a.INT_TYPESUBGROUPID="+group+" ";
    	 		
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND  a.CHR_TYPESUBSIDIARYNAME LIKE '"+startLetter+"%' ";
    	 		else
    	 			sql = sql + " AND  a.CHR_TYPESUBSIDIARYNAME LIKE '%' ";
    	 		sql = sql +" ORDER BY a.CHR_TYPESUBSIDIARYNAME ";
    	 		
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +readData[u][1].toUpperCase()  + "</Name>");
	 					sb.append("<Group>" +readData[u][2].toUpperCase()  + "</Group>");
	 					sb.append("</Row>");
	 				}	
    	 			sb.toString();
	 				response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }
    
    
    
    public static void LoadDayBook(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String sql="";
    	 		sql ="SELECT a.INT_DAYID,b.CHR_TYPESUBSIDIARYNAME,b.INT_TYPEID,date_format(a.DT_DATE,'%d-%m-%Y'), a.DOU_AMOUNT,a.CHR_DESC FROM accc_t_dayentry a ,accc_m_typesubsidiarygroup b  WHERE a.INT_TYPESUBSIDIARYID=b.INT_TYPESUBSIDIARYID ";
    	 		
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND  b.CHR_TYPESUBSIDIARYNAME LIKE '"+startLetter+"%' ";
    	 		else
    	 			sql = sql + " AND  b.CHR_TYPESUBSIDIARYNAME LIKE '%' ";
    	 		sql = sql +" ORDER BY a.DT_DATE ";
    	 		
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +readData[u][1].toUpperCase()  + "</Name>");
	 					if("1".equals(readData[u][2]))
	 					{
	 						sb.append("<Credit>" +readData[u][4] + "</Credit>");
	 						sb.append("<Debit>-</Debit>");
	 					}
	 					else
	 					{
	 						sb.append("<Credit>-</Credit>");
	 						sb.append("<Debit>" +readData[u][4] + "</Debit>");
	 					}
	 					sb.append("<Date>" +readData[u][3] + "</Date>");
	 					sb.append("<Description>" +readData[u][5] + "</Description>");
	 					sb.append("</Row>");
	 				}	
    	 			sb.toString();
	 				response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }
    
    public static void LoadLedger(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String groupid=request.getParameter("under");
    	 		String sql="";
    	 		
    	 		sql ="SELECT  a.INT_LEDGERID,a.CHR_NAME,b.CHR_TYPESUBSIDIARYNAME,a.CHR_PHONE,a.CHR_MOBILE,DATE_FORMAT(DAT_DATE,'%d-%m-%Y') FROM accc_m_ledger a,accc_m_typesubsidiarygroup b  WHERE a.INT_TYPESUBSIDIARYID=b.INT_TYPESUBSIDIARYID ";
    	 		
    	 		if(!"0".equals(groupid))
    	 			sql = sql +" AND a.INT_TYPESUBSIDIARYID="+groupid;
    	 			
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND  b.CHR_TYPESUBSIDIARYNAME LIKE '"+startLetter+"%' ";
    	 		else
    	 			sql = sql + " AND  b.CHR_TYPESUBSIDIARYNAME LIKE '%' ";
    	 		sql = sql +" ORDER BY a.CHR_NAME ";
    	 		
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +readData[u][1].toUpperCase()  + "</Name>");
	 					sb.append("<Subname>" +readData[u][2] + "</Subname>");
	 					sb.append("<Phone>" +readData[u][3] + "</Phone>");
	 					sb.append("<Mobile>" +readData[u][4] + "</Mobile>");
	 					sb.append("<Date>" +readData[u][5] + "</Date>");
	 					sb.append("</Row>");
	 				}	
    	 			sb.toString();
	 				response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }
    
    public static void LoadDateCheck(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String date=request.getParameter("date");
    	 		String fromdate=request.getParameter("fromdate");
    	 		String todate=request.getParameter("todate");
    	 		String sql="";
    	 		date = DateUtil.FormateDateSQL(date);
    	 		sql =" select (('"+date+"' >='"+fromdate+"') AND ('"+date+"' <='"+todate+"'))";
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 		
    	 			sb.append("<Row>");    	            
	 				if("1".equals(readData[0][0]))
	 					sb.append("<Value>True</Value>");
	 				else
	 					sb.append("<Value>False</Value>");
	 				
	 				sb.append("<fromdate>"+DateUtil.FormateDateSys(fromdate)+"</fromdate>");
	 				sb.append("<todate>"+DateUtil.FormateDateSys(todate)+"</todate>");
	 				sb.append("</Row>");
	 				sb.toString();
	 				response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }
    
    
    public static void LoadRuntimeLedger(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String id=request.getParameter("id");
    	 		String sql="";
    	 		
    	 		sql ="SELECT INT_LEDGERID,CHR_NAME FROM  accc_m_ledger ";
    	 		if(!"0".equals(id))
    	 			sql = sql +" WHERE INT_TYPESUBSIDIARYID="+id;
    	 		sql = sql +" ORDER BY CHR_NAME ";
    	 		
    	 		
    	 	 
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			
    	 		if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +readData[u][1].toUpperCase()  + "</Name>");
	 					sb.append("</Row>");
	 				}	
    	 			sb.toString();
    	 			 
	 				response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Rows>"+sb.toString()+"</Rows>");
	 			} 
    	 		else 
    	 		{
    	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 		}
    	 			
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		 System.out.println(e.getMessage());
    	 	} 
    }
    
}
