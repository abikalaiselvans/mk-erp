package com.my.org.erp.SmartSMS;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class SMSMethods 
{

	 public static void LoadCustomerGroup(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	 try 
	    	 {    		 	
	    		String startLetter=request.getParameter("startLetter");
	 	 		String sql="";
	 	 		sql =" SELECT INT_GROUPID,CHR_GROUPNAME,DATE_FORMAT(DAT_REGISTER,'%d-%m-%Y'),CHR_ACTIVE FROM sms_m_customergroup WHERE INT_GROUPID >0 ";
	 	 	 	if(!"0".equals(startLetter))
	 	 			sql = sql + " AND CHR_GROUPNAME LIKE '"+startLetter+"%' ";
	 	 		sql = sql +" ORDER BY CHR_GROUPNAME ";
	 	 		System.out.println(sql);
	 	 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 	 		
	 			if(readData.length>0)
	 	 		{	
	 	 			StringBuffer sb = new StringBuffer();    	     	
	 	 			for(int u=0; u<readData.length;u++)
	 	 			{
		 					sb.append("<Row>");    	            
		 					sb.append("<Id>" +readData[u][0]+ "</Id>");
		 					sb.append("<Name>" +(readData[u][1].toUpperCase()).replaceAll("&", " AND ") + "</Name>");
		 					sb.append("<Date>" +readData[u][2]+ "</Date>");
		 					sb.append("<Active>" +readData[u][3]+ "</Active>");
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
	    
	 
	 
	 public static void LoadCustomerinfos(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	 try 
	    	 {    		 	
	    		String startLetter=request.getParameter("startLetter");
	    		String group=request.getParameter("group");
	    		
	    		String sql="";
	 	 		sql ="  SELECT a.INT_CUSTOMERID,a.CHR_CUSTOMERNAME,a.CHR_COMPANYNAME, a.CHR_ADDRESS1,a.CHR_ADDRESS2,a.CHR_ADDRESS3 , ";
	 	 		sql = sql + " c.CHR_STATENAME,d.CHR_DISTRICT, e.CHR_CITYNAME, a.INT_PINCODE,a.INT_PHONE1,a.INT_MOBILE1,a.CHR_FAX,a.CHR_EMAIL,a.CHR_WEBSITE,   "; 
	 	 		sql = sql + "  a.CHR_ACTIVE, b.CHR_GROUPNAME    ";
	 	 		sql = sql + " FROM sms_m_customerinfo a,sms_m_customergroup  b ,com_m_state c  ,com_m_district d,com_m_city e   ";
	 	 		sql = sql + " WHERE a.INT_GROUPID=b.INT_GROUPID    ";
	 	 		sql = sql + " AND a.INT_STATEID=c.INT_STATEID     ";
	 	 		sql = sql + " AND a.INT_DISTRICTID = d.INT_DISTRICTID   "; 
	 	 		sql = sql + " AND a.INT_CITYID = e.INT_CITYID   ";
	 	 		
	 	 		if(!"0".equals(group))
	 	 			sql = sql + " AND a.INT_GROUPID ="+group;
	 	 		if(!"0".equals(startLetter))
	 	 			sql = sql + " AND a.CHR_CUSTOMERNAME LIKE '"+startLetter+"%' ";
	 	 		sql = sql +" ORDER BY a.INT_CUSTOMERID ";
	 	 		
	 	 		 
	 	 		System.out.println(sql);
	 	 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 	 		
	 			if(readData.length>0)
	 	 		{	
	 	 			StringBuffer sb = new StringBuffer();    	     	
	 	 			for(int u=0; u<readData.length;u++)
	 	 			{
		 					sb.append("<Row>");    	            
		 					sb.append("<Id>" +readData[u][0]+ "</Id>");
		 					sb.append("<Name>" +(readData[u][1].toUpperCase()).replaceAll("&", " AND ") + "</Name>");
		 					sb.append("<CName>" +(readData[u][2].toUpperCase()).replaceAll("&", " AND ") + "</CName>");
		 					sb.append("<Add1>" +(readData[u][3].toUpperCase()).replaceAll("&", " AND ") + "</Add1>");
		 					sb.append("<Add2>" +(readData[u][4].toUpperCase()).replaceAll("&", " AND ") + "</Add2>");
		 					sb.append("<Add3>" +(readData[u][5].toUpperCase()).replaceAll("&", " AND ") + "</Add3>");
		 					sb.append("<State>" +(readData[u][6].toUpperCase()).replaceAll("&", " AND ") + "</State>");
		 					sb.append("<District>" +(readData[u][7].toUpperCase()).replaceAll("&", " AND ") + "</District>");
		 					sb.append("<City>" +(readData[u][8].toUpperCase()).replaceAll("&", " AND ") + "</City>");
		 					sb.append("<Pin>" +(readData[u][9].toUpperCase()).replaceAll("&", " AND ") + "</Pin>");
		 					sb.append("<Phone>" +(readData[u][10].toUpperCase()).replaceAll("&", " AND ") + "</Phone>");
		 					sb.append("<Mobile>" +(readData[u][11].toUpperCase()).replaceAll("&", " AND ") + "</Mobile>");
		 					sb.append("<Fax>" +(readData[u][12].toUpperCase()).replaceAll("&", " AND ") + "</Fax>");
		 					sb.append("<Email>" +(readData[u][13] )+ "</Email>");
		 					sb.append("<Web>" +(readData[u][14].toUpperCase()).replaceAll("&", " AND ") + "</Web>");
		 					sb.append("<GName>" +(readData[u][16].toUpperCase()).replaceAll("&", " AND ") + "</GName>");
		 					sb.append("<Active>" +readData[u][15]+ "</Active>");
		 					sb.append("</Row>");
		 					
		 				}	
	 	 			 
	 	 			sb.toString();
					response.setContentType("text/xml");
					response.setHeader("Cache-Control", "no-cache");
					response.getWriter().write("<Rowss>"+sb.toString()+"</Rowss>");
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
	    
	 
	 public static void LoadMobileContacts(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	 try 
	    	 {    		 	
	    		 	HttpSession session = request.getSession();
	 				String user  = (String) session.getAttribute("USRID");
	 				String startLetter=request.getParameter("startLetter");
	 				String group=request.getParameter("group");
	 				String searchby=request.getParameter("searchby");
	 				
	 				
	 				String usertype=""+session.getAttribute("USRTYPE");
	 				String sql="";
	 	 		

		 	 		sql =" SELECT a.INT_MOBILEID,b.CHR_GROUPNAME,a.CHR_CUSTOMERNAME,a.INT_MOBILENO,a.INT_AGE,a.CHR_CITY,c.CHR_STAFFNAME,a.CHR_EMAIL  ";
		 	 		sql = sql + " FROM  sms_m_mobilecontacts a  , sms_m_mobile_group b ,com_m_staff c";
		 	 		sql = sql + " WHERE a.INT_GROUPID= b.INT_GROUPID AND UPPER(RIGHT(c.CHR_EMPID,6)) = UPPER(a.CHR_USRNAME)";
		 	 		if(!"F".equals(usertype))
		 	 			sql = sql + " UPPER(a.CHR_USRNAME)='"+user.toUpperCase()+"' ";
		 	 		if(!"0".equals(group))
		 	 			sql = sql + " AND a.INT_GROUPID = "+group ;
		 	 		
		 	 		 
		 	 	
		 	 		
		 	 		
	 	 			if(( !"M".equals(searchby) ) && (!"0".equals(startLetter)))
	 	 				sql = sql + " AND a.CHR_CUSTOMERNAME LIKE '"+startLetter+"%' ";
	 	 			else if("M".equals(searchby))
	 	 				sql = sql + " AND a.INT_MOBILENO LIKE '"+startLetter+"%' ";
	 	 			 
	 	 			
	 	 	 
		 	 		 
		 	 		sql = sql +" ORDER BY a.CHR_CUSTOMERNAME ";
		 	 		
		 	 		
	 	 		  
		 	 		System.out.println(sql);
		 	 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 	 		
		 			if(readData.length>0)
		 	 		{	
		 	 			StringBuffer sb = new StringBuffer();    	     	
		 	 			for(int u=0; u<readData.length;u++)
		 	 			{
			 					sb.append("<Row>");    	            
			 					sb.append("<Id>" +readData[u][0]+ "</Id>");
			 					sb.append("<Group>" +readData[u][1].toUpperCase()+ "</Group>");
			 					sb.append("<Name>" +(readData[u][2].toUpperCase())  + "</Name>");
			 					sb.append("<Mobile>" +readData[u][3]+ "</Mobile>");
			 					sb.append("<Age>" +readData[u][4]+ "</Age>");
			 					sb.append("<City>" +readData[u][5].toUpperCase()+ "</City>");
			 					sb.append("<Staff>" +readData[u][6].toUpperCase()+ "</Staff>");
			 					sb.append("<Email>" +readData[u][7].toUpperCase()+ "</Email>");
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
	    
	 
	 public static void loadMobileSearch(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	 try 
	    	 {    		 	
	    		 	HttpSession session = request.getSession();
	 				String user  = (String) session.getAttribute("USRID");
	 				String searchby=request.getParameter("search");
	 				String usertype=""+session.getAttribute("USRTYPE");
		 	 		System.out.println("searchby..."+searchby);

	 				String sql="";
		 	 		sql =" SELECT a.INT_MOBILEID,b.CHR_GROUPNAME,a.CHR_CUSTOMERNAME,a.INT_MOBILENO,a.INT_AGE,a.CHR_CITY,c.CHR_STAFFNAME,a.CHR_EMAIL  ";
		 	 		sql = sql + " FROM  sms_m_mobilecontacts a  , sms_m_mobile_group b ,com_m_staff c";
		 	 		sql = sql + " WHERE a.INT_GROUPID= b.INT_GROUPID AND UPPER(RIGHT(c.CHR_EMPID,6)) = UPPER(a.CHR_USRNAME)";
		 	 		if(!"F".equals(usertype))
		 	 			sql = sql + " UPPER(a.CHR_USRNAME)='"+user.toUpperCase()+"' ";
		 	 		 
	  	 			sql = sql + " AND( (a.CHR_CUSTOMERNAME LIKE '%"+searchby.trim()+"%' ) OR (a.INT_MOBILENO LIKE '%"+searchby.trim()+"%' )  )";
		 	 		sql = sql +" ORDER BY a.CHR_CUSTOMERNAME ";
		 	 		System.out.println("sql..."+sql);
		 	 		System.out.println(sql);
		 	 		String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		 	 		
		 			if(readData.length>0)
		 	 		{	
		 	 			StringBuffer sb = new StringBuffer();    	     	
		 	 			for(int u=0; u<readData.length;u++)
		 	 			{
			 					sb.append("<Row>");    	            
			 					sb.append("<Id>" +readData[u][0]+ "</Id>");
			 					sb.append("<Group>" +readData[u][1].toUpperCase()+ "</Group>");
			 					sb.append("<Name>" +(readData[u][2].toUpperCase())  + "</Name>");
			 					sb.append("<Mobile>" +readData[u][3]+ "</Mobile>");
			 					sb.append("<Age>" +readData[u][4]+ "</Age>");
			 					sb.append("<City>" +readData[u][5].toUpperCase()+ "</City>");
			 					sb.append("<Staff>" +readData[u][6].toUpperCase()+ "</Staff>");
			 					sb.append("<Email>" +readData[u][7].toUpperCase()+ "</Email>");
			 					sb.append("</Row>");
			 				}	
		 	 			sb.toString();
						response.setContentType("text/xml");
						response.setHeader("Cache-Control", "no-cache");
						response.getWriter().write("<Rowm>"+sb.toString()+"</Rowm>");
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
