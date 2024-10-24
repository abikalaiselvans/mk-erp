package com.my.org.erp.SmartCommon;

import java.io.IOException;
 
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
 
public class CertificationActionHandler extends AbstractActionHandler 
{
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			if (action.equals("GENCertificationDelete")) 
			{
				String ids[] = request.getParameterValues("id");
				acs = con.prepareCall("{call  COM_PRO_CERTIFICATION(?,?,?,? )}");
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
				response.sendRedirect("Smart Common/Certification.jsp");
			}
			else if ( "GENCertificationAdd".equals(action) ) 
			{
				String name=request.getParameter("Name");
				name=name.trim();
				acs = con.prepareCall("{call  COM_PRO_CERTIFICATION(?,?,?,? )}");
				acs.setString(1, "INSERT");
				acs.setString(2, "1");
				acs.setString(3, name);
				acs.setString(4, user);
				acs.execute();
				acs.close();
				con.close();    
				response.sendRedirect("Smart Common/Certification.jsp ");//CertificationAction.jsp?action1=Add
			} 
			else if (action.equals("GENCertificationEdit")) 
			{
				String id=request.getParameter("id");
				String name=request.getParameter("Name");
				acs = con.prepareCall("{call  COM_PRO_CERTIFICATION(?,?,?,? )}");
				acs.setString(1, "UPDATE");
				acs.setString(2, id);
				acs.setString(3, name);
				acs.setString(4, user);
				acs.execute();
				acs.close();
				con.close();    
				response.sendRedirect("Smart Common/Certification.jsp");
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
