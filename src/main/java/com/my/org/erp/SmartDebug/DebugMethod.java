package com.my.org.erp.SmartDebug;
import java.io.IOException;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
public class DebugMethod extends HttpServlet
{ 
	 
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public static void Ticket(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		HttpSession session=request.getSession();
    		String admin =""+session.getAttribute("USRTYPE");
    		String userid =""+session.getAttribute("USRID");
     		String pack  = request.getParameter("package");
    		String Status = request.getParameter("Status");
    		String month = request.getParameter("month");
    		String year = request.getParameter("year");
    		String startLetter=request.getParameter("startLetter");
    		System.out.println(startLetter);
    		String sql = " SELECT a.INT_TICKETID,b.CHR_EMPID,(SELECT CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID=b.CHR_EMPID) ";
    		sql = sql +"	,a.DAT_PDATE,a.CHR_PROBLEM,a.CHR_STATUS,c.CHR_MODULE "; 
    		sql = sql+"	from com_m_ticket a , m_user b ,m_projectmodule c ";
    		sql = sql+"	WHERE b.CHR_USRNAME = a.CHR_FROMUSER  AND a.CHR_PACKAGE=c.CHR_SHORTNAME";
    		if(!"0".equals(pack))
    			sql = sql+"	AND a.CHR_PACKAGE ='"+pack+"'";
    		if(!"0".equals(month))
    			sql = sql+"	AND month(a.DAT_PDATE) = "+month+" ";
    		if(!"F".equals(admin))
    			sql = sql+"	AND a.CHR_FROMUSER='"+userid+"'";
    		if(!"0".equals(Status))
    			sql = sql+"	AND a.CHR_STATUS='"+Status+"'  ";
    		sql = sql+"	AND year(a.DAT_PDATE) = "+year;
    		if(!"0".equals(startLetter))
 	 			sql = sql + " AND a.CHR_PACKAGE LIKE '"+startLetter+"%' ";
    		System.out.println(sql);
    		String readData[][]=  CommonFunctions.QueryExecute(sql);
 			if(readData.length>0)
 			{	
 				StringBuffer sb = new StringBuffer();    	     	
 				for(int u=0; u<readData.length;u++)
 				{
 					sb.append("<Ticket>");    	            
 					sb.append("<Ticketid>" +readData[u][0]+ "</Ticketid>");//+" / " +readData[u][1]
 					sb.append("<Name>" +readData[u][2]+ "</Name>");
 					sb.append("<Date>" +DateUtil.FormateDateSys(readData[u][3]) + "</Date>");
 					sb.append("<Problem>" +(readData[u][4].toString().replaceAll("&", "9865043008 ")) + "</Problem>");
 					sb.append("<Status>" +readData[u][5] + "</Status>");
 					sb.append("<Packages>" +readData[u][6] + "</Packages>");
 					if("F".equals(admin))
 						sb.append("<Link>TRUE</Link>");
 					else
 						sb.append("<Link>FALSE</Link>");
 					sb.append("</Ticket>");
 				}
 				 
 				response.setContentType("text/xml");
 				response.setHeader("Cache-Control", "no-cache");
 				response.getWriter().write("<Tickets>"+sb.toString()+"</Tickets>");
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
