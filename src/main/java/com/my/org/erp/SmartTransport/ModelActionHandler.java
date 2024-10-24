package com.my.org.erp.SmartTransport;
import java.io.IOException;
 
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class ModelActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			Statement st = con.createStatement();
			if ("TRSModelAdd".equals(action))
			{
				String name=request.getParameter("name");
				String make=request.getParameter("make");
				acs = con.prepareCall("{call AUTO_PRO_MODEL(?,?,?,?,?)}");
				acs.setString(1, "INSERT");
				acs.setString(2, "1");
				acs.setString(3, name);
				acs.setString(4, make);
				acs.setString(5, user);
				acs.execute();
				acs.close();
				response.sendRedirect("Smart Transport/ModelAction.jsp?action1=Add");
			}
			else if ("TRSModelEdit".equals(action))
			{
				String id=request.getParameter("id");
				String name=request.getParameter("name");
				String make=request.getParameter("make");
				acs = con.prepareCall("{call AUTO_PRO_MODEL(?,?,?,?,?)}");
				acs.setString(1, "UPDATE");
				acs.setString(2, id);
				acs.setString(3, name);
				acs.setString(4, make);
				acs.setString(5, user);
				acs.execute();
				acs.close();
				response.sendRedirect("Smart Transport/ModelAction.jsp?action1=Add");
			}
			else if ("TRSModelDelete".equals(action))
			{
				String ids[] = request.getParameterValues("id");
				acs = con.prepareCall("{call AUTO_PRO_MODEL(?,?,?,?,?)}");
				for (int i = 0; i < ids.length; i++) 
				{
					acs.setString(1, "DELETE");
					acs.setString(2, ids[i]);
					acs.setString(3, "");
					acs.setString(4, "");
					acs.setString(5, "");
					acs.addBatch();
				}
				acs.executeBatch();
				acs.close();
				response.sendRedirect("Smart Transport/Model.jsp");
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
