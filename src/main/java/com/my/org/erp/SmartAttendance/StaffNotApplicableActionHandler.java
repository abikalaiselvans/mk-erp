package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
 
 
public class StaffNotApplicableActionHandler extends AbstractActionHandler 
{
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			if (action.equals("ATTStaffNotApplicable")) 
			{
				
				String mont=request.getParameter("month");
				String month=DateUtil.getMonth(Integer.parseInt(mont));
				String year=request.getParameter("year");
				
				/*Thread.sleep(2000);
				AttendanceFunctions.AttAssignNewJoiner(acs,apstm,con, month, year);
				Thread.sleep(2000);
				AttendanceFunctions.AttAssignResignner(apstm,con, month, year);
				Thread.sleep(2000);
				*/
				System.out.println("New Joinner");
				AttendanceFunctions.AttAssignNewJoiner(acs,apstm,con, month, year);
				Thread.sleep(2000);
				
				System.out.println("Resignner");
				AttendanceFunctions.AttAssignResignner(apstm,con, month, year);
				Thread.sleep(2000);
				
				System.out.println("Duplicate");
				AttendanceFunctions.AvoidAttendanceGenerateDuplicate(apstm,con, month, year);
				Thread.sleep(2000);
				
				System.out.println("Attendance calculate end");
				
				
				
				con.close();
				System.out.println("Not applicable completed for new joinner and resigner for the month of "+month +"-"+year);
				response.sendRedirect("Smart Attendance/AttendanceMain.jsp");
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
