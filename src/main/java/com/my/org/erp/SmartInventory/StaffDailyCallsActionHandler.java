package com.my.org.erp.SmartInventory;

import java.io.IOException;
import java.sql.CallableStatement;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonInfo;
import com.my.org.erp.ServiceLogin.DateUtil; 

public class StaffDailyCallsActionHandler extends AbstractActionHandler 
{
	
	enum ACTION {INVStaffDailyCallsADD,INVStaffDailyCallsUpdate,INVStaffDailyCallsDelete; } 
	
	
	
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

					case INVStaffDailyCallsADD: 
													try 
													{
															
														
														if(!CommonInfo.RecordExist(" SELECT COUNT(*) FROM servicecall_t_report WHERE  CHR_EMPID='"+empid+"'  AND DAT_DATE='"+DateUtil.FormateDateSQL(calldate)+"'  AND CHR_DAYCLOSED='Y'"))
														{
															StaffDailyCalls(request,response);
															if("Y".equals(dayclosed))
															{
																con.close();    
																response.sendRedirect("Staff/Userframe.jsp");
															}
															else
															{
																con.close();    
																response.sendRedirect("Smart Inventory/StaffDailyCallsAdd.jsp");
															}
														}
														else
														{
															con.close();    
															response.sendRedirect("Staff/error.jsp?error=Already "+calldate+" Day closed");
														}
															break;
													} 
													catch (RuntimeException e) 
													{
														response.sendRedirect("Staff/error.jsp?error="+e.getMessage());
													}
		
													
													
													
													
	
													

					case INVStaffDailyCallsUpdate:  
													try 
													{
														 
														StaffDailyCallsUpdate(request,response);	
														 
														response.sendRedirect("Smart Inventory/StaffDailyCallsView.jsp");
														break;
													} 
													catch (RuntimeException e) 
													{
														response.sendRedirect("Staff/error.jsp?error="+e.getMessage());
													}
	
													
					
					case INVStaffDailyCallsDelete:  
													try 
													{
														StaffDailyCallsDelete(request,response);	
														 
														response.sendRedirect("Smart Inventory/StaffDailyCallsView.jsp");
														break;
													} 
													catch (RuntimeException e) 
													{
														response.sendRedirect("Staff/error.jsp?error="+e.getMessage());
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
			CallableStatement cs=con.prepareCall("{call SERVICECALL_PRO_ENGINEERREPORT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, "INSERT");
			cs.setString(2,  "");
			cs.setString(3,  empid);
			cs.setString(4,  DateUtil.FormateDateSQL(calldate));
			cs.setString(5,  callnumber);
			cs.setString(6,  customername);
			cs.setString(7,  location);
			cs.setString(8,  calltype);
			cs.setString(9,  callstatus);
			cs.setString(10,  hours);
			cs.setString(11,  minutes);
			cs.setString(12,  thours);
			cs.setString(13,  tminutes);
			cs.setString(14,  tkm);
			cs.setString(15,  noofspare);
			cs.setString(16, dayclosed );
			cs.setString(17, userid);
			cs.execute();
			
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
			CallableStatement cs=con.prepareCall("{call SERVICECALL_PRO_ENGINEERREPORT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, "UPDATE");
			cs.setString(2,  rowid);
			cs.setString(3,  empid);
			cs.setString(4,  DateUtil.FormateDateSQL(calldate));
			cs.setString(5,  callnumber);
			cs.setString(6,  customername);
			cs.setString(7,  location);
			cs.setString(8,  calltype);
			cs.setString(9,  callstatus);
			cs.setString(10,  hours);
			cs.setString(11,  minutes);
			cs.setString(12,  thours);
			cs.setString(13,  tminutes);
			cs.setString(14,  tkm);
			cs.setString(15,  noofspare);
			cs.setString(16, dayclosed );
			cs.setString(17, userid);
			 
			cs.execute();	 
			 
			 
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
			
			CallableStatement cs=con.prepareCall("{call SERVICECALL_PRO_ENGINEERREPORT(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
			for(int i=0;i<callid.length;i++)
			{
				cs.setString(1, "DELETE");
				cs.setString(2, callid[i] );
				cs.setString(3, "");
				cs.setString(4, "");
				cs.setString(5, "");
				cs.setString(6, "");
				cs.setString(7, "");
				cs.setString(8, "");
				cs.setString(9, "");
				cs.setString(10, "");
				cs.setString(11, "");
				cs.setString(12, "");
				cs.setString(13, "");
				cs.setString(14, "");
				cs.setString(15, "");
				cs.setString(16, "" );
				cs.setString(17, "");
				cs.addBatch();
			}
			cs.executeBatch();
			 
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
