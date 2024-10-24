package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import java.sql.CallableStatement;
 
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
			if (action.equals("ATTBloodGroupDelete")) 
			{
				String ids[] = request.getParameterValues("id");
				CallableStatement cs = con.prepareCall("{call  COM_PRO_BLOODGROUP(?,?,?,? )}");
				for (int i = 0; i < ids.length; i++) 
				{
					cs.setString(1, "DELETE");
					cs.setString(2, ids[i]);
					cs.setString(3, "");
					cs.setString(4, null);
					cs.addBatch();
				}
				cs.executeBatch();
				cs.close();
				con.close();    
				response.sendRedirect("Smart Attendance/BloodGroup.jsp");
			}
			else if ( "ATTBloodGroupAdd".equals(action) ) 
			{
				String name=request.getParameter("Name");
				name=name.trim();
				CallableStatement cs = con.prepareCall("{call  COM_PRO_BLOODGROUP(?,?,?,? )}");
				cs.setString(1, "INSERT");
				cs.setString(2, "1");
				cs.setString(3, name);
				cs.setString(4, user);
				cs.execute();
				cs.close();
				con.close();    
				response.sendRedirect("Smart Attendance/BloodGroupAction.jsp?action1=Add");
			} 
			else if (action.equals("ATTBloodGroupEdit")) 
			{
				String id=request.getParameter("id");
				String name=request.getParameter("Name");
				CallableStatement cs = con.prepareCall("{call  COM_PRO_BLOODGROUP(?,?,?,? )}");
				cs.setString(1, "UPDATE");
				cs.setString(2, id);
				cs.setString(3, name);
				cs.setString(4, user);
				cs.execute();
				cs.close();
				con.close();    
				response.sendRedirect("Smart Attendance/BloodGroup.jsp");
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
