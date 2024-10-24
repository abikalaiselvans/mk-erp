package com.my.org.erp.SmartHRM;

import java.io.IOException;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class TechnicalCompetencyActionHandler extends AbstractActionHandler 
{
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			if (action.equals("HRMTechnicalCompetencyDelete")) 
			{
				String ids[] = request.getParameterValues("id");
				acs = con.prepareCall("{call  HRM_PRO_TECHNICALCOMPETENCY(?,?,?,?,? )}");
				for (int i = 0; i < ids.length; i++) 
				{
					acs.setString(1, "DELETE");
					acs.setString(2, ids[i]);
					acs.setString(3, "");
					acs.setString(4, null);
					acs.setString(5, null);
					acs.addBatch();
				}
				acs.executeBatch();
				acs.close();
				con.close();   
				response.sendRedirect("Smart HRM/TechnicalCompetency.jsp");
			}
			else if ( "HRMTechnicalCompetencyAdd".equals(action) ) 
			{
				String name=request.getParameter("Name");
				String desc=request.getParameter("desc");
			 
				name=name.trim();
				acs = con.prepareCall("{call  HRM_PRO_TECHNICALCOMPETENCY( ?,?,?,?,? )}");
				acs.setString(1, "INSERT");
				acs.setString(2, " ");
				acs.setString(3, name);
				acs.setString(4, desc);
				acs.setString(5, user);
				acs.execute();
				acs.close();
				con.close();   
				response.sendRedirect("Smart HRM/TechnicalCompetency.jsp");
				//response.sendRedirect("Smart HRM/TechnicalCompetencyAction.jsp?action1=Add&jobdesign="+jobs);
			} 
			else if (action.equals("HRMTechnicalCompetencyEdit")) 
			{
				String id=request.getParameter("id");
				String name=request.getParameter("Name");
				String desc=request.getParameter("desc");
				
				name=name.trim();
				acs = con.prepareCall("{call  HRM_PRO_TECHNICALCOMPETENCY( ?,?,?,?,? )}");
				acs.setString(1, "UPDATE");
				acs.setString(2, id);
				acs.setString(3, name);
				acs.setString(4, desc);
				acs.setString(5, user);
				acs.execute();
				acs.close();
				con.close();    
				response.sendRedirect("Smart HRM/TechnicalCompetency.jsp");
			}
			
		} catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
			
		}
	}

}
