package com.my.org.erp.SmartCommon;

import java.io.IOException;
import java.sql.SQLException;
 
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
 
public class BloodGroupActionHandler extends AbstractActionHandler 
{
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			if (action.equals("GENBloodGroupDelete")) 
			{
				String ids[] = request.getParameterValues("id");
				acs = con.prepareCall("{call  COM_PRO_BLOODGROUP(?,?,?,? )}");
				for (int i = 0; i < ids.length; i++) 
				{
					acs.setString(1, "DELETE");
					acs.setString(2, ids[i]);
					acs.setString(3, "");
					acs.setString(4, null);
					acs.addBatch();
				}
				acs.executeBatch();
				acs.close();
				con.close();    
				response.sendRedirect("Smart Common/BloodGroup.jsp");
			}
			else if ( "GENBloodGroupAdd".equals(action) ) 
			{
				String name=request.getParameter("Name");
				name=name.trim();
				acs = con.prepareCall("{call  COM_PRO_BLOODGROUP(?,?,?,? )}");
				acs.setString(1, "INSERT");
				acs.setString(2, "1");
				acs.setString(3, name);
				acs.setString(4, user);
				acs.execute();
				acs.close();
				con.close();    
				response.sendRedirect("Smart Common/BloodGroup.jsp");//BloodGroupAction.jsp?action1=Add
			} 
			else if (action.equals("GENBloodGroupEdit")) 
			{
				String id=request.getParameter("id");
				String name=request.getParameter("Name");
				acs = con.prepareCall("{call  COM_PRO_BLOODGROUP(?,?,?,? )}");
				acs.setString(1, "UPDATE");
				acs.setString(2, id);
				acs.setString(3, name);
				acs.setString(4, user);
				acs.execute();
				acs.close();
				con.close();   	 
				response.sendRedirect("Smart Common/BloodGroup.jsp");
			}
			
		} 
		catch (SQLException e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

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
