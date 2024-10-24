package com.my.org.erp.SmartAttendance;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;
public class AttendanceCreationActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			javax.servlet.http.HttpSession session=request.getSession();
			session.removeAttribute("attinfo"); 
			String userid = (String) session.getAttribute("USRID");
			System.out.println("CONTROLLER FROM ATTENDANCE CREATION ACTION HANDLER  : "+action);
			String ldata[][] = CommonFunctions.QueryExecute("SELECT day(now())<7");
			if(!"0".equals(ldata[0][0]))
			{
				if ( "ATTAttendanceCreation".equals(action) )
				{ 
					acs = con.prepareCall("{call  ATT_PRO_REGISTER_CREATION( ?)}");
					acs.setString(1, userid);
					acs.execute();
					acs.close();
					
					acs = con.prepareCall("{call  ATT_PRO_REGISTER_SUNDAY_MARKING( ?)}");
					acs.setString(1, userid);
					acs.execute();
					acs.close();
					
					acs = con.prepareCall("{call  ATT_PRO_HOLD_ATTENDANCE_MARKING( ?)}");
					acs.setString(1, userid);
					acs.execute();
					acs.close();
					
					con.close();    
				} 
			}
			response.sendRedirect("Smart Attendance/AttendanceMain.jsp");
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