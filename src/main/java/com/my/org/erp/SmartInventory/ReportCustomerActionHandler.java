package com.my.org.erp.SmartInventory;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.DateUtil;

@SuppressWarnings("serial")
public class ReportCustomerActionHandler extends HttpServlet
{
	 public static void loadQuotation(HttpServletRequest request, HttpServletResponse  response)
	    throws IOException, ServletException 
	    {
	    	 try
	    	 {		//System.out.println("hihi you r in Report");
	    		 	String month=request.getParameter("month");
			 		int year=Integer.parseInt(request.getParameter("year"));
			 		int mon=Integer.parseInt(month);
			 		String fDate=year+"-"+month+"-01";
			 		String tDate=year+"-"+month+"-"+com.my.org.erp.ServiceLogin.DateUtil.totalDays(mon, year);
			 		 		
			 		String sql=" SELECT a.INT_QUOTATIONID,a.CHR_QUOTATIONNO,b.CHR_CUSTOMERNAME,a.DAT_QUOTATIONDATE,";
			 		sql = sql +" a.DAT_REQUESTDATE , a.INT_ONHOLD,a.INT_CONDITIONID,a.CHR_DES,a.DOU_TOTALAMOUNT,a.INT_QUOTATIONSTATUS"; 
			 		sql = sql +" FROM  inv_t_customerquotation  a ,inv_m_customerinfo b";
			 		sql = sql +" where a.DAT_QUOTATIONDATE>='"+fDate+"' ";
			 		sql = sql +" AND a.DAT_QUOTATIONDATE<='"+tDate+"'  ";
			 		sql = sql +" AND a.INT_CUSTOMERID =b.INT_CUSTOMERID";
			 		sql = sql +" order by a.DAT_QUOTATIONDATE";
			 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			 		StringBuffer sb = new StringBuffer();
			 		String StartLetter = ""+request.getParameter("id");
			 		if(readData.length>0)
			 		{	
			 			for(int u=0; u<readData.length;u++)
			 			{
			 				if(readData[u][1].toUpperCase().startsWith(StartLetter) || "0".startsWith(StartLetter))
			 				{
			 					sb.append("<quotation>");
			 				    sb.append("<id>" + readData[u][0]+ "</id>");
			 	                sb.append("<quotationNo>" + readData[u][1]+ "</quotationNo>");
			 	                if(!readData[u][3].equals("-"))
			 	                	sb.append("<quotationDate>" + DateUtil.FormateDateSys(readData[u][3])+ "</quotationDate>");
			 	                else
			 	                	sb.append("<quotationDate>" + readData[u][3]+ "</quotationDate>");
			 	                
			 	                sb.append("<customerName>" + readData[u][2]+ "</customerName>");
			 	               
			 	                if(!readData[u][4].equals("-"))
			 	                	sb.append("<reqDate>" + DateUtil.FormateDateSys(readData[u][4])+ "</reqDate>");
			 	                else
			 	                	sb.append("<reqDate>" + readData[u][4]+ "</reqDate>");
			 	                sb.append("<onHold>" + readData[u][5]+ "</onHold>");
			 	                sb.append("<quotationStatus>" + readData[u][9] + "</quotationStatus>");
			 	                sb.append("<credit>" + readData[u][7]+ "</credit>");
			 	                sb.append("<totalAmount>" +readData[u][8]+ "</totalAmount>");                
			 	                sb.append("</quotation>");	
	 		 				}	
			 			}
			 			 
			 			response.setContentType("text/xml");
			 			response.setHeader("Cache-Control", "no-cache");		 			
			 			response.getWriter().write("<quotations>" + sb.toString() + "</quotations>");
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