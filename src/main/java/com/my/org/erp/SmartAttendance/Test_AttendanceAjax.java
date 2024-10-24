package com.my.org.erp.SmartAttendance;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Test_AttendanceAjax extends HttpServlet{
	private static final long serialVersionUID = 1L;
	String readData[][];
	
	private void loadDistrict(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
     try 
    	 {
    	 		String stateId=request.getParameter("id");
    	 		String vrtxtstr=request.getParameter("txtSer");
    	 		////System.out.println("vendor"+stateId);
    	 		vrtxtstr=vrtxtstr.toUpperCase();
    		 	String query="SELECT INT_DISTRICTID,CHR_DISTRICT from  com_m_district  where int_stateid='"+stateId+"'";    			
    			readData= com.my.org.erp.common.CommonFunctions.QueryExecute(query);    		   	     	
    	     	StringBuffer sb = new StringBuffer();    	     	
    	     	boolean flag = false;
    	     	for(int u=0; u<readData.length;u++)
    	     	{
    	     		if(readData[u][1].toUpperCase().startsWith(vrtxtstr) || "".equalsIgnoreCase(vrtxtstr))
		    	     { 
    	     		flag = true;
    	     			sb.append("<district>");    	            
    	                sb.append("<districtId>" +readData[u][0]+ "</districtId>");
    	                sb.append("<districtName>" +readData[u][1] + "</districtName>");      	                         
    	                sb.append("</district>");	
    	     		}    	
    	     	}	
    	    	if (flag) 
    	     	{
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
    	 	} 
    }
	
	
	 private void loadCompensationData(HttpServletRequest request, HttpServletResponse  response)
	    throws IOException, ServletException {
	    	 try 
	    	 {
	    			int year=Integer.parseInt(request.getParameter("year"));     			
	    			
			 		int mon=Integer.parseInt(request.getParameter("month"));
			 		
			 		String startLetter=""+request.getParameter("id");
	    		 	String sql ="";
	    		 	if("0".equals(startLetter))
	    		 	{


	    		 	sql="SELECT A.CHR_EMPID,A.CHR_STAFFNAME ,C.CHR_COMPANYNAME,B.CHR_BRANCHNAME, ";
	    		 	sql=sql+" D.CHR_DEPARTNAME,E.CHR_DESIGNAME,F.CHR_HOLINAME,min(F.DT_HOLIDATE), ";
	    		 	sql=sql+" max(F.DT_HOLIDATE),count(F.DT_HOLIDATE) FROM  com_m_staff  A, ";
	    		 	sql=sql+"  com_m_branch  B, com_m_company  C,  com_m_depart   D,  com_m_desig  E, "; 
	    		 	sql=sql+" att_t_compensation F WHERE A.INT_BRANCHID=B.INT_BRANCHID AND ";
	    		 	sql=sql+" A.INT_COMPANYID=C.INT_COMPANYID  AND A.INT_DEPARTID=D.INT_DEPARTID ";
	    		 	sql=sql+" AND A.INT_DESIGID= E.INT_DESIGID AND A.CHR_EMPID=F.CHR_EMPID ";
	    		 	sql=sql+" AND F.CHR_MONTH='"+com.my.org.erp.ServiceLogin.DateUtil.getMonth(mon)+"' AND F.INT_YEAR="+year+" group by F.CHR_HOLINAME order By A.CHR_STAFFFNAME";
	    		 	}	      		 	
	    		 	else
	    		 	{
	    		 		sql="SELECT A.CHR_EMPID,A.CHR_STAFFNAME ,C.CHR_COMPANYNAME,B.CHR_BRANCHNAME, ";
		    		 	sql=sql+" D.CHR_DEPARTNAME,E.CHR_DESIGNAME,F.CHR_HOLINAME,min(F.DT_HOLIDATE), ";
		    		 	sql=sql+" max(F.DT_HOLIDATE),count(F.DT_HOLIDATE) FROM  com_m_staff  A, ";
		    		 	sql=sql+"  com_m_branch  B, com_m_company  C,  com_m_depart   D,  com_m_desig  E, "; 
		    		 	sql=sql+" att_t_compensation F WHERE A.INT_BRANCHID=B.INT_BRANCHID AND ";
		    		 	sql=sql+" A.INT_COMPANYID=C.INT_COMPANYID  AND A.INT_DEPARTID=D.INT_DEPARTID ";
		    		 	sql=sql+" AND A.INT_DESIGID= E.INT_DESIGID AND A.CHR_EMPID=F.CHR_EMPID ";
		    		 	sql=sql+" AND F.CHR_MONTH='"+com.my.org.erp.ServiceLogin.DateUtil.getMonth(mon)+"' AND F.INT_YEAR="+year+" and A.CHR_STAFFNAME LIKE '"+startLetter+"%' group by F.CHR_HOLINAME order By A.CHR_STAFFFNAME";	
	    		 			    		 		    		 	
	    		 	}	    		 		
	    		  	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	    	     	StringBuffer sb = new StringBuffer(); 	    	     	
	    	     		for(int u=0; u<readData.length;u++)
	    	     		{
	    	     				sb.append("<Compensation>");    
	    	     				sb.append("<Empid>"+readData[u][0]+"</Empid>");
	    	     				sb.append("<Staffname>"+readData[u][1]+"</Staffname>");
	    	     				sb.append("<Companyname>"+readData[u][2]+"</Companyname>");   
	    	     				sb.append("<Branchname>"+readData[u][3]+"</Branchname>");
	    	     				sb.append("<Depart>"+readData[u][4]+"</Depart>");
	    	     				sb.append("<Desig>"+readData[u][5]+"</Desig>");
	    	     				sb.append("<CompensationName>"+readData[u][6]+"</CompensationName>");
	    	     				sb.append("<CompensationFromDate>"+readData[u][7]+"</CompensationFromDate>");
	    	     				sb.append("<CompensationToDate>"+readData[u][8]+"</CompensationToDate>");
	    	     				sb.append("<NoDays>"+readData[u][9]+"</NoDays>");
	    	     				sb.append("</Compensation>");
	    	     		}	          
	    	     		
	    	     		response.setContentType("text/xml");
	    	     		response.setHeader("Cache-Control", "no-cache");
	    	     		response.getWriter().write("<compensations>" + sb.toString() + "</compensations>");
	    	     	  		     	 	 
	    	 	} 
	    	 	catch (Exception e) 
	    	 	{
				 
				 System.out.println(e.getMessage());
	    	 	} 
	    }	
		 	
	
	
	 private void loadHolidayData(HttpServletRequest request, HttpServletResponse  response)
	    throws IOException, ServletException {
	    	 try 
	    	 {
	    			int year=Integer.parseInt(request.getParameter("year"));     			
	    			
			 		int mon=Integer.parseInt(request.getParameter("month"));
			 		
			 		String startLetter=""+request.getParameter("id");
	    		 	String sql ="";
	    		 	if("0".equals(startLetter))
	    		 	{


	    		 	sql="SELECT A.CHR_EMPID,A.CHR_STAFFNAME ,C.CHR_COMPANYNAME,B.CHR_BRANCHNAME, ";
	    		 	sql=sql+" D.CHR_DEPARTNAME,E.CHR_DESIGNAME,F.CHR_HOLINAME,min(F.DT_HOLIDATE), ";
	    		 	sql=sql+" max(F.DT_HOLIDATE),count(F.DT_HOLIDATE) FROM  com_m_staff  A, ";
	    		 	sql=sql+"  com_m_branch  B, com_m_company  C,  com_m_depart   D,  com_m_desig  E, "; 
	    		 	sql=sql+" att_t_holiday F WHERE A.INT_BRANCHID=B.INT_BRANCHID AND ";
	    		 	sql=sql+" A.INT_COMPANYID=C.INT_COMPANYID  AND A.INT_DEPARTID=D.INT_DEPARTID ";
	    		 	sql=sql+" AND A.INT_DESIGID= E.INT_DESIGID AND A.CHR_EMPID=F.CHR_EMPID ";
	    		 	sql=sql+" AND F.CHR_MONTH='"+com.my.org.erp.ServiceLogin.DateUtil.getMonth(mon)+"' AND F.INT_YEAR="+year+" group by F.CHR_HOLINAME order By A.CHR_STAFFFNAME";
	    		 	}	      		 	
	    		 	else
	    		 	{
	    		 		sql="SELECT A.CHR_EMPID,A.CHR_STAFFNAME ,C.CHR_COMPANYNAME,B.CHR_BRANCHNAME, ";
		    		 	sql=sql+" D.CHR_DEPARTNAME,E.CHR_DESIGNAME,F.CHR_HOLINAME,min(F.DT_HOLIDATE), ";
		    		 	sql=sql+" max(F.DT_HOLIDATE),count(F.DT_HOLIDATE) FROM  com_m_staff  A, ";
		    		 	sql=sql+"  com_m_branch  B, com_m_company  C,  com_m_depart   D,  com_m_desig  E, "; 
		    		 	sql=sql+" att_t_holiday F WHERE A.INT_BRANCHID=B.INT_BRANCHID AND ";
		    		 	sql=sql+" A.INT_COMPANYID=C.INT_COMPANYID  AND A.INT_DEPARTID=D.INT_DEPARTID ";
		    		 	sql=sql+" AND A.INT_DESIGID= E.INT_DESIGID AND A.CHR_EMPID=F.CHR_EMPID ";
		    		 	sql=sql+" AND F.CHR_MONTH='"+com.my.org.erp.ServiceLogin.DateUtil.getMonth(mon)+"' AND F.INT_YEAR="+year+" and F.CHR_HOLINAME LIKE '"+startLetter+"%' group by a.CHR_EMPID order By A.CHR_STAFFFNAME";	
	    		 			    		 		    		 	
	    		 	}	    		 		
	    		  	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	    	     	StringBuffer sb = new StringBuffer(); 	    	     	
	    	     		for(int u=0; u<readData.length;u++)
	    	     		{
	    	     				sb.append("<Holiday>");    
	    	     				sb.append("<Empid>"+readData[u][0]+"</Empid>");
	    	     				sb.append("<Staffname>"+readData[u][1]+"</Staffname>");
	    	     				sb.append("<Companyname>"+readData[u][2]+"</Companyname>");   
	    	     				sb.append("<Branchname>"+readData[u][3]+"</Branchname>");
	    	     				sb.append("<Depart>"+readData[u][4]+"</Depart>");
	    	     				sb.append("<Desig>"+readData[u][5]+"</Desig>");
	    	     				sb.append("<HolidayName>"+readData[u][6]+"</HolidayName>");
	    	     				sb.append("<HolidayFromDate>"+readData[u][7]+"</HolidayFromDate>");
	    	     				sb.append("<HolidayToDate>"+readData[u][8]+"</HolidayToDate>");
	    	     				sb.append("<NoDays>"+readData[u][9]+"</NoDays>");
	    	     				sb.append("</Holiday>");
	    	     		}	          
	    	     		
	    	     		response.setContentType("text/xml");
	    	     		response.setHeader("Cache-Control", "no-cache");
	    	     		response.getWriter().write("<holidays>" + sb.toString() + "</holidays>");
	    	     	  		     	 	 
	    	 	} 
	    	 	catch (Exception e) 
	    	 	{
				 
				 System.out.println(e.getMessage());
	    	 	} 
	    }	
		
	 
	 private void loadOverTime(HttpServletRequest request, HttpServletResponse  response)
	    throws IOException, ServletException {
		 try 
	    	 {
	    		int year=Integer.parseInt(request.getParameter("year"));   
	    		////System.out.println("year"+year);
			 	int mon=Integer.parseInt(request.getParameter("month"));
			 	////System.out.println("month"+mon);
			 	String startLetter=""+request.getParameter("id");
	    		String sql ="";
	    		String monthName=com.my.org.erp.ServiceLogin.DateUtil.getMonth(mon);
	    		if("0".equals(startLetter))
	    		 {
	    			sql="SELECT DISTINCT A.CHR_EMPID,A.CHR_STAFFNAME,C.CHR_COMPANYNAME,B.CHR_BRANCHNAME,"; 
	    			sql=sql+"D.CHR_DEPARTNAME,E.CHR_DESIGNAME FROM  com_m_staff A, ";
	    			sql=sql+"com_m_branch  B, com_m_company C,com_m_depart D,com_m_desig E "; 
	    			sql=sql+" WHERE A.INT_BRANCHID=B.INT_BRANCHID AND ";
	    			sql=sql+" A.INT_COMPANYID=C.INT_COMPANYID  AND A.INT_DEPARTID=D.INT_DEPARTID "; 
	    			sql=sql+" AND A.INT_DESIGID= E.INT_DESIGID AND A.CHR_EMPID in( SELECT CHR_EMPID ";
	    			sql=sql+" FROM att_t_ot WHERE ";
	    			sql=sql+" CHR_MONTH='"+monthName+"' AND INT_YEAR="+year+")";
	    			sql=sql+" ORDER BY CHR_STAFFNAME";
	    		 }
	    		 	else
	    		 {

		    			sql="SELECT DISTINCT A.CHR_EMPID,A.CHR_STAFFNAME,C.CHR_COMPANYNAME,B.CHR_BRANCHNAME,"; 
		    			sql=sql+"D.CHR_DEPARTNAME,E.CHR_DESIGNAME FROM  com_m_staff A, ";
		    			sql=sql+"com_m_branch  B, com_m_company C,com_m_depart D,com_m_desig E "; 
		    			sql=sql+" WHERE A.INT_BRANCHID=B.INT_BRANCHID AND ";
		    			sql=sql+" A.INT_COMPANYID=C.INT_COMPANYID  AND A.INT_DEPARTID=D.INT_DEPARTID "; 
		    			sql=sql+" AND A.INT_DESIGID= E.INT_DESIGID AND A.CHR_EMPID in( SELECT CHR_EMPID ";
		    			sql=sql+" FROM att_t_ot WHERE ";
		    			sql=sql+" CHR_MONTH='"+monthName+"' AND INT_YEAR="+year+") ";
		    			sql=sql+" AND A.CHR_STAFFNAME LIKE '"+startLetter+"%' ORDER BY CHR_STAFFNAME";
	    		 }	    	
	    			
	    		  	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	    	     	StringBuffer sb = new StringBuffer(); 	    	     	
	    	     		for(int u=0; u<readData.length;u++)
	    	     		{
	    	     				sb.append("<OverTime>");    
	    	     				sb.append("<Empid>"+readData[u][0]+"</Empid>");
	    	     				sb.append("<Staffname>"+readData[u][1]+"</Staffname>");
	    	     				sb.append("<Companyname>"+readData[u][2]+"</Companyname>");   
	    	     				sb.append("<Branchname>"+readData[u][3]+"</Branchname>");
	    	     				sb.append("<Depart>"+readData[u][4]+"</Depart>");
	    	     				sb.append("<Desig>"+readData[u][5]+"</Desig>");	    	     				
	    	     				sql="SELECT SUM(INT_MINS) FROM att_t_ot WHERE CHR_EMPID='"+readData[u][0]+"' and CHR_MONTH='"+monthName+"' AND INT_YEAR="+year;
	    	     				String readMins[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	    	     				
	    	     				sb.append("<time>"+readMins[0][0]+"</time>");
	    	     				sb.append("</OverTime>");
	    	     		}	          
	    	     		
	    	     		response.setContentType("text/xml");
	    	     		response.setHeader("Cache-Control", "no-cache");
	    	     		response.getWriter().write("<overtimes>" + sb.toString() + "</overtimes>");
	    	     	  		     	 	 
	    	 	} 
	    	 	catch (Exception e) 
	    	 	{
				 
				 System.out.println(e.getMessage());
	    	 	} 
	    }	
	 
	 private void loadShiftData(HttpServletRequest request, HttpServletResponse  response)
	    throws IOException, ServletException {
	    	 try 
	    	 {
	    			int year=Integer.parseInt(request.getParameter("year"));     			
	    		
			 		int mon=Integer.parseInt(request.getParameter("month"));
			 		
			 		String startLetter=""+request.getParameter("id");
	    		 	String sql ="";
	    		 	if("0".equals(startLetter))
	    		 	{
	    		 		sql="SELECT A.CHR_EMPID,A.CHR_STAFFNAME ,C.CHR_COMPANYNAME,B.CHR_BRANCHNAME, ";
	    		 		sql=sql+" D.CHR_DEPARTNAME,E.CHR_DESIGNAME,F.CHR_SHIFTCODE,min(F.DT_DATE), ";
	    		 		sql=sql+" max(F.DT_DATE),count(F.DT_DATE) FROM  com_m_staff  A, ";
	    		 		sql=sql+"  com_m_branch  B, com_m_company  C,  com_m_depart   D,  com_m_desig  E, "; 
	    		 		sql=sql+" att_t_shiftallocation F WHERE A.INT_BRANCHID=B.INT_BRANCHID AND ";
	    		 		sql=sql+" A.INT_COMPANYID=C.INT_COMPANYID  AND A.INT_DEPARTID=D.INT_DEPARTID ";
	    		 		sql=sql+" AND A.INT_DESIGID= E.INT_DESIGID AND A.CHR_EMPID=F.CHR_EMPID ";
	    		 		sql=sql+" AND MONTH(F.DT_DATE)="+mon+" AND YEAR(F.DT_DATE)="+year+" group by a.CHR_EMPID order By A.CHR_STAFFFNAME";
	    		 	}	      		 	
	    		 	else
	    		 	{	    		 		
	    		 		sql="SELECT A.CHR_EMPID,A.CHR_STAFFNAME ,C.CHR_COMPANYNAME,B.CHR_BRANCHNAME, ";
		    		 	sql=sql+" D.CHR_DEPARTNAME,E.CHR_DESIGNAME,F.CHR_SHIFTCODE,min(F.DT_DATE), ";
		    		 	sql=sql+" max(F.DT_DATE),count(F.DT_DATE) FROM  com_m_staff  A, ";
		    		 	sql=sql+"  com_m_branch  B, com_m_company  C,  com_m_depart   D,  com_m_desig  E, "; 
		    		 	sql=sql+" att_t_shiftallocation F WHERE A.INT_BRANCHID=B.INT_BRANCHID AND ";
		    		 	sql=sql+" A.INT_COMPANYID=C.INT_COMPANYID  AND A.INT_DEPARTID=D.INT_DEPARTID ";
		    		 	sql=sql+" AND A.INT_DESIGID= E.INT_DESIGID AND A.CHR_EMPID=F.CHR_EMPID ";
		    		 	sql=sql+" AND MONTH(F.DT_DATE)="+mon+" AND YEAR(F.DT_DATE)="+year+" and A.CHR_STAFFNAME LIKE '"+startLetter+"%' group by a.CHR_EMPID order By A.CHR_STAFFFNAME";
	    		 		  		 		   		 		    		 	
	    		 	}	    		 		
	    		  	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	    	     	StringBuffer sb = new StringBuffer(); 	    	     	
	    	     		for(int u=0; u<readData.length;u++)
	    	     		{
	    	     				sb.append("<Shift>");    
	    	     				sb.append("<Empid>"+readData[u][0]+"</Empid>");
	    	     				sb.append("<Staffname>"+readData[u][1]+"</Staffname>");
	    	     				sb.append("<Companyname>"+readData[u][2]+"</Companyname>");   
	    	     				sb.append("<Branchname>"+readData[u][3]+"</Branchname>");
	    	     				sb.append("<Depart>"+readData[u][4]+"</Depart>");
	    	     				sb.append("<Desig>"+readData[u][5]+"</Desig>");	    	     				
	    	     				sb.append("<ShiftName>"+readData[u][6]+"</ShiftName>");
	    	     				sb.append("<ShiftFromDate>"+readData[u][7]+"</ShiftFromDate>");
	    	     				sb.append("<ShiftToDate>"+readData[u][8]+"</ShiftToDate>");
	    	     				sb.append("<NoOfDays>"+readData[u][9]+"</NoOfDays>");
	    	     				sb.append("</Shift>");
	    	     		}	          
	    	     		
	    	     		response.setContentType("text/xml");
	    	     		response.setHeader("Cache-Control", "no-cache");
	    	     		response.getWriter().write("<shifts>" + sb.toString() + "</shifts>");
	    	     	  		     	 	 
	    	 	} 
	    	 	catch (Exception e) 
	    	 	{
				 
				 System.out.println(e.getMessage());
	    	 	} 
	    }	
		 	 
	
	private void loadBranchData(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
    	 try 
    	 {    		 	
    		 	int id=Integer.parseInt(request.getParameter("id"));
    		 	String stltr=""+request.getParameter("startLetter");
    		 	
    		 	String sql=null;
    		 	if(stltr.equals("null"))
    		 	{
    		 		sql="SELECT INT_BRANCHID,CHR_BRANCHNAME,CHR_LEGALNAME,CHR_CITY,CHR_COUNTRY,CHR_EMAIL ";
        		 	sql=sql+"FROM  com_m_branch  WHERE INT_COMPANYID="+id;
        		 
    		 	}
    		 	else
    		 	{
    		 	  sql="SELECT INT_BRANCHID,CHR_BRANCHNAME,CHR_LEGALNAME,CHR_CITY,CHR_COUNTRY,CHR_EMAIL ";
    		 	  sql=sql+"FROM  com_m_branch  WHERE INT_COMPANYID="+id+" AND CHR_BRANCHNAME LIKE'"+stltr+"%'";
    		 	}
    		 //	//System.out.println("Branch sql---------------------------------"+sql);
    	     	String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    	     	StringBuffer sb = new StringBuffer(); 
    	     	
    	     	
    	     	boolean flag = false;
    	     	for(int u=0; u<readData.length;u++)
    	     	{
    	     		sb.append("<branch>");    	     		
                    sb.append("<id>"+readData[u][0]+"</id>");
                    sb.append("<branchName>"+readData[u][1]+"</branchName>");
                    sb.append("<legalName>"+readData[u][2]+"</legalName>");
                    sb.append("<city>"+readData[u][3]+"</city>");                      
                    sb.append("<country>" +readData[u][4]+"</country>");
                    sb.append("<email>"+readData[u][5]+"</email>");                                
                    sb.append("</branch>");
                    flag = true;
    	     	}    	     	
    	     	if (flag) 
    	     	{
    	     		
    	     		response.setContentType("text/xml");
    	     		response.setHeader("Cache-Control", "no-cache");
    	     	   // //System.out.println(sb.toString());
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
    	 	} 
    }	
	
	
	
	
	
	
    //ArrayList<PurchasePayment> purchasePaymentList = new ArrayList<PurchasePayment>();
    public  void doGet(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException {
		try
                                    {
			String action=request.getParameter("actionS");	
		    
		 if(action.equals("ATTdistrict"))
		 {				
				loadDistrict(request,response);			    
		 }	
		 else if(action.equals("ATTstaff"))
		 {				
			 AttendanceMethod.loadStaff(request,response);			    
		 }
		 else if(action.equals("AttOnduty"))
		 {				
			 AttendanceMethod.loadOnduty(request,response);			    
		 }
		 else if(action.equals("AttManual"))
		 {				
			 AttendanceMethod.loadManual(request,response);			    
		 }
		 else if(action.equals("AttPermission"))
		 {				
			 AttendanceMethod.loadPermission(request,response);			    
		 }
		 else if(action.equals("ATTbranch"))
		 {				
			 	loadBranchData(request,response);			    
		 }	 
		 else if(action.equals("ATTholiday"))
		 {				
			 	loadHolidayData(request,response);			    
		 }
		 else if(action.equals("ATTovertime"))
		 {				
			 	loadOverTime(request,response);			    
		 }
		 else if(action.equals("ATTCompensation"))
		 {				
			 	loadCompensationData(request,response);			    
		 }	 
		 else if(action.equals("ATTShift"))
		 {				
			 	loadShiftData(request,response);			    
		 }		
		 else if(action.equals("AttLeave"))
		 {				
			 AttendanceMethod.loadLeaveData(request,response);			    
		 }
		 else if(action.equals("AttLeaves"))
		 {				
			 AttendanceMethod.loadLeaveDatas(request,response);			    
		 }
		 else if(action.equals("AttQuery"))
		 {				
			 AttendanceMethod.loadAttQuery(request,response);			    
		 }
		 else if(action.equals("ATTBranch"))
		 {				
		 	 AttendanceMethod.loadBranch(request,response);			    
		 }
		 
		} catch (Exception e) {
			 request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
						
			 System.out.println(e.getMessage());
		}			
    }
    
 
}
    
