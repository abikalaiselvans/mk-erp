package com.my.org.erp.common;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.DateUtil;
public class CommonMethod extends HttpServlet
{
	/*	
	 *	Start - Author :: Kalaiselvan
	 * 	Date: 03/02/2006
	 *  
	 */

    
	private static final long serialVersionUID = 1L;


	//  Start  Author :: Kalaiselvan  -----------------------UserName----------
    public static void LoadUserNames(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
    	 try 
    	 {    		 	
    		 	String username=request.getParameter("userName");
		 		String sql = " SELECT count(*) FROM m_user WHERE CHR_USRNAME='"+username+"'";
		 		boolean flag =  CommonInfo.RecordExist(sql);
		 		StringBuffer sb = new StringBuffer(); 
    	     	sb.append("<Username>");    	     		
    	     	sb.append("<Status>"+flag+"</Status>");
    	     	sb.append("</Username>");
    	     	response.setContentType("text/xml");
    	     	response.setHeader("Cache-Control", "no-cache");
    	     	response.getWriter().write("<Usernames>" + sb.toString() + "</Usernames>");
    	     				     	 	 
    	 	} 
    	 	catch (Exception e) 
    	 	{
    	 		System.out.println(e.getMessage());
    			request.setAttribute("error", e.getMessage() );
                RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
        		dispatchers.forward(request, response); 
    	 	} 
    }	
    //  End  Author :: Kalaiselvan  ------------------------------UserName----------
	
    


    public static void LoadDistrict(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
    	 try 
    	 {    		 	
    		  	String stateId=""+request.getParameter("id");
    		  	String startletter=request.getParameter("startletter");
    		  	String search=request.getParameter("search");
 	 			startletter=startletter.toUpperCase();
 	 			 
 	 			if("select".equals(stateId))
 	 				stateId="0";
 	 			String ser ="";
 	 			
 	 			if("".equals(search) )
 	 				ser =" ORDER BY CHR_DISTRICT";
 	 			else
 	 				ser = " AND CHR_DISTRICT LIKE '"+search+"%' ORDER BY CHR_DISTRICT";
 	 			
 	 			String query="SELECT INT_DISTRICTID,UPPER(CHR_DISTRICT) from  com_m_district  where int_stateid="+Integer.parseInt(stateId)+ser;    			
 	 			 
 	 			String readData[][]=  CommonFunctions.QueryExecute(query);
 	 			StringBuffer sb = new StringBuffer();    	     	
 	 			
 	 			if(readData.length >0)
 	 			{	
 	 				for(int u=0; u<readData.length;u++)
 	 				{
 	 					if(readData[u][1].toUpperCase().startsWith(startletter.toUpperCase()) || "0".equalsIgnoreCase(startletter))
 	 					{	 
	 	 					sb.append("<district>");    	            
	 	 					sb.append("<districtId>" +readData[u][0]+ "</districtId>");
	 	 					sb.append("<districtName>" +readData[u][1].toUpperCase() + "</districtName>");      	                         
	 	 					sb.append("</district>");	
			    	     }    	
 	 				}	
 	 				response.setContentType("text/xml");
 	 				response.setHeader("Cache-Control", "no-cache");
 	 				response.getWriter().write("<districts>" + sb.toString() + "</districts>");
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
    
    
    
    
	
	
    
    
    
    
//  Start  Author :: Kalaiselvan  -----------------------loadBranch----------
    public static void loadBranchData(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
    	 try 
    	 {    		 	
    		 	String id= request.getParameter("companyid") ;
    		 	String search=""+request.getParameter("startLetter");
    		 	String sql="";
    			
    		 	sql="SELECT a.INT_BRANCHID,b.CHR_COMPANYNAME,a.CHR_BRANCHNAME,a.CHR_LEGALNAME,a.CHR_CITY,c.CHR_COUNTRYNAME, a.CHR_EMAIL,a.INT_ACTIVE  FROM  com_m_branch a , com_m_company b  ,com_m_country c WHERE a.INT_COMPANYID=b.INT_COMPANYID AND a.CHR_COUNTRY=c.INT_COUNTRYID ";
    		 	if(!"0".equals(id))
    		 		sql=sql+" AND a.INT_COMPANYID="+id;
    		 	if(!"0".equals(search))
    		 		sql=sql+" AND a.CHR_BRANCHNAME LIKE'"+search+"%'";
    		 	sql=sql+" ORDER BY b.CHR_COMPANYNAME,a.CHR_BRANCHNAME ";
    		 	// System.out.println(sql);
    		 	String readData[][] =  CommonFunctions.QueryExecute(sql);
    	     	StringBuffer sb = new StringBuffer(); 
    	     	if(readData.length>0)
    	     	{	
    	     		for(int u=0; u<readData.length;u++)
    	     		{
    	     			sb.append("<branch>");    	     		
			     		sb.append("<id>"+readData[u][0]+"</id>");
			     		sb.append("<companyName>"+readData[u][1].toUpperCase()+"</companyName>");
		     			sb.append("<branchName>"+readData[u][2].toUpperCase()+"</branchName>");
		     			sb.append("<legalName>"+readData[u][3].toUpperCase()+"</legalName>");
		     			sb.append("<city>"+readData[u][4].toUpperCase()+"</city>");                      
		     			sb.append("<country>" +readData[u][5].toUpperCase()+"</country>");
		     			sb.append("<email>"+readData[u][6]+"</email>"); 
		     			sb.append("<active>"+readData[u][7]+"</active>"); 
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
	
    
    
    
//  Start  Author :: Kalaiselvan  -----------------------loadBranch----------
	

 
//  Start Author :: Kalaiselvan  ------------------------------Load Staff-----------
    
    public static void loadStaff(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String companyId=request.getParameter("companyId");
    	 		String branchId=request.getParameter("branchId");    	 
    	 		String departId=request.getParameter("departId");    	 		
    	 		String desigId=request.getParameter("desigId");
    	 		String startLetter=request.getParameter("startLetter");
    	 		int dbcompanyid=0;
    	 		int dbbranchid=0;
    	 		int dbdeptid=0;
    	 		int dbdesgid=0;
    	 		dbcompanyid	=	Integer.parseInt(companyId);
    	 		dbbranchid	=	Integer.parseInt(branchId);
	 			dbdeptid	=	Integer.parseInt(departId);
	 			dbdesgid	=	Integer.parseInt(desigId);
	 			String br="";
	 			 
	 			String dg="";
	 			if(0 != dbdeptid)
	 				br = " AND A.INT_DEPARTID = "+dbdeptid;
	 			if(0 != dbdesgid)
	 				dg = " AND A.INT_DESIGID = "+dbdesgid;
    	 		String query="";
    	 		String sql="SELECT CHR_ORDERBY FROM m_institution";
    	 		String orderdata[][] =  CommonFunctions.QueryExecute(sql);
    	 		sql="";
    	 		if("N".equals(orderdata[0][0]))
    	 			sql = " A.CHR_STAFFNAME ";
    	 		else
    	 			sql = " A.CHR_EMPID ";
    	 		if(!"0".equals(startLetter))
    	 			startLetter =" AND CHR_STAFFNAME Like'"+startLetter+"%' ORDER BY "+sql;
    	 		else
    	 			startLetter =" ORDER BY "+sql;
    	 		if("0".equals(companyId)){
    	 			if("0".equals(branchId))
        	 		{
        	 			query=" SELECT  A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME " +
        	 					" , A.CHR_MOBILE  ,E.CHR_COMPANYNAME , A.CHR_TYPE  from  com_m_staff  A, com_m_branch  B,  com_m_depart   C, com_m_desig  D,  com_m_company  E where A.INT_BRANCHID=B.INT_BRANCHID AND " +
        	 					" A.INT_DEPARTID=C.INT_DEPARTID AND A.INT_COMPANYID =  E.INT_COMPANYID AND A.INT_DESIGID=D.INT_DESIGID  "+br+"  "+dg+" "+ startLetter;
        	 		} 
        	 		else if(!"0".equals(branchId)) 
        	 		{	
        	 			query=" SELECT  A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME " +
        	 					"  ,A.CHR_MOBILE  ,E.CHR_COMPANYNAME  , A.CHR_TYPE   from  com_m_staff  A, com_m_branch  B,  com_m_depart   C, com_m_desig  D,  com_m_company  E where A.INT_BRANCHID=B.INT_BRANCHID AND A.INT_COMPANYID =  E.INT_COMPANYID " +
        	 					" AND A.INT_BRANCHID="+dbbranchid+" AND A.INT_DEPARTID=C.INT_DEPARTID "+br+"  AND A.INT_DESIGID=D.INT_DESIGID "+ dg+startLetter;
        	 		}
    	 			
    	 		}
    	 		else if(!"0".equals(companyId))
    	 		{
    	 			if("0".equals(branchId))
        	 		{
        	 			query=" SELECT  A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME " +
        	 					" ,A.CHR_MOBILE  ,E.CHR_COMPANYNAME , A.CHR_TYPE   from  com_m_staff  A, com_m_branch  B,  com_m_depart   C, com_m_desig  D,  com_m_company  E where A.INT_BRANCHID=B.INT_BRANCHID AND A.INT_COMPANYID =  E.INT_COMPANYID AND " +
        	 					" A.INT_DEPARTID=C.INT_DEPARTID AND A.INT_COMPANYID="+dbcompanyid+" AND A.INT_DESIGID=D.INT_DESIGID  "+br+"  "+dg+" "+ startLetter;
        	 		} 
        	 		else
        	 		if(!"0".equals(branchId)) 
        	 		{	
        	 			query=" SELECT  A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME " +
        	 					" , A.CHR_MOBILE ,E.CHR_COMPANYNAME  , A.CHR_TYPE   from  com_m_staff  A, com_m_branch  B,  com_m_depart   C, com_m_desig  D ,  com_m_company  E where A.INT_BRANCHID=B.INT_BRANCHID " +
        	 					"  AND A.INT_COMPANYID =  E.INT_COMPANYID AND A.INT_BRANCHID="+dbbranchid+" AND  A.INT_COMPANYID="+dbcompanyid+" AND A.INT_DEPARTID=C.INT_DEPARTID "+br+
        	 					"  AND A.INT_DESIGID=D.INT_DESIGID "+ dg+startLetter;
        	 		}
    	 		}
    	 		 
    	 		if (!"".equals(query))
    	 		{	
    	 			String readData[][]=  CommonFunctions.QueryExecute(query);
    	 			if(readData.length>0)
    	 			{	
    	 				StringBuffer sb = new StringBuffer();    	     	
    	 				for(int u=0; u<readData.length;u++)
    	 				{
    	 					sb.append("<Staff>");    	            
    	 					sb.append("<StaffId>" +readData[u][0]+ "</StaffId>");
    	 					sb.append("<StaffName>" +readData[u][1] + "</StaffName>");  
    	 					sb.append("<BranchName>" +readData[u][2] + "</BranchName>");
    	 					sb.append("<DepartName>" +readData[u][3] + "</DepartName>");
    	 					sb.append("<DesigName>" +readData[u][4] + "</DesigName>");
    	 					sb.append("<Mobile>" +readData[u][5] + "</Mobile>");
    	 					sb.append("<Company>" +readData[u][6] + "</Company>");
    	 					sb.append("<Termination>" +readData[u][7] + "</Termination>");
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
		 	} 
    	 	catch (Exception e) 
    	 	{
    	 		System.out.println(e.getMessage());
    			request.setAttribute("error", e.getMessage() );
                RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
        		dispatchers.forward(request, response); 
    	 	} 
    }
    //  END Author :: Kalaiselvan  ------------------------------Load Staff-----------
    
    
    
    
    public static void loadStaffSearch(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String search=request.getParameter("search");
    	 		String sql="SELECT CHR_ORDERBY FROM m_institution";
    	 		String orderdata[][] =  CommonFunctions.QueryExecute(sql);
    	 		
    	 		sql =" SELECT  A.CHR_EMPID,UPPER(A.CHR_STAFFNAME),B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME  , A.CHR_MOBILE ,E.CHR_COMPANYNAME ,A.CHR_TYPE,A.CHR_MIDDLENAME";  
    	 		sql = sql + " from  com_m_staff  A, com_m_branch  B,  com_m_depart  C, com_m_desig  D ,  com_m_company  E "; 
    	 		sql = sql + " where A.INT_BRANCHID=B.INT_BRANCHID ";
    	 		sql = sql + " AND A.INT_COMPANYID =  E.INT_COMPANYID "; 
    	 		sql = sql + " AND A.INT_BRANCHID=B.INT_BRANCHID "; 
    	 		sql = sql + " AND A.INT_COMPANYID=E.INT_COMPANYID";
    	 		sql = sql + " AND A.INT_DEPARTID=C.INT_DEPARTID  ";
    	 		sql = sql + " AND A.INT_DESIGID=D.INT_DESIGID  ";
    	 		sql = sql + " AND( (A.CHR_STAFFNAME LIKE '%"+search.trim()+"%' ) OR (A.CHR_EMPID LIKE '%"+search.trim()+"%' )  )";
    	 		
    	 		if("N".equals(orderdata[0][0]))
    	 			sql = sql+" ORDER BY A.CHR_STAFFNAME ";
    	 		else
    	 			sql = sql+" ORDER BY A.CHR_EMPID ";
    	 		
    	 		String readData[][]=  CommonFunctions.QueryExecute(sql);
	 			if(readData.length>0)
	 			{	
	 				StringBuffer sb = new StringBuffer();    	     	
	 				for(int u=0; u<readData.length;u++)
	 				{
	 					sb.append("<Staff>");    	            
	 					sb.append("<StaffId>" +readData[u][0]+ "</StaffId>");
	 					String rs = readData[u][1].toUpperCase();
	 					//rs =rs.replaceAll(search.toUpperCase(), "9865043008");
	 					//rs = rs.replaceAll("9865043008", "<font color='#993300'>"+search.toUpperCase()+"</fon>");
	 					sb.append("<StaffName>" +rs + "</StaffName>");  
	 					sb.append("<BranchName>" +readData[u][2] + "</BranchName>");
	 					sb.append("<DepartName>" +readData[u][3] + "</DepartName>");
	 					sb.append("<DesigName>" +readData[u][4] + "</DesigName>");
	 					sb.append("<Mobile>" +readData[u][5] + "</Mobile>");
	 					sb.append("<Company>" +readData[u][6] + "</Company>");
	 					sb.append("<Termination>" +readData[u][7] + "</Termination>");
	 					sb.append("<MiddleName>" +readData[u][8] + "</MiddleName>");
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
    
    
    
    
    
    

    public static void LoadSearchStaffids(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		HttpSession session=request.getSession();			
    	 		 
    	 		String search=request.getParameter("search");
    	 		String sql="SELECT CHR_ORDERBY FROM m_institution";
    	 		String orderdata[][] = CommonFunctions.QueryExecute(sql);
    	 		
    	 		sql = " SELECT CHR_OFFICELIST FROM m_user WHERE CHR_USRNAME='"+session.getAttribute("USRID")+"'";
    	 		String officedata[][] = CommonFunctions.QueryExecute(sql);
    	 		
    	 		sql =" SELECT  A.CHR_EMPID,UPPER(A.CHR_STAFFNAME),B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME  , A.CHR_MOBILE ,E.CHR_COMPANYNAME ,A.CHR_TYPE,A.CHR_MIDDLENAME";  
    	 		sql = sql + " from  com_m_staff  A, com_m_branch  B,  com_m_depart  C, com_m_desig  D ,  com_m_company  E "; 
    	 		sql = sql + " where A.INT_BRANCHID=B.INT_BRANCHID ";
    	 		sql = sql + " AND A.INT_COMPANYID =  E.INT_COMPANYID "; 
    	 		sql = sql + " AND A.INT_BRANCHID=B.INT_BRANCHID "; 
    	 		sql = sql + " AND A.INT_COMPANYID=E.INT_COMPANYID";
    	 		sql = sql + " AND A.INT_DEPARTID=C.INT_DEPARTID  ";
    	 		sql = sql + " AND A.INT_DESIGID=D.INT_DESIGID  ";
    	 		sql = sql + " AND  A.INT_OFFICEID IN("+officedata[0][0]+" ,0) ";
    	 		sql = sql + " AND( (A.CHR_STAFFNAME LIKE '%"+search.trim()+"%' ) OR (A.CHR_EMPID LIKE '%"+search.trim()+"%' )  )";
    	 		
    	 		
    	 		if("N".equals(orderdata[0][0]))
    	 			sql = sql+" ORDER BY A.CHR_STAFFNAME ";
    	 		else
    	 			sql = sql+" ORDER BY A.CHR_EMPID ";
    	 		System.out.println();
    	 		System.out.println();
    	 		System.out.println(sql);
    	 		System.out.println();
    	 		String readData[][]= CommonFunctions.QueryExecute(sql);
	 			if(readData.length>0)
	 			{	
	 				StringBuffer sb = new StringBuffer();    	     	
	 				for(int u=0; u<readData.length;u++)
	 				{
	 					sb.append("<Staff>");    	            
	 					sb.append("<StaffId>" +readData[u][0]+ "</StaffId>");
	 					String rs = readData[u][1].toUpperCase();
	 					sb.append("<StaffName>" +rs + "</StaffName>");  
	 					sb.append("<BranchName>" +readData[u][2] + "</BranchName>");
	 					sb.append("<DepartName>" +readData[u][3] + "</DepartName>");
	 					sb.append("<DesigName>" +readData[u][4] + "</DesigName>");
	 					sb.append("<Mobile>" +readData[u][5] + "</Mobile>");
	 					sb.append("<Company>" +readData[u][6] + "</Company>");
	 					sb.append("<Termination>" +readData[u][7] + "</Termination>");
	 					sb.append("<MiddleName>" +readData[u][8] + "</MiddleName>");
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
    
    
    
    
    //  Start Author :: Kalaiselvan  ------------------------------UniqueId-----------
    
    public static void AMCUniqueId(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String sql=""; 
    		 	String tablename=""+request.getParameter("tablename");
    		 	String fieldname=""+request.getParameter("fieldname");
    		 	String value=""+request.getParameter("value");
    		 	sql  = "SELECT COUNT(*) FROM "+tablename+" WHERE "+fieldname+"  = '"+value+"'";
    		 	StringBuffer sb = new StringBuffer();
    		 	if( CommonInfo.RecordExist(sql))
    		 	{
    		 		sb.append("<UniqueId>");
     				sb.append("<Exsist>TRUE</Exsist>");
     				sb.append("</UniqueId>");
     			}
    		 	else
    		 	{
    		 		sb.append("<UniqueId>");
     				sb.append("<Exsist>FALSE</Exsist>");
     				sb.append("</UniqueId>");
    		 	}
    		 	response.setContentType("text/xml");
		 		response.setHeader("Cache-Control", "no-cache");
		 		response.getWriter().write("<UniqueIds>" + sb.toString() + "</UniqueIds>");
		 		
 	 		 
    	 } 
    	 catch (Exception e) 
    	 {
    		 System.out.println(e.getMessage());
 			request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		dispatchers.forward(request, response); 
    	 } 
    }	

    //  End Author :: Kalaiselvan  ------------------------------UniqueId-----------
 
  //  Start Author :: Kalaiselvan  ------------------------------UniqueId-----------
    
    public static void UniqueId(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String sql=""; 
    		 	
    		 	String tablename=""+request.getParameter("tablename");
    		 	String fieldname=""+request.getParameter("fieldname");
    		 	String value=""+request.getParameter("value");
    		 	sql  = "SELECT COUNT(*) FROM "+tablename+" WHERE "+fieldname+"  = '"+value.trim()+"'";
    		 	//System.out.println(sql);
    		 	StringBuffer sb = new StringBuffer();
    		 	if( CommonInfo.RecordExist(sql))
    		 	{
    		 		sb.append("<UniqueId>");
     				sb.append("<Exsist>TRUE</Exsist>");
     				sb.append("</UniqueId>");
     			}
    		 	
    		 	else
    		 	{
    		 		sb.append("<UniqueId>");
     				sb.append("<Exsist>FALSE</Exsist>");
     				sb.append("</UniqueId>");
    		 	}
    		 	response.setContentType("text/xml");
		 		response.setHeader("Cache-Control", "no-cache");
		 		response.getWriter().write("<UniqueIds>" + sb.toString() + "</UniqueIds>");
		 		
 	 		 
    	 } 
    	 catch (Exception e) 
    	 {
    		 System.out.println(e.getMessage());
 			 request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		 dispatchers.forward(request, response); 
    	 } 
    }	

    //  End Author :: Kalaiselvan  ------------------------------UniqueId-----------
 
    
    
//  Start Author :: Kalaiselvan  ------------------------------UniqueIdWithData-----------
    
    public static void UniqueIdWithData(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String sql=""; 
    		 	String tablename=""+request.getParameter("tablename");
    		 	 
    		 	String value=""+request.getParameter("value");
    		 	String data=""+request.getParameter("data");
    		 	sql  = "SELECT CHR_SERIALNO FROM "+tablename+" where CHR_SERIALNO is not null";
    		 	data= data.toUpperCase();
    		 	String datas[][] =  CommonFunction.RecordSetArray(sql);
    		 	String s="";
    		 	for(int u=0;u<datas.length;u++)
    		 	{
    		 		if(!data.equals(datas[u][0].toUpperCase()))
    		 			s = s+datas[u][0]+",";
    		 	}
    		 	String datass[] =s.split(",");
    		 	StringBuffer sb = new StringBuffer();
    		 	boolean f = false;
    		 	for(int u=0;u<datass.length;u++)
    		 		if(value.equalsIgnoreCase(datass[u]))
    		 			f = true;
    		 	if(f)
    		 	{
    		 		sb.append("<UniqueId>");
     				sb.append("<Exsist>TRUE</Exsist>");
     				sb.append("</UniqueId>");
     			}
    		 	else
    		 	{
    		 		sb.append("<UniqueId>");
     				sb.append("<Exsist>FALSE</Exsist>");
     				sb.append("</UniqueId>");
    		 	}
    		 	response.setContentType("text/xml");
		 		response.setHeader("Cache-Control", "no-cache");
		 		response.getWriter().write("<UniqueIds>" + sb.toString() + "</UniqueIds>");
    	 } 
    	 catch (Exception e) 
    	 {
    		 System.out.println(e.getMessage());
 			 request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		 dispatchers.forward(request, response);
    	 } 
    }	

    //  End Author :: Kalaiselvan  ------------------------------UniqueIdWithData-----------
 
    
    //  Start Author :: Kalaiselvan  ------------------------------UniqueIdSale-----------
    public static void UniqueIdSale(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String sql=""; 
    		 	String tablename=""+request.getParameter("tablename");
    		 	String fieldname=""+request.getParameter("fieldname");
    		 	String value=""+request.getParameter("value");
    		 	sql  = "SELECT COUNT(*) FROM "+tablename+" WHERE "+fieldname+"  = '"+value+"'";
    		 	StringBuffer sb = new StringBuffer();
    		 	if( CommonInfo.RecordExist(sql))
    		 	{
    		 		sb.append("<UniqueId>");
     				sb.append("<Exsist>TRUE</Exsist>");
     				sb.append("</UniqueId>");
     			}
    		 	else
    		 	{
    		 		sb.append("<UniqueId>");
     				sb.append("<Exsist>FALSE</Exsist>");
     				sb.append("</UniqueId>");
    		 	}
    		 	response.setContentType("text/xml");
		 		response.setHeader("Cache-Control", "no-cache");
		 		response.getWriter().write("<UniqueIds>" + sb.toString() + "</UniqueIds>");
		 		
 	 		 
    	 } 
    	 catch (Exception e) 
    	 {
    		 System.out.println(e.getMessage());
 			 request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		 dispatchers.forward(request, response);
    	 } 
    }	

 //  End Author :: Kalaiselvan  ------------------------------UniqueId Sale-----------
 
    
    
    
    public static void CheckUnique(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
    	 try
    	 {
    		boolean flag=false;
    		String id=""+request.getParameter("id").trim();
    		id=id.trim();
    		if(!id.equals("null") && !id.equals(""))
    		{
	    		String fieldName=request.getParameter("fieldName");
	    		String tableName=request.getParameter("tableName");
			 	String sql = " SELECT count(*) FROM "+tableName+" WHERE "+fieldName.toUpperCase()+"='"+id.toUpperCase()+"'";
			 	flag = CommonInfo.RecordExist(sql);
			 	System.out.println(sql);
    		}
		 	StringBuffer sb = new StringBuffer();    		
 	     	sb.append("<Username>");    	     		
 	     	sb.append("<Status>"+flag+"</Status>");
 	     	sb.append("</Username>");
 	     	response.setContentType("text/xml");
 	     	response.setHeader("Cache-Control", "no-cache");
 	     	response.getWriter().write("<Usernames>" + sb.toString() + "</Usernames>");
    	 } 
    	 catch (Exception e) 
    	 {
    		 System.out.println(e.getMessage());
 			 request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		 dispatchers.forward(request, response);
    	 } 
    }	
    
    
    public static void CheckUniqueInResigned(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		boolean flag=false;
    		String id=""+request.getParameter("id").trim();
    		id=id.trim();
    		if(!id.equals("null") && !id.equals(""))
    		{
	    		String fieldName=request.getParameter("fieldName");
	    		String tableName=request.getParameter("tableName");
			 	String sql = " SELECT count(*) FROM "+tableName+" WHERE "+fieldName+"='"+id+"' AND  CHR_TYPE='T' ";
			 	flag = CommonInfo.RecordExist(sql);
			}
		 	StringBuffer sb = new StringBuffer();    		
 	     	sb.append("<Username>");    	     		
 	     	sb.append("<Status>"+flag+"</Status>");
 	     	sb.append("</Username>");
 	     	response.setContentType("text/xml");
 	     	response.setHeader("Cache-Control", "no-cache");
 	     	response.getWriter().write("<Usernames>" + sb.toString() + "</Usernames>");
    	 } 
    	 catch (Exception e) 
    	 {
    		 System.out.println(e.getMessage());
 			 request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		 dispatchers.forward(request, response);
    	 } 
    }	
	 
	 
    public static void Ticket(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
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
    		String ssql="";
    		if(!"0".equals(pack))
    			ssql=" AND a.CHR_PACKAGE ='"+pack+"'";
    		else
    			ssql = " ";
    		if(!"F".equals(admin))
    			ssql = ssql+" AND a.CHR_FROMUSER='"+userid+"'";
    		
    		String sql = " SELECT a.INT_TICKETID,b.CHR_EMPID,(SELECT CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID=b.CHR_EMPID) ";
    		sql = sql +"	,a.DAT_PDATE,a.CHR_PROBLEM,a.CHR_STATUS "; 
    		sql = sql+"	from com_m_ticket a , m_user b  ";
    		sql = sql+"	WHERE b.CHR_USRNAME = a.CHR_FROMUSER ";
    		sql = sql+"	AND month(a.DAT_PDATE) = "+month;
    		sql = sql+"	AND year(a.DAT_PDATE) = "+year;
    		sql = sql+"	AND a.CHR_STATUS='"+Status+"'  ";
    		sql = sql+ssql;
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
 					sb.append("<Problem>" +readData[u][4].toString() + "</Problem>");
 					sb.append("<Status>" +readData[u][5] + "</Status>");
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
    
    
    public static void ServerCheckSession(HttpServletRequest request, HttpServletResponse  response)throws IOException, ServletException 
    {
    	 try
    	 {
    		 
    		HttpSession session =   request.getSession();
    		String username =  CommonFunctions.QueryExecute("SELECT CHR_STAFFNAME FROM com_m_staff WHERE CHR_EMPID='"+session.getAttribute("EMPID")+"'")[0][0];
     		String sql = "SELECT CHR_UPDATE FROm m_institution WHERE INT_ID=1";
    		String readData[][]=  CommonFunctions.QueryExecute(sql);
 			StringBuffer sb = new StringBuffer();    	     	
 			sb.append("<Session>");    	            
 			sb.append("<Name>"+username+"</Name>");
 			if("N".equals(readData[0][0].trim()))
 				sb.append("<Flag>N</Flag>");
 			else
 				sb.append("<Flag>Y</Flag>");
 			sb.append("</Session>");
 			response.setContentType("text/xml");
 			response.setHeader("Cache-Control", "no-cache");
 			response.getWriter().write("<Sessions>"+sb.toString()+"</Sessions>");
 			 
 		} 
    	catch (Exception e) 
    	{
    		 System.out.println(e.getMessage());
 			 request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		 dispatchers.forward(request, response);
    	} 
    }	
    
    
    public static void commonSearch(HttpServletRequest request, HttpServletResponse  response)throws IOException, ServletException 
    {
    	 try
    	 {
    		String search = request.getParameter("search");
    		String month =  request.getParameter("month");
    		String year =  request.getParameter("year");
    		String Flag =  request.getParameter("Flag");
    		String branch =  request.getParameter("branch");
    		
    		String sql="";
    		String sql1="";
    		String branchsql="";
    		branchsql=" AND a.INT_BRANCHID ="+branch;
    		
    		if("Y".equals(Flag))
    			sql1=" AND MONTH(a.DAT_SALESDATE)="+month+" AND YEAR(a.DAT_SALESDATE)="+year;
    		else	
    			sql1="";
    		
    		if("".equals(search) || "null".equals(search))
    			sql = " SELECT a.CHR_SALESNO,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) FROM inv_t_directsales a ,inv_m_customerinfo b WHERE  a.INT_CUSTOMERID=b.INT_CUSTOMERID  "+sql1+branchsql+" order by a.CHR_SALESNO ";
    		else
    			sql = " SELECT a.CHR_SALESNO, FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID)  FROM inv_t_directsales a ,inv_m_customerinfo b WHERE  a.INT_CUSTOMERID=b.INT_CUSTOMERID   "+sql1+branchsql+"  AND b.CHR_CUSTOMERNAME LIKE '"+search+"%' order by a.CHR_SALESNO ";

    		System.out.println(sql);
    		String data[][] =  CommonFunctions.QueryExecute(sql);
			PrintWriter out = response.getWriter();
			out.println("<select name=\"invno\" id=\"invno\"  size=\"10\"  class=\"boldEleven\" onchange=\"initinvoice('invno')\" style=\"width:200\">");				
			if(data.length>0)
			{	
				for(int x=0; x<data.length;x++)
					out.println("<option value=" + data[x][0] + ">" + data[x][0]+" / "+ data[x][1]+"</option>");
			}
			else 
			{
				out.println("<option value=0>");
				out.println("Invoice not found...");
				out.println("</option>");
			}
			out.println("</select>");
 		} 
    	catch (Exception e) 
    	{
    		 System.out.println(e.getMessage());
 			 request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		 dispatchers.forward(request, response);
    	} 
    }	
    
    public static void Search(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    		String search=(""+request.getParameter("search")).trim();
    		String category =(""+request.getParameter("choice")).trim();
    		category =category.toUpperCase();
    		String sql ="";
    		StringBuffer sb = new StringBuffer();
    		if("SN".equals(category))
    		{	
    			sql =" SELECT  A.CHR_STAFFNAME,A.CHR_EMPID,B.CHR_BRANCHNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME  , A.CHR_MOBILE ,E.CHR_COMPANYNAME ,A.CHR_TYPE";  
    	 		sql = sql + " from  com_m_staff  A, com_m_branch  B,  com_m_depart  C, com_m_desig  D ,  com_m_company  E "; 
    	 		sql = sql + " where A.INT_BRANCHID=B.INT_BRANCHID ";
    	 		sql = sql + " AND A.INT_COMPANYID =  E.INT_COMPANYID "; 
    	 		sql = sql + " AND A.INT_BRANCHID=B.INT_BRANCHID "; 
    	 		sql = sql + " AND A.INT_COMPANYID=E.INT_COMPANYID";
    	 		sql = sql + " AND A.INT_DEPARTID=C.INT_DEPARTID  ";
    	 		sql = sql + " AND A.INT_DESIGID=D.INT_DESIGID  ";
    	 		sql = sql + " AND A.CHR_STAFFNAME LIKE '%"+search+"%'";
    	 		sb.append("<Field>");
                sb.append("<Field1>Staff Name</Field1>");
                sb.append("<Field2>Emp Id</Field2>");  
                sb.append("<Field3>Branch</Field3>");
                sb.append("<Field4>Department</Field4>");
                sb.append("<Field5>Designation</Field5>");
                sb.append("<Field6>Mobile</Field6>");
                sb.append("<Field7>Company</Field7>");
                sb.append("<Field8>-</Field8>");
               // sb.append("<Field9>" + readData[u][5]+ "</Field9>");
                //sb.append("<Field10>" + readData[u][5]+ "</Field10>");
                
                sb.append("</Field>");	  
    		}	
    		else if("PD".equals(category))
    		{	
    			sql ="SELECT a.CHR_PRODUCTDESC,a.CHR_PRODUCTCODE, a.DOU_PURCHASEPRICE, a.DOU_SALESPRICE, a.CHR_WARRANTY ";
    			sql = sql +" ,b.CHR_COLORCODE ,c.CHR_MODELCODE ,d.CHR_NAME,e.CHR_DIVICODE ";
    			sql = sql +" FROM inv_m_produtlist a ,inv_m_color b ,inv_m_model c ,inv_m_productgroup d, inv_m_division e ";
    			sql = sql +" WHERE b.INT_COLORID = a.CHR_COLOR ";
    			sql = sql +" AND c.INT_MODELID = a.CHR_MODEL AND d.INT_PRODUCTGROUPID =a.INT_PRODUCTGROUPID AND e.INT_DIVIID = a.INT_DIVIID ";
    			sql = sql + " AND a.CHR_PRODUCTDESC LIKE '%"+search+"%'";
    			sb.append("<Field>");
                sb.append("<Field1>Description</Field1>");
                sb.append("<Field2>Code</Field2>");  
                sb.append("<Field3>Purchase Price</Field3>");
                sb.append("<Field4>Warranty </Field4>");
                sb.append("<Field5>Color</Field5>");
                sb.append("<Field6>Model</Field6>");
                sb.append("<Field7>-</Field7>");
                sb.append("<Field8>-</Field8>");
               // sb.append("<Field9>" + readData[u][5]+ "</Field9>");
                //sb.append("<Field10>" + readData[u][5]+ "</Field10>");
                
                sb.append("</Field>");	  
    		}	
    		else if("ID".equals(category))
    		{	
    			sql =" SELECT a.CHR_DES,a.CHR_PRODUCTID, a.DOU_PURCHASEPRICE, a.DOU_SALESPRICE, a.CHR_WARRANTY ";
    			sql = sql +" ,b.CHR_COLORCODE ,c.CHR_MODELCODE ,d.CHR_GROUPNAME,e.CHR_DIVICODE  ";
    			sql = sql +" FROM inv_m_item a ,inv_m_color b ,inv_m_model c ,inv_m_itemgroup d, inv_m_division e  ";
    			sql = sql +" WHERE b.INT_COLORID = a.INT_COLORCODE  ";
    			sql = sql +" AND c.INT_MODELID = a.INT_MODELCODE  ";
    			sql = sql +" AND d.INT_ITEMGROUPID =a.INT_ITEMGROUPID  ";
    			sql = sql +" AND e.INT_DIVIID = a.INT_DIVIID   ";
    			sql = sql +" AND a.CHR_DES LIKE '%"+search+"%'";
    			sb.append("<Field>");
                sb.append("<Field1>Description</Field1>");
                sb.append("<Field2>Code</Field2>");  
                sb.append("<Field3>Purchase Price</Field3>");
                sb.append("<Field4>Warranty </Field4>");
                sb.append("<Field5>Color</Field5>");
                sb.append("<Field6>Model</Field6>");
                sb.append("<Field7>-</Field7>");
                sb.append("<Field8>-</Field8>");
               // sb.append("<Field9>" + readData[u][5]+ "</Field9>");
                //sb.append("<Field10>" + readData[u][5]+ "</Field10>");
                
                sb.append("</Field>");	
    		}
    		/*
    		else if("S".equals(category))
    		{	
    			sql ="";
    		}
    		*/
    		
			String readData[][] =  CommonFunctions.QueryExecute(sql);
			
			if( (readData.length > 0) &&(!"".equals(sql)))
	 		{	
	 			for(int u=0; u<readData.length;u++)
	 			{	
	 				sb.append("<Field>");
                    sb.append("<Field1>" + readData[u][0]+ "</Field1>");
                    sb.append("<Field2>" + readData[u][1]+ "</Field2>");  
                    sb.append("<Field3>" + readData[u][2]+ "</Field3>");
                    sb.append("<Field4>" + readData[u][3]+ "</Field4>");
                    sb.append("<Field5>" + readData[u][4]+ "</Field5>");
                    sb.append("<Field6>" + readData[u][5]+ "</Field6>");
                    sb.append("<Field7>" + readData[u][6]+ "</Field7>");
                    sb.append("<Field8>" + readData[u][7]+ "</Field8>");
                   // sb.append("<Field9>" + readData[u][5]+ "</Field9>");
                    //sb.append("<Field10>" + readData[u][5]+ "</Field10>");
                    
                    sb.append("</Field>");	                    
	 			}
	 			//System.out.println(sb);
	 			response.setContentType("text/xml");
	            response.setHeader("Cache-Control", "no-cache");
		        response.getWriter().write("<Fieldss>" + sb.toString() + "</Fieldss>");
			} 
	 		else 
	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
    	 } 
    	 catch (Exception e) 
    	 {
    		 System.out.println(e.getMessage());
 			 request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		 dispatchers.forward(request, response);
    	 } 
    }	
    
    
    
    //send Flyer Mail
    public static void MailServerSession(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
    	 try
    	 {
    		String sql = "SELECT INT_GROUPID,DAT_DATE,CHR_EMAILID FROM  email_m_setting WHERE CHR_MAILSENDFLAG='N' ";
    		String readData[][]=  CommonFunctions.QueryExecute(sql);
 			if(readData.length>0)
 			{
 
 				StringBuffer sb = new StringBuffer();   
 				int f= Integer.parseInt( CommonFunctions.QueryExecute("select (( SELECT DATE_FORMAT('"+readData[0][1]+"','%y-%m-%d %H:%i')) =(select DATE_FORMAT(now(),'%y-%m-%d %H:%i')))")[0][0]);
 				sb.append("<Session>");    	            
 	 			if(f==1)
 	 			{
 	 				com.my.org.erp.SmartUtility.SendGreetingsMail.readEemailIds(readData[0][0], readData[0][2]);
 	 				sb.append("<Flag>Y</Flag>");
 	 			}	
 	 			else
 	 			{
 	 				sb.append("<Flag>N</Flag>");
 	 			}	
 	 			sb.append("</Session>");
 	 			response.setContentType("text/xml");
 	 			response.setHeader("Cache-Control", "no-cache");
 	 			response.getWriter().write("<Sessions>"+sb.toString()+"</Sessions>");
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
    
   //loadNotification
    public static void loadNotification(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
    	 try
    	 {
     		String message = "";
     		ServletContext sc = request.getSession().getServletContext();
     		message = (String) sc.getAttribute("ERP_MESSAGE");
     		if(message.length()>0)
 			{
     			StringBuffer sb = new StringBuffer();   
 				sb.append("<Row>");
 				if(message.length()>0)
 					sb.append("<Flag>Y</Flag>");
 				else
 	 				sb.append("<Flag>N</Flag>");
 				sb.append("<Message>"+message+"</Message>");
 				sb.append("</Row>");
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
    
    //  Start Author :: Kalaiselvan  ------------------------------UniqueIdSales-----------
    public static void UniqueIdSales(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
    	 try
    	 {
    		 	String sql=""; 
    		 	String itype=""+request.getParameter("itype");
    		 	String itemname=""+request.getParameter("itemname");
    		 	String search=""+request.getParameter("search");
    		 	HttpSession session=request.getSession();			
				String branchid = session.getAttribute("INVBRANCH").toString();
				
				sql = "SELECT TRIM(CHR_SERIALNO) ,CHR_WARRANTY ,CHR_QUALITY,CHR_FLAG FROM inv_t_vendorgoodsreceived ";
				sql = sql+ " WHERE CHR_FLAG='N' AND CHR_GRTFLAG='N' ";
				sql = sql+ " AND CHR_TYPE='"+itype+"' ";
				sql = sql+ " AND CHR_ITEMID='"+itemname+"' ";
				sql = sql+ " AND INT_BRANCHID="+Integer.parseInt(branchid);
				if(search.length()>0)
					sql = sql+ " AND TRIM(CHR_SERIALNO) LIKE '%"+search.trim()+"%'";
				sql = sql+ "  ORDER BY CHR_SERIALNO ";
    		 	System.out.println(sql);
    		 	String readData[][] = CommonFunctions.QueryExecute(sql);
    	     	StringBuffer sb = new StringBuffer(); 
    	     	if(readData.length>0)
    	     	{	
    	     		for(int u=0; u<readData.length;u++)
    	     			if(!"-".equals(readData[u][0].trim()))
    	     			{
    	     	
    	     				sb.append("<Id>");    	     		
			     			sb.append("<Serial>"+readData[u][0].trim()+"</Serial>");
			     			sb.append("<Warranty>"+readData[u][1].trim()+"</Warranty>");
			     			sb.append("<Good>"+readData[u][2].trim()+"</Good>");
			     			sb.append("<Flag>"+readData[u][3].trim()+"</Flag>");
			     			sb.append("</Id>");
    	     			}   
    	     		response.setContentType("text/xml");
    	     		response.setHeader("Cache-Control", "no-cache");
    	     		response.getWriter().write("<Ids>" + sb.toString() + "</Ids>");
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

    
    public static void loadSearchStaff(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    		
    		String search =""+request.getParameter("search");
     		String sql = "SELECT CHR_EMPID,CHR_STAFFNAME FROM com_m_staff WHERE   CHR_TYPE !='Y' AND CHR_HOLD!='Y'  ";
     		if(!"".equals(search)&& !"null".equals(search) )
     			sql = sql +" AND (  (CHR_STAFFNAME LIKE '"+search+"%')  OR (CHR_EMPID LIKE '%"+search+"%')     ) ";
     		sql = sql +" ORDER BY CHR_STAFFNAME";
     		String readData[][] =  CommonFunctions.QueryExecute(sql);
     		StringBuffer sb = new StringBuffer(); 
			if( readData.length > 0 )
	 		{	
	 			for(int u=0; u<readData.length;u++)
	 			{	
	 				sb.append("<Row>");
                    sb.append("<Id>" + readData[u][0]+ "</Id>");
                    sb.append("<Name>" + readData[u][1]+ "</Name>");  
                    sb.append("</Row>");	                    
	 			}
	 			
	 			response.setContentType("text/xml");
	            response.setHeader("Cache-Control", "no-cache");
		        response.getWriter().write("<Rowss>" + sb.toString() + "</Rowss>");
			} 
	 		else 
	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			
     		
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
		
	
	public static void LoadSelectDistrict(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
    	 try 
    	 {    		 	
    		String State=request.getParameter("state");
 	 		String sql="SELECT  INT_DISTRICTID,CHR_DISTRICT  FROM com_m_district   WHERE INT_DISTRICTID>0 ";
 	 		if(!"0".equals(State))
 	 			sql = sql +" AND INT_STATEID="+State;
 	 		sql = sql +" ORDER BY CHR_DISTRICT ";
 	 		System.out.println(sql);
 	 		String readData[][] =  CommonFunctions.QueryExecute(sql);
     		if(readData.length>0)
     		{
     			StringBuffer sb = new StringBuffer();   
     			for(int u=0; u<readData.length;u++)
    	     		{
     				sb.append("<Row>");  	     		
 			     	sb.append("<Id>"+readData[u][0]+"</Id>");
 		     		sb.append("<Name>"+readData[u][1].toUpperCase()+"</Name>");
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
   
    
    
    
	public static void LoadSelectCity(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
    	 try
    	 {
    	 		String state=request.getParameter("state");
    	 		String district=request.getParameter("district");
    	 		String sql="";
    	 		sql ="  SELECT INT_CITYID,CHR_CITYNAME FROM com_m_city  WHERE INT_CITYID >=1";
    	 		if(!"0".equals(state))
    	 			sql = sql + " AND INT_STATEID = "+state;
    	 		if(!"0".equals(district))
    	 			sql = sql + " AND INT_DISTRICTID = "+district;
    	 		sql = sql +" ORDER BY CHR_CITYNAME ";
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
	
	public static void AssignPincode(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
	{
		 try
		 {
			
			String city = ""+request.getParameter("city");	
			String sql="";
			sql = " SELECT DECODE(CHR_PINCODE,'9865043008'),CHR_CITYNAME FROM  com_m_city WHERE INT_CITYID ="+city;
			StringBuffer sb = new StringBuffer();
			String readData[][] =  CommonFunctions.QueryExecute(sql);
			if (readData.length > 0)
	 		{	
	 			sb.append("<Row>");
	 			sb.append("<Id>" + readData[0][0]+ "</Id>"); 
	 			sb.append("</Row>");	             
	 			response.setContentType("text/xml");
	            response.setHeader("Cache-Control", "no-cache");
		        response.getWriter().write("<Rows>" + sb.toString() + "</Rows>");
			} 
		 	else 
		 		response.setStatus(HttpServletResponse.SC_NO_CONTENT);
		 } 
		 catch (Exception e) 
		 {
			 System.out.println(e.getMessage());
 			 request.setAttribute("error", e.getMessage() );
             RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
     		 dispatchers.forward(request, response);
		 } 
	}	



    
	
	
	
	  public static void LoadISD(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
	    {
	    	 try
	    	 {
	    		
	    		String startLetter = request.getParameter("startLetter");
	    		String f = request.getParameter("f");
	    		String sql="SELECT CHR_NAME,CHR_CITY,CHR_ISDCODE  FROM  com_m_isdcode  WHERE INT_ISDCODEID>=1";
	    		if("N".equals(f))
	    			sql = sql +" AND CHR_NAME like '"+startLetter+"%' ";
	    		else
	    			sql = sql +" AND CHR_ISDCODE like '"+startLetter+"%' ";
	    		
	    		sql = sql +" ORDER BY CHR_NAME ";
	    		String readData[][] =  CommonFunctions.QueryExecute(sql);
	    		if(readData.length>0)
	    		{
	    			StringBuffer sb = new StringBuffer();   
	    			for(int u=0; u<readData.length;u++)
	   	     		{
	    				sb.append("<Row>");  	     		
				     	sb.append("<Name>"+readData[u][0].replaceAll("&", " AND ")+"</Name>");
			     		sb.append("<City>"+readData[u][1].replaceAll("&", " AND ")+"</City>");
			     		sb.append("<Code>"+readData[u][2]+"</Code>");
			     		
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
		
		
		
		
	    public static void LoadSTD(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	 try
	    	 {
	    		
	    		String startLetter = request.getParameter("startLetter");
	    		String f = request.getParameter("f");
	    		String sql="SELECT CHR_NAME,CHR_STATE, CHR_STDCODE   FROM  com_m_stdcode  WHERE INT_STDCODEID>=1";
	    		if("N".equals(f))
	    			sql = sql +" AND CHR_NAME like '"+startLetter+"%' ";
	    		else
	    			sql = sql +" AND CHR_STDCODE like '"+startLetter+"%' ";
	    		
	    		sql = sql +" ORDER BY CHR_NAME ";
	    		 
	    		String readData[][] =  CommonFunctions.QueryExecute(sql);
	    		if(readData.length>0)
	    		{
	    			StringBuffer sb = new StringBuffer();   
	    			for(int u=0; u<readData.length;u++)
	   	     		{
	    				sb.append("<Row>");  	     		
				     	sb.append("<Name>"+readData[u][0].replaceAll("&", " AND ")+"</Name>");
			     		sb.append("<City>"+readData[u][1].replaceAll("&", " AND ")+"</City>");
			     		sb.append("<Code>"+readData[u][2]+"</Code>");
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
	    	
   
		
		  public static void LoadPINCODE(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
		    {
		    	 try
		    	 {
		    		String startLetter = request.getParameter("startLetter");
		    		String f = request.getParameter("f");
		    		String sql = " SELECT d.CHR_COUNTRYNAME,a.CHR_STATENAME ,b.CHR_DISTRICT,c.CHR_CITYNAME,(DECODE(c.CHR_PINCODE,'9865043008')) ";
		    		sql = sql +" FROM com_m_state a,com_m_district b,com_m_city c ,com_m_country d WHERE a.INT_STATEID = b.INT_STATEID "; 
		    		sql = sql +" AND b.INT_DISTRICTID = c.INT_DISTRICTID  AND c.INT_COUNTRYID =d.INT_COUNTRYID ";
		    		if("N".equals(f))
		    			sql = sql +" AND c.CHR_CITYNAME like '"+startLetter+"%'  ORDER BY c.CHR_CITYNAME  ";
		    		else
		    			sql = sql +" AND (DECODE(c.CHR_PINCODE,'9865043008')) like '"+startLetter+"%' ORDER BY (DECODE(c.CHR_PINCODE,'9865043008')) ";
		    		String readData[][] =  CommonFunctions.QueryExecute(sql);
		    		if(readData.length>0)
		    		{
		    			StringBuffer sb = new StringBuffer();   
		    			for(int u=0; u<readData.length;u++)
		   	     		{
		    				sb.append("<Row>");  	     		
					     	sb.append("<Country>"+readData[u][0].replaceAll("&", " AND ")+"</Country>");
				     		sb.append("<State>"+readData[u][1].replaceAll("&", " AND ")+"</State>");
				     		sb.append("<District>"+readData[u][2].replaceAll("&", " AND ")+"</District>");
				     		sb.append("<City>"+readData[u][3].replaceAll("&", " AND ")+"</City>");
				     		sb.append("<Code>"+readData[u][4]+"</Code>");
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
