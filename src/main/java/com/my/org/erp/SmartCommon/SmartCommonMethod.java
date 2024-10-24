package com.my.org.erp.SmartCommon;
import java.io.IOException;



import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
 
public class SmartCommonMethod extends HttpServlet
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1353669185209145078L;
	
	public static void loadCountry(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	  {
	   try 
	  	 {
	  	 		
		   		String str = request.getParameter("str");
		   		String sql =  " SELECT INT_COUNTRYID,UPPER(CHR_COUNTRYNAME),CHR_COUNTRYDESC FROM  com_m_country WHERE INT_COUNTRYID >0";
		   		if(!"0".equals(str))
		   			sql = sql +" AND UPPER(CHR_COUNTRYNAME) LIKE  '"+str+"%'";
		   		sql = sql +" ORDER BY CHR_COUNTRYNAME ";
		 		System.out.println(sql);
	  	 		 
			  	String readData[][] =  CommonFunctions.QueryExecute(sql);
		     	StringBuffer sb = new StringBuffer();
		     	for(int u=0; u<readData.length;u++)
		     	{
	 				sb.append("<Rows>");    
	 				sb.append("<Id>" +readData[u][0]+ "</Id>");
					sb.append("<Name>" +readData[u][1].replaceAll("&", "AND ")+ "</Name>");
					sb.append("<Desc>" +readData[u][2].replaceAll("&", "AND ") + "</Desc>");  
					sb.append("</Rows>");
		     	}	          

		   		response.setContentType("text/xml");
		   		response.setHeader("Cache-Control", "no-cache");
		   		response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
		   	  		     	 	 
		 	
	  	 } 
	 	 catch (Exception e) 
	 	 {
	 		System.out.println(e.getMessage());
	 		 request.setAttribute("error", e.getMessage() );
	         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			 dispatchers.forward(request, response); 
	 	 } 
	  }
  

public static void loadState(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
   try 
  	 {
  	 		
	   		String str = request.getParameter("str");
	   		String sql =  " SELECT INT_STATEID,UPPER(CHR_STATENAME),CHR_STATEDES FROM  com_m_state WHERE INT_STATEID>0 ";
	   		if(!"0".equals(str))
	  			sql = sql +" AND UPPER(CHR_STATENAME) LIKE  '"+str+"%'";
	   		sql = sql+ "	ORDER BY CHR_STATENAME ";
	   		System.out.println(sql);
	   		
	   		
		  	String readData[][] =  CommonFunctions.QueryExecute(sql);
	     	StringBuffer sb = new StringBuffer();
	     	for(int u=0; u<readData.length;u++)
	     	{
 				sb.append("<Rows>");    
 				sb.append("<Id>" +readData[u][0]+ "</Id>");
				sb.append("<Name>" +readData[u][1].replaceAll("&", "AND ")+ "</Name>");
				//sb.append("<Desc>" +readData[u][2].replaceAll("&", "AND ") + "</Desc>");  
				sb.append("</Rows>");
	     	}	          

	   		response.setContentType("text/xml");
	   		response.setHeader("Cache-Control", "no-cache");
	   		response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
	   	  		     	 	 
	 	
  	 } 
 	 catch (Exception e) 
 	 {
 		System.out.println(e.getMessage());
		 request.setAttribute("error", e.getMessage() );
        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
		 dispatchers.forward(request, response); 
 	 } 
  }
  
  
  
  public static void loadDistrict(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
   try 
  	 {
	   		String state =request.getParameter("state");
	   		String str = request.getParameter("str");
	   		String sql = " SELECT c.INT_DISTRICTID,a.CHR_COUNTRYNAME,b.CHR_STATENAME,c.CHR_DISTRICT  ";
		   	sql = sql +" FROM com_m_country a , com_m_state b, com_m_district c ";
		   	sql = sql +" WHERE a.INT_COUNTRYID= b.INT_COUNTRYID ";
		   	sql = sql +" AND b.INT_STATEID= c.INT_STATEID ";
		   	if(!"0".equals(state ))
		   	 	sql = sql +" AND b.INT_STATEID="+state;
		   		
		   	if(!"0".equals(str))
	  			sql = sql +" AND  c.CHR_DISTRICT  LIKE  '"+str+"%'";
	   		
		   	sql = sql +" ORDER BY b.CHR_STATENAME ,c.CHR_DISTRICT ";
		   	  
	        System.out.println(sql);
		  	String readData[][] =  CommonFunctions.QueryExecute(sql);
	     	StringBuffer sb = new StringBuffer();
	     	for(int u=0; u<readData.length;u++)
	     	{
 				sb.append("<Rows>");    
 				sb.append("<Id>" +readData[u][0]+ "</Id>");
				sb.append("<Country>" +readData[u][1].replaceAll("&", "AND ")+ "</Country>");
				sb.append("<State>" +readData[u][2].replaceAll("&", "AND ") + "</State>");
 				sb.append("<District>" +readData[u][3].replaceAll("&", "AND ") + "</District>"); 
				sb.append("</Rows>");
	     	}	          

	   		response.setContentType("text/xml");
	   		response.setHeader("Cache-Control", "no-cache");
	   		response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
	   	  		     	 	 
	 	
  	 } 
 	 catch (Exception e) 
 	 {
 		System.out.println(e.getMessage());
		 request.setAttribute("error", e.getMessage() );
        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
		 dispatchers.forward(request, response); 
 	 } 
  }
  
  
  
  public static void LoadCity(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
  {
  	 try
  	 {
	 		String startLetter=request.getParameter("startLetter");
	 		String country=request.getParameter("country");
	 		String state=request.getParameter("state");
	 		String district=request.getParameter("district");
	 		String sql="";
	 		sql =" SELECT a.INT_CITYID, a.CHR_CITYNAME,DECODE(a.CHR_PINCODE,'9865043008')  , b.CHR_COUNTRYNAME,c.CHR_STATENAME,d.CHR_DISTRICT FROM com_m_city a,com_m_country b,com_m_state c,com_m_district d WHERE a.INT_COUNTRYID=b.INT_COUNTRYID AND a.INT_STATEID = c.INT_STATEID AND a.INT_DISTRICTID = d.INT_DISTRICTID ";
	 		if(!"0".equals(country))
	 			sql = sql + " AND a.INT_COUNTRYID = "+country;
	 		if(!"0".equals(state))
	 			sql = sql + " AND a.INT_STATEID = "+state;
	 		if(!"0".equals(district))
	 			sql = sql + " AND a.INT_DISTRICTID = "+district;
	 		
	 		if(!"0".equals(startLetter))
	 			sql = sql + " AND a.CHR_CITYNAME LIKE '"+startLetter+"%' ";
	 		sql = sql +" ORDER BY a.CHR_CITYNAME ";
	 		System.out.println(sql);
			String readData[][] = CommonFunctions.QueryExecute(sql);
			if(readData.length>0)
	 		{	
	 			StringBuffer sb = new StringBuffer();    	     	
	 			for(int u=0; u<readData.length;u++)
	 			{
					sb.append("<Row>");    	            
					sb.append("<Id>" +readData[u][0]+ "</Id>");
					sb.append("<Name>" +(readData[u][1].toUpperCase()).replaceAll("&", " AND ") + "</Name>");
					sb.append("<Pincode>" +(readData[u][2].toUpperCase()).replaceAll("&", " AND ") + "</Pincode>");
					sb.append("<country>" +(readData[u][3].toUpperCase()).replaceAll("&", " AND ") + "</country>");
					sb.append("<state>" +(readData[u][4].toUpperCase()).replaceAll("&", " AND ") + "</state>");
					sb.append("<district>" +(readData[u][5].toUpperCase()).replaceAll("&", " AND ") + "</district>");
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
  
  
  
  
  
  

  public static void loadCompany(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
   try 
  	 {
  	 		
	   		String str =request.getParameter("str");
	   		String sql =  "SELECT a.INT_COMPANYID,UPPER(a.CHR_COMPANYNAME),UPPER(a.CHR_LEGALNAME), ";
	   		sql = sql+ " UPPER(e.CHR_CITYNAME),UPPER(d.CHR_DISTRICT),UPPER(c.CHR_STATENAME),  ";
	   		sql = sql+ "  a.CHR_EMAIL   ,UPPER(a.CHR_PFNUMBER) ,a.INT_ACTIVE ";
	   		sql = sql+ " FROM com_m_company a,com_m_country b,com_m_state c,com_m_district d,com_m_city e ";  
	   		sql = sql+ " WHERE a.INT_COUNTRYID = b.INT_COUNTRYID    ";
	   		sql = sql+ " AND a.INT_STATEID =c.INT_STATEID ";    
	   		sql = sql+ " AND a.INT_DISTRICTID= d.INT_DISTRICTID "; 
	   		sql = sql+ " AND a.INT_CITYID =e.INT_CITYID "; 
	   		if(!"0".equals(str))
	 			sql = sql+" AND a.CHR_COMPANYNAME LIKE '"+str+"%'";
	 		sql = sql+ " ORDER BY a.CHR_COMPANYNAME";
  	 		System.out.println(sql);
		  	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	     	StringBuffer sb = new StringBuffer();
	     	for(int u=0; u<readData.length;u++)
	     	{
 				sb.append("<Rows>");    
 				sb.append("<Id>" +readData[u][0]+ "</Id>");
				sb.append("<Name>" +readData[u][1].replaceAll("&", "AND ")+ "</Name>");
				sb.append("<Legal>" +readData[u][2].replaceAll("&", "AND ") + "</Legal>"); 
				sb.append("<City>" +readData[u][3].replaceAll("&", "AND ") + "</City>"); 
				sb.append("<District>" +readData[u][4].replaceAll("&", "AND ") + "</District>"); 
				sb.append("<State>" +readData[u][5].replaceAll("&", "AND ") + "</State>"); 
				sb.append("<Email>" +readData[u][6].replaceAll("&", "AND ") + "</Email>");
				sb.append("<Pfnumber>" +readData[u][7].replaceAll("&", "AND ") + "</Pfnumber>"); 
				sb.append("<Active>" +readData[u][8].replaceAll("&", "AND ") + "</Active>");
				sb.append("</Rows>");
	     	}	          

	   		response.setContentType("text/xml");
	   		response.setHeader("Cache-Control", "no-cache");
	   		response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
	   	  		     	 	 
	 	
  	 } 
 	 catch (Exception e) 
 	 {
 		System.out.println(e.getMessage());
		 request.setAttribute("error", e.getMessage() );
        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
		 dispatchers.forward(request, response); 
 	 } 
  }	


  
  
  public static void loadBranch(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
  	 try 
  	 {    		 	
  		 	String id= request.getParameter("companyid") ;
  		 	String search=""+request.getParameter("startLetter");
  		 	String sql = " SELECT a.INT_BRANCHID,f.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_LEGALNAME, ";
	   		sql = sql + " e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME ,a.CHR_EMAIL,a.CHR_PANNO,a.INT_ACTIVE ";
	   		sql = sql + " FROM com_m_branch a,com_m_country b,com_m_state c,com_m_district d,com_m_city e,com_m_company f "; 
	   		sql = sql + " WHERE a.INT_COUNTRYID = b.INT_COUNTRYID   ";  
	   		sql = sql + " AND a.INT_STATEID =c.INT_STATEID      ";
	   		sql = sql + " AND a.INT_DISTRICTID= d.INT_DISTRICTID  "; 
	   		sql = sql + " AND a.INT_CITYID =e.INT_CITYID   ";
	   		sql = sql + " AND a.INT_COMPANYID =f.INT_COMPANYID  ";
  		 	if(!"0".equals(id))
  		 		sql=sql+" AND a.INT_COMPANYID="+id;
  		 	if(!"0".equals(search))
  		 		sql=sql+" AND a.CHR_BRANCHNAME LIKE'"+search+"%'";
  		 	sql=sql+" ORDER BY f.CHR_COMPANYNAME,a.CHR_BRANCHNAME ";
  		 	System.out.println(sql);
		  	String readData[][] = CommonFunctions.QueryExecute(sql);
  	     	StringBuffer sb = new StringBuffer(); 
  	     	if(readData.length>0)
  	     	{	
  	     		for(int u=0; u<readData.length;u++)
  	     		{
  	     			sb.append("<branch>");    	     		
			     		sb.append("<id>"+readData[u][0]+"</id>");
			     		sb.append("<companyName>"+readData[u][1].toUpperCase().replaceAll("&", " AND")+"</companyName>");
		     			sb.append("<branchName>"+readData[u][2].toUpperCase().replaceAll("&", " AND")+"</branchName>");
		     			sb.append("<legalName>"+readData[u][3].toUpperCase().replaceAll("&", " AND")+"</legalName>");
		     			sb.append("<city>"+readData[u][4].toUpperCase()+"</city>");
		     			sb.append("<district>"+readData[u][5].toUpperCase()+"</district>");
		     			sb.append("<state>"+readData[u][6].toUpperCase()+"</state>");
		     			sb.append("<email>"+readData[u][7]+"</email>");
		     			sb.append("<pan>"+readData[u][8].toUpperCase()+"</pan>");
		     			sb.append("<active>"+readData[u][9]+"</active>");
		     			sb.append("</branch>");
		     			
  	     		}   
  	     		response.setContentType("text/xml");
  	     		response.setHeader("Cache-Control", "no-cache");
  	     		response.getWriter().write("<branches>" + sb.toString() + "</branches>");
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
	
  
  public static void loadBranchSelect(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
  	 try 
  	 {    		 	
  		 	String id= request.getParameter("companyid") ;
  		 	String sql = " SELECT b.INT_BRANCHID,UPPER(b.CHR_BRANCHNAME)";
	   		sql = sql + " FROM com_m_company a, com_m_branch b ";
	   		sql = sql + " WHERE a.INT_COMPANYID = b.INT_COMPANYID ";
	   		sql=sql+" AND a.INT_COMPANYID="+id;
  		 	sql=sql+" ORDER BY b.CHR_BRANCHNAME ";
  		 	System.out.println(sql);
		  	String readData[][] = CommonFunctions.QueryExecute(sql);
  	     	StringBuffer sb = new StringBuffer(); 
  	     	if(readData.length>0)
  	     	{	
  	     		for(int u=0; u<readData.length;u++)
  	     		{
  	     			sb.append("<Row>");    	     		
			     	sb.append("<id>"+readData[u][0]+"</id>");
			     	sb.append("<branchName>"+readData[u][1].replaceAll("&", " AND") +"</branchName>");
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
	

  
  
  public static void LoadOffice(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
   try 
  	 {
  	 		
	   		String str = request.getParameter("str");
	   		String sql =  " SELECT a.INT_OFFICEID,a.CHR_OFFICENAME,a.CHR_OFFICESHORTNAME,a.CHR_OFFICEDES,a.CHR_STATUS, b.CHR_STATENAME,a.CHR_EMAIL  ";
	   		sql = sql +" FROM com_m_office a , com_m_state b WHERE a.INT_STATEID = b.INT_STATEID  ";
	   		if(!"0".equals(str))
	   			sql = sql+ " AND a.CHR_OFFICENAME LIKE '"+str+"%' ";
	   		sql = sql+ " ORDER BY a.CHR_OFFICENAME ";
	 		System.out.println(sql);
		  	String readData[][] =  CommonFunctions.QueryExecute(sql);
	     	StringBuffer sb = new StringBuffer();
	     	for(int u=0; u<readData.length;u++)
	     	{
 				sb.append("<Rows>");    
 				sb.append("<Id>" +readData[u][0]+ "</Id>");
				sb.append("<Name>" +readData[u][1].replaceAll("&", "AND ")+ "</Name>");
				sb.append("<ShortName>" +readData[u][2].replaceAll("&", "AND ") + "</ShortName>"); 
				sb.append("<Desc>" +readData[u][3].replaceAll("&", "AND ") + "</Desc>");
				sb.append("<Status>"+readData[u][4]+"</Status>");
				sb.append("<State>" +readData[u][5].replaceAll("&", "AND ") + "</State>");
				sb.append("<Email>"+readData[u][6]+"</Email>");
				sb.append("</Rows>");
	     	}	          

	   		response.setContentType("text/xml");
	   		response.setHeader("Cache-Control", "no-cache");
	   		response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
	   	  		     	 	 
	 	
  	 } 
 	 catch (Exception e) 
 	 {
 		System.out.println(e.getMessage());
		 request.setAttribute("error", e.getMessage() );
        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
		 dispatchers.forward(request, response); 
 	 } 
  }
  
  
  
  public static void loadDepartment(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
   try 
  	 {
  	 		
	   		String str = request.getParameter("str");
	   		String sql =  "SELECT   INT_DEPARTID,CHR_DEPARTNAME ,CHR_DEPARTDES,CHR_STATUS FROM com_m_depart WHERE INT_DEPARTID >0 ";
	   		if(!"0".equals(str))
	   			sql = sql+ " AND CHR_DEPARTNAME LIKE '"+str+"%' ";
	   		
	   		sql = sql+ " ORDER BY CHR_DEPARTNAME";
	 		System.out.println(sql);
		  	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	     	StringBuffer sb = new StringBuffer();
	     	for(int u=0; u<readData.length;u++)
	     	{
 				sb.append("<Rows>");    
 				sb.append("<Id>" +readData[u][0]+ "</Id>");
				sb.append("<Name>" +readData[u][1].replaceAll("&", "AND ")+ "</Name>");
				//sb.append("<Desc>" +readData[u][2].replaceAll("&", "AND ") + "</Desc>");  
				sb.append("<Status>"+readData[u][3]+"</Status>");
				sb.append("</Rows>");
	     	}	          

	   		response.setContentType("text/xml");
	   		response.setHeader("Cache-Control", "no-cache");
	   		response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
	   	  		     	 	 
	 	
  	 } 
 	 catch (Exception e) 
 	 {
 		System.out.println(e.getMessage());
		 request.setAttribute("error", e.getMessage() );
        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
		 dispatchers.forward(request, response); 
 	 } 
  }
  

  public static void loadDesignation(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
   try 
  	 {
  	 		
	   
	   		String str = request.getParameter("str");
	   		String sql =  "SELECT INT_DESIGID,CHR_DESIGNAME,CHR_DESIGDES,CHR_STATUS   FROM com_m_desig WHERE INT_DESIGID >0 ";
	   		if(!"0".equals(str))
	   			sql = sql+ " AND CHR_DESIGNAME LIKE '"+str+"%' ";
	   		sql = sql+ " ORDER BY CHR_DESIGNAME ";
	 		System.out.println(sql);
	   		 
	 		System.out.println(sql);
		  	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	     	StringBuffer sb = new StringBuffer();
	     	for(int u=0; u<readData.length;u++)
	     	{
 				sb.append("<Rows>");    
 				sb.append("<Id>" +readData[u][0]+ "</Id>");
				sb.append("<Name>" +readData[u][1].replaceAll("&", "AND ")+ "</Name>");
				//sb.append("<Desc>" +readData[u][2].replaceAll("&", "AND ") + "</Desc>"); 
				sb.append("<Status>"+readData[u][3]+"</Status>");
				sb.append("</Rows>");
	     	}	          

	   		response.setContentType("text/xml");
	   		response.setHeader("Cache-Control", "no-cache");
	   		response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
	   	  		     	 	 
	 	
  	 } 
 	 catch (Exception e) 
 	 {
 		System.out.println(e.getMessage());
		 request.setAttribute("error", e.getMessage() );
        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
		 dispatchers.forward(request, response); 
 	 } 
  }
  
  
  public static void loadBloodGroup(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
  	 try 
  	 {    		 	
  		 	 
  		 	 	
  		 	String str = request.getParameter("str");
	   		String sql =  " SELECT INT_BLOODGROUPID,CHR_GROUPNAME FROM com_m_bloodgroup WHERE INT_BLOODGROUPID>0 ";
	   		if(!"0".equals(str))
	   			sql = sql+ " AND CHR_GROUPNAME LIKE '"+str+"%' ";
	   		sql = sql+ " ORDER BY CHR_GROUPNAME ";
	 		System.out.println(sql);
	 		
  		 	
		  	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
  		 	StringBuffer sb = new StringBuffer(); 
  	     	if(readData.length >0)
  	     	{	
  	     		for(int u=0; u<readData.length;u++)
  	     		{
	     				sb.append("<Row>");    	     		
	     				sb.append("<Id>"+readData[u][0]+"</Id>");
	     				sb.append("<Name>"+readData[u][1].replaceAll("&", " AND")+"</Name>");
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
  
  
  
  public static void LoadQualification(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
  	 try 
  	 {    		 	
  		 	 
  		 	String startLetter = request.getParameter("startLetter");	
  		 	String sql = " SELECT INT_QUALIFICATIONID,CHR_QUALIFICATIONNAME FROM  com_m_qualification  WHERE INT_QUALIFICATIONID>=1";
  		 	 if(!"0".equals(startLetter))
      			 sql = sql + " AND CHR_QUALIFICATIONNAME LIKE '"+startLetter+"%' ";
  		 	 
      		sql = sql +" ORDER BY CHR_QUALIFICATIONNAME  ";
      		System.out.println(sql);
		  	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
  		 	StringBuffer sb = new StringBuffer(); 
  	     	if(readData.length >0)
  	     	{	
  	     		for(int u=0; u<readData.length;u++)
  	     		{
	     				sb.append("<Row>");    	     		
	     				sb.append("<Id>"+readData[u][0]+"</Id>");
	     				sb.append("<Name>"+readData[u][1].replaceAll("&", " AND")+"</Name>");
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
  

  
  public static void DatatableLoadQualification(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
  	 try 
  	 {    		 	
  		 	String sql = " SELECT INT_QUALIFICATIONID quaid,CHR_QUALIFICATIONNAME quaName FROM  com_m_qualification  WHERE INT_QUALIFICATIONID>=1";
  		 	sql = sql +" ORDER BY CHR_QUALIFICATIONNAME  ";
      		System.out.println(sql);
		  	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		  	response.setContentType("application/json");
	        response.setCharacterEncoding("UTF-8");
	        String json = "";//new ObjectMapper().writeValueAsString( readData );
	        json = "{ \"demo\":" +json+"}";
	        response.getWriter().write(json);
	        System.out.println(json);
  	 	} 
  	 	catch (Exception e) 
  	 	{
   	 		 System.out.println(e.getMessage());
  	 		 request.setAttribute("error", e.getMessage() );
  	         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
  			 dispatchers.forward(request, response); 
  	 	} 
  }	
  
  public static void loadEmployeeCategory(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
  	 try 
  	 {    		 	
  		 	String cdata[][]=CommonFunctions.QueryExecute("SELECT INT_FROM,INT_TO FROM att_m_basicsettings  WHERE INT_ID=1");
  		 	String cy ="";
  		 	if(cdata.length>0)
  		 		cy = cdata[0][0]+"th to "+cdata[0][1]+"th";
  		 	
  		 	String str = request.getParameter("str");
	   		String sql =  " SELECT INT_EMPLOYEECATEGORYID,CHR_CATEGORYNAME ,CHR_STATUS,";
	   		sql = sql+ " if(INT_ATTENDANCE_CYCLE='1','1-31','"+cy+"'),CHR_PFCALCULATIONTYPE FROM  com_m_employeecategory  WHERE INT_EMPLOYEECATEGORYID>0 ";
	   		if(!"0".equals(str))
	   			sql = sql+ " AND CHR_CATEGORYNAME LIKE '"+str+"%' ";
	   		sql = sql+ " ORDER BY CHR_CATEGORYNAME ";
	 		System.out.println(sql);
	 		
		  	String readData[][] =  CommonFunctions.QueryExecute(sql);
  		 	StringBuffer sb = new StringBuffer(); 
  	     	if(readData.length >0)
  	     	{	
  	     		for(int u=0; u<readData.length;u++)
  	     		{
	     				sb.append("<Row>");    	     		
	     				sb.append("<Id>"+readData[u][0]+"</Id>");
	     				sb.append("<Name>"+readData[u][1].replaceAll("&", " AND")+"</Name>");
	     				sb.append("<Status>"+readData[u][2]+"</Status>");
	     				sb.append("<Cycle>"+readData[u][3]+"</Cycle>");
	     				sb.append("<Calculation>"+readData[u][4]+"</Calculation>");
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
  
  public static void loadStaffType(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
  	 try 
  	 {    		 	
			
  		 	String str = request.getParameter("str");
			String sql =  "SELECT INT_STAFFTYPEID,CHR_TYPENAME,CHR_FLAG FROM com_m_stafftype  WHERE INT_STAFFTYPEID>0 ";
			if(!"0".equals(str))
				sql = sql+ " AND CHR_TYPENAME LIKE '"+str+"%' ";
			sql = sql+ " ORDER BY CHR_TYPENAME ";
			System.out.println(sql);
			
 		
  		 	 String readData[][] =  CommonFunctions.QueryExecute(sql);
  		 	StringBuffer sb = new StringBuffer(); 
  	     	if(readData.length >0)
  	     	{	
  	     		for(int u=0; u<readData.length;u++)
  	     		{
	     				sb.append("<Row>");    	     		
	     				sb.append("<Id>"+readData[u][0]+"</Id>");
	     				sb.append("<Name>"+readData[u][1].replaceAll("&", " AND")+"</Name>");
	     				sb.append("<Flag>"+readData[u][2]+"</Flag>");
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
  
  
  public static void loadDispensary(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
  	 try 
  	 {    		 	
  		 	 
  		 	String str = request.getParameter("str");
  		 	String sql = " Select INT_DESPID,UPPER(CHR_DESPNAME),INT_PINCODE From com_m_dispensary WHERE INT_DESPID> 0";
  		 	if(!"0".equals(str))
  		 		sql = sql+" AND CHR_DESPNAME LIKE '"+str+"%'";
  		 	sql = sql+" order by CHR_DESPNAME ";
  		 	System.out.println(sql);
		  	String readData[][] = CommonFunctions.QueryExecute(sql);
  		 	StringBuffer sb = new StringBuffer(); 
  	     	if(readData.length >0)
  	     	{	
  	     		for(int u=0; u<readData.length;u++)
  	     		{
	     				sb.append("<Row>");    	     		
	     				sb.append("<Id>"+readData[u][0]+"</Id>");
	     				sb.append("<Name>"+readData[u][1].replaceAll("&", " AND ")+"</Name>");
	     				sb.append("<Pincode>"+readData[u][2]+"</Pincode>");
	     				sb.append("</Row>");
                  }
  	     		 
  	     		response.setContentType("text/xml");
  	     		response.setHeader("Cache-Control", "no-cache");
  	     		response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
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
  
  
  public static void loadCertification(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
  	 try 
  	 {    		 	
  		 	 
  		 	
  		 	String str = request.getParameter("str");
			String sql = " SELECT INT_CERTIFICATIONID,CHR_CERTIFICATIONNAME FROM com_m_certification WHERE INT_CERTIFICATIONID > 0 ";
	  		if(!"0".equals(str))
		 		sql = sql+" AND CHR_CERTIFICATIONNAME LIKE '"+str+"%'";
		 	sql = sql+" order by CHR_CERTIFICATIONNAME ";
		 	System.out.println(sql);
	 	  	String readData[][] =  CommonFunctions.QueryExecute(sql);
  		 	StringBuffer sb = new StringBuffer(); 
  	     	if(readData.length >0)
  	     	{	
  	     		for(int u=0; u<readData.length;u++)
  	     		{
	     				sb.append("<Row>");    	     		
	     				sb.append("<Id>"+readData[u][0]+"</Id>");
	     				sb.append("<Name>"+readData[u][1].replaceAll("&", " AND")+"</Name>");
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
  
  
  
  
  public static void loadCertificationTrack(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
  	 try 
  	 {    		 	
  		 	 
  		 	
  		 
  		 String cid = request.getParameter("cid");
  		 String str = request.getParameter("str");
  		 String sql = "  SELECT  a.INT_CERTIFICATIONTRACKID,a.CHR_EMPID,b.CHR_STAFFNAME,a.CHR_CERTIFICATIONID,b.CHR_EMAILID,b.CHR_MOBILE ";
  		 sql = sql + " FROM  com_t_certification  a ,com_m_staff b WHERE   a.CHR_EMPID= b.CHR_EMPID  AND b.CHR_HOLD !='Y' ";
  		 if(!"0".equals(cid))
  			 sql = sql + " AND a.CHR_CERTIFICATIONID LIKE '%"+cid+"%' ";
  		 if(!"0".equals(str))
  			 sql = sql + " AND b.CHR_STAFFNAME LIKE '"+str+"%'  ";
  		 sql = sql + " ORDER BY b.CHR_STAFFNAME ";
  		 
  		 
  		 String readData[][] =  CommonFunctions.QueryExecute(sql);
  		 	StringBuffer sb = new StringBuffer(); 
  	     	if(readData.length >0)
  	     	{	
  	     		for(int u=0; u<readData.length;u++)
  	     		{
	     				sb.append("<Row>");    	     		
	     				sb.append("<RId>"+readData[u][0]+"</RId>");
	     				sb.append("<Id>"+readData[u][1]+"</Id>");
	     				sb.append("<Name>"+readData[u][2].replaceAll("&", " AND")+"</Name>");
	     				String Data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("	SELECT CHR_CERTIFICATIONNAME FROM com_m_certification  WHERE INT_CERTIFICATIONID IN ("+readData[u][3]+") ");
	     				sql = "";
	     				if(Data.length>0)
	     				{
	     					for(int v=0; v<Data.length;v++)
	     						sql = sql+Data[v][0] +" ,";
	     				}
	     				else
	     					sql = " ";
	     				sql = sql.substring(0,sql.length()-1);
	     				sb.append("<Cid>"+sql+"</Cid>");
	     				sb.append("<Email>"+readData[u][4]+"</Email>");
	     				sb.append("<Mobile>"+readData[u][5]+"</Mobile>");
	     				
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
			 
  	 		request.setAttribute("error", e.getMessage() );
  	 		RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
  	 		dispatchers.forward(request, response); 
  	 		System.out.println(e.getMessage());
  	 	} 
  }	
  
  
  
  
  public static void LoadIdProof(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
  	 try 
  	 {    		 	
  		 	 
  		 	String str = request.getParameter("str");
			String sql = " SELECT INT_ADDRESSPROOFID,CHR_PROOFNAME FROM com_m_addressproof WHERE INT_ADDRESSPROOFID > 0 ";
	  		if(!"0".equals(str))
		 		sql = sql+" AND CHR_PROOFNAME LIKE '"+str+"%'";
		 	sql = sql+" order by CHR_PROOFNAME ";
		 	System.out.println(sql);
		  	String readData[][] =  CommonFunctions.QueryExecute(sql);
  		 	StringBuffer sb = new StringBuffer(); 
  	     	if(readData.length >0)
  	     	{	
  	     		for(int u=0; u<readData.length;u++)
  	     		{
	     				sb.append("<Row>");    	     		
	     				sb.append("<Id>"+readData[u][0]+"</Id>");
	     				sb.append("<Name>"+readData[u][1].replaceAll("&", " AND")+"</Name>");
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
  
  public static void loadStaffAccountNumberSearch(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
   try 
  	 {
	   		HttpSession session=request.getSession();
	   		String search=request.getParameter("search");
  	 		String stype=request.getParameter("stype");
  	 		String bank=request.getParameter("bank");
  	 		if(search=="")
  	 			search ="0";
  	 		String sql="SELECT CHR_ORDERBY,CHR_SHOW_EMPLOYEE FROM m_institution";
  	 		String orderdata[][] = CommonFunctions.QueryExecute(sql);
  	 		sql = " SELECT CHR_OFFICELIST,CHR_TYPE FROM m_user WHERE CHR_USRNAME='"+session.getAttribute("USRID")+"'";
	 		String officedata[][] = CommonFunctions.QueryExecute(sql);
	 		sql =" SELECT  A.CHR_EMPID,UPPER(A.CHR_STAFFNAME),B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME  , A.CHR_MOBILE ,E.CHR_COMPANYNAME ,A.CHR_TYPE,A.CHR_MOTHERNAME ,";  
	 		sql = sql + " F.CHR_BANKGROUPNAME,A.CHR_ACCNO,A.CHR_IFSC,A.CHR_TYPE ";
	 		sql = sql + " from  com_m_staff  A, com_m_branch  B,  com_m_depart  C, com_m_desig  D ,  com_m_company  E , com_m_bankgroup F "; 
  	 		sql = sql + " where A.INT_BRANCHID=B.INT_BRANCHID ";
  	 		sql = sql + " AND A.INT_COMPANYID =  E.INT_COMPANYID "; 
  	 		sql = sql + " AND A.INT_BRANCHID=B.INT_BRANCHID "; 
  	 		sql = sql + " AND A.INT_COMPANYID=E.INT_COMPANYID";
  	 		sql = sql + " AND A.INT_DEPARTID=C.INT_DEPARTID  ";
  	 		sql = sql + " AND A.INT_DESIGID=D.INT_DESIGID  ";
  	 		sql = sql + " AND A.CHR_BANK  = F.INT_BANKGROUPID "; // AND A.CHR_TYPE !='T'
  	 		sql = sql + " AND  A.INT_OFFICEID IN("+officedata[0][0]+" ,0) ";
  	 		
  	 		if(!"0".equals(orderdata[0][1]))
  	 			if("R".equals(orderdata[0][1]))
  	 				sql = sql +" AND A.CHR_EMPLOYEE ='R' ";
  	 			else
  	 				sql = sql +" AND A.CHR_EMPLOYEE ='N' ";
  	 		
  	 		
  	 		if(!"0".equals(bank))
  	 			sql = sql + " AND F.INT_BANKGROUPID ="+bank;
  	 		
  	 		if("1".equals(stype))
  	 		{	
  	 			if(!"0".equals(search))
  	 				sql = sql + " AND( (A.CHR_STAFFNAME LIKE '%"+search.trim()+"%' ) OR (A.CHR_EMPID LIKE '%"+search.trim()+"%' ) OR (A.CHR_ACCNO LIKE '%"+search.trim()+"%' )   )";
  	 		}
  	 		else if("2".equals(stype))
  	 		{
  	 			if(!"0".equals(search))
  	 				sql = sql + " AND A.CHR_STAFFNAME LIKE '"+search.trim()+"%'  ";
  	 		}
  	 		if("N".equals(orderdata[0][0]))
  	 			sql = sql+" GROUP BY A.CHR_EMPID  ORDER BY A.CHR_STAFFNAME ";
  	 		else
  	 			sql = sql+" GROUP BY A.CHR_EMPID   ORDER BY A.CHR_EMPID ";
  	 		sql = sql + " LIMIT 100 ";
  	 		System.out.println(sql);
		  	String readData[][]=  CommonFunctions.QueryExecute(sql);
	 			if(readData.length>0)
	 			{	
	 				StringBuffer sb = new StringBuffer();    	     	
	 				for(int u=0; u<readData.length;u++)
	 				{
	 					sb.append("<Row>");    	            
	 					sb.append("<StaffId>" +readData[u][0]+ "</StaffId>");
	 					sb.append("<StaffName>" +readData[u][1].toUpperCase() + "</StaffName>");  
	 					sb.append("<BranchName>" +readData[u][2].replaceAll("&", " AND") + "</BranchName>");
	 					sb.append("<DepartName>" +readData[u][3].replaceAll("&", " AND") + "</DepartName>");
	 					sb.append("<DesigName>" +readData[u][4].replaceAll("&", " AND") + "</DesigName>");
	 					sb.append("<Mobile>" +readData[u][5] + "</Mobile>");
	 					sb.append("<Company>" +readData[u][6].replaceAll("&", " AND") + "</Company>");
	 					sb.append("<Termination>" +readData[u][7] + "</Termination>");
	 					sb.append("<MiddleName>" +readData[u][8].replaceAll("&", " AND") + "</MiddleName>");
	 					sb.append("<Usertype>" +officedata[0][1] + "</Usertype>");
	 					sb.append("<Bank>" +readData[u][9].replaceAll("&", " AND") + "</Bank>");
	 					sb.append("<Account>" +readData[u][10] + "</Account>");
	 					sb.append("<IFSC>" +readData[u][11] + "</IFSC>");
	 					sb.append("<Resigned>" +readData[u][12] + "</Resigned>");
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
  
  public static void loadStaffPFESI(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
   try 
  	 {
	   		HttpSession session=request.getSession();
	   		String search=request.getParameter("search");
  	 		String stype=request.getParameter("stype");
  	 		  
  	 		String sql = " SELECT CHR_OFFICELIST,CHR_TYPE FROM m_user WHERE CHR_USRNAME='"+session.getAttribute("USRID")+"'";
	 		String officedata[][] = CommonFunctions.QueryExecute(sql);
	 		 
	 		sql =" SELECT a.CHR_EMPID,a.CHR_STAFFNAME, ";
 			sql = sql + " IF(a.CHR_PF ='Y', 'YES',if(a.CHR_PF='N','NO','COMMON')), ";
 			sql = sql + " IF(a.CHR_PFTYPE='P','PERCENTAGE','AMOUNT'), ";
 			sql = sql + " a.CHR_PFNO, a.CHR_NOMINEE, ";
 			sql = sql + " IF(a.CHR_ESI ='Y', 'YES',if(a.CHR_ESI='N','NO','COMMON')), ";
 			sql = sql + " IF(a.CHR_ESITYPE='P','PERCENTAGE','AMOUNT'), ";
 			sql = sql + " a.CHR_ESINO ,a.CHR_TYPE ";
 			sql = sql + " FROM com_m_staff a  WHERE a.CHR_EMPID IS NOT NULL ";
 			sql = sql + " AND  a.INT_OFFICEID IN("+officedata[0][0]+" ,0) ";
  	 		 
  	 		if("1".equals(stype))
  	 			sql = sql + " AND( (a.CHR_STAFFNAME LIKE '%"+search.trim()+"%' ) OR (a.CHR_EMPID LIKE '%"+search.trim()+"' )  )";
  	 		else if("2".equals(stype))
  	 		{
  	 			if(!"0".equals(search))
  	 				sql = sql + " AND a.CHR_STAFFNAME LIKE '"+search.trim()+"%'  ";
  	 		}
  	 		 
  	 		sql = sql + " ORDER BY a.CHR_STAFFNAME LIMIT 1000 ";
  	 		System.out.println(sql);
		  	String readData[][]=  CommonFunctions.QueryExecute(sql);
	 			if(readData.length>0)
	 			{	
	 				StringBuffer sb = new StringBuffer();    	     	
	 				for(int u=0; u<readData.length;u++)
	 				{
	 					sb.append("<Row>");    	            
	 					sb.append("<StaffId>" +readData[u][0]+ "</StaffId>");
	 					sb.append("<StaffName>" +readData[u][1].toUpperCase() + "</StaffName>");  
	 					sb.append("<PF>" +readData[u][2].replaceAll("&", " AND") + "</PF>");
	 					sb.append("<PFtype>" +readData[u][3].replaceAll("&", " AND") + "</PFtype>");
	 					sb.append("<PFnumber>" +readData[u][4].replaceAll("&", " AND") + "</PFnumber>");
	 					sb.append("<Nominee>" +readData[u][5] + "</Nominee>");
	 					sb.append("<ESI>" +readData[u][6].replaceAll("&", " AND") + "</ESI>");
	 					sb.append("<ESIType>" +readData[u][7] + "</ESIType>");
	 					sb.append("<ESINumber>" +readData[u][8].replaceAll("&", " AND") + "</ESINumber>");
	 					sb.append("<Resigned>" +readData[u][9] + "</Resigned>");
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
  
  
  public static void loadStaffPFESIClaims(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
   try 
  	 {
	   		HttpSession session=request.getSession();
	   		String search=request.getParameter("search");
  	 		String stype=request.getParameter("stype");
  	 		  
  	 		String sql = " SELECT CHR_OFFICELIST,CHR_TYPE FROM m_user WHERE CHR_USRNAME='"+session.getAttribute("USRID")+"'";
	 		String officedata[][] = CommonFunctions.QueryExecute(sql);
	 		 
	 		sql =" SELECT a.CHR_EMPID,a.CHR_STAFFNAME, ";
 			sql = sql + " IF(a.CHR_PF ='Y', 'YES',if(a.CHR_PF='N','NO','COMMON')), ";
 			sql = sql + " IF(a.CHR_PFTYPE='P','PERCENTAGE','AMOUNT'), ";
 			sql = sql + " a.CHR_PFNO, a.CHR_NOMINEE, ";
 			sql = sql + " IF(a.CHR_ESI ='Y', 'YES',if(a.CHR_ESI='N','NO','COMMON')), ";
 			sql = sql + " IF(a.CHR_ESITYPE='P','PERCENTAGE','AMOUNT'), ";
 			sql = sql + " a.CHR_ESINO ,a.CHR_TYPE, ";
 			sql = sql + " IF(CHR_PFCLAIMSTATUS='Y','Claimed','') ,DATE_FORMAT(DAT_PFCLIAMDATE,'%d-%b-%Y') ,CHR_PFCLIAMDESCRIPTION  ";
 			sql = sql + " FROM com_m_staff a  WHERE a.CHR_EMPID IS NOT NULL  AND a.CHR_PF !='N' ";
 			sql = sql + " AND  a.INT_OFFICEID IN("+officedata[0][0]+" ,0) ";
  	 		 
  	 		if("1".equals(stype))
  	 			sql = sql + " AND( (a.CHR_STAFFNAME LIKE '%"+search.trim()+"%' ) OR (a.CHR_EMPID LIKE '%"+search.trim()+"' )  )";
  	 		else if("2".equals(stype))
  	 		{
  	 			if(!"0".equals(search))
  	 				sql = sql + " AND a.CHR_STAFFNAME LIKE '"+search.trim()+"%'  ";
  	 		}
  	 		 
  	 		sql = sql + " ORDER BY a.CHR_STAFFNAME LIMIT 1000 ";
  	 		System.out.println(sql);
		  	String readData[][]=  CommonFunctions.QueryExecute(sql);
	 			if(readData.length>0)
	 			{	
	 				StringBuffer sb = new StringBuffer();    	     	
	 				for(int u=0; u<readData.length;u++)
	 				{
	 					sb.append("<Row>");    	            
	 					sb.append("<StaffId>" +readData[u][0]+ "</StaffId>");
	 					sb.append("<StaffName>" +readData[u][1].toUpperCase() + "</StaffName>");  
	 					sb.append("<PF>" +readData[u][2].replaceAll("&", " AND") + "</PF>");
	 					sb.append("<PFtype>" +readData[u][3].replaceAll("&", " AND") + "</PFtype>");
	 					sb.append("<PFnumber>" +readData[u][4].replaceAll("&", " AND") + "</PFnumber>");
	 					sb.append("<Nominee>" +readData[u][5] + "</Nominee>");
	 					sb.append("<ESI>" +readData[u][6].replaceAll("&", " AND") + "</ESI>");
	 					sb.append("<ESIType>" +readData[u][7] + "</ESIType>");
	 					sb.append("<ESINumber>" +readData[u][8].replaceAll("&", " AND") + "</ESINumber>");
	 					sb.append("<Resigned>" +readData[u][9] + "</Resigned>");
	 					sb.append("<Status>" +readData[u][10] + "</Status>");
	 					sb.append("<Claimdate>" +readData[u][11] + "</Claimdate>");
	 					
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
  
  public static void loadStaffSearch(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
   try 
  	 {
	   		HttpSession session=request.getSession();
	   		String search=request.getParameter("search");
	   		String resigned=request.getParameter("resigned");
	   		String confirmation=request.getParameter("confirmation");
	   		String modified=request.getParameter("modified");
  	 		String stype=request.getParameter("stype");
  	 		String sql="SELECT CHR_ORDERBY,CHR_SHOW_EMPLOYEE FROM m_institution";
  	 		String orderdata[][] = CommonFunctions.QueryExecute(sql);
  	 		sql = " SELECT CHR_OFFICELIST,CHR_TYPE FROM m_user WHERE CHR_USRNAME='"+session.getAttribute("USRID")+"'";
	 		String officedata[][] = CommonFunctions.QueryExecute(sql);
	 		sql =" SELECT  A.CHR_EMPID,UPPER(A.CHR_STAFFNAME),B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME  , A.CHR_MOBILE ,E.CHR_COMPANYNAME ,A.CHR_TYPE,A.CHR_STAFFFNAME,";  
  	 		sql = sql + " A.INT_PROGRESSBAR,A.CHR_REJOIN ,";//(20+FIND_A_PERFORM_STAFFREGISTRATION( A.CHR_EMPID))
  	 		sql = sql+ " A.CHR_APPROVED, A.CHR_EMPLOYEE,A.CHR_MODIFICATION   ";
  	 		sql = sql + " from  com_m_staff  A, com_m_branch  B,  com_m_depart  C, com_m_desig  D ,  com_m_company  E "; 
  	 		sql = sql + " where A.INT_BRANCHID=B.INT_BRANCHID ";
  	 		sql = sql + " AND A.INT_COMPANYID =  E.INT_COMPANYID "; 
  	 		sql = sql + " AND A.INT_BRANCHID=B.INT_BRANCHID "; 
  	 		sql = sql + " AND A.INT_COMPANYID=E.INT_COMPANYID";
  	 		sql = sql + " AND A.INT_DEPARTID=C.INT_DEPARTID  ";
  	 		sql = sql + " AND A.INT_DESIGID=D.INT_DESIGID  ";

  	 		if(!"0".equals(orderdata[0][1]))
  	 			if("R".equals(orderdata[0][1]))
  	 				sql = sql +" AND A.CHR_EMPLOYEE ='R' ";
  	 			else
  	 				sql = sql +" AND A.CHR_EMPLOYEE ='N' ";
 
  	 		if("Y".equals(confirmation))
  	 			sql = sql + " AND A.CHR_APPROVED ='N' ";
  	 		
  	 		if("Y".equals(modified))
  	 			sql = sql + " AND A.CHR_MODIFICATION ='Y' ";
  	 		
  	 		if("Y".equals(resigned))
  	 			sql = sql + " AND A.CHR_TYPE ='T' ";
  	 		
  	 		sql = sql + " AND  A.INT_OFFICEID IN("+officedata[0][0]+" ,0) ";
  	 		if("1".equals(stype))
  	 			sql = sql + " AND( (A.CHR_STAFFNAME LIKE '%"+search.trim()+"%' ) OR (A.CHR_EMPID LIKE '%"+search.trim()+"' )  )";
  	 		else if("2".equals(stype))
  	 		{
  	 			if(!"0".equals(search))
  	 				sql = sql + " AND A.CHR_STAFFNAME LIKE '"+search.trim()+"%'  ";
  	 		}
  	 		if("N".equals(orderdata[0][0]))
  	 			sql = sql+" GROUP BY A.CHR_EMPID  ORDER BY A.CHR_STAFFNAME ";
  	 		else
  	 			sql = sql+" GROUP BY A.CHR_EMPID   ORDER BY A.CHR_EMPID ";
  	 		sql = sql + " LIMIT 100 ";
  	 		
  	 		System.out.println(sql);
		  	String readData[][]=  CommonFunctions.QueryExecute(sql);
	 			if(readData.length>0)
	 			{	
	 				StringBuffer sb = new StringBuffer();    	     	
	 				for(int u=0; u<readData.length;u++)
	 				{
	 					sb.append("<Staff>");    	            
	 					sb.append("<StaffId>" +readData[u][0]+ "</StaffId>");
	 					sb.append("<StaffName>" +readData[u][1].toUpperCase() + "</StaffName>");  
	 					sb.append("<BranchName>" +readData[u][2].replaceAll("&", " AND") + "</BranchName>");
	 					sb.append("<DepartName>" +readData[u][3].replaceAll("&", " AND") + "</DepartName>");
	 					sb.append("<DesigName>" +readData[u][4].replaceAll("&", " AND") + "</DesigName>");
	 					sb.append("<Mobile>" +readData[u][5] + "</Mobile>");
	 					sb.append("<Company>" +readData[u][6].replaceAll("&", " AND") + "</Company>");
	 					sb.append("<Termination>" +readData[u][7] + "</Termination>");
	 					sb.append("<MiddleName>" +readData[u][8].replaceAll("&", " AND") + "</MiddleName>");
	 					sb.append("<Usertype>" +officedata[0][1] + "</Usertype>");
	 					sb.append("<Bar>" +readData[u][9] + "</Bar>");
	 					sb.append("<Rejoin>" +readData[u][10] + "</Rejoin>");
	 					sb.append("<Approval>" +readData[u][11] + "</Approval>");
	 					sb.append("<Employee>" +readData[u][12] + "</Employee>");
	 					sb.append("<Modification>" +readData[u][13] + "</Modification>");
	 					sb.append("</Staff>");
	 				}	
	 				response.setContentType("text/xml");
	 				response.setHeader("Cache-Control", "no-cache");
	 				response.getWriter().write("<Staffs>"+sb.toString()+"</Staffs>");
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
  
  
  public static void loadStaff(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
   try 
  	 {
	   		HttpSession session=request.getSession();
	   		String companyId=request.getParameter("companyId");
  	 		String branchId=request.getParameter("branchId");    	 
  	 		String departId=request.getParameter("departId");    	 		
  	 		String desigId=request.getParameter("desigId");
  	 		String startLetter=request.getParameter("startLetter");
  	 		String resigned=request.getParameter("resigned");
  	 		String modified=request.getParameter("modified");
  	 		String asql="";
  	 		String orderdata[][] = CommonFunctions.QueryExecute("SELECT CHR_ORDERBY ,CHR_SHOW_EMPLOYEE FROM m_institution");
  	 		asql = " SELECT CHR_OFFICELIST,CHR_TYPE FROM m_user WHERE CHR_USRNAME='"+session.getAttribute("USRID")+"'";
	 		String officedata[][] = CommonFunctions.QueryExecute(asql);
	 		asql=" SELECT  A.CHR_EMPID,UPPER(A.CHR_STAFFNAME),B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME " ;
  	 		asql = asql+ " , A.CHR_MOBILE  ,E.CHR_COMPANYNAME , A.CHR_TYPE ,A.INT_PROGRESSBAR , ";//(20+FIND_A_PERFORM_STAFFREGISTRATION( A.CHR_EMPID))
  	 		asql = asql+ " A.CHR_APPROVED,A.CHR_EMPLOYEE , A.CHR_MODIFICATION ,A.CHR_STAFFFNAME  ";
  	 		asql = asql+ " from  com_m_staff  A, com_m_branch  B, ";
			asql = asql+ " com_m_depart   C, com_m_desig  D,  com_m_company  E where A.INT_BRANCHID=B.INT_BRANCHID AND " ;
			asql = asql+ "  A.INT_DEPARTID=C.INT_DEPARTID AND A.INT_COMPANYID =  E.INT_COMPANYID AND A.INT_DESIGID=D.INT_DESIGID  ";

			if(!"0".equals(orderdata[0][1]))
	 			if("R".equals(orderdata[0][1]))
	 				asql = asql +" AND A.CHR_EMPLOYEE ='R' ";
	 			else
	 				asql = asql +" AND A.CHR_EMPLOYEE ='N' ";
	 
			if(!"0".equals(companyId))
				asql = asql+ " AND A.INT_COMPANYID=" +companyId;
			if(!"0".equals(branchId))
				asql = asql+ " AND A.INT_BRANCHID=" +branchId;
			if(!"0".equals(departId))
				asql = asql+ " AND A.INT_DEPARTID=" +departId;
			if(!"0".equals(desigId))
				asql = asql+ " AND A.INT_DESIGID=" +desigId;
			
			if(!"Y".equals(resigned))
				asql = asql+ " AND A.CHR_TYPE !='T' ";
			
			if(!"N".equals(modified))
				asql = asql+ " AND A.CHR_MODIFICATION ='Y' ";
			
			asql = asql + " AND  A.INT_OFFICEID IN("+officedata[0][0]+" ,0) ";
	 		if(!"0".equals(startLetter))
				asql = asql+ "  AND CHR_STAFFNAME Like'"+startLetter+"%'  ";
			if("N".equals(orderdata[0][0]))
				asql = asql+ " GROUP BY A.CHR_EMPID    ORDER BY A.CHR_STAFFNAME LIMIT 100 ";
  	 		else
  	 			asql = asql+ "   GROUP BY A.CHR_EMPID  ORDER BY A.CHR_EMPID LIMIT 100 ";

			System.out.println(asql);
		 	String readData[][]= CommonFunctions.QueryExecute(asql);
 			if(readData.length>0)
 			{	
 				StringBuffer sb = new StringBuffer();    	     	
 				for(int u=0; u<readData.length;u++)
 				{
 					sb.append("<Staff>");    	            
 					sb.append("<StaffId>" +readData[u][0]+ "</StaffId>");
 					sb.append("<StaffName>" +readData[u][1] + "</StaffName>");  
 					sb.append("<BranchName>" +readData[u][2].replaceAll("&", " AND") + "</BranchName>");
 					sb.append("<DepartName>" +readData[u][3].replaceAll("&", " AND") + "</DepartName>");
 					sb.append("<DesigName>" +readData[u][4].replaceAll("&", " AND") + "</DesigName>");
 					sb.append("<Mobile>" +readData[u][5] + "</Mobile>");
 					sb.append("<Company>" +readData[u][6].replaceAll("&", " AND") + "</Company>");
 					sb.append("<Termination>" +readData[u][7] + "</Termination>");
 					sb.append("<Usertype>" +officedata[0][1] + "</Usertype>");
 					sb.append("<Bar>" +readData[u][8] + "</Bar>");
 					sb.append("<Approval>" +readData[u][9] + "</Approval>");
 					sb.append("<Employee>" +readData[u][10] + "</Employee>");
 					sb.append("<Modification>" +readData[u][11] + "</Modification>");
 					sb.append("<Father>" +readData[u][12] + "</Father>");
 					sb.append("</Staff>");
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
  
  public static void loadlocation(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
   try 
  	 {
	   		String startLetter = request.getParameter("startLetter");
	   		String officeid = request.getParameter("officeid");
	   		
	   		
	   		String sql =  "  SELECT a.INT_LOCATIONID,a.CHR_LOCATION,b.CHR_OFFICENAME,a.CHR_ACTIVE ";
	   		sql = sql+ " FROM com_m_locations a , com_m_office b  WHERE a.INT_OFFICEID = b.INT_OFFICEID ";
	   		//sql = sql +" AND a.CHR_ACTIVE ='Y' ";
	   		if(!"0".equals(officeid))
	   			sql = sql + "  AND a.INT_OFFICEID = "+officeid;
	   		
	   		if(!"0".equals(startLetter))
     			 sql = sql + "  AND a.CHR_LOCATION LIKE '"+startLetter+"%' ";
     		
	   		sql = sql +" ORDER BY a.CHR_LOCATION  ";
	 		System.out.println(sql);
		  	
	 		String readData[][] =  CommonFunctions.QueryExecute(sql);
	     	StringBuffer sb = new StringBuffer();
	     	for(int u=0; u<readData.length;u++)
	     	{
 				sb.append("<Rows>");    
 				sb.append("<Id>" +readData[u][0]+ "</Id>");
				sb.append("<locationname>" +readData[u][1].replaceAll("&", "AND ")+ "</locationname>");
				sb.append("<Office>" +readData[u][2].replaceAll("&", "AND ") + "</Office>"); 
				sb.append("<active>" +readData[u][3].replaceAll("&", "AND ") + "</active>");  
				sb.append("</Rows>");
	     	}	          

	   		response.setContentType("text/xml");
	   		response.setHeader("Cache-Control", "no-cache");
	   		response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
	   	  		     	 	 
	 	
  	 } 
 	 catch (Exception e) 
 	 {
 		 System.out.println(e.getMessage());
 	 } 
  }
  
  
  public static void loadlocationActive(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
   try 
  	 {
	   		String startLetter = request.getParameter("startLetter");
	   		String officeid = request.getParameter("officeid");
	   		
	   		
	   		String sql =  "  SELECT a.INT_LOCATIONID,a.CHR_LOCATION,b.CHR_OFFICENAME,a.CHR_ACTIVE ";
	   		sql = sql+ " FROM com_m_locations a , com_m_office b  WHERE a.INT_OFFICEID = b.INT_OFFICEID ";
	   		sql = sql +" AND a.CHR_ACTIVE ='Y' ";
	   		if(!"0".equals(officeid))
	   			sql = sql + "  AND a.INT_OFFICEID = "+officeid;
	   		
	   		if(!"0".equals(startLetter))
     			 sql = sql + "  AND a.CHR_LOCATION LIKE '"+startLetter+"%' ";
     		
	   		sql = sql +" ORDER BY a.CHR_LOCATION  ";
	 		System.out.println(sql);
		  	
	 		String readData[][] =  CommonFunctions.QueryExecute(sql);
	     	StringBuffer sb = new StringBuffer();
	     	for(int u=0; u<readData.length;u++)
	     	{
 				sb.append("<Rows>");    
 				sb.append("<Id>" +readData[u][0]+ "</Id>");
				sb.append("<locationname>" +readData[u][1].replaceAll("&", "AND ")+ "</locationname>");
				sb.append("<Office>" +readData[u][2].replaceAll("&", "AND ") + "</Office>"); 
				sb.append("<active>" +readData[u][3].replaceAll("&", "AND ") + "</active>");  
				sb.append("</Rows>");
	     	}	          

	   		response.setContentType("text/xml");
	   		response.setHeader("Cache-Control", "no-cache");
	   		response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
	   	  		     	 	 
	 	
  	 } 
 	 catch (Exception e) 
 	 {
 		 System.out.println(e.getMessage());
 	 } 
  }
  
  
  public static void loadAttendanceCycle(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
   try 
  	 {
	   		String categoryid = request.getParameter("categoryid");
	   		String cdata[][]=CommonFunctions.QueryExecute("SELECT INT_FROM,INT_TO FROM att_m_basicsettings  WHERE INT_ID=1");
  		 	String cy ="";
  		 	if(cdata.length>0)
  		 		cy = cdata[0][0]+"th to "+cdata[0][1]+"th";
  		 	String sql =  "  SELECT INT_ATTENDANCE_CYCLE,if(INT_ATTENDANCE_CYCLE='1','1-31','"+cy+"'),CHR_PFCALCULATIONTYPE,CHR_EMP_TYPE  FROM com_m_employeecategory WHERE INT_EMPLOYEECATEGORYID ="+categoryid;
	   		
		  	String readData[][] =  CommonFunctions.QueryExecute(sql);
	     	StringBuffer sb = new StringBuffer();
	     	for(int u=0; u<readData.length;u++)
	     	{
 				sb.append("<Rows>");    
 				sb.append("<Id>" +readData[u][0]+ "</Id>");
				sb.append("<Cycle>" +readData[u][1]+ "</Cycle>");
				sb.append("<Calculation>"+readData[u][2]+"</Calculation>");
				sb.append("<Employeetype>"+readData[u][3]+"</Employeetype>");
				sb.append("</Rows>");
	     	}	          

	   		response.setContentType("text/xml");
	   		response.setHeader("Cache-Control", "no-cache");
	   		response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
	   	  		     	 	 
	 	
  	 } 
 	 catch (Exception e) 
 	 {
 		 System.out.println(e.getMessage());
 	 } 
  }
  
  public static void loadBank(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
   try 
  	 {
  	 		String search = request.getParameter("str");
	   		String sql =  " SELECT INT_BANKGROUPID,CHR_BANKGROUPNAME,CHR_SHORTNAME FROM com_m_bankgroup";
	   		if(!"0".equals(search))
	   			sql = sql +" WHERE CHR_BANKGROUPNAME LIKE '"+search+"%'";
	   		sql = sql+ " ORDER BY CHR_BANKGROUPNAME";
	 		System.out.println(sql);
		  	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	     	StringBuffer sb = new StringBuffer();
	     	for(int u=0; u<readData.length;u++)
	     	{
 				sb.append("<Rows>");    
 				sb.append("<Id>" +readData[u][0]+ "</Id>");
				sb.append("<Name>" +readData[u][1].replaceAll("&", "AND ")+ "</Name>");
				sb.append("<SName>" +readData[u][2].replaceAll("&", "AND ")+ "</SName>");
				sb.append("</Rows>");
	     	}	          
	   		response.setContentType("text/xml");
	   		response.setHeader("Cache-Control", "no-cache");
	   		response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
  	 } 
 	 catch (Exception e) 
 	 {
 		System.out.println(e.getMessage());
 		request.setAttribute("error", e.getMessage() );
        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
		dispatchers.forward(request, response); 
 	 } 
  }
  
  
  public static void loadBankBranch(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
   try 
  	 {
  	 		String search = request.getParameter("search");
  	 		String bank = request.getParameter("bank");
  	 		String sql =  " SELECT a.INT_BANKBRANCHID,b.CHR_BANKGROUPNAME,b.CHR_SHORTNAME,a.CHR_IFSC,a.CHR_MCR,a.CHR_BRANCHNAME,";
	   		sql = sql +" a.CHR_ADDRESS,a.CHR_CONTACT,a.CHR_CITY,a.CHR_DISTRICT,a.CHR_STATE,a.CHR_COUNRY ";
	   		sql = sql +" FROM com_m_bankbranchname a,com_m_bankgroup b ";
	   		sql = sql +" WHERE a.INT_BANKGROUPID= b.INT_BANKGROUPID ";
	   		if(!"0".equals(bank))
	   			sql = sql +" AND a.INT_BANKGROUPID="+ bank;
	   		if(!"0".equals(search))
	   			sql = sql +" AND a.CHR_BRANCHNAME LIKE '"+search+"%'";
	   		sql = sql+ " ORDER BY a.CHR_BRANCHNAME LIMIT 100";
	   		System.out.println(sql);
		  	String readData[][] =  CommonFunctions.QueryExecute(sql);
	     	StringBuffer sb = new StringBuffer();
	     	for(int u=0; u<readData.length;u++)
	     	{
 				sb.append("<Rows>");    
 				sb.append("<Id>" +readData[u][0]+ "</Id>");
				sb.append("<Name>" +readData[u][1].replaceAll("&", "AND ").replaceAll("<", "")+ "</Name>");
				sb.append("<IFSC>" +readData[u][3].replaceAll("&", "AND ".replaceAll("<", ""))+ "</IFSC>");
				sb.append("<MCR>" +readData[u][4].replaceAll("&", "AND ").replaceAll("<", "")+ "</MCR>");
				sb.append("<BName>" +readData[u][5].replaceAll("&", "AND ").replaceAll("<", "")+ "</BName>");
				sb.append("<Address>" +readData[u][6].replaceAll("&", "AND ").replaceAll("<", "")+ "</Address>");
				sb.append("<Contact>" +readData[u][7].replaceAll("&", "AND ").replaceAll("<", "")+ "</Contact>");
				sb.append("</Rows>");
	     	}	          
	   		response.setContentType("text/xml");
	   		response.setHeader("Cache-Control", "no-cache");
	   		response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
  	 } 
 	 catch (Exception e) 
 	 {
 		System.out.println(e.getMessage());
		request.setAttribute("error", e.getMessage() );
        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
		dispatchers.forward(request, response); 
 	 } 
  }
  
  
  
  public static void  loadBranchData(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
  	 try 
  	 {    		 	
  		 	int id=Integer.parseInt(request.getParameter("id"));
  		 	String sql=null;
  		 	sql="SELECT INT_BRANCHID,CHR_BRANCHNAME, INT_ACTIVE ";
      		sql=sql+"FROM  com_m_branch  WHERE INT_COMPANYID="+id + " ORDER BY CHR_BRANCHNAME " ;
		  	String readData[][] = CommonFunctions.QueryExecute(sql);
  	     	StringBuffer sb = new StringBuffer(); 
  	     	boolean flag = false;
  	     	for(int u=0; u<readData.length;u++)
  	     	{
  	     		  sb.append("<Row>");    	     		
                  sb.append("<id>"+readData[u][0]+"</id>");
                  sb.append("<branchName>"+readData[u][1].replaceAll("&", " AND ")+"</branchName>");
                  sb.append("<Active>"+readData[u][2].replaceAll("&", " AND ")+"</Active>");
                  sb.append("</Row>");
                  flag = true;
  	     	}    	     	
  	     	if (flag) 
  	     	{
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
	
  
  

  public static void loadReportingHead(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
   try 
  	 {
  	 		String search = request.getParameter("search");
  	 		String stype = request.getParameter("stype");
	   		String sql =  " e ";
	   		sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,b.CHR_OFFICENAME,  a.CHR_REPTO , ";
	   		sql = sql +" (SELECT c.CHR_STAFFNAME FROM com_m_staff c WHERE c.CHR_EMPID=a.CHR_REPTO) , a.CHR_TYPE ";
	   		sql = sql +" FROM com_m_staff a, com_m_office b ";
	   		sql = sql +" WHERE  a.INT_OFFICEID= b.INT_OFFICEID ";
	   		if("1".equals(stype))
  	 		{	
	   			if(!"0".equals(search))
  	 				sql = sql + " AND A.CHR_STAFFNAME LIKE '"+search.trim()+"%'  ";
  	 		}
  	 		else if("2".equals(stype))
  	 		{		
  	 			if(!"0".equals(search))
	 				sql = sql + " AND( (A.CHR_STAFFNAME LIKE '%"+search.trim()+"%' ) OR (A.CHR_EMPID LIKE '%"+search.trim()+"' )  )";
  	  	 	}
	   		
	   		 
	   		sql = sql+ " ORDER BY a.CHR_STAFFNAME";
	 		System.out.println(sql);
		  	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	     	StringBuffer sb = new StringBuffer();
	     	for(int u=0; u<readData.length;u++)
	     	{
 				sb.append("<Rows>");    
 				sb.append("<Id>" +readData[u][0]+ "</Id>");
				sb.append("<Name>" +readData[u][1].replaceAll("&", "AND ")+ "</Name>");
				sb.append("<Office>" +readData[u][2].replaceAll("&", "AND ")+ "</Office>");
				sb.append("<Rid>" +readData[u][3].replaceAll("&", "AND ")+ "</Rid>");
				sb.append("<Rname>" +readData[u][4].replaceAll("&", "AND ")+ "</Rname>");
				sb.append("<Rtype>" +readData[u][5].replaceAll("&", "AND ")+ "</Rtype>");
				sb.append("</Rows>");
	     	}	          
	   		response.setContentType("text/xml");
	   		response.setHeader("Cache-Control", "no-cache");
	   		response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
  	 } 
 	 catch (Exception e) 
 	 {
 		 System.out.println(e.getMessage());
 		 request.setAttribute("error", e.getMessage() );
         RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
		 dispatchers.forward(request, response); 
 	 } 
  }
  
  
  public static void StaffRegistrationUnique(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
  {
   try 
  	 {
  	 		String name = request.getParameter("name");
  	 		String fname = request.getParameter("fname");
  	 		String mothername = request.getParameter("mothername");
  	 		String dob = request.getParameter("dob");
  	 		
  	 		 
	   		String sql =  "";
	   		sql = sql+ " SELECT CHR_EMPID,CHR_STAFFNAME,CHR_STAFFFNAME,CHR_MOTHERNAME,DATE_FORMAT(DT_DOB,'%d-%b-%Y') ";
	   		sql = sql+ " FROM com_m_staff ";
	   		sql = sql+ " WHERE CHR_STAFFNAME LIKE '%"+name+"%' ";
	   		sql = sql+ " AND ( ";
	   			sql = sql+ "      ( CHR_STAFFNAME LIKE '%"+name+"%'  )";
	   		if(fname.length()>0)
	   			sql = sql+ "      AND ( CHR_STAFFFNAME LIKE '%"+fname+"%'  )";
	   		if(mothername.length()>0)	
	   			sql = sql+ "      AND ( CHR_MOTHERNAME LIKE '%"+mothername+"%' ) ";
	   		if(dob.length()>0)
	   			sql = sql+ "      AND ( DT_DOB LIKE '%"+DateUtil.FormateDateSQL(dob)+"%' ) ";
	   		sql = sql+ " ) ";
	   		sql = sql+ " ORDER BY CHR_STAFFNAME LIMIT 10";
	 		System.out.println(sql);
		  	String readData[][] = CommonFunctions.QueryExecute(sql);
	     	StringBuffer sb = new StringBuffer();
	     	for(int u=0; u<readData.length;u++)
	     	{
 				sb.append("<Rows>");    
 				sb.append("<Id>" +readData[u][0]+ "</Id>");
				sb.append("<Name>" +readData[u][1].replaceAll("&", "AND ")+ "</Name>");
				sb.append("<Fname>" +readData[u][2].replaceAll("&", "AND ")+ "</Fname>");
				sb.append("<Mname>" +readData[u][3].replaceAll("&", "AND ")+ "</Mname>");
				sb.append("<DOB>" +readData[u][4].replaceAll("&", "AND ")+ "</DOB>");
				sb.append("</Rows>");
	     	}	          
	   		response.setContentType("text/xml");
	   		response.setHeader("Cache-Control", "no-cache");
	   		response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
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
