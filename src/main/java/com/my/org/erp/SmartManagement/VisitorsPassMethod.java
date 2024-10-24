 package com.my.org.erp.SmartManagement;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.my.org.erp.common.CommonFunctions;

@SuppressWarnings("serial")
public class VisitorsPassMethod extends HttpServlet
{
 	   
	  
	  public static void loadBuilding(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	  {
		  try
		  {
	  	 		String startLetter=request.getParameter("startLetter");
	  	 		 
	  	 		String sql = " SELECT INT_BUILDINGID,CHR_BUILDINGNAME,CHR_DESC ";
	  	 		sql = sql + "  FROM mgt_m_buildingname  WHERE  INT_BUILDINGID > 0 ";
	  	 		
	  	 		if(!"0".equals(startLetter))
	  	 			sql = sql +" AND   CHR_BUILDINGNAME  LIKE '"+startLetter+"%'"  ;
	  	 		sql = sql + " ORDER BY CHR_BUILDINGNAME ";
	  	 	 
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
	  
	  
	 

	  public static void loadFloor(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	  {
		  try
		  {
	  	 		String startLetter=request.getParameter("startLetter");
	  	 		 
	  	 		String sql = " SELECT INT_FLOORID,CHR_FLOOR,CHR_DESC ";
	  	 		sql = sql + "  FROM mgt_m_floor  WHERE  INT_FLOORID > 0 ";
	  	 		
	  	 		if(!"0".equals(startLetter))
	  	 			sql = sql +" AND   CHR_FLOOR  LIKE '"+startLetter+"%'"  ;
	  	 		sql = sql + " ORDER BY CHR_FLOOR ";
	  	 	 
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
	  
	  public static void loadPurpose(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	  {
		  try
		  {
	  	 		String startLetter=request.getParameter("startLetter");
	  	 		 
	  	 		String sql = " SELECT INT_PURPOSEID,CHR_PURPOSE,CHR_DESC ";
	  	 		sql = sql + "  FROM mgt_m_purpose  WHERE  INT_PURPOSEID > 0 ";
	  	 		
	  	 		if(!"0".equals(startLetter))
	  	 			sql = sql +" AND   CHR_PURPOSE  LIKE '"+startLetter+"%'"  ;
	  	 		sql = sql + " ORDER BY CHR_PURPOSE ";
	  	 	 
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
	  public static void loadVisitors(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	  {
		  try
		  {
	  	 		String startLetter=request.getParameter("startLetter");
	  	 		String building=request.getParameter("building");
	  	 		String purpose=request.getParameter("purpose");
	  	 		String type=request.getParameter("type");
	  	 		 
	  	 		
	  	 		String sql = " ";
	  	 		sql = sql +" SELECT a.INT_VISITORID,a.CHR_VISITORNO, a.CHR_VISITORNAME, ";
	  	 		sql = sql +" b.CHR_BUILDINGNAME, c.CHR_FLOOR, d.CHR_PURPOSE,  ";
	  	 		sql = sql +" a.CHR_WHOMTOMEET, DATE_FORMAT(a.DT_TIMEIN,'%d-%b-%Y %h:%i:%s %p') timein,  ";
	  	 		sql = sql +" DATE_FORMAT(a.DT_TIMEOUT,'%d-%b-%Y %h:%i:%s %p') timeout, a.INT_MOBILE,  ";
	  	 		sql = sql +" a.CHR_EMAILID, a.CHR_ENTRYBY,a.CHR_STATUS ";
	  	 		sql = sql +" FROM mgt_m_visitor a, mgt_m_buildingname b, mgt_m_floor c, mgt_m_purpose d ";
	  	 		sql = sql +" WHERE a.INT_BUILDINGID = b.INT_BUILDINGID ";
	  	 		sql = sql +" AND a.INT_FLOORID = c.INT_FLOORID ";
	  	 		sql = sql +"  AND a.INT_PURPOSEID = d.INT_PURPOSEID ";
	  	 		
	  	 		if(!"0".equals(building))
	  	 			sql = sql +" AND   a.INT_BUILDINGID = "+building  ;
	  	 		if(!"0".equals(purpose))
	  	 			sql = sql +" AND   a.INT_PURPOSEID = "+purpose  ;
	  	 		 
	  	 		if("1".equals(type))
				{	
					if (!"0".equals(startLetter))
						sql = sql + " AND a.CHR_VISITORNAME LIKE '" + startLetter.toUpperCase() + "%'";
				}
				else
				{
					sql = sql+ " AND ( (a.INT_MOBILE LIKE '%"+startLetter+"%') OR ( a.CHR_VISITORNAME LIKE '" + startLetter.toUpperCase() + "%') )";
				}
	  	 		
	  	 		
	  	 		sql = sql + " ORDER BY a.CHR_VISITORNAME ";
	  	 	 
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
	 					sb.append("<Name>" +readData[u][2] + "</Name>");
	 					sb.append("<Building>" +readData[u][3] + "</Building>");
	 					sb.append("<Floor>" +readData[u][4] + "</Floor>");
	 					sb.append("<Purpose>" +readData[u][5] + "</Purpose>");
	 					sb.append("<Whomtomeet>" +readData[u][6] + "</Whomtomeet>");
	 					sb.append("<In>" +readData[u][7] + "</In>");
	 					sb.append("<Out>" +readData[u][8] + "</Out>");
	 					sb.append("<Mobile>" +readData[u][9] + "</Mobile>");
	 					sb.append("<Email>" +readData[u][10] + "</Email>");
	 					sb.append("<Entryby>" +readData[u][11] + "</Entryby>");
	 					sb.append("<Status>" +readData[u][12] + "</Status>");
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
