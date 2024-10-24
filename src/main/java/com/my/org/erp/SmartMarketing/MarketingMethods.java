package com.my.org.erp.SmartMarketing;
 
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.file.FileFunctions;

public class MarketingMethods 
{
	public static void loadDepart(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	  {
	   try 
	  	 {
		   String startLetter=request.getParameter("startLetter");
		   String sql =  "SELECT INT_DEPARTID,CHR_DEPARTNAME,CHR_DESC FROM mkt_m_depart WHERE INT_DEPARTID>=1";
	  	 		if(!"0".equals(startLetter))
	 	 			sql = sql + " AND CHR_DEPARTNAME LIKE '"+startLetter+"%' ";
	 	 		sql = sql +" ORDER BY CHR_DEPARTNAME";
		 		System.out.println(sql);
			  	String readData[][] =  CommonFunctions.QueryExecute(sql);
		     	StringBuffer sb = new StringBuffer();
		     	for(int u=0; u<readData.length;u++)
		     	{
	 				sb.append("<Rows>");    
	 				sb.append("<DepartId>" +readData[u][0]+ "</DepartId>");
					sb.append("<DepartName>" +readData[u][1].replaceAll("&", "AND ")+ "</DepartName>");
					sb.append("</Rows>");
		     	}	          
		   		response.setContentType("text/xml");
		   		response.setHeader("Cache-Control", "no-cache");
		   		response.getWriter().write("<RowsDepart>" + sb.toString() + "</RowsDepart>");
	  	 } 
	 	 catch (Exception e) 
	 	 {
	 		request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
			System.out.println(e.getMessage());
	 	 } 
	  }
	 
	 public static void loadDesign(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	  {
	   try 
	  	 {
		   String startLetter=request.getParameter("startLetter");
		   String sql =  "SELECT INT_DESIGID,CHR_DESIGNAME,CHR_DESC FROM mkt_m_desig  WHERE INT_DESIGID>=1";
	  	 		if(!"0".equals(startLetter))
	 	 			sql = sql + " AND CHR_DESIGNAME LIKE '"+startLetter+"%' ";
	 	 		sql = sql +" ORDER BY CHR_DESIGNAME ";
		 		System.out.println(sql);
			  	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		     	StringBuffer sb = new StringBuffer();
		     	for(int u=0; u<readData.length;u++)
		     	{
	 				sb.append("<Rows>");    
	 				sb.append("<DesignId>" +readData[u][0]+ "</DesignId>");
					sb.append("<DesignName>" +readData[u][1].replaceAll("&", "AND ")+ "</DesignName>");
					sb.append("</Rows>");
		     	}	          
		   		response.setContentType("text/xml");
		   		response.setHeader("Cache-Control", "no-cache");
		   		response.getWriter().write("<RowsD>" + sb.toString() + "</RowsD>");
	  	 } 
	 	 catch (Exception e) 
	 	 {
	 		request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
			System.out.println(e.getMessage());
	 	 } 
	  }




	 public static void LoadCustomerGroup(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	 try 
	    	 {    		 	
	    		String startLetter=request.getParameter("startLetter");
	 	 		String sql="";
	 	 		sql =" SELECT INT_GROUPID,CHR_GROUPNAME,DATE_FORMAT(DAT_REGISTER,'%d-%m-%Y'),CHR_ACTIVE FROM mkt_m_customergroup WHERE INT_GROUPID>=1 ";
	 	 	 	if(!"0".equals(startLetter))
	 	 			sql = sql + " AND CHR_GROUPNAME LIKE '"+startLetter+"%' ";
	 	 		sql = sql +" ORDER BY CHR_GROUPNAME ";
	 	 		String readData[][] =CommonFunctions.QueryExecute(sql);
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
		 		request.setAttribute("error", e.getMessage());
		 		RequestDispatcher dispatchers = request	.getRequestDispatcher("/error/index.jsp");
		 		dispatchers.forward(request, response);
	    	 } 
	    }	
	    

	 	public static void LoadCustomerName(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	  try 
	    	  {
	    		   	HttpSession session = request.getSession();
					String usertype  = (""+session.getAttribute("USERTYPE")).toUpperCase();
					String userid  = (""+session.getAttribute("USRID")).toUpperCase();
					String StartLetter = "" + request.getParameter("startLetter");
	    			String status = "" + request.getParameter("status");
	    			String division = "" + request.getParameter("division");
	    			String sql = "";
	    			sql = " SELECT INT_CUSTOMERNAMEID,UPPER(CHR_NAME),UPPER(CHR_SHORT),CHR_VERIFY,FUN_INV_DIVISION(INT_DIVIID),FIND_A_EMPLOYEE_ID_NAME_BY_USERID(CHR_USRNAME)   FROM mkt_m_customername ";
	    			sql = sql + "    WHERE INT_CUSTOMERNAMEID >0 ";
	    			if (!"0".equals(status))
	    				sql = sql + " AND  CHR_VERIFY = '" + status + "'";
	    			if (!"0".equals(division))
	    				sql = sql + " AND  INT_DIVIID =  " + division ;
	    			if (!"0".equals(StartLetter))
	    				sql = sql + " AND  CHR_NAME LIKE '" + StartLetter + "%'";
	    			/*if(  !("F".equals(usertype) || "B".equals(usertype))  )
	    				sql = sql + " AND  CHR_USRNAME = '"+userid+"' ";
	    			*/
	    			sql = sql + " ORDER BY CHR_NAME ";
    				String readData[][] = CommonFunctions.QueryExecute(sql);
    				StringBuffer sb = new StringBuffer();
    				if (readData.length > 0) 
    				{
    					System.out.println(sql);
    					for (int u = 0; u < readData.length; u++) 
    					{
    						sb.append("<Row>");
    						sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
    						sb.append("<Name>"	+ readData[u][1].trim().replaceAll("&", " AND ") + "</Name>");
    						sb.append("<Short>"	+ readData[u][2].trim().replaceAll("&", " AND ") + "</Short>");
    						sb.append("<Verify>"	+ readData[u][3].trim().replaceAll("&", " AND ") + "</Verify>");
    						sb.append("<Division>"	+ readData[u][4].trim().replaceAll("&", " AND ") + "</Division>");
    						sb.append("<Entryby>"	+ readData[u][5].trim().replaceAll("&", " AND ") + "</Entryby>");
    						sb.append("<usertype>" +usertype+ "</usertype>");
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
	    			request.setAttribute("error", e.getMessage());
	    			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    			dispatchers.forward(request, response);
   			  }
	  	    }	
	    
	 	public static void LoadCustomerContactPerson(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	  try 
	    	  {
	    		    
					String customer = "" + request.getParameter("customer");
	    			String sql = "";
	    			sql = " SELECT  a.INT_CUSTOMERID,UPPER(a.CHR_ALIAS),UPPER(a.CHR_ALIAS1) ,UPPER(a.CHR_CONTACTPERSON),UPPER(a.CHR_CONTACTPERSON1),a.INT_MOBILE1 ,b.INT_DIVIID, a.CHR_DESIGINATION1,a.CHR_DESIGINATION2,a.INT_PHONE1 ";
	    			sql = sql + " FROM mkt_m_customerinfo  a, mkt_m_customername b WHERE a.INT_CUSTOMERNAMEID = b.INT_CUSTOMERNAMEID ";
	    			sql = sql + "  AND a.INT_CUSTOMERID = "+customer;
	    			String readData[][] = CommonFunctions.QueryExecute(sql);
    				StringBuffer sb = new StringBuffer();
    				if (readData.length > 0) 
    				{
    					System.out.println(sql);
    					for (int u = 0; u < readData.length; u++) 
    					{
    						sb.append("<Row>");
    						sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
    						sb.append("<dept1>"	+ readData[u][1].trim().replaceAll("&", " AND ") + "</dept1>");
    						sb.append("<dept2>"	+ readData[u][2].trim().replaceAll("&", " AND ") + "</dept2>");
    						sb.append("<contact1>"	+ readData[u][3].trim().replaceAll("&", " AND ") + "</contact1>");
    						sb.append("<contact2>"	+ readData[u][4].trim().replaceAll("&", " AND ") + "</contact2>");
    						sb.append("<Mobile>" + readData[u][5].trim() + "</Mobile>");
    						sb.append("<Division>" + readData[u][6].trim() + "</Division>");
    						sb.append("<Desigination1>" + readData[u][7].trim() + "</Desigination1>");
    						sb.append("<Desigination2>" + readData[u][8].trim() + "</Desigination2>");
    						sb.append("<Phone1>" + readData[u][9].trim() + "</Phone1>");
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
	    			request.setAttribute("error", e.getMessage());
	    			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    			dispatchers.forward(request, response);
   			  }
	  	    }	
	    
	 	public static void LoadCustomerNameAddress(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	  try 
	    	  {
	    			String customername = "" + request.getParameter("customername");
	    			String sql = "";
	    			sql = sql + " SELECT a.INT_CUSTOMERID,b.CHR_NAME, a.CHR_ADDRESS1,c.CHR_CITYNAME,a.INT_PINCODE ";  
	    			sql = sql + " FROM mkt_m_customerinfo a, mkt_m_customername b  ,com_m_city c ";
	    			sql = sql + " WHERE a.INT_CUSTOMERNAMEID =b.INT_CUSTOMERNAMEID AND   a.INT_CITYID =c.INT_CITYID ";
	    			sql = sql + " AND  a.CHR_VERIFY != 'R' ";  
	    			if (!"0".equals(customername))
	    				sql = sql + " AND  a.INT_CUSTOMERNAMEID =  " + customername ;
	    			sql = sql + "  ORDER BY b.CHR_NAME ";
	    			System.out.println(sql);
    				String readData[][] = CommonFunctions.QueryExecute(sql);
    				StringBuffer sb = new StringBuffer();
    				if (readData.length > 0) 
    				{
    					for (int u = 0; u < readData.length; u++) 
    					{
    						sb.append("<Row>");
    						sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
    						sb.append("<Name>"	+ readData[u][1].trim().replaceAll("&", " AND ") + "</Name>");
    						sb.append("<Address1>"	+ readData[u][2].trim().replaceAll("&", " AND ") + "</Address1>");
    						sb.append("<City>"	+ readData[u][3].trim().replaceAll("&", " AND ") + "</City>");
    						sb.append("<Pincode>"	+ readData[u][4].trim().replaceAll("&", " AND ") + "</Pincode>");
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
	    			request.setAttribute("error", e.getMessage());
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
	    		String active=request.getParameter("active");
	    		String verified=request.getParameter("verified");
	    		String account=request.getParameter("account");
	    		String division=request.getParameter("division");
	    		String me=request.getParameter("me");
	    		HttpSession session = request.getSession();
				String usertype  = (""+session.getAttribute("USERTYPE")).toUpperCase();
				String empid  = (""+session.getAttribute("EMPID")).toUpperCase();
				 
				String datad[] = CommonFunctions.getReportingEmployeeIds(empid);
 				String ids=" AND a.CHR_HOLDER IN ( '"+empid+"',";
 				for(int u=0;u<datad.length;u++)
 					ids = ids +"'"+datad[u]+"' , ";
 				ids = ids +" '0'  )";
 				
				String sql="";
				sql ="  SELECT a.INT_CUSTOMERID,a.CHR_CONTACTPERSON,f.CHR_NAME, a.CHR_ADDRESS1,a.CHR_ADDRESS2,a.CHR_ADDRESS3 , ";
	 	 		sql = sql + " c.CHR_STATENAME,d.CHR_DISTRICT, e.CHR_CITYNAME, a.INT_PINCODE,a.INT_PHONE1,a.INT_MOBILE1,a.CHR_FAX,a.CHR_EMAIL,a.CHR_WEBSITE,   "; 
	 	 		sql = sql + "  a.CHR_ACTIVE, b.CHR_GROUPNAME ,FIND_A_EMPLOYEE_ID_NAME(a.CHR_CREATEDBY),a.CHR_VERIFY ,FIND_A_EMPLOYEE_ID_NAME(a.CHR_HOLDER )  ";
	 	 		sql = sql + " FROM mkt_m_customerinfo a,mkt_m_customergroup  b ,com_m_state c  , ";
	 	 		sql = sql + "  com_m_district d,com_m_city e , mkt_m_customername f  ";
	 	 		sql = sql + " WHERE a.INT_GROUPID=b.INT_GROUPID    ";
	 	 		sql = sql + " AND a.INT_STATEID=c.INT_STATEID     ";
	 	 		sql = sql + " AND a.INT_DISTRICTID = d.INT_DISTRICTID   "; 
	 	 		sql = sql + " AND a.INT_CITYID = e.INT_CITYID   ";
	 	 		sql = sql + " AND a.INT_CUSTOMERNAMEID = f.INT_CUSTOMERNAMEID ";
	 	 		if(!"F".equals(usertype))
 	 				sql = sql + ids;
	 	 		if(!"0".equals(active))
	 	 			sql = sql + " AND a.CHR_ACTIVE = '"+active+"' ";
	 	 		
	 	 		if(!"0".equals(verified))
	 	 			sql = sql + " AND a.CHR_VERIFY = '"+verified+"' ";
	 	 		if(!"0".equals(group))
	 	 			sql = sql + " AND a.INT_GROUPID ="+group;
	 	 		if(!"0".equals(account))
	 	 			sql = sql + " AND a.INT_CUSTOMERNAMEID ="+account;
	 	 		if(!"0".equals(division))
	 	 			sql = sql + " AND f.INT_DIVIID ="+division;
	 	 		if(!"0".equals(me))
	 	 			sql = sql + " AND a.CHR_HOLDER = '"+me+"' ";
	 	 		if(!"0".equals(startLetter))
	 	 			sql = sql + " AND f.CHR_NAME LIKE '"+startLetter+"%' ";
	 	 		sql = sql +" ORDER BY f.CHR_NAME ";
	 	 		System.out.println("==============="+sql);
	 	 		String readData[][] =CommonFunctions.QueryExecute(sql);
	 			if(readData.length>0)
	 	 		{	
	 	 			StringBuffer sb = new StringBuffer();    	     	
	 	 			for(int u=0; u<readData.length;u++)
	 	 			{
		 					sb.append("<Row>");    	            
		 					sb.append("<Id>" +readData[u][0].trim().toString()+ "</Id>");
		 					sb.append("<Name>" +(readData[u][1].trim().toUpperCase()).replaceAll("&", " AND ").toString() + "</Name>");
		 					sb.append("<CName>" +(readData[u][2].trim().toUpperCase()).replaceAll("&", " AND ").toString() + "</CName>");
		 					sb.append("<Add1>" +(readData[u][3].trim().toUpperCase()).replaceAll("&", " AND ").toString() + "</Add1>");
		 					sb.append("<Add2>" +(readData[u][4].trim().toUpperCase()).replaceAll("&", " AND ").toString() + "</Add2>");
		 					sb.append("<Add3>" +(readData[u][5].trim().toUpperCase()).replaceAll("&", " AND ").toString() + "</Add3>");
		 					sb.append("<State>" +(readData[u][6].trim().toUpperCase()).replaceAll("&", " AND ").toString() + "</State>");
		 					sb.append("<District>" +(readData[u][7].trim().toUpperCase()).replaceAll("&", " AND ").toString() + "</District>");
		 					sb.append("<City>" +(readData[u][8].trim().toUpperCase()).replaceAll("&", " AND ").toString() + "</City>");
		 					sb.append("<Pin>" +(readData[u][9].trim().toUpperCase()).replaceAll("&", " AND ").toString() + "</Pin>");
		 					sb.append("<Phone>" +(readData[u][10].trim().toUpperCase()).replaceAll("&", " AND ").toString() + "</Phone>");
		 					sb.append("<Mobile>" +(readData[u][11].trim().toUpperCase()).replaceAll("&", " AND ").toString() + "</Mobile>");
		 					sb.append("<Fax>" +(readData[u][12].trim().toUpperCase()).replaceAll("&", " AND ").toString() + "</Fax>");
		 					//sb.append("<Email>" +(readData[u][13] )+ "</Email>");
		 					sb.append("<Web>" +(readData[u][14].trim().toUpperCase()).replaceAll("&", " AND ").toString() + "</Web>");
		 					sb.append("<Active>" +readData[u][15].trim().toString()+ "</Active>");
		 					sb.append("<verified>" +readData[u][18].trim().toString()+ "</verified>");
		 					sb.append("<usertype>" +usertype+ "</usertype>");
		 					sb.append("<GName>" +(readData[u][16].trim().toUpperCase()).replaceAll("&", " AND ").toString() + "</GName>");
		 					sb.append("<Createdby>" +readData[u][17].trim().toString()+ "</Createdby>");
		 					sb.append("<Handle>" +readData[u][19].trim().toString()+ "</Handle>");
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
		 		request.setAttribute("error", e.getMessage());
		 		RequestDispatcher dispatchers = request	.getRequestDispatcher("/error/index.jsp");
		 		dispatchers.forward(request, response);
	    	 } 
	    }	
	    
	 
	 public static void LoadStage(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	 try 
	    	 {    		 	
	    		String startLetter=request.getParameter("startLetter");
	 	 		String sql="";
	 	 		sql =" SELECT INT_STAGEID,CHR_STAGENAME,INT_PERCENTAGE,CHR_STATUS,CHR_COLORVALUE FROM mkt_m_stage WHERE INT_STAGEID>=1 ";
	 	 	 	if(!"0".equals(startLetter))
	 	 			sql = sql + " AND CHR_STAGENAME LIKE '"+startLetter+"%' ";
	 	 		sql = sql +" ORDER BY CHR_STAGENAME ";
	 	 		String readData[][] =CommonFunctions.QueryExecute(sql);
	 			if(readData.length>0)
	 	 		{	
	 	 			StringBuffer sb = new StringBuffer();    	     	
	 	 			for(int u=0; u<readData.length;u++)
	 	 			{
		 					sb.append("<Row>");    	            
		 					sb.append("<Id>" +readData[u][0]+ "</Id>");
		 					sb.append("<Name>" +(readData[u][1].toUpperCase()).replaceAll("&", " AND ") + "</Name>");
		 					sb.append("<Percentage>" +readData[u][2]+ "</Percentage>");
		 					sb.append("<Active>" +readData[u][3]+ "</Active>");
		 					sb.append("<Color>" +readData[u][4]+ "</Color>");
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
		 		request.setAttribute("error", e.getMessage());
		 		RequestDispatcher dispatchers = request	.getRequestDispatcher("/error/index.jsp");
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
		 	 		sql = sql + " FROM  mkt_m_mobilecontacts a  , mkt_m_mobile_group b ,com_m_staff c";
		 	 		sql = sql + " WHERE a.INT_GROUPID= b.INT_GROUPID AND UPPER(RIGHT(c.CHR_EMPID,6)) = UPPER(a.CHR_USRNAME)";
		 	 		if(!"F".equals(usertype))
		 	 			sql = sql + " UPPER(a.CHR_USRNAME)='"+user.toUpperCase()+"' ";
		 	 		if(!"0".equals(group))
		 	 			sql = sql + " AND a.INT_GROUPID = "+group ;
		 	 		if(!"0".equals(startLetter))
			 	 		sql = sql + " AND( ( a.CHR_CUSTOMERNAME LIKE '%"+startLetter.trim()+"%' ) OR ( a.INT_MOBILENO LIKE '%"+startLetter.trim()+"%' )  )";
		 	 		if(!"0".equals(searchby))
			 	 		sql = sql + " AND( ( a.CHR_CUSTOMERNAME LIKE '%"+searchby.trim()+"%' ) OR ( a.INT_MOBILENO LIKE '%"+searchby.trim()+"%' )  )";
		 	 		sql = sql +" ORDER BY a.CHR_CUSTOMERNAME ";
		 	 		String readData[][] = CommonFunctions.QueryExecute(sql);
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
	 			request.setAttribute("error", e.getMessage());
	 			RequestDispatcher dispatchers = request	.getRequestDispatcher("/error/index.jsp");
	 			dispatchers.forward(request, response);
	    	 } 
	    }	
	    
	 
	 
	 
	 
	 
	 public static void LoadScheduleEntry(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	 try 
	    	 {    		 	
	    		String startLetter=request.getParameter("startLetter");
	    		String day=request.getParameter("day");
	    		String month=request.getParameter("month");
	    		String year=request.getParameter("year");
	    		HttpSession session = request.getSession();
	    		String userid = (String) session.getAttribute("USRID");
	 	 		String sql="";
	 	 		sql = " SELECT  a.INT_SCHEDULEID,c.CHR_NAME, a.CHR_TITLE , DATE_FORMAT(a.DAT_START,'%W %d-%b-%Y %H:%i:%s  %p'),  DATE_FORMAT(a.DAT_END,'%W %d-%b-%Y %H:%i:%s  %p'),'',a.CHR_ALLDAY  ";  
	 	 		sql = sql + " FROM mkt_t_schedule  a , mkt_m_customerinfo b ,mkt_m_customername c ";
	 	 		sql = sql + " WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID AND b.INT_CUSTOMERNAMEID =c.INT_CUSTOMERNAMEID ";
	 	 		sql = sql + " AND a.CHR_EMPID='"+userid+"'   ";
	 	 		if(!"0".equals(day))
	 	 			sql = sql+ " AND DAY(a.DAT_START)="+day;
	 	 		if(!"0".equals(month))
	 	 			sql = sql+ " AND MONTH(a.DAT_START)="+month;
	 	 		if(!"0".equals(year))
	 	 			sql = sql+ " AND YEAR(a.DAT_START)="+year;
	 	 		if(!"0".equals(startLetter))
	 	 			sql = sql + " AND a.CHR_TITLE LIKE '"+startLetter+"%' ";
	 	 		sql = sql +" ORDER BY a.CHR_TITLE ";
	 	 		
	 	 		System.out.println(sql);
	 	 		String readData[][] =  CommonFunctions.QueryExecute(sql);
	 	 		if(readData.length>0)
	 	 		{	
	 	 			StringBuffer sb = new StringBuffer();    	     	
	 	 			for(int u=0; u<readData.length;u++)
	 	 			{
		 					sb.append("<Row>");    	            
		 					sb.append("<Id>" +readData[u][0]+ "</Id>");
		 					sb.append("<Name>" +readData[u][1]+ "</Name>");
							sb.append("<Title>" +readData[u][2]+ "</Title>");
		 					sb.append("<SDate>" +readData[u][3]+ "</SDate>");
		 					sb.append("<EDate>" +readData[u][4]+ "</EDate>");
		 					sb.append("<Diff>" +readData[u][5]+ "</Diff>");
		 					sb.append("<Allday>" +readData[u][6]+ "</Allday>");
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
		 		request.setAttribute("error", e.getMessage());
		 		RequestDispatcher dispatchers = request	.getRequestDispatcher("/error/index.jsp");
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
	 				System.out.println(searchby+"searchby");
	 				String usertype=""+session.getAttribute("USRTYPE");
	 				String sql="";
		 	 		sql =" SELECT a.INT_MOBILEID,b.CHR_GROUPNAME,a.CHR_CUSTOMERNAME,a.INT_MOBILENO,a.INT_AGE,a.CHR_CITY,c.CHR_STAFFNAME,a.CHR_EMAIL  ";
		 	 		sql = sql + " FROM  mkt_m_mobilecontacts a  , mkt_m_mobile_group b ,com_m_staff c";
		 	 		sql = sql + " WHERE a.INT_GROUPID= b.INT_GROUPID AND UPPER(RIGHT(c.CHR_EMPID,6)) = UPPER(a.CHR_USRNAME)";
		 	 		if(!"F".equals(usertype))
		 	 			sql = sql + " UPPER(a.CHR_USRNAME)='"+user.toUpperCase()+"' ";
		 	 		 
		 	 		if(!"0".equals(searchby))
			 	 		sql = sql + " AND( ( a.CHR_CUSTOMERNAME LIKE '%"+searchby.trim()+"%' ) OR ( a.INT_MOBILENO LIKE '%"+searchby.trim()+"%' )  )";
					
		 	 		sql = sql +" ORDER BY a.CHR_CUSTOMERNAME ";
		 	 		
		 	 		System.out.println("sql.."+sql); 
		 	 		String readData[][] =  CommonFunctions.QueryExecute(sql);
		 	 		
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
						response.getWriter().write("<RowM>"+sb.toString()+"</RowM>");
			 			} 
		 	 		else 
		 	 		{
		 	     	response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		 	 		}	
    	 } 
	    	 catch (Exception e) 
	    	 {
	    		 	System.out.println(e.getMessage());
		 			request.setAttribute("error", e.getMessage());
		 			RequestDispatcher dispatchers = request	.getRequestDispatcher("/error/index.jsp");
		 			dispatchers.forward(request, response);
	    	 } 
	    }	
	 
	 
	 
	 	public static void loadCallSearch(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	 try 
	    	 {    		 	
	    		String startLetter=request.getParameter("startLetter");
	 	 		String sql="";
	 	 		sql =" SELECT INT_CALLTYPEID,UPPER(CHR_CALLTYPE),CHR_DESC FROM mkt_k_calltype WHERE INT_CALLTYPEID>=1 ";
	 	 	 	if(!"0".equals(startLetter))
	 	 			sql = sql + " AND CHR_CALLTYPE LIKE '"+startLetter+"%' ";
	 	 		sql = sql +" ORDER BY CHR_CALLTYPE ";
	 	 		System.out.println(sql); 
	 	 		String readData[][] =  CommonFunctions.QueryExecute(sql);
	 	 		
	 			if(readData.length>0)
	 	 		{	
	 	 			StringBuffer sb = new StringBuffer();    	     	
	 	 			for(int u=0; u<readData.length;u++)
	 	 			{
		 					sb.append("<Row>");    	            
		 					sb.append("<CallId>" +readData[u][0]+ "</CallId>");
		 					sb.append("<CallName>" +readData[u][1].replaceAll("&", " AND ")+ "</CallName>");
		 					sb.append("<Desc>" +readData[u][2].replaceAll("&", " AND ")+ "</Desc>");
		 					sb.append("</Row>");
		 				}	
	 	 			sb.toString();
					response.setContentType("text/xml");
					response.setHeader("Cache-Control", "no-cache");
					response.getWriter().write("<CallRows>"+sb.toString()+"</CallRows>");
		 		} 
	 	 		else 
	 	 		{
	 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	 	 		}	
	    	 } 
	    	 catch (Exception e) 
	    	 {
	    		System.out.println(e.getMessage());
	 			request.setAttribute("error", e.getMessage());
	 			RequestDispatcher dispatchers = request	.getRequestDispatcher("/error/index.jsp");
	 			dispatchers.forward(request, response);
	    	 } 
	    }	
	    

	 
	 	
	 public static void LoadScheduleEntrystaff1(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	 try 
	    	 {    		 	
	    		String startLetter=request.getParameter("startLetter");
	    		String day=request.getParameter("day");
	    		String month=request.getParameter("month");
	    		String year=request.getParameter("year");
	    		String customer=request.getParameter("customer");
	    		
	    		HttpSession session = request.getSession();
	    		String userid = (String) session.getAttribute("USRID");
	 	 		String sql="";
	 	 		sql = " SELECT  a.INT_CALLID, b.CHR_CUSTOMERNAME,a.CHR_NEWCALL,a.CHR_NAME, DATE_FORMAT(a.DAT_START,'%W %d-%b-%Y %H:%i:%s  %p'),  DATE_FORMAT(a.DAT_END,'%W %d-%b-%Y %H:%i:%s  %p'),a.CHR_STATUS,a.CHR_NEXT  ";  
	 	 		sql = sql + " FROM mkt_t_daillycalls a , mkt_m_customerinfo b    ";
	 	 		sql = sql + " WHERE  a.INT_CUSTOMERID = b.INT_CUSTOMERID  ";
	 	 		sql = sql + " AND  a.CHR_EMPID='"+userid+"'   ";
	 	 		if(!"0".equals(day))
	 	 			sql = sql+ " AND DAY( a.DAT_START)="+day;
	 	 		if(!"0".equals(month))
	 	 			sql = sql+ " AND MONTH( a.DAT_START)="+month;
	 	 		if(!"0".equals(year))
	 	 			sql = sql+ " AND YEAR( a.DAT_START)="+year;
	 	 		if(!"0".equals(customer))
	 	 			sql = sql+ " AND  a.INT_CUSTOMERID="+customer;
	 	 		if(!"0".equals(startLetter))
	 	 			sql = sql + " AND  a.CHR_NAME LIKE '"+startLetter+"%' ";
	 	 		sql = sql +" ORDER BY  a.DAT_START  ";
	 	 		System.out.println("sql..."+sql);
	 	 		String readData[][] = CommonFunctions.QueryExecute(sql);
	 	 		if(readData.length>0)
	 	 		{	
	 	 			StringBuffer sb = new StringBuffer(); 
	 	 			for(int u=0; u<readData.length;u++)
	 	 			{
	 	 					sb.append("<Row>");    	            
		 					sb.append("<Id>" +readData[u][0]+ "</Id>");
		 					sb.append("<Name>" +readData[u][1]+ "</Name>");
		 					sb.append("<Calltype>" +readData[u][2]+ "</Calltype>");
		 					sb.append("<Agenda>" +readData[u][3]+ "</Agenda>");
		 					sb.append("<SDate>" +readData[u][4]+ "</SDate>");
		 					sb.append("<EDate>" +readData[u][5]+ "</EDate>");
		 					sb.append("<Status>" +readData[u][6]+ "</Status>");
		 					sb.append("<Next>" +readData[u][7]+ "</Next>");
		 					sb.append("</Row>");
		 					
		 			}	
	 	 			sb.toString();
					response.setContentType("text/xml");
					response.setHeader("Cache-Control", "no-cache");
					response.getWriter().write("<RowS>"+sb.toString()+"</RowS>");
		 		} 
	 	 		else 
	 	 		{
	 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	 	 		}	
	    	 } 
	    	 catch (Exception e) 
	    	 {
	    		System.out.println(e.getMessage());
	 			request.setAttribute("error", e.getMessage());
	 			RequestDispatcher dispatchers = request	.getRequestDispatcher("/error/index.jsp");
	 			dispatchers.forward(request, response); 	
	    	 } 
	    }	
	 
	 
	 @SuppressWarnings("deprecation")
	public static void LoadDaillyCalls(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	 try 
	    	 {    		 	
	    		String startLetter=request.getParameter("startLetter");
	    		String day=request.getParameter("day");
	    		String me=request.getParameter("me");
	    		String month=request.getParameter("month");
	    		String year=request.getParameter("year");
	    		String customer=request.getParameter("customer");
	    		String calltype=request.getParameter("calltype");
	    		String status=request.getParameter("status");
	    		HttpSession session = request.getSession();
	    		String usertype  = (""+session.getAttribute("USERTYPE")).toUpperCase();
	    		String empid  = (""+session.getAttribute("EMPID")).toUpperCase();
	 	 		String sql="";
	 	 		sql = " SELECT  a.INT_CALLID,d.CHR_NAME,c.CHR_CALLTYPE,   ";
	 	 		sql = sql+ " DATE_FORMAT(a.DAT_START,'%d-%b-%Y'),  ";// %p
	 	 		sql = sql+ " DATE_FORMAT(a.DAT_START,'%H:%i:%s'), DATE_FORMAT(a.DAT_END,'%H:%i:%s'),  ";
	 	 		sql = sql + " a.CHR_STATUS,";
	 	 		sql = sql + " a.CHR_NEXT,DATE_FORMAT(a.DAT_FOLLOWON,'%d-%b-%Y %h:%m:%s' ) , ";
	 	 		sql = sql + " FIND_A_EMPLOYEE_NAME(a.CHR_EMPID), ";
	 	 		sql = sql + " a.CHR_ADDEDTO_FUNNEL, b.CHR_VERIFY , ";
	 	 		sql = sql + " TIME_FORMAT(TIMEDIFF(a.DAT_END,a.DAT_START),'%H:%i:%s')  age,a.CHR_QUOTATION_ASSIGN,a.CHR_QUOTATION, ";
	 	 		sql = sql + " MKT_FUN_GET_NOOFVISIT_PERCALL(a.CHR_TRANSACTIONID) ";
	 	 		sql = sql + " FROM mkt_t_daillycalls a,mkt_m_customerinfo b,mkt_k_calltype c, mkt_m_customername d ";
	 	 		sql = sql + " WHERE  a.INT_CALLID >0 AND a.INT_CUSTOMERID=b.INT_CUSTOMERID AND a.CHR_CALLTYPE=c.INT_CALLTYPEID ";
	 	 		sql = sql + " AND  b.INT_CUSTOMERNAMEID =d.INT_CUSTOMERNAMEID " ;
	 	 		if(!"0".equals(me))
	 	 			sql = sql + " AND a.CHR_EMPID ='"+me+"'";
	 	 		else
	 	 		{
	 	 			if(!"F".equals(usertype))
	 	 			{
	 	 				String datad[] = CommonFunctions.getReportingEmployeeIds(empid);
	 	 				String ids=" AND a.CHR_EMPID IN ( '"+empid+"',";
	 	 				for(int u=0;u<datad.length;u++)
	 	 					ids = ids +"'"+datad[u]+"' , ";
	 	 				ids = ids +" '0'  )";
	 	 				sql = sql + ids;
	 	 			}	
	 	 		}
	 	 		
	 	 		if(!"0".equals(calltype))
	 	 			sql = sql+ " AND a.CHR_CALLTYPE="+calltype;
	 	 		if(!"0".equals(day))
	 	 			sql = sql+ " AND DAY(a.DAT_START)="+day;
	 	 		if(!"0".equals(month))
	 	 			sql = sql+ " AND MONTH(a.DAT_START)="+month;
	 	 		if(!"0".equals(year))
	 	 			sql = sql+ " AND YEAR(a.DAT_START)="+year;
	 	 		if(!"0".equals(customer))
	 	 			sql = sql+ " AND b.INT_CUSTOMERID="+customer;
	 	 		if(!"0".equals(status))
	 	 			sql = sql+ " AND a.CHR_STATUS = '"+status+"' ";
	 	 		if(!"0".equals(startLetter))
	 	 			sql = sql + " AND d.CHR_NAME LIKE '"+startLetter+"%' ";
	 	 		sql = sql +" ORDER BY   a.DAT_START";
	 	 		System.out.println("------------------"+sql);
	 	 		
	 	 		String readData[][] = CommonFunctions.QueryExecute(sql);
	 	 		String filepath = request.getRealPath("/");
	 	 		if(readData.length>0)
	 	 		{	
	 	 			StringBuffer sb = new StringBuffer(); 
	 	 			for(int u=0; u<readData.length;u++)
	 	 			{
	 	 					sb.append("<Row>");    	            
		 					sb.append("<Id>" +readData[u][0]+ "</Id>");
		 					if(FileFunctions.fileIsThere(filepath+"SFA/"+readData[u][0]+".pdf")) 
		 						sb.append("<F>Y</F>");
		 					else	
		 						sb.append("<F>N</F>");
		 					sb.append("<Name>"+readData[u][1]+"</Name>");
		 					sb.append("<Calltype>" +readData[u][2]+ "</Calltype>");
		 					sb.append("<Calldate>" +readData[u][3]+ "</Calldate>");
		 					sb.append("<SDate>" +readData[u][4]+ "</SDate>");
		 					sb.append("<EDate>" +readData[u][5]+ "</EDate>");
		 					sb.append("<Status>" +readData[u][6]+ "</Status>");
		 					sb.append("<Next>" +readData[u][7]+ "</Next>");
		 					sb.append("<DFollowon>" +readData[u][8]+ "</DFollowon>");
		 					sb.append("<Created>" +readData[u][9]+ "</Created>");
		 					sb.append("<Funnel>" +readData[u][10]+ "</Funnel>");
		 					sb.append("<Cverify>" +readData[u][11]+ "</Cverify>");
		 					sb.append("<Age>" +readData[u][12]+ "</Age>");
		 					sb.append("<Qassign>" +readData[u][13]+ "</Qassign>"); 
		 					sb.append("<Quotation>" +readData[u][14]+ "</Quotation>");
		 					sb.append("<Noofvisit>" +readData[u][15]+ "</Noofvisit>"); 
		 					sb.append("<usertype>" +usertype+ "</usertype>");
		 					sb.append("</Row>");//Calldate
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
	 			request.setAttribute("error", e.getMessage());
	 			RequestDispatcher dispatchers = request	.getRequestDispatcher("/error/index.jsp");
	 			dispatchers.forward(request, response); 
	    	 } 
	    }	
	 
	 
	 
	 public static void LoadQuotationRegardsCustomer(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	  try 
	    	  {
	    		  	String customer = "" + request.getParameter("customer");
	    			String sql = "";//CHR_ASSIGNED='N' AND
	    			sql = " SELECT INT_QUOTATIONID,CHR_QUOTATIONNO,DOU_TOTALAMOUNT from mkt_t_quotation  WHERE   DATEDIFF(NOW(),DAT_CREATIONTIME)<=60 AND  INT_CUSTOMERID = "+customer;
	    			System.out.println(sql);
	    			String readData[][] = CommonFunctions.QueryExecute(sql);
	    			StringBuffer sb = new StringBuffer();
	 				if (readData.length > 0) 
	 				{
	 					for (int u = 0; u < readData.length; u++) 
	 					{
	 						sb.append("<Row>");
	 						sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
	 						sb.append("<Quote>"	+ readData[u][1].trim()+ "</Quote>");
	 						sb.append("<Amount>"	+ readData[u][2].trim()+ "</Amount>");
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
	    			request.setAttribute("error", e.getMessage());
	    			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    			dispatchers.forward(request, response);
			  }
	  	    }	
	    
	 
	 
	 @SuppressWarnings("deprecation")
		public static void LoadMovetoCPO(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
		    {
		    	 try 
		    	 {    		 	
		    		String startLetter=request.getParameter("startLetter");
		    		String day=request.getParameter("day");
		    		String me=request.getParameter("me");
		    		String month=request.getParameter("month");
		    		String year=request.getParameter("year");
		    		String customer=request.getParameter("customer");
		    		String calltype=request.getParameter("calltype");
		    		String status=request.getParameter("status");
		    		HttpSession session = request.getSession();
		    		 
					String empid  = (""+session.getAttribute("EMPID")).toUpperCase();
		 	 		String sql="";
		 	 		sql = " SELECT  a.INT_CALLID,d.CHR_NAME,c.CHR_CALLTYPE,   ";
		 	 		sql = sql + " DATE_FORMAT(a.DAT_START,'%d-%b-%Y'),  ";//%W 
		 	 		sql = sql + " DATE_FORMAT(a.DAT_END,'%d-%b-%Y'),a.CHR_STATUS,";
		 	 		sql = sql + " a.CHR_NEXT,DATE_FORMAT(a.DAT_FOLLOWON,'%d-%b-%Y' ) , ";
		 	 		sql = sql + " FIND_A_EMPLOYEE_NAME(a.CHR_EMPID), ";
		 	 		sql = sql + " a.CHR_ADDEDTO_FUNNEL, b.CHR_VERIFY , ";
		 	 		sql = sql + " DATEDIFF(a.DAT_END , a.DAT_START),a.CHR_QUOTATION_ASSIGN,a.CHR_QUOTATION ";
		 	 		sql = sql + " FROM mkt_t_daillycalls a,mkt_m_customerinfo b,mkt_k_calltype c, mkt_m_customername d ";
		 	 		sql = sql + " WHERE  a.INT_CALLID >0 AND a.INT_CUSTOMERID=b.INT_CUSTOMERID AND a.CHR_CALLTYPE=c.INT_CALLTYPEID ";
		 	 		sql = sql + " AND  b.INT_CUSTOMERNAMEID =d.INT_CUSTOMERNAMEID " ;
		 	 		sql = sql + " AND  a.CHR_CONFIRMATION='Y' ";
		 	 		if(!"0".equals(me))
		 	 			sql = sql + " AND a.CHR_EMPID ='"+me+"'";
		 	 		else
		 	 		{
		 	 			String datad[] = CommonFunctions.getReportingEmployeeIds(empid);
		 				String ids=" AND a.CHR_EMPID IN ( '"+empid+"',";
		 				for(int u=0;u<datad.length;u++)
		 					ids = ids +"'"+datad[u]+"' , ";
		 				ids = ids +" '0'  )";
		 				sql = sql + ids;
		 	 		}
		 	 		
		 	 		if(!"0".equals(calltype))
		 	 			sql = sql+ " AND a.CHR_CALLTYPE="+calltype;
		 	 		if(!"0".equals(day))
		 	 			sql = sql+ " AND DAY(a.DAT_START)="+day;
		 	 		if(!"0".equals(month))
		 	 			sql = sql+ " AND MONTH(a.DAT_START)="+month;
		 	 		if(!"0".equals(year))
		 	 			sql = sql+ " AND YEAR(a.DAT_START)="+year;
		 	 		if(!"0".equals(customer))
		 	 			sql = sql+ " AND b.INT_CUSTOMERID="+customer;
		 	 		if(!"0".equals(status))
		 	 			sql = sql+ " AND a.CHR_STATUS = '"+status+"' ";
		 	 		if(!"0".equals(startLetter))
		 	 			sql = sql + " AND d.CHR_NAME LIKE '"+startLetter+"%' ";
		 	 		sql = sql +" ORDER BY  d.CHR_NAME,a.DAT_START";
		 	 		//System.out.println(sql);
		 	 		
		 	 		String readData[][] = CommonFunctions.QueryExecute(sql);
		 	 		String filepath = request.getRealPath("/");
		 	 		if(readData.length>0)
		 	 		{	
		 	 			StringBuffer sb = new StringBuffer(); 
		 	 			for(int u=0; u<readData.length;u++)
		 	 			{
		 	 					sb.append("<Row>");    	            
			 					sb.append("<Id>" +readData[u][0]+ "</Id>");
			 					if(FileFunctions.fileIsThere(filepath+"SFA/"+readData[u][0]+".pdf")) 
			 						sb.append("<F>Y</F>");
			 					else	
			 						sb.append("<F>N</F>");
			 					sb.append("<Name>"+readData[u][1]+"</Name>");
			 					sb.append("<Calltype>" +readData[u][2]+ "</Calltype>");
			 					sb.append("<SDate>" +readData[u][3]+ "</SDate>");
			 					sb.append("<EDate>" +readData[u][4]+ "</EDate>");
			 					sb.append("<Status>" +readData[u][5]+ "</Status>");
			 					sb.append("<Next>" +readData[u][6]+ "</Next>");
			 					sb.append("<DFollowon>" +readData[u][7]+ "</DFollowon>");
			 					sb.append("<Created>" +readData[u][8]+ "</Created>");
			 					sb.append("<Funnel>" +readData[u][9]+ "</Funnel>");
			 					sb.append("<Cverify>" +readData[u][10]+ "</Cverify>");
			 					sb.append("<Age>" +readData[u][11]+ "</Age>");
			 					sb.append("<Qassign>" +readData[u][12]+ "</Qassign>"); 
			 					sb.append("<Quotation>" +readData[u][13]+ "</Quotation>"); 
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
		 			request.setAttribute("error", e.getMessage());
		 			RequestDispatcher dispatchers = request	.getRequestDispatcher("/error/index.jsp");
		 			dispatchers.forward(request, response); 
		    	 } 
		    }	
		 
	 
	 public static void LoadFunnel(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	 try 
	    	 {    		 	
	    		String startLetter=request.getParameter("startLetter");
	    		String me=request.getParameter("me");
	    		String customer=request.getParameter("customer");
	    		String calltype=request.getParameter("calltype");
	    		String stage=request.getParameter("stage");
	    		
	    		HttpSession session = request.getSession();
	    		
	    		String empid  = (""+session.getAttribute("EMPID")).toUpperCase();
	    		String usertype  = (""+session.getAttribute("USERTYPE")).toUpperCase();
	 	 		String sql="";
	 	 		 
 	 			String datad[] = CommonFunctions.getReportingEmployeeIds(empid);
 				String ids=" AND a.CHR_EMPID IN ( '"+empid+"',";
 				for(int u=0;u<datad.length;u++)
 					ids = ids +"'"+datad[u]+"' , ";
 				ids = ids +" '0'  )";
 				sql = sql + ids;
 	 		  
	 	 		sql =  "    SELECT  FIND_A_EMPLOYEE_ID_NAME(a.CHR_EMPID) ME,   FIND_A_MKT_CUSTOMER_NAME(a.INT_CUSTOMERID) Clientname, ";
	 	 		sql = sql + "    b.CHR_DESC, CONCAT(a.INT_PERCENTAGE,'%') stage,DATE_FORMAT(c.DAT_QUOTATIONDATE,'%d-%b-%Y') funneldate, ";
	 	 		sql = sql + "    b.INT_QUANTITY,b.DOU_UNITPRICE,(b.DOU_TOTAL-b.DOU_TAX_AMOUNT),FIND_A_EMPLOYEE_REPORTING_TO(a.CHR_EMPID) Owner,MKT_FUN_GET_COLORCODE(a.INT_PERCENTAGE) ";
	 	 		sql = sql + "    FROM mkt_t_daillycalls a ,mkt_t_quotationitem b, mkt_t_quotation c ";
	 	 		sql = sql + "    WHERE  a.INT_CALLID >0  AND a.CHR_QUOTATION = b.CHR_QUOTATIONNO  AND b.CHR_QUOTATIONNO = c.CHR_QUOTATIONNO ";
	 	 		sql = sql + "    AND  a.CHR_ADDEDTO_FUNNEL ='Y'  AND a.CHR_STATUS ='N' ";
	 	 		sql = sql + "   ";
	 	 		if(!"0".equals(me))
	 	 			sql = sql + " AND a.CHR_EMPID ='"+me+"'";
	 	 		else
	 	 		{
	 	 			if(!"F".equals(usertype))
	 	 				sql = sql + ids;
	 	 		}	
	 	 		
	 	 		if(!"0".equals(stage))
	 	 			sql = sql+ " AND a.INT_PERCENTAGE="+stage;
	 	 		
	 	 		if(!"0".equals(calltype))
	 	 			sql = sql+ " AND a.CHR_CALLTYPE="+calltype;
	 	 		if(!"0".equals(customer))
	 	 			sql = sql+ " AND b.INT_CUSTOMERID="+customer;
	 	 		if(!"0".equals(startLetter))
	 	 			sql = sql + " AND d.CHR_NAME LIKE '"+startLetter+"%' ";
	 	 		sql = sql +"  ORDER BY c.INT_QUOTATIONID ";
	 	 		System.out.println(sql);
	 	 		String readData[][] = CommonFunctions.QueryExecute(sql);
	 	 		 
	 	 		if(readData.length>0)
	 	 		{	
	 	 			StringBuffer sb = new StringBuffer(); 
	 	 			for(int u=0; u<readData.length;u++)
	 	 			{
	 	 					sb.append("<Row>");    	            
		 					sb.append("<ME>" +readData[u][0]+ "</ME>");
		 					sb.append("<Customer>"+readData[u][1]+"</Customer>");
		 					sb.append("<Product>" +readData[u][2]+ "</Product>");
		 					sb.append("<Stage>" +readData[u][3]+ "</Stage>");
		 					sb.append("<FDate>" +readData[u][4]+ "</FDate>");
		 					sb.append("<Qty>" +readData[u][5]+ "</Qty>");
		 					sb.append("<Value>" +readData[u][6]+ "</Value>");
		 					sb.append("<Total>" +readData[u][7]+ "</Total>");
		 					sb.append("<Owner>" +readData[u][8]+ "</Owner>");
		 					sb.append("<Color>" +readData[u][9]+ "</Color>");
		 					
		 					sb.append("</Row>");
		 			}	
	 	 			sb.toString();
					response.setContentType("text/xml");
					response.setHeader("Cache-Control", "no-cache");
					response.getWriter().write("<RowsSStaff>"+sb.toString()+"</RowsSStaff>");
		 		} 
	 	 		else 
	 	 		{
	 	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
	 	 		}	
	    	 } 
	    	 catch (Exception e) 
	    	 {
	    		System.out.println(e.getMessage());
	 			request.setAttribute("error", e.getMessage());
	 			RequestDispatcher dispatchers = request	.getRequestDispatcher("/error/index.jsp");
	 			dispatchers.forward(request, response); 
	    	 } 
	    }	
	 
	 
	 public static void loadEnquirySearch(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	 try 
	    	 {    		 	
	    		String startLetter=request.getParameter("startLetter");
	 	 		String sql="" ;
	 	 		sql =" SELECT INT_ENQUIRYID,CHR_CUSTOMERNAME,CHR_SUBJECT,CHR_CALLASSIGNED,CHR_CUSTOMER_TYPE,INT_CUSTOMERID,CHR_CALLRECEIVED FROM mkt_t_enquiry a WHERE INT_ENQUIRYID>=1 ";
	 	 	 	if(!"0".equals(startLetter))
	 	 			sql = sql + " AND CHR_SUBJECT LIKE '"+startLetter+"%' ";
	 	 		sql = sql +" ORDER BY CHR_CUSTOMERNAME";
	 	 		System.out.println(sql);
	 	 		String readData[][] = CommonFunctions.QueryExecute(sql);
	 	 		if(readData.length>0)
	 	 		{	
	 	 			StringBuffer sb = new StringBuffer();    	     	
	 	 			for(int u=0; u<readData.length;u++)
	 	 			{
	 	 					sb.append("<Row>");    	            
		 					sb.append("<EnquiryId>" +readData[u][0]+ "</EnquiryId>");
		 					if("Y".equals(readData[u][4]))
		 					{
		 						sb.append("<CustomerName>" +readData[u][1]+ "</CustomerName>");
		 					}
		 					else
		 					{
		 						sb.append("<CustomerName>" + CommonFunctions.QueryExecute("SELECT  b.CHR_NAME  FROM mkt_m_customerinfo a, mkt_m_customername b  WHERE a.INT_CUSTOMERNAMEID =b.INT_CUSTOMERNAMEID AND a.INT_CUSTOMERID="+readData[u][5])[0][0]+ "</CustomerName>");
		 					}
		 					sb.append("<Subject>" +readData[u][2].toUpperCase()+ "</Subject>");
		 					sb.append("<CallAssig>" +readData[u][3]+ "</CallAssig>");
		 					sb.append("<Callreceived>" +readData[u][6]+ "</Callreceived>");
		 					sb.append("</Row>");
		 			}	
	 	 			sb.toString();
					response.setContentType("text/xml");
					response.setHeader("Cache-Control", "no-cache");
					response.getWriter().write("<CustomerRows>"+sb.toString()+"</CustomerRows>");
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
	 
	 public static void marketingQuotation(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException 
		{
			try 
			{
				 
				String division = request.getParameter("division");
				String customer = request.getParameter("customer");
				String day = request.getParameter("day");
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				String startletter = request.getParameter("startletter");
				HttpSession session = request.getSession();
	    		String empid  = (""+session.getAttribute("EMPID")).toUpperCase();
	    		String usertype  = (""+session.getAttribute("USERTYPE")).toUpperCase();
	    		String datad[] = CommonFunctions.getReportingEmployeeIds(empid);
 				String ids=" AND b.CHR_HOLDER IN ( '"+empid+"',";
 				for(int u=0;u<datad.length;u++)
 					ids = ids +"'"+datad[u]+"' , ";
 				ids = ids +" '0'  )";
 				
 				String sql = " SELECT a.INT_QUOTATIONID,a.CHR_QUOTATIONNO,FIND_A_MKT_CUSTOMER_NAME(b.INT_CUSTOMERID),DATE_FORMAT(a.DAT_QUOTATIONDATE,'%d-%b-%Y'),";
				sql = sql + "  SUM(c.INT_QUANTITY * c.DOU_UNITPRICE) ,a.CHR_STATUS, ";
				sql = sql + " FUN_INV_DIVISION(a.INT_DIVIID ),a.CHR_ASSIGNED,a.CHR_MOVING_TO_CPO, a.CHR_REVISED FROM ";
				sql = sql + " mkt_t_quotation  a ,mkt_m_customerinfo b, mkt_t_quotationitem c ";
				sql = sql + " WHERE a.CHR_QUOTATIONNO = c.CHR_QUOTATIONNO AND a.INT_CUSTOMERID =b.INT_CUSTOMERID ";
				if(!"F".equals(usertype))
	 	 				sql = sql + ids;
	 	 		if(!"0".equals(customer))
					sql = sql + " AND a.INT_CUSTOMERID = "+customer;
				if(!"0".equals(division))
					sql = sql + " AND a.INT_DIVIID = "+division;
				if(!"0".equals(day))
					sql = sql + " AND DAY(a.DAT_QUOTATIONDATE) = "+day;
				if(!"0".equals(month))
					sql = sql + " AND MONTH(a.DAT_QUOTATIONDATE) = "+month;
				if(!"0".equals(year))
					sql = sql + " AND YEAR(a.DAT_QUOTATIONDATE) = "+year;
				if(!"0".equals(startletter))
					sql = sql + " AND  FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) LIKE '"+startletter+"%' " ;
				sql = sql + "  GROUP BY a.CHR_QUOTATIONNO ORDER BY  a.DAT_QUOTATIONDATE";
				System.out.println(sql);
				String readData[][] = CommonFunctions.QueryExecute(sql);
				StringBuffer sb = new StringBuffer();
				if (readData.length > 0)
				{
					for (int u = 0; u < readData.length; u++) 
					{
						 	sb.append("<Row>");
							sb.append("<id>" + readData[u][0] + "</id>");
							sb.append("<quotationNo>" + readData[u][1]+ "</quotationNo>");
							sb.append("<customerName>" + readData[u][2].replaceAll("&"," AND ")+ "</customerName>");
							sb.append("<QuotDate>" + readData[u][3]+ "</QuotDate>");
							sb.append("<totalAmount>" + readData[u][4]+ "</totalAmount>");
							sb.append("<quotationStatus>" + readData[u][5]+ "</quotationStatus>");
							sb.append("<Division>" + readData[u][6]+ "</Division>");
							sb.append("<Attached>" + readData[u][7]+ "</Attached>");
							sb.append("<Moved>" + readData[u][8]+ "</Moved>");
							sb.append("<Revised>" + readData[u][9]+ "</Revised>");
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
				request.setAttribute("error", e.getMessage());
				RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
				dispatchers.forward(request, response);
			}
		}

	 
	 
	 public static void marketingQuotationCPO(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException 
		{
			try 
			{
				 
				String division = request.getParameter("division");
				String customer = request.getParameter("customer");
				String day = request.getParameter("day");
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				String startletter = request.getParameter("startletter");
				HttpSession session = request.getSession();
	    		String empid  = (""+session.getAttribute("EMPID")).toUpperCase();
	    		String usertype  = (""+session.getAttribute("USERTYPE")).toUpperCase();
	    		
				String sql = " ";
				sql = sql + "  SELECT b.INT_QUOTATIONID, a.CHR_QUOTATION,FIND_A_EMPLOYEE_ID_NAME(a.CHR_EMPID) ME, FIND_A_MKT_CUSTOMER_NAME(a.INT_CUSTOMERID) Clientname, ";
				sql = sql + "  DATE_FORMAT(b.DAT_QUOTATIONDATE,'%d-%b-%Y') funneldate  ,b.CHR_MOVING_TO_CPO ,b.DOU_TOTALAMOUNT, b.CHR_CPOQUOTENUMBER  ";
				sql = sql + "  FROM mkt_t_daillycalls a ,mkt_t_quotation b ";
				sql = sql + "  WHERE  a.INT_CALLID >0 AND a.CHR_QUOTATION = b.CHR_QUOTATIONNO AND a.INT_CUSTOMERID= b.INT_CUSTOMERID "; 
				sql = sql + "  AND a.CHR_ADDEDTO_FUNNEL ='Y' AND a.CHR_STATUS ='Y' AND a.CHR_WINLOST ='W' "; 
				if(!"0".equals(customer))
					sql = sql + " AND a.INT_CUSTOMERID = "+customer;
				if(!"0".equals(division))
					sql = sql + " AND a.INT_DIVIID = "+division;
				if(!"0".equals(day))
					sql = sql + " AND DAY(b.DAT_QUOTATIONDATE) = "+day;
				if(!"0".equals(month))
					sql = sql + " AND MONTH(b.DAT_QUOTATIONDATE) = "+month;
				if(!"0".equals(year))
					sql = sql + " AND YEAR(b.DAT_QUOTATIONDATE) = "+year;
				if(!"0".equals(startletter))
					sql = sql + " AND  FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) LIKE '"+startletter+"%' " ;
				sql = sql + "    ORDER BY  b.DAT_QUOTATIONDATE";
				System.out.println(sql);
				String readData[][] = CommonFunctions.QueryExecute(sql);
				StringBuffer sb = new StringBuffer();
				if (readData.length > 0)
				{
					for (int u = 0; u < readData.length; u++) 
					{
						 	sb.append("<Row>");
							sb.append("<id>" + readData[u][0] + "</id>");
							sb.append("<quotationNo>" + readData[u][1]+ "</quotationNo>");
							sb.append("<ME>" + readData[u][2]+ "</ME>");
							sb.append("<customerName>" + readData[u][3].replaceAll("&"," AND ")+ "</customerName>");
							sb.append("<QuotDate>" + readData[u][4]+ "</QuotDate>");
							sb.append("<CPO>" + readData[u][5]+ "</CPO>");
							sb.append("<totalAmount>" + readData[u][6]+ "</totalAmount>");
							sb.append("<CPOQuotenumber>" + readData[u][7]+ "</CPOQuotenumber>");
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
				request.setAttribute("error", e.getMessage());
				RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
				dispatchers.forward(request, response);
			}
		}

	 public static void loadCustomerAddress(HttpServletRequest request,HttpServletResponse response) throws IOException, ServletException 
		{
			try 
			{
				String id = request.getParameter("id");
				String sql = "";
				sql = sql + " SELECT CONCAT(f.CHR_NAME,',',e.CHR_CITYNAME,',',d.CHR_DISTRICT,',',  ";    
				sql = sql + "  c.CHR_STATENAME,',', CONCAT('PIN :',a.INT_PINCODE),'.'      ";
				//sql = sql + "  IF(LENGTH(a.INT_MOBILE1)>4 ,CONCAT('MOBILE :',a.INT_MOBILE1,','),''),   ";
				//sql = sql + "  IF(LENGTH(a.INT_PHONE1)>4 ,CONCAT('Phone :',a.INT_PHONE1,','),''),   ";
				//sql = sql + "  IF(LENGTH(a.CHR_EMAIL )>4 ,CONCAT('E-Mail : :',a.CHR_EMAIL),'')         ";
				sql = sql + " )";
				sql = sql + "  FROM  mkt_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,  ";    
				sql = sql + "  com_m_city e  ,mkt_m_customername f     ";   
				sql = sql + "  WHERE a.INT_CUSTOMERNAMEID = f.INT_CUSTOMERNAMEID    "; 
				sql = sql + "  AND a.INT_COUNTRYID = b.INT_COUNTRYID    ";      
				sql = sql + "  AND a.INT_STATEID =c.INT_STATEID    ";      
				sql = sql + "  AND a.INT_DISTRICTID= d.INT_DISTRICTID      ";  
				sql = sql + "  AND a.INT_CITYID =e.INT_CITYID    ";      
				sql = sql + " AND a.INT_CUSTOMERID=" + id;
				sql = sql + " ORDER BY f.CHR_NAME   ";
				System.out.println(sql);
				String readData[][] = CommonFunctions.QueryExecute(sql);
				StringBuffer sb = new StringBuffer();
				if (readData.length > 0) 
				{
					for (int u = 0; u < readData.length; u++) 
					{
						sb.append("<Address>");
						sb.append("<A>" + readData[u][0] + "</A>");
						sb.append("</Address>");
					}
					response.setContentType("text/xml");
					response.setHeader("Cache-Control", "no-cache");
					response.getWriter().write("<Addresss>" + sb.toString() + "</Addresss>");
				} 
				else 
				{
					response.setStatus(HttpServletResponse.SC_NO_CONTENT);
				}
			} 
			catch (Exception e) 
			{
				System.out.println(e.getMessage());
				request.setAttribute("error", e.getMessage());
				RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
				dispatchers.forward(request, response);
			}
		}

	 public static void LoadMovetoCustomerName(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	  try 
	    	  {
	    		   	HttpSession session = request.getSession();
					String usertype  = (""+session.getAttribute("USERTYPE")).toUpperCase();
					String userid  = (""+session.getAttribute("USRID")).toUpperCase();
					String StartLetter = "" + request.getParameter("startLetter");
	    			String status = "" + request.getParameter("status");
	    			String division = "" + request.getParameter("division");
	    			String sql = "";
	    			sql = " SELECT INT_CUSTOMERNAMEID,UPPER(CHR_NAME),UPPER(CHR_SHORT),CHR_VERIFY,FUN_INV_DIVISION(INT_DIVIID),FIND_A_EMPLOYEE_ID_NAME_BY_USERID(CHR_USRNAME),CHR_MOVETO_INVENTORY   FROM mkt_m_customername ";
	    			sql = sql + "    WHERE INT_CUSTOMERNAMEID >0 ";
	    			if (!"0".equals(status))
	    				sql = sql + " AND  CHR_MOVETO_INVENTORY = '" + status + "'";
	    			if (!"0".equals(division))
	    				sql = sql + " AND  INT_DIVIID =  " + division ;
	    			if (!"0".equals(StartLetter))
	    				sql = sql + " AND  CHR_NAME LIKE '" + StartLetter + "%'";
	    			 
	    			sql = sql + " ORDER BY CHR_NAME ";
 				String readData[][] = CommonFunctions.QueryExecute(sql);
 				StringBuffer sb = new StringBuffer();
 				if (readData.length > 0) 
 				{
 					System.out.println(sql);
 					for (int u = 0; u < readData.length; u++) 
 					{
 						sb.append("<Row>");
 						sb.append("<Rowid>" + readData[u][0].trim() + "</Rowid>");
 						sb.append("<Name>"	+ readData[u][1].trim().replaceAll("&", " AND ") + "</Name>");
 						sb.append("<Short>"	+ readData[u][2].trim().replaceAll("&", " AND ") + "</Short>");
 						sb.append("<Verify>"	+ readData[u][3].trim().replaceAll("&", " AND ") + "</Verify>");
 						sb.append("<Division>"	+ readData[u][4].trim().replaceAll("&", " AND ") + "</Division>");
 						sb.append("<Entryby>"	+ readData[u][5].trim().replaceAll("&", " AND ") + "</Entryby>");
 						sb.append("<MovetoInventory>"	+ readData[u][6].trim().replaceAll("&", " AND ") + "</MovetoInventory>");
 						sb.append("<usertype>" +usertype+ "</usertype>");
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
	    			request.setAttribute("error", e.getMessage());
	    			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    			dispatchers.forward(request, response);
			  }
	  	    }	
	    
	 
	 public static void LoadMovetoCustomerinfos(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	 try 
	    	 {    		 	
	    		String startLetter=request.getParameter("startLetter");
	    		String group=request.getParameter("group");
	    		String status=request.getParameter("status");
	    		String account=request.getParameter("account");
	    		String division=request.getParameter("division");
	    		String me=request.getParameter("me");
	    		HttpSession session = request.getSession();
				String usertype  = (""+session.getAttribute("USERTYPE")).toUpperCase();
				String sql="";
				sql ="  SELECT a.INT_CUSTOMERID,a.CHR_CONTACTPERSON,f.CHR_NAME, a.CHR_ADDRESS1,a.CHR_ADDRESS2,a.CHR_ADDRESS3 , ";
	 	 		sql = sql + " c.CHR_STATENAME,d.CHR_DISTRICT, e.CHR_CITYNAME, a.INT_PINCODE,a.INT_PHONE1,a.INT_MOBILE1,a.CHR_FAX,a.CHR_EMAIL,a.CHR_WEBSITE,   "; 
	 	 		sql = sql + "  a.CHR_ACTIVE, b.CHR_GROUPNAME ,FIND_A_EMPLOYEE_ID_NAME(a.CHR_CREATEDBY),a.CHR_VERIFY ,FIND_A_EMPLOYEE_ID_NAME(a.CHR_HOLDER ),a.CHR_MOVETO_INVENTORY  ";
	 	 		sql = sql + " FROM mkt_m_customerinfo a,mkt_m_customergroup  b ,com_m_state c  , ";
	 	 		sql = sql + "  com_m_district d,com_m_city e , mkt_m_customername f  ";
	 	 		sql = sql + " WHERE a.INT_GROUPID=b.INT_GROUPID    ";
	 	 		sql = sql + " AND a.INT_STATEID=c.INT_STATEID     ";
	 	 		sql = sql + " AND a.INT_DISTRICTID = d.INT_DISTRICTID   "; 
	 	 		sql = sql + " AND a.INT_CITYID = e.INT_CITYID   ";
	 	 		sql = sql + " AND a.INT_CUSTOMERNAMEID = f.INT_CUSTOMERNAMEID ";
	 	 		sql = sql + " AND  a.CHR_VERIFY ='Y' ";
	 	 		if (!"0".equals(status))
    				sql = sql + " AND  a.CHR_MOVETO_INVENTORY = '" + status + "'";
    			if(!"0".equals(group))
	 	 			sql = sql + " AND a.INT_GROUPID ="+group;
	 	 		if(!"0".equals(account))
	 	 			sql = sql + " AND a.INT_CUSTOMERNAMEID ="+account;
	 	 		if(!"0".equals(division))
	 	 			sql = sql + " AND f.INT_DIVIID ="+division;
	 	 		if(!"0".equals(me))
	 	 			sql = sql + " AND a.CHR_HOLDER = '"+me+"' ";
	 	 		if(!"0".equals(startLetter))
	 	 			sql = sql + " AND f.CHR_NAME LIKE '"+startLetter+"%' ";
	 	 		sql = sql +" ORDER BY f.CHR_NAME ";
	 	 		System.out.println(sql);
	 	 		String readData[][] =CommonFunctions.QueryExecute(sql);
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
		 					sb.append("<Active>" +readData[u][15]+ "</Active>");
		 					sb.append("<verified>" +readData[u][18]+ "</verified>");
		 					sb.append("<usertype>" +usertype+ "</usertype>");
		 					sb.append("<GName>" +(readData[u][16].toUpperCase()).replaceAll("&", " AND ") + "</GName>");
		 					sb.append("<Createdby>" +readData[u][17]+ "</Createdby>");
		 					sb.append("<Handle>" +readData[u][19]+ "</Handle>");
		 					sb.append("<MovetoInventory>"	+ readData[u][20].trim().replaceAll("&", " AND ") + "</MovetoInventory>");
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
		 		request.setAttribute("error", e.getMessage());
		 		RequestDispatcher dispatchers = request	.getRequestDispatcher("/error/index.jsp");
		 		dispatchers.forward(request, response);
	    	 } 
	    }	
}
