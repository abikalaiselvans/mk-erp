package com.my.org.erp.SmartStaff;
 

 
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.file.FileFunctions;
public class CommonMethod extends HttpServlet
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L; 
	
	
	 public static void LoadDailyEngineerReport(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	 try 
	    	 {    		 	
	    		 	
	    		 	String search=""+request.getParameter("startLetter");
	    		 	String month=""+request.getParameter("month");
	    		 	String year=""+request.getParameter("year");
	    		 	String day=""+request.getParameter("day");
	    		 	String callstatus=""+request.getParameter("callstatus");
	    		 	String calltype=""+request.getParameter("calltype");
	    		 	
	    		 	String monthname= DateUtil.getMonth(Integer.parseInt(month));
	    		 	HttpSession session=request.getSession();
	    		 	String empid = "" + session.getAttribute("EMPID");
	    		 	
	    		 	String usertype = "" + session.getAttribute("USERTYPE");
	    		 	
	    		 	String sql="";
	    			sql = " SELECT  a.INT_ID,DATE_FORMAT(a.DAT_DATE,'%d-%b-%Y') ,a.CHR_CALLNUMBER,a.CHR_CUSTOMERNAME,a.CHR_CUSTOMERLOCATION,a.CHR_CALLTYPE,a.CHR_CALLSTATUS, ";
	    		 	sql = sql + " a.INT_HANDSONHOURS,a.INT_HANDSONMINUTES,a.INT_TRAVELHOURS,a.INT_TRAVELMINUTES,a.INT_KM,a.INT_NOOFSPARE,a.CHR_DAYCLOSED, ";
	    		 	sql = sql + " b.CHR_EMPID,b.CHR_STAFFNAME  FROM  servicecall_t_report a, com_m_staff b ";
	    		 	sql = sql + "  WHERE a.CHR_EMPID = b.CHR_EMPID  ";
	    		 	if(!"F".equals(usertype))
	    		 		sql = sql + " AND a.CHR_EMPID='"+empid+"'  ";
	    		 	
	    		 	sql = sql + " AND a.CHR_MONTH='"+monthname+"' ";
	    			if(!"0".equals(day))
	    		 		sql = sql + " AND DAY(a.DAT_DATE)="+day;
	    		 	
	    		 	sql = sql + " AND a.INT_YEAR="+year;
	    		 	if(!"0".equals(callstatus))
	    		 		sql = sql + " AND a.CHR_CALLSTATUS='"+callstatus+"'  "; 
	    		 	  
	    		 	if(!"0".equals(calltype))
	    		 		sql = sql + " AND a.CHR_CALLTYPE="+calltype;
	    		 	
	    		 	if(!"0".equals(search))
	    		 		sql=sql+" AND a.CHR_CUSTOMERNAME LIKE'"+search+"%'";
	    		 	sql=sql+" ORDER BY a.DAT_DATE  ";
	    		 	// System.out.println(sql);
	    		 	
	    		 	String readData[][] = CommonFunctions.QueryExecute(sql);
	    	     	StringBuffer sb = new StringBuffer(); 
	    	     	if(readData.length>0)
	    	     	{	
	    	     		for(int u=0; u<readData.length;u++)
	    	     		{
	    	     			sb.append("<Row>");    	     		
				     		sb.append("<Id>"+readData[u][0]+"</Id>");
				     		sb.append("<Date>"+readData[u][1].toUpperCase()+"</Date>");
			     			sb.append("<Callno>"+readData[u][2].toUpperCase()+"</Callno>");
			     			sb.append("<Customername>"+readData[u][3].toUpperCase()+"</Customername>");
			     			sb.append("<Location>"+readData[u][4].toUpperCase()+"</Location>");                      
			     			sb.append("<Calltype>" +readData[u][5].toUpperCase()+"</Calltype>");
			     			sb.append("<Callstatus>"+readData[u][6]+"</Callstatus>"); 
			     			sb.append("<Hhour>"+readData[u][7]+"</Hhour>"); 
			     			sb.append("<Hminute>"+readData[u][8]+"</Hminute>"); 
			     			sb.append("<TRH>"+readData[u][9]+"</TRH>"); 
			     			sb.append("<TRM>"+readData[u][10]+"</TRM>"); 
			     			sb.append("<TKM>"+readData[u][11]+"</TKM>"); 
			     			sb.append("<Spare>"+readData[u][12]+"</Spare>"); 
			     			sb.append("<Day>"+readData[u][13]+"</Day>");
			     			sb.append("<Empid>"+readData[u][14]+"</Empid>"); 
			     			sb.append("<Empname>"+readData[u][15]+"</Empname>");
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
		
	    
	 
	 public static void INVloadEMDAsset(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	 try
	    	 {
	    		 	HttpSession session=request.getSession();	
	    		 	
	    		 	String offic=request.getParameter("office");
	    		 	String EmdType=request.getParameter("EmdType");
	    			int month=Integer.parseInt(request.getParameter("month"));
			 		int year=Integer.parseInt(request.getParameter("year"));
			 		String StartLetter = ""+request.getParameter("startLetter");
			 		String accept = ""+request.getParameter("accept");
			 		String returned = ""+request.getParameter("returned");
	    		 	String bid=""+session.getAttribute("BRANCHID");
	    		 	String sql = "SELECT a.INT_EMDID,if(a.INT_EMD_TYPE ='E','Earnest Money Deposit',if(a.INT_EMD_TYPE ='B','Bank Guarantee','Security Deposit')),FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID ),a.DOU_EMD_AMOUNT,DATE_FORMAT(a.DAT_TENDER_LASTDATE,'%d-%b-%Y'),a.CHR_APPROVAL,a.CHR_STATUS,d.CHR_DIVICODE,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF)";
			 		sql = sql +" FROM inv_t_emd_informations a,inv_m_customerinfo b,com_m_staff c,inv_m_division d WHERE a.INT_DIVIID =d.INT_DIVIID AND a.INT_CUSTOMERID = b.INT_CUSTOMERID";
	    	    	sql = sql +" AND  a.CHR_REF =c.CHR_EMPID";
			 		if(!"0".equals(bid))
		    	    	sql = sql +" AND  a.INV_BRANCHID ="+bid;
		    	    if(!"0".equals(offic))
		    	    	sql = sql +" AND  c.INT_OFFICEID ="+offic;
		    	    if(!"0".equals(EmdType))
		    	    	sql = sql +" AND a.INT_EMD_TYPE ='"+EmdType+"'";
		    	    if(!"0".equals(accept))
		    	    	sql = sql +" AND a.CHR_APPROVAL ='"+accept+"'";
		    	    if(!"0".equals(returned))
		    	    	sql = sql +" AND a.CHR_STATUS ='"+returned+"'";
		    	    
		    	    if(!"0".equals(month))
		    	    	sql = sql +" AND MONTH(a.DAT_CREATION) = "+month;
			 		sql = sql +" AND YEAR(a.DAT_CREATION) = "+year;
			 		sql = sql +" AND a.CHR_USRNAME ='"+session.getAttribute("USRID")+"'";
			 		sql = sql +" ORDER BY a.INT_CUSTOMERID ";
			 		System.out.println("========"+sql);
			 		String readData[][] = CommonFunctions.QueryExecute(sql);
			 		StringBuffer sb = new StringBuffer();
			 		if (readData.length > 0)
			 		{	
			 			for(int u=0; u<readData.length;u++)
			 			{
			 				if(readData[u][1].toUpperCase().startsWith(StartLetter) || "0".startsWith(StartLetter))
			 				{
			 					sb.append("<Emddetail>");
			 	 				sb.append("<Emdid>"+readData[u][0]+"</Emdid>");
			 	 				sb.append("<EmdType>" +readData[u][1]+ "</EmdType>");
			 	 				sb.append("<CustomerName>" +readData[u][2]+ "</CustomerName>");
			 	 				sb.append("<EmdAmt>" + readData[u][3]+ "</EmdAmt>");
			 	 				sb.append("<TenderLastDate>" + readData[u][4]+ "</TenderLastDate>");
			 	 				sb.append("<Approval>"+readData[u][5]+"</Approval>");
			 	 				sb.append("<Status>"+readData[u][6]+"</Status>");
			 	 				sb.append("<Division>"+readData[u][7]+"</Division>");
			 	 				sb.append("<Entry>"+readData[u][8]+"</Entry>");
			    	     		sb.append("</Emddetail>");
			 				}
			 			}
			 			response.setContentType("text/xml");
			 			response.setHeader("Cache-Control", "no-cache");
			 			response.getWriter().write("<Emd>" + sb.toString() + "</Emd>");
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

	 
	 public static void INVloadStaffEMD(HttpServletRequest request,
				HttpServletResponse response) throws IOException, ServletException {
			try {
				HttpSession session = request.getSession();
				String offic = request.getParameter("office");
				String EmdType = request.getParameter("EmdType");
				String month = request.getParameter("month");
				int year = Integer.parseInt(request.getParameter("year"));
				String StartLetter = "" + request.getParameter("startLetter");
				String accept = "" + request.getParameter("accept");
				String returned = "" + request.getParameter("returned");
				String bid = "" + session.getAttribute("BRANCHID");
				String sql = "SELECT a.INT_EMDID,a.CHR_EMD_REFNUMBER,if(a.INT_EMD_TYPE ='E','Earnest Money Deposit',if(a.INT_EMD_TYPE ='B','Bank Guarantee','Security Deposit')),FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID ),a.DOU_EMD_AMOUNT,DATE_FORMAT(a.DAT_TENDER_LASTDATE,'%d-%b-%Y'),a.CHR_APPROVAL,a.CHR_STATUS,d.CHR_DIVICODE,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF)";
				sql = sql
						+ " FROM inv_t_emd_informations a,inv_m_customerinfo b,com_m_staff c,inv_m_division d WHERE a.INT_DIVIID =d.INT_DIVIID AND a.INT_CUSTOMERID = b.INT_CUSTOMERID";
				sql = sql + " AND  a.CHR_REF =c.CHR_EMPID";
				if (!"0".equals(bid))
					sql = sql + " AND  a.INV_BRANCHID =" + bid;
				if (!"0".equals(offic))
					sql = sql + " AND  c.INT_OFFICEID =" + offic;
				if (!"0".equals(EmdType))
					sql = sql + " AND a.INT_EMD_TYPE ='" + EmdType + "'";
				if (!"0".equals(accept))
					sql = sql + " AND a.CHR_APPROVAL ='" + accept + "'";
				if (!"0".equals(returned))
					sql = sql + " AND a.CHR_STATUS ='" + returned + "'";
				if(!"0".equals(StartLetter))
	    			sql = sql + " AND FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID ) LIKE '"+StartLetter+"%'";
	    		

				if (!"0".equals(month))
					sql = sql + " AND MONTH(a.DAT_CREATION) = " + month;
				sql = sql + " AND YEAR(a.DAT_CREATION) = " + year;
				sql = sql + " AND a.CHR_REF='" + session.getAttribute("EMPID")+ "' ";
				sql = sql + " ORDER BY  FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID ) ";
				System.out.println(sql);
				String readData[][] = CommonFunctions.QueryExecute(sql);
				StringBuffer sb = new StringBuffer();
				
				if (readData.length > 0) 
				{
					for (int u = 0; u < readData.length; u++) 
					{
						 	sb.append("<Emddetail>");
							sb.append("<Emdid>" + readData[u][0] + "</Emdid>");
							sb.append("<Emdnumber>" + readData[u][1]+ "</Emdnumber>");
							sb.append("<EmdType>" + readData[u][2] + "</EmdType>");
							sb.append("<CustomerName>"+ readData[u][3].replaceAll("&", " AND")+ "</CustomerName>");
							sb.append("<EmdAmt>" + readData[u][4] + "</EmdAmt>");
							sb.append("<TenderLastDate>" + readData[u][5]+ "</TenderLastDate>");
							sb.append("<Approval>" + readData[u][6] + "</Approval>");
							sb.append("<Status>" + readData[u][7] + "</Status>");
							sb.append("<Division>" + readData[u][8] + "</Division>");
							sb.append("<Entry>" + readData[u][9] + "</Entry>");
							sb.append("</Emddetail>");
						 
					}
					  
					response.setContentType("text/xml");
					response.setHeader("Cache-Control", "no-cache");
					response.getWriter().write("<Emd>" + sb.toString() + "</Emd>");
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
	    		 
	    		HttpSession session = request.getSession();
				String usertype  = (""+session.getAttribute("USERTYPE")).toUpperCase();
				String createdby  = (""+session.getAttribute("EMPID")).toUpperCase();
				System.out.println(usertype);
	    		String sql="";
	 	 		sql ="  SELECT a.INT_CUSTOMERID,a.CHR_CONTACTPERSON,f.CHR_NAME, a.CHR_ADDRESS1,a.CHR_ADDRESS2,a.CHR_ADDRESS3 , ";
	 	 		sql = sql + " c.CHR_STATENAME,d.CHR_DISTRICT, e.CHR_CITYNAME, a.INT_PINCODE,a.INT_PHONE1,a.INT_MOBILE1,a.CHR_FAX,a.CHR_EMAIL,a.CHR_WEBSITE,   "; 
	 	 		sql = sql + "  a.CHR_ACTIVE, b.CHR_GROUPNAME ,FIND_A_EMPLOYEE_ID_NAME(a.CHR_CREATEDBY),a.CHR_VERIFY   ";
	 	 		sql = sql + " FROM mkt_m_customerinfo a,mkt_m_customergroup  b ,com_m_state c  ,com_m_district d,com_m_city e , mkt_m_customername f   ";
	 	 		sql = sql + " WHERE a.INT_GROUPID=b.INT_GROUPID    ";
	 	 		sql = sql + " AND a.INT_STATEID=c.INT_STATEID     ";
	 	 		sql = sql + " AND a.INT_DISTRICTID = d.INT_DISTRICTID   "; 
	 	 		sql = sql + " AND a.INT_CITYID = e.INT_CITYID  AND a.INT_CUSTOMERNAMEID = f.INT_CUSTOMERNAMEID ";
	 	 		if(!"0".equals(active))
	 	 			sql = sql + " AND a.CHR_ACTIVE = '"+active+"' ";
	 	 		if(!"0".equals(verified))
	 	 			sql = sql + " AND a.CHR_VERIFY = '"+verified+"' ";
	 	 		
	 	 		if(  !("F".equals(usertype) || "B".equals(usertype))  )
	 	 			sql = sql + " AND a.CHR_CREATEDBY ='"+createdby+"'";
	 	 		if(!"0".equals(group))
	 	 			sql = sql + " AND a.INT_GROUPID ="+group;
	 	 		if(!"0".equals(startLetter))
	 	 			sql = sql + " AND a.CHR_COMPANYNAME LIKE '"+startLetter+"%' ";
	 	 		sql = sql +" ORDER BY a.INT_CUSTOMERID ";
	 	 		 
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
		 					sb.append("<GName>" +(readData[u][16].toUpperCase()).replaceAll("&", " AND ") + "</GName>");
		 					sb.append("<Createdby>" +readData[u][17]+ "</Createdby>");
		 					sb.append("<verified>" +readData[u][18]+ "</verified>");
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
	 
	 public static void LoadScheduleEntrystaff(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
	    {
	    	 try 
	    	 {    		 	
	    		String startLetter=request.getParameter("startLetter");
	    		String day=request.getParameter("day");
	    		String month=request.getParameter("month");
	    		String year=request.getParameter("year");
	    		String customer=request.getParameter("customer");
	    		String calltype=request.getParameter("calltype");
	    		String status=request.getParameter("status");
	    		
	    		
	    		HttpSession session = request.getSession();
	    		String empid = (String) session.getAttribute("EMPID");
	 	 		String sql="";
	 	 		sql = " SELECT  a.INT_CALLID,d.CHR_NAME,c.CHR_CALLTYPE,a.CHR_NAME, DATE_FORMAT(a.DAT_START,'%W %d-%b-%Y %H:%i:%s  %p'),  DATE_FORMAT(a.DAT_END,'%W %d-%b-%Y %H:%i:%s  %p'),a.CHR_STATUS,a.CHR_NEXT,DAT_FOLLOWON  ";  
	 	 		sql = sql + " FROM mkt_t_daillycalls a,mkt_m_customerinfo b,mkt_k_calltype c ,mkt_m_customername d";
	 	 		sql = sql + " WHERE  a.INT_CALLID >0 AND a.INT_CUSTOMERID=b.INT_CUSTOMERID AND a.CHR_CALLTYPE=c.INT_CALLTYPEID ";
	 	 		sql = sql + " AND b.INT_CUSTOMERNAMEID = d.INT_CUSTOMERNAMEID AND a.CHR_EMPID='"+empid+"'   ";
	 	 		if(!"0".equals(status))
	 	 			sql = sql+ " AND a.CHR_STATUS = '"+status+"' ";
	 	 		
	 	 		if(!"0".equals(day))
	 	 			sql = sql+ " AND DAY(a.DAT_START)="+day;
	 	 		
	 	 		if(!"0".equals(calltype))
	 	 			sql = sql+ " AND a.CHR_CALLTYPE="+calltype;
	 	 		
	 	 		if(!"0".equals(month))
	 	 			sql = sql+ " AND MONTH(a.DAT_START)="+month;
	 	 		
	 	 		if(!"0".equals(year))
	 	 			sql = sql+ " AND YEAR(a.DAT_START)="+year;
	 	 		
	 	 		if(!"0".equals(customer))
	 	 			sql = sql+ " AND b.INT_CUSTOMERID="+customer;
	 	 		
	 	 		if(!"0".equals(startLetter))
	 	 			sql = sql + " AND d.CHR_NAME LIKE '"+startLetter+"%' ";
	 	 		sql = sql +" ORDER BY d.CHR_NAME,a.DAT_START";
	 	 		//System.out.println(sql);
	 	 		String readData[][] = CommonFunctions.QueryExecute(sql);

	 	 		@SuppressWarnings("deprecation")
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
		 					sb.append("<SDate>" +readData[u][4]+ "</SDate>");
		 					sb.append("<EDate>" +readData[u][5]+ "</EDate>");
		 					sb.append("<Status>" +readData[u][6]+ "</Status>");
		 					sb.append("<Next>" +readData[u][7]+ "</Next>");
		 					sb.append("<DFollowon>" +readData[u][8]+ "</DFollowon>");
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
	 
	    
}
