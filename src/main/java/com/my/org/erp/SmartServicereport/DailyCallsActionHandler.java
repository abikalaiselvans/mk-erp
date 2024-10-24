package com.my.org.erp.SmartServicereport;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonInfo;
import com.my.org.erp.ServiceLogin.DateUtil; 

public class DailyCallsActionHandler extends AbstractActionHandler 
{
	
	enum ACTION {SSRStaffDailyCallsADD,SSRStaffDailyCallsUpdate,SSRStaffDailyCallsDelete; } 
	
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			
			HttpSession session=request.getSession();
			String action = request.getParameter("actionS");
			String empid = "" + session.getAttribute("EMPID");
			String  calldate= request.getParameter("calldate");
			String   dayclosed= request.getParameter("dayclosed"); 
			 
			
			switch(ACTION.valueOf(action))
			{

					case SSRStaffDailyCallsADD: 
													try 
													{
															
														if(!CommonInfo.RecordExist(" SELECT COUNT(*) FROM servicecall_t_report WHERE  CHR_EMPID='"+empid+"'  AND DAT_DATE='"+DateUtil.FormateDateSQL(calldate)+"'  AND CHR_DAYCLOSED='Y'"))
														{
															StaffDailyCalls(request,response);
															if("Y".equals(dayclosed))
															{
																con.close();   
																response.sendRedirect("Smart Servicereport/ServiceReportmain.jsp");
															}
															else
															{
																con.close();    
																response.sendRedirect("Smart Servicereport/DailyCalls.jsp");
															}
														}
														else
														{
															con.close();    
															response.sendRedirect("Smart Servicereport/error.jsp?error=Already "+calldate+" Day closed");
														}
															break;
													} 
													catch (RuntimeException e) 
													{
														con.close();   
														response.sendRedirect("error/index.jsp?error=" + e.getMessage());
													}
		
													
													
													
													
	
													

					case SSRStaffDailyCallsUpdate:  
													try 
													{
														 
														StaffDailyCallsUpdate(request,response);	
														con.close();    
														response.sendRedirect("Smart Servicereport/DailyCalls.jsp");
														break;
													} 
													catch (RuntimeException e) 
													{
														con.close();   
														response.sendRedirect("error/index.jsp?error=" + e.getMessage());
													}
	
													
					
					case SSRStaffDailyCallsDelete:  
													try 
													{
														StaffDailyCallsDelete(request,response);	
														con.close();    
														response.sendRedirect("Smart Servicereport/DailyCalls.jsp");
														break;
													} 
													catch (RuntimeException e) 
													{
														con.close();   
														response.sendRedirect("error/index.jsp?error=" + e.getMessage());
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
	
	
	
	
	
	public void StaffDailyCalls(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			
			HttpSession session=request.getSession();
			String empid = "" + session.getAttribute("EMPID");
			String  calldate= request.getParameter("calldate");
			String  userid= request.getParameter("userid");
			String   callnumber= request.getParameter("callnumber");
			String   customername= request.getParameter("customername");
			String   location= request.getParameter("location");
			String   calltype= request.getParameter("calltype");
			String   callstatus= request.getParameter("callstatus");
			String   hours= request.getParameter("hours");
			String   minutes= request.getParameter("minutes");
			String   thours= request.getParameter("thours");
			String   tminutes= request.getParameter("tminutes");
			String   tkm= request.getParameter("tkm");
			String   noofspare= request.getParameter("noofspare");
			String   dayclosed= request.getParameter("dayclosed");
			acs=con.prepareCall("{call SERVICECALL_PRO_ENGINEERREPORT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			acs.setString(1, "INSERT");
			acs.setString(2,  "");
			acs.setString(3,  empid);
			acs.setString(4,  DateUtil.FormateDateSQL(calldate));
			acs.setString(5,  callnumber.replaceAll("&", "and"));
			acs.setString(6,  customername.replaceAll("&", "and"));
			acs.setString(7,  location.replaceAll("&", "and"));
			acs.setString(8,  calltype);
			acs.setString(9,  callstatus);
			acs.setString(10,  hours);
			acs.setString(11,  minutes);
			acs.setString(12,  thours);
			acs.setString(13,  tminutes);
			acs.setString(14,  tkm);
			acs.setString(15,  noofspare);
			acs.setString(16, dayclosed );
			acs.setString(17, userid);
			acs.execute();
			acs.close();
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	
	
	


	
	public void StaffDailyCallsUpdate(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			
			 
			HttpSession session=request.getSession();
			String empid = "" + session.getAttribute("EMPID");
			String  rowid= request.getParameter("rowid");
			String  calldate= request.getParameter("calldate");
			String  userid= request.getParameter("userid");
			String   callnumber= request.getParameter("callnumber");
			String   customername= request.getParameter("customername");
			String   location= request.getParameter("location");
			String   calltype= request.getParameter("calltype");
			String   callstatus= request.getParameter("callstatus");
			String   hours= request.getParameter("hours");
			String   minutes= request.getParameter("minutes");
			String   thours= request.getParameter("thours");
			String   tminutes= request.getParameter("tminutes");
			String   tkm= request.getParameter("tkm");
			String   noofspare= request.getParameter("noofspare");
			String   dayclosed= request.getParameter("dayclosed");
			acs=con.prepareCall("{call SERVICECALL_PRO_ENGINEERREPORT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			acs.setString(1, "UPDATE");
			acs.setString(2,  rowid);
			acs.setString(3,  empid);
			acs.setString(4,  DateUtil.FormateDateSQL(calldate));
			acs.setString(5,  callnumber.replaceAll("&", "and"));
			acs.setString(6,  customername.replaceAll("&", "and"));
			acs.setString(7,  location.replaceAll("&", "and"));
			acs.setString(8,  calltype);
			acs.setString(9,  callstatus);
			acs.setString(10,  hours);
			acs.setString(11,  minutes);
			acs.setString(12,  thours);
			acs.setString(13,  tminutes);
			acs.setString(14,  tkm);
			acs.setString(15,  noofspare);
			acs.setString(16, dayclosed );
			acs.setString(17, userid);
			 
			acs.execute();	 
			acs.close(); 
			 
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	
	
	
	
	
	
	public void StaffDailyCallsDelete(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			
			 
			
			String  callid[]= request.getParameterValues("callid");
			
			acs=con.prepareCall("{call SERVICECALL_PRO_ENGINEERREPORT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			for(int i=0;i<callid.length;i++)
			{
				acs.setString(1, "DELETE");
				acs.setString(2, callid[i] );
				acs.setString(3, "");
				acs.setString(4, "");
				acs.setString(5, "");
				acs.setString(6, "");
				acs.setString(7, "");
				acs.setString(8, "");
				acs.setString(9, "");
				acs.setString(10, "");
				acs.setString(11, "");
				acs.setString(12, "");
				acs.setString(13, "");
				acs.setString(14, "");
				acs.setString(15, "");
				acs.setString(16, "" );
				acs.setString(17, "");
				acs.addBatch();
			}
			acs.executeBatch();
			acs.close(); 
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
