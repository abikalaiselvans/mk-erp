 package com.my.org.erp.SmartManagement;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.my.org.erp.common.CommonFunctions;

@SuppressWarnings("serial")
public class ManagementMethod extends HttpServlet
{
 	  public static void loadContraStaff(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	  {
	   try 
	  	 {
	  	 		String companyId=request.getParameter("companyId");
	  	 		String departId=request.getParameter("departId");    	 		
	  	 		String desigId=request.getParameter("desigId");
	  	 		String startLetter=request.getParameter("startLetter");
	  	 		String asql="";
	  	 		String orderdata[][] =  CommonFunctions.QueryExecute("SELECT CHR_ORDERBY FROM m_institution");
	  	 		asql=" SELECT  A.INT_CONTRACTID,A.CHR_STAFFNAME,E.CHR_COMPANYNAME ,C.CHR_DEPARTNAME,D.CHR_DESIGNAME ";
	  	 		asql = asql+ " , A.CHR_P_PHONE from  com_m_contractstaff  A,";
				asql = asql+ " com_m_depart   C, com_m_desig  D,  com_m_company  E where ";
				asql = asql+ "  A.INT_DEPARTID=C.INT_DEPARTID AND A.INT_COMPANYID =  E.INT_COMPANYID AND A.INT_DESIGID=D.INT_DESIGID";
				if(!"0".equals(companyId))
					asql = asql+ " AND A.INT_COMPANYID=" +companyId;
				
				if(!"0".equals(departId))
					asql = asql+ " AND A.INT_DEPARTID=" +departId;
				
				if(!"0".equals(desigId))
					asql = asql+ " AND A.INT_DESIGID=" +desigId;
								
				if(!"0".equals(startLetter))
					asql = asql+ "  AND CHR_STAFFNAME Like'"+startLetter+"%'  ";
				
				if("N".equals(orderdata[0][0]))
					asql = asql+ " ORDER BY A.CHR_STAFFNAME ";
	  	 		else
	  	 			asql = asql+ "  ORDER BY A.INT_CONTRACTID ";
				 
				 	
			 	String readData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(asql);
	 			if(readData.length>0)
	 			{	
	 				StringBuffer sb = new StringBuffer();    	     	
	 				for(int u=0; u<readData.length;u++)
	 				{
	 					sb.append("<Staff>");    	            
	 					sb.append("<StaffId>" +readData[u][0]+ "</StaffId>");
	 					sb.append("<StaffName>" +readData[u][1] + "</StaffName>");
	 					sb.append("<Company>" +readData[u][2] + "</Company>");
	 					sb.append("<DepartName>" +readData[u][3] + "</DepartName>");
	 					sb.append("<DesigName>" +readData[u][4] + "</DesigName>");
	 					sb.append("<Mobile>" +readData[u][5] + "</Mobile>");
	 					sb.append("</Staff>");

	 				}
	 				response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<ContracStaff>"+sb.toString()+"</ContracStaff>");
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
	  
	  
	  
	  public static void loadContraStaffSearch(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	  {
	   try 
	  	 {
	  	 		String search=request.getParameter("search");
	  	 		System.out.println("....search...."+search);
	  	 		String sql="SELECT CHR_ORDERBY FROM m_institution";
	  	 		String orderdata[][] = CommonFunctions.QueryExecute(sql);
	  	 		sql =" SELECT  A.INT_CONTRACTID,A.CHR_STAFFNAME,E.CHR_COMPANYNAME ,C.CHR_DEPARTNAME,D.CHR_DESIGNAME";  
	  	 		sql = sql + " , A.CHR_P_PHONE from  com_m_contractstaff A,com_m_depart C,com_m_desig D,com_m_company E where "; 
	  	 		sql = sql + "  A.INT_DEPARTID=C.INT_DEPARTID AND A.INT_COMPANYID =  E.INT_COMPANYID AND A.INT_DESIGID=D.INT_DESIGID ";
	  	 		sql = sql + " AND( (A.CHR_STAFFNAME LIKE '%"+search.trim()+"%' ) OR (A.INT_CONTRACTID LIKE '%"+search.trim()+"%' )  )";
	  	 		
	  	 		if("N".equals(orderdata[0][0]))
	  	 			sql = sql+" ORDER BY A.CHR_STAFFNAME ";
	  	 		else
	  	 			sql = sql+" ORDER BY A.INT_CONTRACTID ";
	  	 		 
	  	 		System.out.println(sql);
			  	
	  	 		String readData[][]=  CommonFunctions.QueryExecute(sql);
		 			if(readData.length>0)
		 			{	
		 				StringBuffer sb = new StringBuffer();    	     	
		 				for(int u=0; u<readData.length;u++)
		 				{
		 					sb.append("<Staff>");    	            
		 					sb.append("<StaffId>" +readData[u][0]+ "</StaffId>");
		 					//String rs = readData[u][1].toUpperCase();
		 					sb.append("<StaffName>" +readData[u][1] + "</StaffName>");
		 					sb.append("<Company>" +readData[u][2] + "</Company>");
		 					sb.append("<DepartName>" +readData[u][3] + "</DepartName>");
		 					sb.append("<DesigName>" +readData[u][4] + "</DesigName>");
		 					sb.append("<Mobile>" +readData[u][5] + "</Mobile>");
		 					sb.append("</Staff>");
		 					System.out.println(readData[u][0]+""+readData[u][1]+""+readData[u][2]+""+readData[u][3]+""+readData[u][4]+""+readData[u][5]);
		 				}	
		 				response.setContentType("text/xml");
		 				response.setHeader("Cache-Control", "no-cache");
		 				response.getWriter().write("<ContracStaffsearch>"+sb.toString()+"</ContracStaffsearch>");
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
	  
	  
	  public static void loadComplaints(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	  {
		  try
		  {
	  	 		String startLetter=request.getParameter("startLetter");
	  	 		String status=request.getParameter("status");
	  	 		String day=request.getParameter("day");
	  	 		String month=request.getParameter("month");
	  	 		String year=request.getParameter("year");
	  	 		String priority=request.getParameter("priority");
	  	 		
	  	 		String sql = " SELECT INT_COMPLAINTID,FUN_GET_BRANCH(INT_BRANCHID),CHR_COMPLAINTNO,CHR_SUBJECT, ";
	  	 		sql = sql + " DATE_FORMAT(DAT_CREATION,'%d-%b-%Y  %r'),INT_PRIORITY, ";
	  	 		sql = sql + " CHR_STATUS,CHR_CANCEL,FIND_A_EMPLOYEE_ID_NAME_BY_USERID(CHR_SOLVEDBY) FROM mgt_t_complaints  WHERE  INT_COMPLAINTID > 0 ";
	  	 		if(!"0".equals(day))
	  	 			sql = sql +" AND DAY(DAT_CREATION) = " +day;
	  	 		if(!"0".equals(month))
	  	 			sql = sql +" AND MONTH(DAT_CREATION) = " +month;
	  	 		if(!"0".equals(year))
	  	 			sql = sql +" AND YEAR(DAT_CREATION) = " +year;
	  	 		if(!"0".equals(status))
	  	 			sql = sql +" AND   CHR_STATUS = '"+status+"'"  ;
	  	 		if(!"0".equals(priority))
	  	 			sql = sql +" AND INT_PRIORITY = " +priority;
	  	 		
	  	 		if(!"0".equals(startLetter))
	  	 			sql = sql +" AND   CHR_SUBJECT  LIKE '"+startLetter+"'%"  ;
	  	 		sql = sql + " ORDER BY DAT_CREATION ";
	  	 	 
	  	 		System.out.println(sql);
	  	  		String readData[][]=  CommonFunctions.QueryExecute(sql);
	 			if(readData.length>0)
	 			{	
	 				StringBuffer sb = new StringBuffer();    	     	
	 				for(int u=0; u<readData.length;u++)
	 				{
	 					sb.append("<Row>");    	            
	 					sb.append("<Rowid>" +readData[u][0]+ "</Rowid>");
	 					sb.append("<Branch>" +readData[u][1] + "</Branch>");
	 					sb.append("<Complaint>" +readData[u][2] + "</Complaint>");
	 					sb.append("<Subject>" +readData[u][3] + "</Subject>");
	 					sb.append("<Cdate>" +readData[u][4] + "</Cdate>");
	 					sb.append("<Priority>" +readData[u][5] + "</Priority>");
	 					sb.append("<Status>" +readData[u][6] + "</Status>");
	 					sb.append("<Cancel>" +readData[u][7] + "</Cancel>");
	 					sb.append("<Solved>" +readData[u][8] + "</Solved>");
	 					sb.append("</Row>");
	 					
	 				}	
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
	  
	  
	  public static void loadComplaintsResponse(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	  {
		  try
		  {
	  	 		String startLetter=request.getParameter("startLetter");
	  	 		String status=request.getParameter("status");
	  	 		String day=request.getParameter("day");
	  	 		String month=request.getParameter("month");
	  	 		String year=request.getParameter("year");
	  	 		String priority=request.getParameter("priority");
	  	 		
	  	 		String sql = " SELECT INT_COMPLAINTID,FUN_GET_BRANCH(INT_BRANCHID),CHR_COMPLAINTNO,CHR_SUBJECT, ";
	  	 		sql = sql + " DATE_FORMAT(DAT_CREATION,'%d-%b-%Y  %r'),INT_PRIORITY, ";
	  	 		sql = sql + " CHR_STATUS,CHR_CANCEL,FIND_A_EMPLOYEE_ID_NAME_BY_USERID(CHR_SOLVEDBY) FROM mgt_t_complaints  WHERE  INT_COMPLAINTID > 0 ";
	  	 		if(!"0".equals(day))
	  	 			sql = sql +" AND DAY(DAT_CREATION) = " +day;
	  	 		if(!"0".equals(month))
	  	 			sql = sql +" AND MONTH(DAT_CREATION) = " +month;
	  	 		if(!"0".equals(year))
	  	 			sql = sql +" AND YEAR(DAT_CREATION) = " +year;
	  	 		if(!"0".equals(status))
	  	 			sql = sql +" AND   CHR_STATUS = '"+status+"'"  ;
	  	 		if(!"0".equals(priority))
	  	 			sql = sql +" AND INT_PRIORITY = " +priority;
	  	 		
	  	 		if(!"0".equals(startLetter))
	  	 			sql = sql +" AND   CHR_SUBJECT  LIKE '"+startLetter+"'%"  ;
	  	 		sql = sql + " ORDER BY DAT_CREATION ";
	  	 	 
	  	 		System.out.println(sql);
	  	  		String readData[][]=  CommonFunctions.QueryExecute(sql);
	 			if(readData.length>0)
	 			{	
	 				StringBuffer sb = new StringBuffer();    	     	
	 				for(int u=0; u<readData.length;u++)
	 				{
	 					sb.append("<Row>");    	            
	 					sb.append("<Rowid>" +readData[u][0]+ "</Rowid>");
	 					sb.append("<Branch>" +readData[u][1] + "</Branch>");
	 					sb.append("<Complaint>" +readData[u][2] + "</Complaint>");
	 					sb.append("<Subject>" +readData[u][3] + "</Subject>");
	 					sb.append("<Cdate>" +readData[u][4] + "</Cdate>");
	 					sb.append("<Priority>" +readData[u][5] + "</Priority>");
	 					sb.append("<Status>" +readData[u][6] + "</Status>");
	 					sb.append("<Cancel>" +readData[u][7] + "</Cancel>");
	 					sb.append("<Solved>" +readData[u][8] + "</Solved>");
	 					
	 					sb.append("</Row>");
	 					
	 				}	
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
