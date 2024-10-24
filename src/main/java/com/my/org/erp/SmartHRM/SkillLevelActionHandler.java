package com.my.org.erp.SmartHRM;

import java.io.IOException;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class SkillLevelActionHandler extends AbstractActionHandler 
{
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			if (action.equals("HRMSkillLevelDelete")) 
			{
				 
				String ids[] = request.getParameterValues("id");
				acs = con.prepareCall("{call  HRM_PRO_SKILLTYPE(?,?,?,?,? )}");
				for (int i = 0; i < ids.length; i++) 
				{
					acs.setString(1, "DELETE");
					acs.setString(2, ids[i]);
					acs.setString(3, "");
					acs.setString(4, "");
					acs.setString(5, null);
					acs.addBatch();
				}
				acs.executeBatch();
				acs.close();
				con.close();    
				response.sendRedirect("Smart HRM/SkillLevel.jsp");
			}
			else if ( "HRMSkillLevelAdd".equals(action) ) 
			{
				String name=request.getParameter("Name");
				String desc=request.getParameter("desc");
				name=name.trim();
				acs = con.prepareCall("{call  HRM_PRO_SKILLTYPE(?,?,?,?,? )}");
				acs.setString(1, "INSERT");
				acs.setString(2, " ");
				acs.setString(3, name);
				acs.setString(4, desc);
				acs.setString(5, user);
				System.out.println(""+acs);
				acs.execute();
				acs.close();
				con.close();
				response.sendRedirect("Smart HRM/SkillLevel.jsp");
				//response.sendRedirect("Smart HRM/SkillLevelAction.jsp?action1=Add");
			} 
			else if (action.equals("HRMSkillLevelEdit")) 
			{
				String id=request.getParameter("id");
				String name=request.getParameter("Name");
				String desc=request.getParameter("desc");
				 
				name=name.trim();
				acs = con.prepareCall("{call  HRM_PRO_SKILLTYPE( ?,?,?,?,? )}");
				acs.setString(1, "UPDATE");
				acs.setString(2, id);
				acs.setString(3, name);
				acs.setString(4, desc);
				acs.setString(5, user);
				acs.execute();
				acs.close();
				con.close();    
				response.sendRedirect("Smart HRM/SkillLevel.jsp");
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
