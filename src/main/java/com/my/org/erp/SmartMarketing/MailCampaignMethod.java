package com.my.org.erp.SmartMarketing;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

import com.my.org.erp.common.CommonFunctions;
public class MailCampaignMethod extends HttpServlet
{
	 
	private static final long serialVersionUID = 1L;

	
	public static void LoadEmailCustomerGroup(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	     try 
	    	 {
	    	 		String startLetter=request.getParameter("startLetter");
	    	 		String sql="";
	    	 		sql =" SELECT INT_GROUPID, CHR_GROUPNAME FROM email_m_customergroup WHERE INT_GROUPID >0 ";
	    	 		 
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
		 					sb.append("<Name>" +readData[u][1].replaceAll("&", " AND ").toUpperCase() + "</Name>");  
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


	public static void LoadEmailCompany(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String Group=request.getParameter("group");
    	 		String sql="";
    	 		sql ="SELECT a.INT_COMPANYID,a.CHR_COMPANYNAME ,b.CHR_GROUPNAME FROM email_m_companyname a ,email_m_customergroup b WHERE a.INT_GROUPID=b.INT_GROUPID ";
    	 		if(!"0".equals(Group))
    	 			sql = sql + " AND a.INT_GROUPID="+Group;
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND a.CHR_COMPANYNAME LIKE '"+startLetter+"%' ";
    	 		sql = sql +" ORDER BY a.CHR_COMPANYNAME";
    	 		
    	 		
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +readData[u][1].replaceAll("&", " AND ").toUpperCase() + "</Name>");  
	 					sb.append("<Group>" +readData[u][2].replaceAll("&", " AND ").toUpperCase() + "</Group>");
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


	
	public static void LoadEmailBranch(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String Group=request.getParameter("group");
    	 		String company=request.getParameter("company");
    	 		String sql="";
    	 		
    	 		
    	 		sql = " SELECT a.INT_BRANCHID,c.CHR_GROUPNAME,b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_ADDRESS1,a.CHR_CITY,a.CHR_EMAIL ";
    	 		sql = sql + " FROM  email_m_branchname a,email_m_companyname b,email_m_customergroup c ";
    	 		sql = sql + "  WHERE a.INT_COMPANYID=b.INT_COMPANYID AND b.INT_GROUPID=c.INT_GROUPID ";
    	 		
    	 		if(!"0".equals(company))
    	 			sql = sql + " AND a.INT_COMPANYID="+company;
    	 		if(!"0".equals(Group))
    	 			sql = sql + " AND c.INT_GROUPID="+Group;
    	 		
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND a.CHR_BRANCHNAME LIKE '"+startLetter+"%' ";
    	 		sql = sql +" GROUP BY a.INT_BRANCHID ORDER BY a.CHR_BRANCHNAME";
    	 		
    	 		
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Group>" +readData[u][1].replaceAll("&", " AND ").toUpperCase() + "</Group>");
	 					sb.append("<CName>" +readData[u][2].replaceAll("&", " AND ").toUpperCase() + "</CName>");  
	 					sb.append("<BName>" +readData[u][3].replaceAll("&", " AND ").toUpperCase() + "</BName>");
	 					sb.append("<Address>" +readData[u][4].replaceAll("&", " AND ").toUpperCase() + "</Address>");
	 					sb.append("<City>" +readData[u][5].replaceAll("&", " AND ").toUpperCase() + "</City>");
	 					sb.append("<Email>" +readData[u][6].replaceAll("&", " AND ").toUpperCase() + "</Email>");
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

	
	public static void LoadSelectEmailCompany(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		
    	 		String Group=request.getParameter("id");
    	 		String sql="";
    	 		sql ="SELECT INT_COMPANYID,CHR_COMPANYNAME FROM  email_m_companyname  WHERE INT_COMPANYID >=1";
    	 		if(!"0".equals(Group))
    	 			sql = sql + " AND INT_GROUPID="+Group;
    	 		sql = sql +" ORDER BY  CHR_COMPANYNAME";
    	 		
    	 		 
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +readData[u][1].replaceAll("&", " AND ").toUpperCase() + "</Name>");  
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

	public static void LoadSelectEmailBranch(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		
    	 		String company=request.getParameter("id");
    	 		String sql="";
    	 		sql ="SELECT INT_BRANCHID,CHR_BRANCHNAME FROM  email_m_branchname  WHERE INT_BRANCHID >=1";
    	 		if(!"0".equals(company))
    	 			sql = sql + " AND INT_COMPANYID="+company;
    	 		sql = sql +" ORDER BY  CHR_BRANCHNAME";
    	 		
    	 		 
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +readData[u][1].replaceAll("&", " AND ").toUpperCase() + "</Name>");  
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

	
	public static void LoadEmailCustomer(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		
    	 		String startLetter=request.getParameter("startLetter");
    	 		String group=request.getParameter("group");
    	 		String company=request.getParameter("company");
    	 		String branch=request.getParameter("branch");
    	 		String department=request.getParameter("department");
    	 		String designation=request.getParameter("designation");
    	 		String newsletter=request.getParameter("newsletter");
    	 		String active=request.getParameter("active");
    	 		String sql="";
    	 		sql ="SELECT a.INT_CUSTOMERID,b.CHR_GROUPNAME,c.CHR_COMPANYNAME,d.CHR_BRANCHNAME,d.CHR_ADDRESS1, d.INT_STDCODE,d.INT_PHONE1,d.INT_MOBILE1,d.CHR_FAX,e.CHR_DEPARTNAME,f.CHR_DESIGNAME, a.CHR_CONTACTNAME,a.CHR_EMAIL,a.CHR_FLAG,a.CHR_ACTIVE FROM  email_m_customerinfo a,email_m_customergroup b,email_m_companyname c,email_m_branchname d, email_m_depart e,email_m_desig f WHERE a.INT_GROUPID=b.INT_GROUPID AND a.INT_GROUPID=c.INT_GROUPID AND a.INT_COMPANYID=c.INT_COMPANYID AND a.INT_BRANCHID= d.INT_BRANCHID AND a.INT_DEPARTID=e.INT_DEPARTID AND a.INT_DESIGID=f.INT_DESIGID ";
    	 		
    	 		if(!"0".equals(group))
    	 			sql = sql + " AND a.INT_GROUPID="+group;
    	 		if(!"0".equals(company))
    	 			sql = sql + " AND a.INT_COMPANYID="+company;
    	 		if(!"0".equals(branch))
    	 			sql = sql + " AND a.INT_BRANCHID=="+branch;
    	 		if(!"0".equals(department))
    	 			sql = sql + " AND a.INT_DEPARTID="+department;
    	 		if(!"0".equals(designation))
    	 			sql = sql + " AND a.INT_DESIGID=="+designation;
    	 		
    	 		if(!"0".equals(newsletter))
    	 			sql = sql + " AND a.CHR_FLAG="+newsletter;
    	 		
    	 		if(!"0".equals(active))
    	 			sql = sql + " AND a.CHR_ACTIVE="+active;
    	 		
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND a.CHR_CONTACTNAME LIKE '"+startLetter+"%' ";
    	 		
    	 		sql = sql +" ORDER BY  a.CHR_CONTACTNAME";
    	 		
    	 		 
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<GroupName>" +readData[u][1].replaceAll("&", " AND ").toUpperCase() + "</GroupName>");
	 					sb.append("<CompanyName>" +readData[u][2]+ "</CompanyName>");
	 					sb.append("<BranchName>" +readData[u][3]+ "</BranchName>");
	 					sb.append("<Address>" +readData[u][4]+ "</Address>");
	 					sb.append("<STD>" +readData[u][5]+ "</STD>");
	 					sb.append("<Phone>" +readData[u][6]+ "</Phone>");
	 					sb.append("<Mobile>" +readData[u][7]+ "</Mobile>");
	 					sb.append("<Fax>" +readData[u][8]+ "</Fax>");
	 					sb.append("<Department>" +readData[u][9]+ "</Department>");
	 					sb.append("<Designation>" +readData[u][10]+ "</Designation>");
	 					sb.append("<ContactName>" +readData[u][11]+ "</ContactName>");
	 					sb.append("<Email>" +readData[u][12]+ "</Email>");
	 					sb.append("<Newletter>" +readData[u][13]+ "</Newletter>");
	 					sb.append("<Status>" +readData[u][14]+ "</Status>");
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
	
	
	

	
}