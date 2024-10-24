 package com.my.org.erp.SmartManagement;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.my.org.erp.common.CommonFunctions;

@SuppressWarnings("serial")
public class PettyCashMethod extends HttpServlet
{
 	   
	  
	  public static void loadPettyCash(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	  {
		  try
		  {
	  	 		String startLetter=request.getParameter("startLetter");
	  	 		 
	  	 		String sql = " SELECT INT_CATEGORYID,UPPER(CHR_NAME),CHR_DESC  FROM mgt_m_pettycash  WHERE  INT_CATEGORYID > 0 ";
	  	 		
	  	 		if(!"0".equals(startLetter))
	  	 			sql = sql +" AND   CHR_NAME  LIKE '"+startLetter+"%'"  ;
	  	 		sql = sql + " ORDER BY CHR_NAME ";
	  	 	 
	  	 		System.out.println(sql);
	  	  		String readData[][]=  CommonFunctions.QueryExecute(sql);
	 			if(readData.length>0)
	 			{	
	 				StringBuffer sb = new StringBuffer();    	     	
	 				for(int u=0; u<readData.length;u++)
	 				{
	 					sb.append("<Row>");    	            
	 					sb.append("<Rowid>" +readData[u][0]+ "</Rowid>");
	 					sb.append("<Name>" +readData[u][1] + "</Name>");
	 					sb.append("<Description>" +readData[u][2].replaceAll("&", " AND ") + "</Description>");
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
	  
	  public static void loadDayBook(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	  {
		  try
		  {
	  	 		String startLetter=request.getParameter("startLetter");
	  	 		String branch=request.getParameter("branch");
	  	 		String day=request.getParameter("day");
	  	 		String month=request.getParameter("month");
	  	 		String year=request.getParameter("year");
	  	 		String sql = "";
		  	 	sql = " SELECT a.INT_ROWID, b.CHR_NAME, DATE_FORMAT(a.DT_DATE,'%d-%b-%Y'), ";
		  	 	sql = sql + " IF(a.CHR_TYPE = 'C' ,'CT','DT'), LEFT(a.CHR_DESC,100), ";
		  	 	sql = sql + " a.INT_CREDITAMOUNT,a.INT_DEBITAMOUNT  ";
		  	 	sql = sql + " FROM mgt_t_daybook a, mgt_m_pettycash b ";
		  	 	sql = sql + " WHERE a.INT_CATEGORYID = b.INT_CATEGORYID  ";
		  	 	if(!"0".equals(branch))
	  	 			sql = sql +" AND a.INT_BRANCHID = "+branch;
	  	 		if(!"0".equals(day))
	  	 			sql = sql +" AND DAY(a.DT_DATE) = "+day;
	  	 		if(!"0".equals(month))
	  	 			sql = sql +" AND  MONTH(a.DT_DATE) = "+month;
	  	 		if(!"0".equals(year))
	  	 			sql = sql +" AND  YEAR(a.DT_DATE) = "+year;
		  	 	if(!"0".equals(startLetter))
	  	 			sql = sql +" AND   b.CHR_NAME  LIKE '"+startLetter+"%'"  ;
	  	 		sql = sql + " ORDER BY a.DT_DATE";
	  	 		
	  	 		System.out.println(sql);
	  	  		String readData[][]=  CommonFunctions.QueryExecute(sql);
	 			if(readData.length>0)
	 			{	
	 				StringBuffer sb = new StringBuffer();    	     	
	 				for(int u=0; u<readData.length;u++)
	 				{
	 					sb.append("<Row>");    	            
	 					sb.append("<Rowid>" +readData[u][0]+ "</Rowid>");
	 					sb.append("<Name>" +readData[u][1] + "</Name>");
	 					sb.append("<EDate>" +readData[u][2] + "</EDate>");
	 					sb.append("<Type>" +readData[u][3] + "</Type>");
	 					sb.append("<Description>" +readData[u][4].replaceAll("&", " AND ") + "</Description>");
	 					sb.append("<Credit>" +readData[u][5] + "</Credit>");
	 					sb.append("<Debit>" +readData[u][6] + "</Debit>");
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
	  
	  public static void LoadPettyCashIncome(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	  {
		  try
		  {
	  	 		String startLetter=request.getParameter("startLetter");
	  	 		String branch=request.getParameter("branch");
	  	 		String day=request.getParameter("day");
	  	 		String month=request.getParameter("month");
	  	 		String year=request.getParameter("year");
	  	 		String sql = " ";
	  	 		sql = sql + " SELECT a.INT_INCOMEID,a.CHR_INCOMEREFNO,FUN_GET_BRANCH_NAME(a.INT_BRANCHID),";//FUN_GET_BRANCH_WITH_COMPANY_NAME
	  	 		sql = sql + " DATE_FORMAT(a.DAT_INCOME,'%d-%b-%Y'), a.CHR_DESC,a.DOU_AMOUNT,FIND_A_EMPLOYEE_ID_NAME_BY_USERID(a.CHR_USRNAME) ";
	  	 		sql = sql + " FROM mgt_t_pettycash_income a ";
	  	 		sql = sql + " WHERE a.INT_INCOMEID > 0 ";
	  	 		if(!"0".equals(branch))
	  	 			sql = sql +" AND a.INT_BRANCHID = "+branch;
	  	 		if(!"0".equals(day))
	  	 			sql = sql +" AND DAY(a.DAT_INCOME) = "+day;
	  	 		if(!"0".equals(month))
	  	 			sql = sql +" AND  MONTH(a.DAT_INCOME) = "+month;
	  	 		if(!"0".equals(year))
	  	 			sql = sql +" AND  YEAR(a.DAT_INCOME) = "+year;
	  	 		if(!"0".equals(startLetter))
	  	 			sql = sql +" AND   b.CHR_NAME  LIKE '"+startLetter+"%'"  ;
	  	 		sql = sql + " ORDER BY a.DAT_INCOME ";
	  	 		 
	  	 		System.out.println(sql);
	  	  		String readData[][]=  CommonFunctions.QueryExecute(sql);
	 			if(readData.length>0)
	 			{	
	 				StringBuffer sb = new StringBuffer();    	     	
	 				for(int u=0; u<readData.length;u++)
	 				{
	 					sb.append("<Row>");    	            
	 					sb.append("<Rowid>" +readData[u][0]+ "</Rowid>");
	 					sb.append("<Refno>" +readData[u][1] + "</Refno>");
	 					sb.append("<Branch>" +readData[u][2] + "</Branch>");
	 					sb.append("<IDate>" +readData[u][3] + "</IDate>");
	 					sb.append("<Description>" +readData[u][4].replaceAll("&", " AND ") + "</Description>");
	 					sb.append("<Amount>" +readData[u][5] + "</Amount>");
	 					sb.append("<Entry>" +readData[u][6] + "</Entry>");
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
	  
	  public static void LoadPettyCashExpense(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	  {
		  try
		  {
	  	 		String startLetter=request.getParameter("startLetter");
	  	 		String branch=request.getParameter("branch");
	  	 		String day=request.getParameter("day");
	  	 		String month=request.getParameter("month");
	  	 		String year=request.getParameter("year");
	  	 		String sql = " ";
	  	 		sql = sql + " SELECT a.INT_EXPENSESID,a.CHR_EXPENSEREFNO ,FUN_GET_BRANCH_NAME(a.INT_BRANCHID),";
	  	 		sql = sql + " DATE_FORMAT(a.DAT_EXPENSE,'%d-%b-%Y'),b.CHR_NAME,a.CHR_DESC,a.DOU_AMOUNT,FIND_A_EMPLOYEE_ID_NAME_BY_USERID(a.CHR_USRNAME) ";
	  	 		sql = sql + " FROM mgt_t_pettycash_expenses a, mgt_m_pettycash b ";
	  	 		sql = sql + " WHERE a.INT_CATEGORYID = b.INT_CATEGORYID ";
	  	 		if(!"0".equals(branch))
	  	 			sql = sql +" AND a.INT_BRANCHID = "+branch;
	  	 		if(!"0".equals(day))
	  	 			sql = sql +" AND DAY(a.DAT_EXPENSE) = "+day;
	  	 		if(!"0".equals(month))
	  	 			sql = sql +" AND  MONTH(a.DAT_EXPENSE) = "+month;
	  	 		if(!"0".equals(year))
	  	 			sql = sql +" AND  YEAR(a.DAT_EXPENSE) = "+year; 
	  	 		if(!"0".equals(startLetter))
	  	 			sql = sql +" AND   b.CHR_NAME  LIKE '"+startLetter+"%'"  ;
	  	 		sql = sql + " ORDER BY a.DAT_EXPENSE ";
	  	 		System.out.println(sql);
	  	  		String readData[][]=  CommonFunctions.QueryExecute(sql);
	 			if(readData.length>0)
	 			{	
	 				StringBuffer sb = new StringBuffer();    	     	
	 				for(int u=0; u<readData.length;u++)
	 				{
	 					sb.append("<Row>");    	            
	 					sb.append("<Rowid>" +readData[u][0]+ "</Rowid>");
	 					sb.append("<Refno>" +readData[u][1] + "</Refno>");
	 					sb.append("<Branch>" +readData[u][2] + "</Branch>");
	 					sb.append("<IDate>" +readData[u][3] + "</IDate>");
	 					sb.append("<Type>" +readData[u][4] + "</Type>");
	 					sb.append("<Description>" +readData[u][5].replaceAll("&", " AND ") + "</Description>");
	 					sb.append("<Amount>" +readData[u][6] + "</Amount>");
	 					sb.append("<Entry>" +readData[u][7] + "</Entry>");
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
	  
	  
	  public static void loadPettyCashSample(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	  {
		  try
		  {
	  	 		String startLetter=request.getParameter("startLetter");
	  	 		String sql = " SELECT INT_CATEGORYID,UPPER(CHR_NAME),CHR_DESC  FROM mgt_m_pettycash  WHERE  INT_CATEGORYID > 0 ";
	  	 		if(!"0".equals(startLetter))
	  	 			sql = sql +" AND   CHR_NAME  LIKE '"+startLetter+"%'"  ;
	  	 		sql = sql + " ORDER BY CHR_NAME ";
	  	 	 	System.out.println(sql);
	  	  		String readData[][]=  CommonFunctions.QueryExecute(sql);
		  	  	
	  	  		String name="<table width='100%'  class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC' >"; 
	 			if(readData.length>0)
	 			{	
	 				for(int u=0; u<readData.length;u++)
	 				{
	 					name = name + "<tr bgcolor='#fffff'>";    	            
	 					name = name + "<td>" +readData[u][0]+ "</td>";
	 					name = name + "<td>" +readData[u][1] + "</td>";
	 					name = name + "<td>" +readData[u][2].replaceAll("&", " AND ") + "</td>";
	 					name = name + "</td>";
	 				}	
	 			} 
	 			name = name + "</table>";
	  	  		response.setContentType("text/html");  
	  	  		response.setCharacterEncoding("UTF-8"); 
	  	  		response.getWriter().write(name); 
  	  		
	  	  		 
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
