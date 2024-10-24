package com.my.org.erp.SmartTransport;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import com.my.org.erp.common.CommonFunctions;

public class TransactionMethod extends HttpServlet
{
	private static final long serialVersionUID = 7348552898549086356L;
	
	
	public static void LoadFuelType(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String sql="";
    	 		sql =" SELECT INT_FUELTYPEID,CHR_FUELTYPENAME FROM veh_m_fueltype WHERE  INT_FUELTYPEID>=1 ";
    	 	 	if(!"0".equals(startLetter))
    	 			sql = sql + " AND CHR_FUELTYPENAME LIKE '"+startLetter+"%' ";
    	 		sql = sql +" ORDER BY CHR_FUELTYPENAME ";
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +(readData[u][1].toUpperCase()).replaceAll("&", " AND ") + "</Name>");
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


	
	
	
	
public static void LoadVehicleType(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
{
   	 try
   	 {
	 		String startLetter=request.getParameter("startLetter");
	 		String sql="";
	 		sql =" SELECT INT_VEHICLETYPEID,CHR_VEHICLETYPENAME FROM veh_m_vehicletype WHERE  INT_VEHICLETYPEID>=1 ";
	 	 	if(!"0".equals(startLetter))
	 			sql = sql + " AND CHR_VEHICLETYPENAME LIKE '"+startLetter+"%' ";
	 		sql = sql +" ORDER BY CHR_VEHICLETYPENAME ";
	 		String readData[][] = CommonFunctions.QueryExecute(sql);
			if(readData.length>0)
	 		{	
	 			StringBuffer sb = new StringBuffer();
	 			for(int u=0; u<readData.length;u++)
	 			{
 					sb.append("<Row>");    	            
 					sb.append("<Id>" +readData[u][0]+ "</Id>");
 					sb.append("<Name>" +(readData[u][1].toUpperCase()).replaceAll("&", " AND ") + "</Name>");
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
		
	







	public static void LoadMake(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
	{
    	 try
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String typeid=request.getParameter("typeid");
    	 		String sql="";
    	 		sql =" SELECT a.INT_MAKEID,a.CHR_MAKENAME,b.CHR_VEHICLETYPENAME FROM veh_m_make a , veh_m_vehicletype b WHERE a.INT_VEHICLETYPEID=b.INT_VEHICLETYPEID ";
    	 		if(!"0".equals(typeid))
    	 			sql = sql + " AND a.INT_VEHICLETYPEID= "+typeid;
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND a.CHR_MAKENAME LIKE '"+startLetter+"%' ";
    	 		sql = sql +" ORDER BY a.CHR_MAKENAME ";
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +(readData[u][1].toUpperCase()).replaceAll("&", " AND ") + "</Name>");
	 					sb.append("<Type>" +(readData[u][2].toUpperCase()).replaceAll("&", " AND ") + "</Type>");
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
	
	
	
	
	
	
	public static void LoadModel(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String typeid=request.getParameter("typeid");
    	 		String sql="";
    	 		sql =" SELECT a.INT_MODELID,a.CHR_MODELNAME,b.CHR_MAKENAME FROM veh_m_model a , veh_m_make b WHERE a.INT_MAKEID=b.INT_MAKEID  ";
    	 		if(!"0".equals(typeid))
    	 			sql = sql + " AND a.INT_MAKEID= "+typeid;
    	 		if(!"0".equals(startLetter))
    	 			sql = sql + " AND a.CHR_MODELNAME LIKE '"+startLetter+"%' ";
    	 		sql = sql +" ORDER BY a.CHR_MODELNAME ";
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +(readData[u][1].toUpperCase()).replaceAll("&", " AND ") + "</Name>");
	 					sb.append("<Type>" +(readData[u][2].toUpperCase()).replaceAll("&", " AND ") + "</Type>");
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
	
	
	
	
	
	
	public static void LoadSelectMake(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    	 		String vehicletype=request.getParameter("vehicletype");
    	 		String sql="";
    	 		sql =" SELECT a.INT_MAKEID,a.CHR_MAKENAME,b.CHR_VEHICLETYPENAME FROM veh_m_make a , veh_m_vehicletype b WHERE a.INT_VEHICLETYPEID=b.INT_VEHICLETYPEID ";
    	 		if(!"0".equals(vehicletype))
    	 			sql = sql + " AND a.INT_MAKEID= "+vehicletype;
    	 		sql = sql +" ORDER BY a.CHR_MAKENAME ";
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +(readData[u][1].toUpperCase()).replaceAll("&", " AND ") + "</Name>");
	 					sb.append("<Type>" +(readData[u][2].toUpperCase()).replaceAll("&", " AND ") + "</Type>");
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
	
	
	
	
	
	
	public static void LoadSelectModel(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    	 		String vehiclemake=request.getParameter("vehiclemake");
    	 		String sql="";
    	 		sql =" SELECT a.INT_MODELID,a.CHR_MODELNAME  FROM veh_m_model a   WHERE a.INT_MODELID >= 1  ";
    	 		if(!"0".equals(vehiclemake))
    	 			sql = sql + " AND a.INT_MAKEID= "+vehiclemake;
    	 		sql = sql +" ORDER BY a.CHR_MODELNAME ";
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +(readData[u][1].toUpperCase()).replaceAll("&", " AND ") + "</Name>");
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
	
	
	
	
	
	
	
	 
	
	
	
	
	
	
	public static void LoadSelectState(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    	 		String country=request.getParameter("country");
    	 		String sql="";
    	 		sql ="  SELECT INT_STATEID,CHR_STATENAME FROM  com_m_state WHERE INT_STATEID>=1 ";
    	 		if(!"0".equals(country))
    	 			sql = sql + " AND INT_COUNTRYID = "+country;
    	 		sql = sql +" ORDER BY CHR_STATENAME ";
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +(readData[u][1].toUpperCase()).replaceAll("&", " AND ") + "</Name>");
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	public static void LoadSelectDistrict(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    	 		String country=request.getParameter("country");
    	 		String state=request.getParameter("state");
    	 		String sql="";
    	 		sql ="  SELECT INT_DISTRICTID ,CHR_DISTRICT  FROM com_m_district WHERE INT_DISTRICTID>=1 ";
    	 		if(!"0".equals(country))
    	 			sql = sql + " AND INT_COUNTRYID = "+country;
    	 		if(!"0".equals(state))
    	 			sql = sql + " AND INT_STATEID = "+state;
    	 		sql = sql +" ORDER BY CHR_DISTRICT ";
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +(readData[u][1].toUpperCase()).replaceAll("&", " AND ") + "</Name>");
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
	
	
	 
	public static void LoadVarriant(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    		 
    		 	String startLetter=request.getParameter("startLetter");	
    		 	String typeid=request.getParameter("typeid");
    	 		String makeid=request.getParameter("makeid");
    	 		String modelid=request.getParameter("modelid");
    	 		String sql="";
       	 		sql =" SELECT a.INT_VARRIANTID ,d.CHR_VEHICLETYPENAME,c.CHR_MAKENAME,b.CHR_MODELNAME,a.CHR_VARRIANTNAME FROM veh_m_varriant a,veh_m_model b,veh_m_make c,veh_m_vehicletype d WHERE a.INT_MODELID= b.INT_MODELID AND b.INT_MAKEID = c.INT_MAKEID AND c.INT_VEHICLETYPEID = d.INT_VEHICLETYPEID  ";
    	 		if(!"0".equals(typeid))
    	 			sql = sql + " AND d.INT_VEHICLETYPEID= "+typeid;
    	 		if(!"0".equals(makeid))
    	 			sql = sql + " AND c.INT_MAKEID= "+makeid;
    	 		if(!"0".equals(modelid))
    	 			sql = sql + " AND b.INT_MODELID= "+modelid;
    	 		if(!"0".equals(startLetter))
     	 			sql = sql + " AND a.CHR_VARRIANTNAME LIKE '"+startLetter+"%' ";
     	 		sql = sql +" ORDER BY a.CHR_VARRIANTNAME ";
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Type>" +(readData[u][1].toUpperCase()).replaceAll("&", " AND ") + "</Type>");
	 					sb.append("<Make>" +(readData[u][2].toUpperCase()).replaceAll("&", " AND ") + "</Make>");
	 					sb.append("<Model>" +(readData[u][3].toUpperCase()).replaceAll("&", " AND ") + "</Model>");
	 					sb.append("<Varriant>" +(readData[u][4].toUpperCase()).replaceAll("&", " AND ") + "</Varriant>");
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
	
	
	
	
	
	public static void LoadAccessories(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    	 		String startLetter=request.getParameter("startLetter");
    	 		String sql="";
    	 		sql =" SELECT INT_ACCESSORIESID,CHR_ACCESSORIESNAME FROM veh_m_accessories WHERE  INT_ACCESSORIESID>=1 ";
    	 	 	if(!"0".equals(startLetter))
    	 			sql = sql + " AND CHR_ACCESSORIESNAME LIKE '"+startLetter+"%' ";
    	 		sql = sql +" ORDER BY CHR_ACCESSORIESNAME ";
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +(readData[u][1].toUpperCase()).replaceAll("&", " AND ") + "</Name>");
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
	
	
	
	
	
	public static void LoadAccessoriesinfo(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    		String startLetter = request.getParameter("startLetter");
    		String state = request.getParameter("state");
    		String country = request.getParameter("country");
    		String district = request.getParameter("district");
    		String city = request.getParameter("city");
    		String branch = request.getParameter("branch");
    		String accessories = request.getParameter("accessories");
    		
    		String sql = "";
 	 		sql ="SELECT a.INT_ACCESSORIESINFOID, a.CHR_COMPANYNAME,b.CHR_COUNTRYNAME,c.CHR_STATENAME," +
 	 				"d.CHR_BRANCHNAME,a.CHR_EMAIL,a.INT_ACTIVE,a.CHR_ACCESSORIESID,a.CHR_LEGALNAME," +
 	 				"a.CHR_STREET,a.CHR_POSTAL,a.CHR_AREACODE,a.CHR_PHONE, " +
 	 				"a.CHR_FAX,a.CHR_WEBSITE,a.CHR_TNGSTNO,a.CHR_CSTNO,a.CHR_REGNO,a.CHR_TINNO, " +
 	 				"a.CHR_LOCALTAXNO,f.CHR_DISTRICT,g.CHR_CITYNAME  FROM veh_m_accessoriesinfo a,com_m_country b,com_m_state c," +
 	 				"com_m_branch d ,com_m_district f,com_m_city g 	" +
 	 				"WHERE a.INT_COUNTRYID=b.INT_COUNTRYID " +
 	 				" AND a.INT_STATEID= c.INT_STATEID  AND a.INT_DISTRICTID = f.INT_DISTRICTID " +
 	 				" AND a.INT_CITYID = g.INT_CITYID AND a.INT_BRANCHID = d.INT_BRANCHID " +
 	 				" ";
 	 		if(!"0".equals(country))
 	 			sql = sql + " AND a.INT_COUNTRYID=  "+country;
 	 		if(!"0".equals(state))
 	 			sql = sql + " AND a.INT_STATEID=  "+state;
 	 		if(!"0".equals(district))
 	 			sql = sql + " AND a.INT_DISTRICTID=  "+district;
 	 		if(!"0".equals(city))
 	 			sql = sql + " AND a.INT_CITYID=  "+city;
 	 		if(!"0".equals(branch))
 	 			sql = sql + " AND a.INT_BRANCHID=  "+branch;
 	 		if(!"0".equals(accessories))
 	 			sql = sql + " AND  a.CHR_ACCESSORIESID IN("+accessories+" ) ";
 	 		if(!"0".equals(startLetter))
 	 			sql = sql + " AND a.CHR_COMPANYNAME LIKE '"+startLetter+"%' ";
 	 		sql = sql +" ORDER BY a.CHR_COMPANYNAME ";
 	 		String readData[][] = CommonFunctions.QueryExecute(sql);
 	 		if(readData.length>0)
 	 		{	
 	 			StringBuffer sb = new StringBuffer();
 	 			for(int u=0; u<readData.length;u++)
 	 			{
 					sb.append("<Row>");    	            
 					sb.append("<Id>" +readData[u][0]+ "</Id>");
 					sb.append("<Name>" +(readData[u][1].toUpperCase()).replaceAll("&", " AND ") + "</Name>");
 					sb.append("<Country>" +(readData[u][2].toUpperCase()).replaceAll("&", " AND ") + "</Country>");
 					sb.append("<State>" +(readData[u][3].toUpperCase()).replaceAll("&", " AND ") + "</State>");
 					sb.append("<Branch>" +(readData[u][4].toUpperCase()).replaceAll("&", " AND ") + "</Branch>");
 					sb.append("<Email>" +(readData[u][5].toUpperCase()).replaceAll("&", " AND ") + "</Email>");
 					sb.append("<Active>" +(readData[u][6].toUpperCase()).replaceAll("&", " AND ") + "</Active>");
 					sb.append("<District>" +(readData[u][20].toUpperCase()).replaceAll("&", " AND ") + "</District>");
 					sb.append("<City>" +(readData[u][21].toUpperCase()).replaceAll("&", " AND ") + "</City>");
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
	
	

	public static void LoadSelectHomeMake(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    	 		String typeid=request.getParameter("vehicletype");
    	 		String sql="";
    	 		sql =" SELECT a.INT_MAKEID,a.CHR_MAKENAME,b.CHR_VEHICLETYPENAME FROM veh_m_make a , veh_m_vehicletype b WHERE a.INT_VEHICLETYPEID=b.INT_VEHICLETYPEID ";
    	 		if(!"0".equals(typeid))
    	 			sql = sql + " AND a.INT_VEHICLETYPEID= "+typeid;
    	 		sql = sql +" ORDER BY a.CHR_MAKENAME ";
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +(readData[u][1].toUpperCase()).replaceAll("&", " AND ") + "</Name>");
	 					sb.append("<Type>" +(readData[u][2].toUpperCase()).replaceAll("&", " AND ") + "</Type>");
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
	

	public static void LoadSelectHomeModel(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    	 		String vehiclemake=request.getParameter("vehiclemake");
    	 		String sql="";
    	 		sql =" SELECT a.INT_MODELID,a.CHR_MODELNAME,b.CHR_MAKENAME FROM veh_m_model a , veh_m_make b WHERE a.INT_MAKEID=b.INT_MAKEID  ";
    	 		if(!"0".equals(vehiclemake))
    	 			sql = sql + " AND a.INT_MAKEID= "+vehiclemake;
    	 		sql = sql +" ORDER BY a.CHR_MODELNAME ";
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +(readData[u][1].toUpperCase()).replaceAll("&", " AND ") + "</Name>");
	 					sb.append("<Type>" +(readData[u][2].toUpperCase()).replaceAll("&", " AND ") + "</Type>");
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
	
	
	
	
	
	
	
	
	
	
	public static void LoadSelectHomeVarriant(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String typeid=request.getParameter("vehicletype");
    	 		String makeid=request.getParameter("vehiclemake");
    	 		String modelid=request.getParameter("vehiclemodel");
    	 		String sql="";
    	 		sql =" SELECT a.INT_VARRIANTID ,a.CHR_VARRIANTNAME FROM veh_m_varriant a,veh_m_model b,veh_m_make c,veh_m_vehicletype d WHERE a.INT_MODELID= b.INT_MODELID AND b.INT_MAKEID = c.INT_MAKEID AND c.INT_VEHICLETYPEID = d.INT_VEHICLETYPEID  ";
    	 		if(!"0".equals(typeid))
    	 			sql = sql + " AND d.INT_VEHICLETYPEID= "+typeid;
    	 		if(!"0".equals(makeid))
    	 			sql = sql + " AND c.INT_MAKEID= "+makeid;
    	 		if(!"0".equals(modelid))
    	 			sql = sql + " AND b.INT_MODELID= "+modelid;
    	 		sql = sql +" ORDER BY a.CHR_VARRIANTNAME ";
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Name>" +(readData[u][1].toUpperCase()).replaceAll("&", " AND ") + "</Name>");
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
	

	public static void LoadVechicleInfo(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String typeid=request.getParameter("typeid");
    	 		String makeid=request.getParameter("makeid");
    	 		String modelid=request.getParameter("modelid");
    	 		String varriant=request.getParameter("varriant");
    	 		String sql="";
    	 		sql =" ";
    	 		sql = " SELECT e.INT_ID,e.CHR_VEHICLEREGNO, d.CHR_VEHICLETYPENAME,c.CHR_MAKENAME,b.CHR_MODELNAME, ";
    	 		sql = sql + " a.CHR_VARRIANTNAME ,f.CHR_FUELTYPENAME,g.CHR_COLORNAME ";
    	 		sql = sql + " FROM veh_m_varriant a,veh_m_model b,veh_m_make c,veh_m_vehicletype d ,veh_m_vehicleinfo e, ";
    	 		sql = sql + " veh_m_fueltype f,com_m_color g ";
    	 		sql = sql + " WHERE a.INT_MODELID= b.INT_MODELID  ";
    	 		sql = sql + " AND b.INT_MAKEID = c.INT_MAKEID  ";
    	 		sql = sql + " AND c.INT_VEHICLETYPEID = d.INT_VEHICLETYPEID  ";
    	 		sql = sql + " AND e.INT_VEHICLETYPEID=d.INT_VEHICLETYPEID ";
    	 		sql = sql + " AND e.INT_MAKEID=c.INT_MAKEID ";
    	 		sql = sql + " AND e.INT_MODELID=b.INT_MODELID ";
    	 		sql = sql + " AND e.INT_VARRIANTID=a.INT_VARRIANTID ";
    	 		sql = sql + " AND e.INT_FUELTYPEID = f.INT_FUELTYPEID ";
    	 		sql = sql + " AND e.INT_COLORID = g.INT_COLORID ";
    	 		if(!"0".equals(typeid))
    	 			sql = sql + " AND e.INT_VEHICLETYPEID= "+typeid;
    	 		if(!"0".equals(makeid))
    	 			sql = sql + " AND e.INT_MAKEID= "+makeid;
    	 		if(!"0".equals(modelid))
    	 			sql = sql + " AND e.INT_MODELID= "+modelid;
    	 		if(!"0".equals(varriant))
    	 			sql = sql + " AND e.INT_VARRIANTID= "+varriant;
    	 		
    	 		sql = sql +" ORDER BY a.CHR_VARRIANTNAME ";
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Regno>" +readData[u][1] + "</Regno>");
	 					sb.append("<Vehicletype>" +readData[u][2]  + "</Vehicletype>");
	 					sb.append("<Make>" +readData[u][3]  + "</Make>");
	 					sb.append("<Model>" +readData[u][4] + "</Model>");
	 					sb.append("<Varriant>" +readData[u][5]  + "</Varriant>");
	 					sb.append("<Fuel>" +readData[u][6]  + "</Fuel>");
	 					sb.append("<Color>" +readData[u][7]  + "</Color>");
	 					
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
	
	
	public static void LoadDriverAssign(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String typeid=request.getParameter("typeid");
    	 		String makeid=request.getParameter("makeid");
    	 		String modelid=request.getParameter("modelid");
    	 		String varriant=request.getParameter("varriant");
    	 		String sql="";
    	 		sql =" ";
    	 		sql = " SELECT h.INT_DRIVERASSIGNID,e.CHR_VEHICLEREGNO, d.CHR_VEHICLETYPENAME,c.CHR_MAKENAME,b.CHR_MODELNAME,  ";
	 			sql = sql + " a.CHR_VARRIANTNAME ,f.CHR_FUELTYPENAME,g.CHR_COLORNAME,h.CHR_EMPID,i.CHR_STAFFNAME, h.CHR_FLAG, ";
	 			sql = sql + " DATE_FORMAT(h.DT_DATE,'%d-%m-%Y') ";
	 			sql = sql + " FROM veh_m_varriant a,veh_m_model b,veh_m_make c,veh_m_vehicletype d ,veh_m_vehicleinfo e,  ";
	 			sql = sql + " veh_m_fueltype f,com_m_color g ,veh_m_driverassign h ,com_m_staff i ";
	 			sql = sql + " WHERE a.INT_MODELID= b.INT_MODELID   ";
	 			sql = sql + " AND b.INT_MAKEID = c.INT_MAKEID  ";
	 			sql = sql + " AND c.INT_VEHICLETYPEID = d.INT_VEHICLETYPEID   ";
	 			sql = sql + " AND e.INT_VEHICLETYPEID=d.INT_VEHICLETYPEID  ";
	 			sql = sql + " AND e.INT_MAKEID=c.INT_MAKEID  ";
	 			sql = sql + " AND e.INT_MODELID=b.INT_MODELID  ";
	 			sql = sql + " AND e.INT_VARRIANTID=a.INT_VARRIANTID  ";
	 			sql = sql + " AND e.INT_FUELTYPEID = f.INT_FUELTYPEID  ";
	 			sql = sql + " AND e.INT_COLORID = g.INT_COLORID  ";
	 			sql = sql + " AND h.INT_VEHICLEID=e.INT_ID    ";	 
	 			sql = sql + " AND h.CHR_EMPID = i.CHR_EMPID ";
	 			sql = sql + " AND h.CHR_FLAG='Y' ";
	 			if(!"0".equals(typeid))
    	 			sql = sql + " AND e.INT_VEHICLETYPEID= "+typeid;
    	 		if(!"0".equals(makeid))
    	 			sql = sql + " AND e.INT_MAKEID= "+makeid;
    	 		if(!"0".equals(modelid))
    	 			sql = sql + " AND e.INT_MODELID= "+modelid;
    	 		if(!"0".equals(varriant))
    	 			sql = sql + " AND e.INT_VARRIANTID= "+varriant;
    	 		
    	 		sql = sql +" ORDER BY a.CHR_VARRIANTNAME ";
    	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Regno>" +readData[u][1] + "</Regno>");
	 					sb.append("<Vehicletype>" +readData[u][2]  + "</Vehicletype>");
	 					sb.append("<Make>" +readData[u][3]  + "</Make>");
	 					sb.append("<Model>" +readData[u][4] + "</Model>");
	 					sb.append("<Varriant>" +readData[u][5]  + "</Varriant>");
	 					sb.append("<Fuel>" +readData[u][6]  + "</Fuel>");
	 					sb.append("<Color>" +readData[u][7]  + "</Color>");
	 					sb.append("<Empid>" +readData[u][8]  + "</Empid>");
	 					sb.append("<Staff>" +readData[u][9]  + "</Staff>");
	 					sb.append("<Flag>" +readData[u][10]  + "</Flag>");
	 					sb.append("<Date>" +readData[u][11]  + "</Date>");
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
	

	public static void loadVehicleTransaction(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String Month=request.getParameter("Month");
    	 		String Year=request.getParameter("Year");
    	 		String startLetter=request.getParameter("startLetter");
    	 		String sql="";
    	 		sql =" ";
    	 		sql = " SELECT h.INT_TRANSACTIONID,e.CHR_VEHICLEREGNO, d.CHR_VEHICLETYPENAME,c.CHR_MAKENAME,b.CHR_MODELNAME,    ";
	 			sql = sql +" a.CHR_VARRIANTNAME ,f.CHR_FUELTYPENAME,g.CHR_COLORNAME, h.CHR_DESC,h.DOU_AMOUNT,    ";
	 			sql = sql +" DATE_FORMAT(h.DT_DATE,'%d-%m-%Y') , h.CHR_ACCESSID     ";
	 			sql = sql +" FROM veh_m_varriant a,veh_m_model b,veh_m_make c,veh_m_vehicletype d ,veh_m_vehicleinfo e,    "; 
	 			sql = sql +" veh_m_fueltype f,com_m_color g ,veh_t_transaction h      ";
	 			sql = sql +" WHERE a.INT_MODELID= b.INT_MODELID      ";
	 			sql = sql +" AND b.INT_MAKEID = c.INT_MAKEID      ";
	 			sql = sql +" AND c.INT_VEHICLETYPEID = d.INT_VEHICLETYPEID      "; 
	 			sql = sql +" AND e.INT_VEHICLETYPEID=d.INT_VEHICLETYPEID      ";
	 			sql = sql +" AND e.INT_MAKEID=c.INT_MAKEID     ";
	 			sql = sql +" AND e.INT_MODELID=b.INT_MODELID    ";  
	 			sql = sql +" AND e.INT_VARRIANTID=a.INT_VARRIANTID     ";
	 			sql = sql +" AND e.INT_FUELTYPEID = f.INT_FUELTYPEID     ";
	 			sql = sql +" AND e.INT_COLORID = g.INT_COLORID     ";
	 			sql = sql +" AND h.INT_VEHICLEID=e.INT_ID     ";
	 			sql = sql +" AND MONTH(h.DT_DATE)= "+Month;
	 			sql = sql +" AND YEAR(h.DT_DATE)= "+Year;
	 			if(!"0".equals(startLetter))
	 				sql = sql +" AND e.CHR_VEHICLEREGNO LIKE '"+startLetter+"%' "; 
	 			sql = sql +" ORDER BY a.CHR_VARRIANTNAME ";
     	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Regno>" +readData[u][1] + "</Regno>");
	 					sb.append("<Vehicletype>" +readData[u][2]  + "</Vehicletype>");
	 					sb.append("<Make>" +readData[u][3]  + "</Make>");
	 					sb.append("<Model>" +readData[u][4] + "</Model>");
	 					sb.append("<Varriant>" +readData[u][5]  + "</Varriant>");
	 					sb.append("<Fuel>" +readData[u][6]  + "</Fuel>");
	 					sb.append("<Color>" +readData[u][7]  + "</Color>");
	 					sb.append("<Amount>" +readData[u][9]  + "</Amount>");
	 					sb.append("<Date>" +readData[u][10]  + "</Date>");
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
	
	
	
	

	public static void LoadVechicleExpense(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String Month=request.getParameter("Month");
    	 		String Year=request.getParameter("Year");
    	 		 
    	 		String sql="";
    	 		sql =" ";
    	 		sql = " SELECT INT_EXPENSEID,DATE_FORMAT(DAT_EXPENSEDATE,'%d-%m-%Y'),DOU_NETAMOUNT  FROM veh_t_expense   WHERE INT_EXPENSEID >0";
    	 		sql = sql +" AND MONTH(DAT_EXPENSEDATE)= "+Month;
	 			sql = sql +" AND YEAR(DAT_EXPENSEDATE)= "+Year;
	 			sql = sql +" ORDER BY DAT_EXPENSEDATE";
	 			// System.out.println(request.getRealPath("/"),sql);
     	 		String readData[][] = CommonFunctions.QueryExecute(sql);
    			if(readData.length>0)
    	 		{	
    	 			StringBuffer sb = new StringBuffer();    	     	
    	 			for(int u=0; u<readData.length;u++)
    	 			{
	 					sb.append("<Row>");    	            
	 					sb.append("<Id>" +readData[u][0]+ "</Id>");
	 					sb.append("<Date>" +readData[u][1]  + "</Date>");
	 					sb.append("<Amount>" +readData[u][2]  + "</Amount>");
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
	
	
	
	
	public static void LoadReminder(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
			  	String startletter=""+request.getParameter("startLetter");
    		  	String sql="SELECT INT_REMINDERID,CHR_REMINDERNAME FROM vehicle_m_insurancereminder WHERE INT_REMINDERID>=1" ;
 	 			if(!"0".equals(startletter))
 	 				sql = sql +" AND CHR_REMINDERNAME LIKE '%"+startletter+"'" ;
 	 			String readData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
 	 			StringBuffer sb = new StringBuffer();    	     	
 	 			if(readData.length >0)
 	 			{	
 	 				for(int u=0; u<readData.length;u++)
 	 				{
 	 						sb.append("<Row>");    	            
	 	 					sb.append("<Field1>" +readData[u][0]+ "</Field1>");
	 	 					sb.append("<Field2>" +readData[u][1] + "</Field2>");      	                         
	 	 					sb.append("</Row>");	
	 				}	
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
	
	
	
	
	public static void LoadIssuer(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 { 

			  
			 
			 String startletter=""+request.getParameter("startLetter");
		  	String sql="SELECT INT_ISSUERID,CHR_ISSUERNAME FROM vehicle_m_insuranceissuer WHERE INT_ISSUERID>=1" ;
	 			if(!"0".equals(startletter))
	 				sql = sql +" AND CHR_ISSUERNAME LIKE '%"+startletter+"'" ;
	 			String readData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 			StringBuffer sb = new StringBuffer();    	     	
	 			if(readData.length >0)
	 			{	
	 				for(int u=0; u<readData.length;u++)
	 				{
	 						sb.append("<Row>");    	            
 	 					sb.append("<Field1>" +readData[u][0]+ "</Field1>");
 	 					sb.append("<Field2>" +readData[u][1] + "</Field2>");      	                         
 	 					sb.append("</Row>");	
 				}	
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
	
	
	
	
	public static void LoadInsuranceTransaction(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 { 

			  	String startletter=""+request.getParameter("startLetter");
			  	String offices=""+request.getParameter("offices");
			  	String reminder=""+request.getParameter("reminder");
			  	String sql="SELECT a.INT_TRANSACTIONID,a.CHR_EMPID,b.CHR_STAFFNAME, c.CHR_REMINDERNAME,a.CHR_POLICYNO,a.CHT_PERIOD , a.DOU_PREMIUM,DATE_FORMAT(a.DT_DATE,'%d-%m-%Y'),  DATE_FORMAT(a.DT_DUEDATE,'%D-%b-%Y'), DATE_FORMAT(a.DT_MATURITY,'%d-%m-%Y'), a.DOU_SUMASSURED,a.CHR_REGNUMBER, a.CHR_MAKE,a.CHR_MODEL,d.CHR_ISSUERNAME,  DATE_FORMAT(a.DT_VALIDUPTO,'%d-%m-%Y'), e.CHR_OFFICENAME, 	a.CHR_STATUS,a.CHR_VECHICLESTATUS,a.CHR_DEC  ";
			  	sql = sql +" FROM veh_t_insurancereminder a  ,com_m_staff b,vehicle_m_insurancereminder c,vehicle_m_insuranceissuer d,   	com_m_office e WHERE a.CHR_EMPID=b.CHR_EMPID  AND a.INT_REMINDERID = c.INT_REMINDERID AND a.INT_ISSUERID=d.INT_ISSUERID AND a.INT_BRANCHID=e.INT_OFFICEID " ;
 		  	if(!"0".equals(offices))
	 				sql = sql +" AND e.INT_OFFICEID = "+offices;
 		  	if(!"0".equals(reminder))
	 				sql = sql +" AND a.INT_REMINDERID ="+reminder;
 		  	if(!"0".equals(startletter))
	 				sql = sql +" AND b.CHR_STAFFNAME LIKE '%"+startletter+"'" ;
 		  	sql = sql +"  ORDER BY b.CHR_STAFFNAME ";
 		  	String readData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 			StringBuffer sb = new StringBuffer();    	     	
	 			if(readData.length >0)
	 			{	
	 				for(int u=0; u<readData.length;u++)
	 				{
	 						sb.append("<Row>");    	            
	 	 					sb.append("<Field1>" +readData[u][0]+ "</Field1>");
	 	 					sb.append("<Field2>" +readData[u][1] + "</Field2>");      	                         
	 	 					sb.append("<Field3>" +readData[u][2] + "</Field3>");
	 	 					sb.append("<Field4>" +readData[u][3] + "</Field4>");
	 	 					sb.append("<Field5>" +readData[u][4] + "</Field5>");
	 	 					sb.append("<Field6>" +readData[u][5] + "</Field6>");
	 	 					sb.append("<Field7>" +readData[u][6] + "</Field7>");
	 	 					sb.append("<Field8>" +readData[u][7] + "</Field8>");
	 	 					sb.append("<Field9>" +readData[u][8] + "</Field9>");
	 	 					sb.append("<Field10>" +readData[u][9]+ "</Field10>");
	 	 					sb.append("<Field11>" +readData[u][10]+ "</Field11>");
	 	 					sb.append("<Field12>" +readData[u][11] + "</Field12>");      	                         
	 	 					sb.append("<Field13>" +readData[u][12] + "</Field13>");
	 	 					sb.append("<Field14>" +readData[u][13] + "</Field14>");
	 	 					sb.append("<Field15>" +readData[u][14] + "</Field15>");
	 	 					sb.append("<Field16>" +readData[u][15] + "</Field16>");
	 	 					sb.append("<Field17>" +readData[u][16] + "</Field17>");
	 	 					sb.append("<Field18>" +readData[u][17] + "</Field18>");
	 	 					sb.append("<Field19>" +readData[u][18] + "</Field19>");
	 	 					sb.append("<Field20>" +readData[u][19].replaceAll("&", " AND ") + "</Field20>");
	 	 					sb.append("</Row>");	
			    	}
	 				 
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
	
	
}