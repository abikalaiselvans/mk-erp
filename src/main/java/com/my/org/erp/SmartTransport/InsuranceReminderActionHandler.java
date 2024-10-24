package com.my.org.erp.SmartTransport;
import java.io.IOException;
import java.sql.CallableStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class InsuranceReminderActionHandler extends AbstractActionHandler
{
	
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
				
		try
		{
		
			String action=request.getParameter("actionS");
			HttpSession session=request.getSession();
			String user=""+session.getAttribute("USRID");			
			if(action.equals("TRSInsuranceReminderAdd"))
			{
				String name=request.getParameter("name");
				String desc=request.getParameter("desc");
				CallableStatement cs = con.prepareCall("{call VEH_PRO_INSURANCEREMINDER(?,?,?,?,?)}");
				cs.setString(1, "INSERT");
				cs.setString(2, "1");
				cs.setString(3, name);
				cs.setString(4, desc);
				cs.setString(5, user);
				cs.execute();
				 
				response.sendRedirect("Smart Transport/Insurancemaster.jsp");

			}
			else if(action.equals("TRSInsuranceReminderEdit"))
			{
				
				String id=request.getParameter("id");
				String name=request.getParameter("name");
				String desc=request.getParameter("desc");
				CallableStatement cs = con.prepareCall("{call VEH_PRO_INSURANCEREMINDER(?,?,?,?,?)}");
				cs.setString(1, "UPDATE");
				cs.setString(2, id);
				cs.setString(3, name);
				cs.setString(4, desc);
				cs.setString(5, user);
				cs.execute();
				 
				response.sendRedirect("Smart Transport/Insurancemaster.jsp");
			}
			else if(action.equals("TRSInsuranceReminderDelete"))
			{
				String ids[] = request.getParameterValues("id");
				CallableStatement cs = con.prepareCall("{call VEH_PRO_INSURANCEREMINDER(?,?,?,?,?)}");
				for (int i = 0; i < ids.length; i++) {
					cs.setString(1, "DELETE");
					cs.setString(2, ids[i]);
					cs.setString(3, "");
					cs.setString(4, "");
					cs.setString(5, "");
					cs.addBatch();
				}
				cs.executeBatch();
				 
				response.sendRedirect("Smart Transport/Insurancemaster.jsp");
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