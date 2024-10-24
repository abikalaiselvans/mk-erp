package com.my.org.erp.SmartAMC;
 
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
 
@SuppressWarnings("serial")
public class AMCMethod extends HttpServlet
{ 

	public static void LoadServiceGroup(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
    	 {
			String startLetter =request.getParameter("startLetter");
			String branch=request.getParameter("branch");
			String sql=" ";
	 		sql= " SELECT INT_GROUPID ,CHR_GROUPNAME FROM  inv_m_servicecustomergroup ";
	 		sql = sql + " WHERE INT_GROUPID >= 1 ";
	 		if(!"0".equals(branch))
	 			sql = sql + " AND  INT_BRANCHID ="+branch;
	 		if(!"0".equals(startLetter))
	 			sql = sql +" AND CHR_GROUPNAME like '"+startLetter+"%' ";
	 		else
	 			sql = sql +" AND CHR_GROUPNAME like '%' ";
	 		
	 		
	 		sql = sql+ "ORDER BY  CHR_GROUPNAME ";
	 		System.out.println(sql);
	 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 		
	 		
	 		StringBuffer sb = new StringBuffer();
	 		if (readData.length > 0)
	 		{	
	 			for(int u=0; u<readData.length;u++)		 				
	 	 		{
	 	 				sb.append("<Group>");
	 	 				sb.append("<Id>"+readData[u][0]+"</Id>");		 	 				
	 	 				sb.append("<Name>"+readData[u][1].replaceAll("&", " AND ")+"</Name>");
	 	 				sb.append("</Group>");
	 	 		}	
	 			response.setContentType("text/xml");
	 			response.setHeader("Cache-Control", "no-cache");		 		
	 			response.getWriter().write("<Groups>" + sb.toString() + "</Groups>");
	 			
	 		} 
	 		else 
	 		{
	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	 		}
    	 } 
    	 catch (Exception e) 
    	 {
    		 System.out.println(e.getMessage());
 				request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		dispatchers.forward(request, response); 
    	 }			
	}
	
	public static void LoadRuntimeNonCustomerGroup(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    	 		String id=request.getParameter("id");
    	 		String branch=request.getParameter("branch");
    	 		
    	 		String sql="";
    	 		  
    	 		sql =" SELECT a.INT_GROUPID,b.CHR_GROUPNAME FROM  inv_m_servicecustomerinfo a ,inv_m_servicecustomergroup b WHERE a.INT_GROUPID = b.INT_GROUPID ";
    	 	 	if(!"0".equals(id))
    	 			sql = sql + " AND a.INT_SERVICECENTERID="+id;
    	 	 	if(!"0".equals(branch))
    	 			sql = sql + " AND b.INT_BRANCHID="+branch;
    	 	 	sql = sql +" GROUP BY a.INT_GROUPID  ORDER BY b.CHR_GROUPNAME";
    	 	 	System.out.println(sql);
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +readData[u][1].toUpperCase().replaceAll("&", " AND ") + "</Name>");
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
 			request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		dispatchers.forward(request, response); 
		 } 
    }	
	
	public static void LoadAMCCustomer(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
    	 {
			String group=request.getParameter("group");
	 		String startLetter =request.getParameter("startLetter");
	 		String servicecenter =request.getParameter("servicecenter");
	 		String branch =request.getParameter("branch");
	 		
	 		String sql=" ";
	 		sql= " SELECT  INT_CUSTOMERID ,CHR_CUSTOMERNAME,CHR_PHONE,CHR_MOBILE,CHR_EMAIL 	FROM inv_m_servicecustomerinfo ";
	 		sql = sql + " WHERE INT_CUSTOMERID >= 1 ";
	 		if(!"0".equals(group))
	 			sql = sql +" AND INT_GROUPID="+group;
	 		if(!"0".equals(branch))
	 			sql = sql +" AND INT_BRANCHID  ="+branch;
	 		
	 		if(!"0".equals(servicecenter))
	 			sql = sql +" AND INT_SERVICECENTERID="+servicecenter;
	 		
	 		if(!"0".equals(startLetter))
	 			sql = sql +" AND CHR_CUSTOMERNAME like '"+startLetter+"%' ";
	 		else
	 			sql = sql +" AND CHR_CUSTOMERNAME like '%' ";
	 		
	 		sql = sql+ "ORDER BY  CHR_CUSTOMERNAME    ";
	 		 
	 		System.out.println(sql);
	 		String readData[][] =  CommonFunctions.QueryExecute(sql);
	 		StringBuffer sb = new StringBuffer();
	 		if (readData.length > 0)
	 		{	
	 			for(int u=0; u<readData.length;u++)		 				
	 	 		{
		 				sb.append("<Rows>");
	 	 				sb.append("<Id>"+readData[u][0]+"</Id>");		 	 				
	 	 				sb.append("<Name>"+(readData[u][1].replaceAll("&", " AND ")).trim()+"</Name>");
	 	 				sb.append("<Phone>"+readData[u][2]+"</Phone>");
	 	 				sb.append("<Mobile>"+readData[u][3]+" </Mobile>");
	 	 				sb.append("<Email>"+readData[u][4]+"</Email>");
	 	 				sb.append("</Rows>");
	 	 		}
	 			response.setContentType("text/xml");
	 			response.setHeader("Cache-Control", "no-cache");		 		
	 			response.getWriter().write("<Fieldsss>" + sb.toString() + "</Fieldsss>");
	 			
	 		} 
	 		else 
	 		{
	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	 		}
    	 } 
    	 catch (Exception e) 
    	 {
    		 System.out.println(e.getMessage());
 			request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		dispatchers.forward(request, response); 
    	 }			
	}
	
	public static void LoadServiceCenter(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
    	 {
			String startLetter =request.getParameter("startLetter");
	 		String sql=" ";
		 		sql= " SELECT INT_SERVICECENTERID,CHR_CENTERNAME,CHR_SHORTNAME,CHR_MOBILE,CHR_MAIL FROM  inv_m_servicecenter";
	 		sql = sql + " WHERE INT_SERVICECENTERID >= 1 ";
	 		if(!"0".equals(startLetter))
	 			sql = sql +" AND CHR_CENTERNAME like '"+startLetter+"%' ";
	 		else
	 			sql = sql +" AND CHR_CENTERNAME like '%' ";
	 		sql = sql+ "ORDER BY  CHR_CENTERNAME ";
	 		System.out.println(sql);
	 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 		StringBuffer sb = new StringBuffer();
	 		if (readData.length > 0)
	 		{	
	 			for(int u=0; u<readData.length;u++)		 				
	 	 		{
	 	 				sb.append("<Group>");
	 	 				sb.append("<Id>"+readData[u][0]+"</Id>");		 	 				
	 	 				sb.append("<Name>"+readData[u][1]+"</Name>");
	 	 				sb.append("<SName>"+readData[u][2]+"</SName>");
	 	 				sb.append("<Mobile>"+readData[u][3]+"</Mobile>");
	 	 				sb.append("<EMail>"+readData[u][4]+"</EMail>");
	 	 				sb.append("</Group>");
	 	 		}	
	 			response.setContentType("text/xml");
	 			response.setHeader("Cache-Control", "no-cache");		 		
	 			response.getWriter().write("<Groups>" + sb.toString() + "</Groups>");
	 			
	 		} 
	 		else 
	 		{
	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	 		}
    	 } 
    	 catch (Exception e) 
    	 {
    		 System.out.println(e.getMessage());
 			request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		dispatchers.forward(request, response); 
    	 }			
	}
	
	
	
	

	
	public static void LoadServiceItems(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try
    	 {
			String startLetter =request.getParameter("startLetter");
	 		String sql=" ";
	 		sql= " SELECT INT_SERVICEITEMID ,CHR_SERVICEITEMNAME FROM  inv_m_serviceitems ";
	 		sql = sql + " WHERE INT_SERVICEITEMID >= 1 ";
	 		if(!"0".equals(startLetter))
	 			sql = sql +" AND CHR_SERVICEITEMNAME like '"+startLetter+"%' ";
	 		else
	 			sql = sql +" AND CHR_SERVICEITEMNAME like '%' ";
	 		sql = sql+ "ORDER BY  CHR_SERVICEITEMNAME ";
	 		System.out.println(sql);
	 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 		StringBuffer sb = new StringBuffer();
	 		if (readData.length > 0)
	 		{	
	 			for(int u=0; u<readData.length;u++)		 				
	 	 		{
	 	 				sb.append("<Item>");
	 	 				sb.append("<Id>"+readData[u][0]+"</Id>");		 	 				
	 	 				sb.append("<Name>"+readData[u][1].replaceAll("&", " AND ")+"</Name>");
	 	 				sb.append("</Item>");
	 	 		}	
	 			response.setContentType("text/xml");
	 			response.setHeader("Cache-Control", "no-cache");		 		
	 			response.getWriter().write("<Items>" + sb.toString() + "</Items>");
	 			
	 		} 
	 		else 
	 		{
	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	 		}
    	 } 
    	 catch (Exception e) 
    	 {
    		 System.out.println(e.getMessage());
 			request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		dispatchers.forward(request, response); 
    	 }			
	}
	
	
	

	public static void LoadServiceAMC(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try
    	 {
			
			String startLetter =request.getParameter("startLetter");
			String servicecenter =request.getParameter("servicecenter");
			String customerid =request.getParameter("customerid");
			String peripheralid =request.getParameter("peripheralid");
			String branch =request.getParameter("branch");
			
			String sql=" ";
	 		sql= "  SELECT a.INT_CUSTOMERID,a.INT_SERVICEITEMID,b.CHR_CUSTOMERNAME  ,c.CHR_SERVICEITEMNAME,count(c.CHR_SERVICEITEMNAME), b.CHR_MOBILE ,d.CHR_BRANCHNAME,e.CHR_CENTERNAME";
	 		sql = sql + "   FROM inv_m_serviceamc a  ,inv_m_servicecustomerinfo b,inv_m_serviceitems c ,com_m_branch d, inv_m_servicecenter e "; 
	 		sql = sql + "   WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID   AND a.INT_SERVICEITEMID = c.INT_SERVICEITEMID";
	 		sql = sql + "   AND a.INT_BRANCHID = d.INT_BRANCHID AND b.INT_SERVICECENTERID =e.INT_SERVICECENTERID ";
	 		
	 		if(!"0".equals(branch))
	 			sql = sql + " AND a.INT_BRANCHID  ="+branch;
	 		
	 		if(!"0".equals(customerid))
	 			sql = sql + " AND a.INT_CUSTOMERID="+customerid;
	 		
	 		if(!"0".equals(servicecenter))
	 			sql = sql + " AND b.INT_SERVICECENTERID="+servicecenter;
	 		
	 		if(!"0".equals(peripheralid))
	 			sql = sql + " AND c.INT_SERVICEITEMID="+peripheralid;
	 		
	 		if(!"0".equals(startLetter))
	 			sql = sql +" AND b.CHR_CUSTOMERNAME like '"+startLetter+"%' ";
	 		else
	 			sql = sql +" AND b.CHR_CUSTOMERNAME like '%' ";
	 		
	 		sql = sql+ " GROUP BY a.INT_CUSTOMERID,c.CHR_SERVICEITEMNAME  ORDER BY  b.CHR_CUSTOMERNAME  LIMIT 3000";
	 		 
	 		System.out.println(sql);
	 		String readData[][] = CommonFunctions.QueryExecute(sql);
	 		StringBuffer sb = new StringBuffer();
	 		if (readData.length > 0)
	 		{	
	 			for(int u=0; u<readData.length;u++)		 				
	 	 		{
	 	 				sb.append("<Row>");
	 	 				sb.append("<Customerid>"+(readData[u][0])+"</Customerid>");
	 	 				sb.append("<Serviceitemid>"+readData[u][1]+"</Serviceitemid>");
	 	 				sb.append("<Name>"+readData[u][2].replaceAll("&", " AND ").replaceAll(">", "")+"</Name>");
	 	 				sb.append("<Item>"+readData[u][3].replaceAll("&", " AND ").replaceAll(">", "")+"</Item>");
	 	 				sb.append("<Noofmachine>"+readData[u][4].replaceAll("&", " AND ").replaceAll(">", "")+"</Noofmachine>");
	 	 				sb.append("<Mobile>"+readData[u][5].replaceAll("&", " AND ").replaceAll(">", "")+"</Mobile>");
	 	 				sb.append("<Branch>"+readData[u][6].replaceAll("&", " AND ").replaceAll(">", "")+"</Branch>");
	 	 				sb.append("<SCenter>"+readData[u][7].replaceAll("&", " AND ").replaceAll(">", "")+"</SCenter>");
	 	 				sb.append("</Row>");
	 	 		}	
	 			System.out.println();
	 			System.out.println();
	 			 
	 			response.setContentType("text/xml");
	 			response.setHeader("Cache-Control", "no-cache");		 		
	 			response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
	 			
	 		} 
	 		else 
	 		{
	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	 		}
    	 } 
    	 catch (Exception e) 
    	 {
    		 System.out.println(e.getMessage());
 			request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		dispatchers.forward(request, response); 
    	 }			
	}

	
	
	
	public static void LoadAMCPersonalinfo(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String id=request.getParameter("id");
    		 	String sql =" SELECT CHR_CUSTOMERNAME,CHR_STREET,CHR_CITY,CHR_STATE,CHR_PHONE,CHR_MOBILE,CHR_EMAIL FROM  inv_m_servicecustomerinfo  WHERE INT_CUSTOMERID="+id;
    		 	System.out.println(sql);
    		 	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		 	StringBuffer sb = new StringBuffer();
		 		if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
		 	 			
		 	 				sb.append("<Details>");
		 	 				sb.append("<Name>"+readData[u][0] +"</Name>");
		 	 				sb.append("<Street>"+readData[u][1] +"</Street>");
		 	 				sb.append("<City>"+readData[u][2] +"</City>");
		 	 				sb.append("<State>"+readData[u][3] +"</State>");
		 	 				sb.append("<Phone>"+readData[u][4] +"</Phone>");
		 	 				sb.append("<Mobile>"+readData[u][5] +"</Mobile>");
		 	 				sb.append("<Email>"+readData[u][6] +"</Email>");
		 	 				sb.append("</Details>");
		 	 			
		 			}
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Detailss>" + sb.toString() + "</Detailss>");
		 		} 
		 		else 
		 		{
		 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		 		}			     	 	 
 	 		      	 } 
    	 catch (Exception e) 
    	 {
    		 System.out.println(e.getMessage());
 			request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		dispatchers.forward(request, response);  
    	 } 
    }	

	public static void LoadAMCCallBooking(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String month=request.getParameter("month");
    		 	String year=request.getParameter("year");
    		 	String customerid=request.getParameter("customerid");
    		 	String bookingtype=request.getParameter("bookingtype");
    		 	String bookingunder=request.getParameter("bookingunder");
    		 	String callstatus=request.getParameter("callstatus");
    		 	String StartLetter = ""+request.getParameter("StartLetter");
    		 	String branch = ""+request.getParameter("branch");
    		 	
    		 	String sql =" SELECT a.CHR_SERVICECALLNO, b.CHR_CUSTOMERNAME,a.CHR_SERIALNO,DATE_FORMAT(a.DT_BOOKINGDATE,'%d-%m-%Y %H :%i :%s %p'), DATE_FORMAT(a.DT_CLOSINGDATE,'%d-%m-%Y  %H :%i :%s %p'),a.CHR_BOOKINGTYPE,a.CHR_BOOKINGUNDER,a.CHR_STATUS, a.CHR_ENGGSTATUS,a.CHR_BOOKINGEMPID,c.CHR_STAFFNAME FROM  inv_t_servicecallbooking  a, inv_m_servicecustomerinfo b ,com_m_staff c";
    		 	sql = sql +" WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID AND a.CHR_USRNAME =c.CHR_USERID";
    		 	if(!"0".equals(branch))
    		 		sql = sql +"  AND a.INT_BRANCHID   ="+branch;
    		 	
    		 	
    		 	if(!"0".equals(customerid))
    		 		sql = sql +"  AND a.INT_CUSTOMERID ="+customerid;
    		 	
    		 	if(!"0".equals(bookingtype))
    		 		sql = sql +"  AND a.CHR_BOOKINGTYPE= '"+bookingtype +"'";
    		 	
    		 	if(!"0".equals(bookingunder))
	    		 		sql = sql +"  AND a.CHR_BOOKINGUNDER='"+bookingunder+"'";
    		 	
    		 	if(!"0".equals(callstatus))
    		 		sql = sql +"  AND a.CHR_STATUS ='"+callstatus+"'";
    		 	
    		 	if(!"0".equals(month))
    		 		sql = sql +"  AND MONTH(DT_BOOKINGDATE)= "+month;
    		 	
    		 	if(!"0".equals(year))
    		 		sql = sql +"  AND YEAR(DT_BOOKINGDATE) ="+year;

    		 	if(!"0".equals(StartLetter))
    		 		sql = sql +"  AND b.CHR_CUSTOMERNAME LIKE '"+StartLetter +"%'";
    		 	System.out.println(sql);
    		 	
    		 	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		 	StringBuffer sb = new StringBuffer();
		 		if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
		 	 			
		 	 				sb.append("<Booking>");
		 	 				sb.append("<Bookingid>"+readData[u][0] +"</Bookingid>");
		 	 				sb.append("<Name>"+readData[u][1].replaceAll("&" , " AND") +"</Name>");
		 	 				sb.append("<Serial>"+readData[u][2].replaceAll("&" , " AND") +"</Serial>");
		 	 				sb.append("<Bdate>"+readData[u][3].replaceAll("&" , " AND") +"</Bdate>");
		 	 				sb.append("<Cdate>"+readData[u][4].replaceAll("&" , " AND") +"</Cdate>");
		 	 				sb.append("<Btype>"+readData[u][5].replaceAll("&" , " AND") +"</Btype>");
		 	 				sb.append("<Bunder>"+readData[u][6].replaceAll("&" , " AND") +"</Bunder>");
		 	 				sb.append("<CallStatus>"+readData[u][7].replaceAll("&" , " AND") +"</CallStatus>");
		 	 				sb.append("<EnggStatus>"+readData[u][8].replaceAll("&" , " AND") +"</EnggStatus>");
		 	 				sb.append("<Bookedby>"+readData[u][9].replaceAll("&" , " AND") +"</Bookedby>");
		 	 				sb.append("<Staff>"+readData[u][10].replaceAll("&" , " AND") +"</Staff>");
		 	 	 			sb.append("</Booking>");
		 	 			 
		 			}
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Bookings>" + sb.toString() + "</Bookings>");
		 		} 
		 		else 
		 		{
		 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		 		}			     	 	 
 	 		      	 } 
    	 catch (Exception e) 
    	 {
    		 System.out.println(e.getMessage());
 			request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		dispatchers.forward(request, response); 
    	 } 
    }	
	
	
	
	

	public static void LoadRuntimeCustomer(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    	 		String id=request.getParameter("id");
    	 		String branch=""+request.getParameter("branch");
    	 		  
    	 		String sql="";
    	 		    
    	 		sql =" SELECT  INT_CUSTOMERID ,CHR_CUSTOMERNAME FROM inv_m_servicecustomerinfo     WHERE INT_CUSTOMERID >= 1 ";
    	 	 	if(!"0".equals(id))
    	 			sql = sql + " AND INT_SERVICECENTERID="+id;
    	 	 	if(!"0".equals(branch))
    	 			sql = sql + " AND INT_BRANCHID  ="+branch;
    	 		sql = sql +" ORDER BY CHR_CUSTOMERNAME ";
    	 		
    	 		System.out.println("\n Load Customer List");
    	 		System.out.println(sql);
    	 		System.out.println("\n");
    	 		
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +readData[u][1].toUpperCase().replaceAll("&", " AND ") + "</Name>");
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
 			request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		dispatchers.forward(request, response); 
		 } 
    }	
	
	

	
	

	public static void LoadAMCSerialnumber(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try
    	 {
			
			String startLetter =request.getParameter("search");
			String tablename =request.getParameter("tablename");
			String fieldname=request.getParameter("fieldname");
			String sql=" ";
	 		sql = " SELECT "+fieldname+" FROM "+tablename; 
			
	 		if(!"".equals(startLetter))
	 			sql = sql +" WHERE CHR_STATUS ='Y'AND "+fieldname+" like '"+startLetter+"%' ";
	 		else
	 			sql = sql +"  WHERE CHR_STATUS ='Y'AND  "+fieldname+" like '%' ";
	 		
	 		sql = sql+ "ORDER BY  "+fieldname;
	 		System.out.println(sql);
	 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 		StringBuffer sb = new StringBuffer();
	 		if (readData.length > 0)
	 		{	
	 			for(int u=0; u<readData.length;u++)		 				
	 	 		{
	 	 				sb.append("<AMC>");
	 	 				sb.append("<Serial>"+readData[u][0]+"</Serial>");
	 	 				sb.append("</AMC>");
	 	 		}	
	 			response.setContentType("text/xml");
	 			response.setHeader("Cache-Control", "no-cache");		 		
	 			response.getWriter().write("<AMCs>" + sb.toString() + "</AMCs>");
	 			
	 		} 
	 		else 
	 		{
	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	 		}
    	 } 
    	 catch (Exception e) 
    	 {
    		 System.out.println(e.getMessage());
 			request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		dispatchers.forward(request, response); 
    	 }			
	}

	
	
	public static void CustomerServiceCallSerialnumberCheck(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		
    			String serialno=request.getParameter("serialno");
    			String startdate=request.getParameter("startdate");
    		 	String sdate[]= startdate.split(" ");
    		 	startdate = DateUtil.FormateDateSQL(sdate[0])+" "+sdate[1];
    			
    		 	String sql= "SELECT DT_CLOSEDATE,CHR_CALLSTATUS  FROM  inv_t_servicecallbookingtrack WHERE DT_CLOSEDATE=(SELECT MAX(DT_CLOSEDATE) FROM  inv_t_servicecallbookingtrack WHERE CHR_SERIALNO='"+serialno+"')";
    		 	System.out.println(sql);
    		 	String diff[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		 	boolean f1 =false;
    		 	 
    		 	if(diff.length>0)
    		 	{
    		 		sql=" select datediff('"+startdate+"','"+diff[0][0]+"')";
    		 		int day =Integer.parseInt(com.my.org.erp.common.CommonFunctions.QueryExecute(sql)[0][0]);
    		 		if(day>=7)
    		 			f1 = true;
    		 		else
    		 			f1 = false;
    		 		 
    		 		
    		 	}
    		 	else
    		 	{	
    		 		f1 = true;
    		 	}
    					 	 
    		 	StringBuffer sb = new StringBuffer();
    	 		sb.append("<Details>");
 	 			if (f1)
 	 				sb.append("<Valid>True</Valid>");
 	 			else
 	 				sb.append("<Valid>False</Valid>");
 	 			
 	 			sb.append("</Details>");
 	 			 
 	 			response.setContentType("text/xml");
		 		response.setHeader("Cache-Control", "no-cache");
		 		response.getWriter().write("<Detailss>" + sb.toString() + "</Detailss>"); 
		 } 
    	 catch (Exception e) 
    	 {
    		 System.out.println(e.getMessage());
 			request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		dispatchers.forward(request, response); 
    	 } 
    }	
	
	
	public static void LoadAMCSerialNumberCustomerwise(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
    	 {
			
			String id =request.getParameter("id");
			String sql=" ";
	 		sql = " SELECT CHR_SERIALNO FROM inv_m_serviceamc "; 
			sql = sql +"  WHERE CHR_STATUS ='Y' AND   INT_CUSTOMERID= "+id;
	 		sql = sql+ " ORDER BY  CHR_SERIALNO";

	 		System.out.println("\n Load Customerwise serial numer  ");
	 		System.out.println(sql);
	 		System.out.println("\n");
	 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 		StringBuffer sb = new StringBuffer();
	 		if (readData.length > 0)
	 		{	
	 			for(int u=0; u<readData.length;u++)		 				
	 	 		{
	 	 				sb.append("<AMC>");
	 	 				sb.append("<Serial>"+readData[u][0]+"</Serial>");
	 	 				sb.append("</AMC>");
	 	 		}	
	 			response.setContentType("text/xml");
	 			response.setHeader("Cache-Control", "no-cache");		 		
	 			response.getWriter().write("<AMCs>" + sb.toString() + "</AMCs>");
	 			
	 		} 
	 		else 
	 		{
	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	 		}
    	 } 
    	 catch (Exception e) 
    	 {
    		 System.out.println(e.getMessage());
 			request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		dispatchers.forward(request, response); 
    	 }			
	}

	
	public static void LoadAMCCallAssign(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String month=request.getParameter("month");
    		 	String year=request.getParameter("year");
    		 	String servicecenter=request.getParameter("servicecenter");
    		 	String callstatus=request.getParameter("callstatus");
    		 	String StartLetter = ""+request.getParameter("StartLetter");
    		 	String branch = ""+request.getParameter("branch");
    		 	HttpSession session=request.getSession();
    		 	String usertype=""+session.getAttribute("USRTYPE");
    		 	
    		 	
    		 	String sql =" SELECT a.CHR_SERVICECALLNO, b.CHR_CUSTOMERNAME,a.CHR_SERIALNO,DATE_FORMAT(a.DT_BOOKINGDATE,'%d-%m-%Y %H:%i:%s %p'), DATE_FORMAT(a.DT_CLOSINGDATE,'%d-%m-%Y  %H:%i:%s %p'),a.CHR_BOOKINGTYPE,a.CHR_BOOKINGUNDER,a.CHR_STATUS, a.CHR_ENGGSTATUS,a.CHR_BOOKINGEMPID,a.CHR_CONTACTPERSON,a.CHR_CONTACTADDRESS,a.CHR_CONTACTMOBILE,a.CHR_CONTACTEMAIL,a.CHR_SERVICEDESC,c.CHR_CENTERNAME FROM  inv_t_servicecallbooking  a, inv_m_servicecustomerinfo b ,inv_m_servicecenter c ";
    		 	sql = sql +" WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID  AND b.INT_SERVICECENTERID = c.INT_SERVICECENTERID";
    		 	
    		 	if(!"0".equals(branch))
    		 		sql = sql +"  AND a.INT_BRANCHID = "+branch+" ";
    		 	
    		 	if(!"0".equals(callstatus))
    		 		sql = sql +"  AND a.CHR_STATUS ='"+callstatus+"'";
    		 	
    		 	if(!"0".equals(month))
    		 		sql = sql +"  AND MONTH(DT_BOOKINGDATE)= "+month;
    		 	
    		 	if(!"0".equals(year))
    		 		sql = sql +"  AND YEAR(DT_BOOKINGDATE) ="+year;
    		 	
    		 	if(!"0".equals(servicecenter))
    		 		sql = sql +"  AND b.INT_SERVICECENTERID ="+servicecenter;

    		 	if(!"0".equals(StartLetter))
    		 		sql = sql +"  AND b.CHR_CUSTOMERNAME LIKE '"+StartLetter +"%'";
    		 	System.out.println(sql);
    		 	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		 	StringBuffer sb = new StringBuffer();
		 		if (readData.length > 0)
		 		{	
		 			for(int u=0; u<readData.length;u++)
		 			{
		 	 			
		 	 				sb.append("<Booking>");
		 	 				sb.append("<Bookingid>"+readData[u][0] +"</Bookingid>");
		 	 				sb.append("<Name>"+readData[u][1].replaceAll("&" ," and ") +"</Name>");
		 	 				sb.append("<Serial>"+readData[u][2].replaceAll("&" ," and ") +"</Serial>");
		 	 				sb.append("<Bdate>"+readData[u][3].replaceAll("&" ," and ") +"</Bdate>");
		 	 				sb.append("<Cdate>"+readData[u][4].replaceAll("&" ," and ") +"</Cdate>");
		 	 				sb.append("<Btype>"+readData[u][5].replaceAll("&" ," and ") +"</Btype>");
		 	 				sb.append("<usertype>"+usertype.replaceAll("&" ," and ") +"</usertype>");
		 	 				sb.append("<Bunder>"+readData[u][6].replaceAll("&" ," and ") +"</Bunder>");
		 	 				sb.append("<CallStatus>"+readData[u][7].replaceAll("&" ," and ") +"</CallStatus>");
		 	 				sb.append("<EnggStatus>"+readData[u][8].replaceAll("&" ," and ") +"</EnggStatus>");
		 	 				sb.append("<Bookedby>"+readData[u][9].replaceAll("&" ," and ") +"</Bookedby>");
		 	 				sb.append("<Cperson>"+readData[u][10].replaceAll("&" ," and ") +"</Cperson>");
		 	 				sb.append("<Caddress>"+readData[u][11].replaceAll("&" ," and ") +"</Caddress>");
		 	 				sb.append("<Cmobile>"+readData[u][12].replaceAll("&" ," and ") +"</Cmobile>");
		 	 				sb.append("<Cmail>"+readData[u][13].replaceAll("&" ," and ") +"</Cmail>");
		 	 				sb.append("<Descriptions>"+readData[u][14].replaceAll("&" ," and ") +"</Descriptions>");
		 	 				sb.append("<ServiceCenter>"+readData[u][15].replaceAll("&" ," and ") +"</ServiceCenter>");
		 	 				sb.append("</Booking>");
		 	 			 
		 			}
		 			response.setContentType("text/xml");
		 			response.setHeader("Cache-Control", "no-cache");
		 			response.getWriter().write("<Bookings>" + sb.toString() + "</Bookings>");
		 		} 
		 		else 
		 		{
		 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		 		}			     	 	 
 	 		      	 } 
    	 catch (Exception e) 
    	 {
    		 System.out.println(e.getMessage());
 			request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		dispatchers.forward(request, response); 
    	 } 
    }	

	
	public static void INVCustomerServiceCallCreditLimit(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		
    			String callid=request.getParameter("callid");
    			String startdate=request.getParameter("startdate");
    		 	String sdate[]= startdate.split(" ");
    		 	startdate = DateUtil.FormateDateSQL(sdate[0])+" "+sdate[1];
    		 	
    		 	String enddate=request.getParameter("enddate");
    		 	String edate[]= enddate.split(" ");
    		 	enddate = DateUtil.FormateDateSQL(edate[0])+" "+edate[1];
    		 	
    		 	String bookingdate=request.getParameter("bookingdate");
    		 	String bdate[]= bookingdate.split(" ");
    		 	bookingdate = DateUtil.FormateDateSQL(bdate[0])+" "+bdate[1];
    		 	
    		 	 	
    		 	boolean f1 = false;
    		 	boolean f2 = false;
    		 	boolean f3 = false;
    		 	 
    		 	
    		 	String sql= " SELECT '"+startdate +"' >" +"'"+bookingdate+"'";
    		 	String bookdiff[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		 	if("1".equals(bookdiff[0][0]))
    		 		f1 = true;
    		 	else
    		 		f1 = false;
    		 	
    		 	
    		 	sql= " SELECT '"+enddate +"' >" +"'"+startdate+"'";
    		 	String dtdiff[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		 	if("1".equals(dtdiff[0][0]))
    		 		f2 = true;
    		 	else
    		 		f2 = false;
    		 	
    		 	sql = "SELECT DT_CLOSEDATE FROM   inv_t_servicecallbookingtrack WHERE  INT_TRACKID = ( SELECT max(INT_TRACKID) FROM   inv_t_servicecallbookingtrack WHERE CHR_SERVICECALLNO='"+callid+"' ) ";
    		 	System.out.println(sql);
    		 	String call[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		 	if(call.length>0)
    		 	{	
    		 		sql= " SELECT '"+startdate +"' >" +"'"+call[0][0]+"'";
    		 		String dbdtdiff[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		 		if("1".equals(dbdtdiff[0][0]))
    		 			f3 = true;
    		 		else
    		 			f3=false;
    		 					
    		 	}
    		 	else
    		 		f3 = true;
    		 	
    		 	
    		 	//check booking date
    		 	//check previos call close and current starting date
    		 	// check current starting date and current ending date
    		 	
    		 	 
    		 	
    		 	StringBuffer sb = new StringBuffer();
    	 		sb.append("<Details>");
 	 			if (f1 && f2&& f3)
 	 				sb.append("<Valid>True</Valid>");
 	 			else
 	 				sb.append("<Valid>False</Valid>");
 	 			sb.append("</Details>");
 	 			response.setContentType("text/xml");
		 		response.setHeader("Cache-Control", "no-cache");
		 		response.getWriter().write("<Detailss>" + sb.toString() + "</Detailss>");
		 } 
    	 catch (Exception e) 
    	 {
    		 System.out.println(e.getMessage());
 			request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		dispatchers.forward(request, response); 
			 
    	 } 
    }	
	
	public static void LoadAMCcustomerinfo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try
    	 {
			
			String serialnumber =request.getParameter("serialnumber");
			String sql = " SELECT d.CHR_SERVICEITEMNAME,b.CHR_GROUPNAME,a.CHR_CUSTOMERNAME,a.CHR_STREET,a.CHR_CITY,a.CHR_STATE,a.CHR_PHONE,a.CHR_MOBILE,a.CHR_EMAIL,a.INT_CUSTOMERID,c.CHR_CATEGORY,c.CHR_DESC , ";  
			sql = sql + "DATE_FORMAT(c.DT_STARTDATE,'%d-%b-%Y %H:%m:%s %p'),DATE_FORMAT(c.DT_ENDDATE,'%d-%b-%Y %H:%m:%s %p'),DATE_FORMAT(c.DT_ENDDATE,'%d-%m-%Y %H:%m:%s %p')   FROM inv_m_servicecustomerinfo  a ,inv_m_servicecustomergroup b,inv_m_serviceamc c,inv_m_serviceitems d  ";
			sql = sql + " WHERE a.INT_GROUPID = b.INT_GROUPID  ";
			sql = sql + " AND a.INT_CUSTOMERID=c.INT_CUSTOMERID  ";
			sql = sql + " AND c.INT_SERVICEITEMID = d.INT_SERVICEITEMID  ";
			sql = sql + " AND c.CHR_SERIALNO='"+serialnumber+"' ";
			System.out.println("\n Load Customer info  regds serial numer  ");
	 		System.out.println(sql);
	 		System.out.println("\n");
			String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 		StringBuffer sb = new StringBuffer();
	 		if (readData.length > 0)
	 		{	
	 			for(int u=0; u<readData.length;u++)		 				
	 	 		{
	 	 				sb.append("<Customer>");
	 	 				sb.append("<Type>"+readData[u][0]+"</Type>");
	 	 				sb.append("<Group>"+readData[u][1]+"</Group>");
	 	 				sb.append("<Name>"+readData[u][2]+"</Name>");
	 	 				sb.append("<Street>"+readData[u][3]+"</Street>");
	 	 				sb.append("<City>"+readData[u][4]+"</City>");
	 	 				sb.append("<State>"+readData[u][5]+"</State>");
	 	 				sb.append("<Phone>"+readData[u][6]+"</Phone>");
	 	 				sb.append("<Mobile>"+readData[u][7]+"</Mobile>");
	 	 				sb.append("<Email>"+readData[u][8]+"</Email>");
	 	 				sb.append("<Id>"+readData[u][9]+"</Id>");
	 	 				sb.append("<Category>"+readData[u][10]+"</Category>");
	 	 				sb.append("<Descs>"+readData[u][11].replaceAll("&", " and ")+"</Descs>");
	 	 				sb.append("<Start>"+readData[u][12]+"</Start>");
	 	 				sb.append("<End>"+readData[u][13]+"</End>"); 
	 	 				sb.append("<Enddate>"+readData[u][14]+"</Enddate>"); 
	 	 				sb.append("</Customer>");
	 	 				//Type,Group,Name,City,State,Phone,Mobile,Email
	 	 		}	
	 			response.setContentType("text/xml");
	 			response.setHeader("Cache-Control", "no-cache");		 		
	 			response.getWriter().write("<Customers>" + sb.toString() + "</Customers>");
	 			
	 		} 
	 		else 
	 		{
	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	 		}
    	 } 
    	 catch (Exception e) 
    	 {
    		 System.out.println(e.getMessage());
 			request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		dispatchers.forward(request, response); 
    	 }			
	}
	
}

