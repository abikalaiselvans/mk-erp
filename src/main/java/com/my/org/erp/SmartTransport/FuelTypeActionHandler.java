package com.my.org.erp.SmartTransport;

import java.io.IOException;
 
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class FuelTypeActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			Statement st = con.createStatement();
			if ("TRSFuelAdd".equals(action))
			{
				String name=request.getParameter("name");
				acs = con.prepareCall("{call AUTO_PRO_FUELTYPE(?,?,?,?)}");
				acs.setString(1, "INSERT");
				acs.setString(2, "1");
				acs.setString(3, name);
				acs.setString(4, user);
				acs.execute();
				response.sendRedirect("Smart Transport/FuelAction.jsp?action1=Add");
			}
			else if ("TRSFuelEdit".equals(action))
			{
				String id=request.getParameter("id");
				String name=request.getParameter("name");
				acs = con.prepareCall("{call AUTO_PRO_FUELTYPE(?,?,?,?)}");
				acs.setString(1, "UPDATE");
				acs.setString(2, id);
				acs.setString(3, name);
				acs.setString(4, user);
				acs.execute();
				response.sendRedirect("Smart Transport/FuelAction.jsp?action1=Add");
			}
			else if ("TRSFuelDelete".equals(action))
			{
				String ids[] = request.getParameterValues("id");
				acs = con.prepareCall("{call AUTO_PRO_FUELTYPE(?,?,?,?)}");
				for (int i = 0; i < ids.length; i++) 
				{
					acs.setString(1, "DELETE");
					acs.setString(2, ids[i]);
					acs.setString(3, "");
					acs.setString(4, "");
					acs.addBatch();
				}
				acs.executeBatch();
				response.sendRedirect("Smart Transport/Fueltype.jsp");
			}
			st.close();
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
