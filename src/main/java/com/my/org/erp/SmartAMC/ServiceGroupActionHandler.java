package com.my.org.erp.SmartAMC;
import java.io.IOException;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class ServiceGroupActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
		try
		{
				String action=request.getParameter("actionS");
				HttpSession session=request.getSession();			
				String userid=""+session.getAttribute("USRID");
				String branchid=""+session.getAttribute("AMCBRANCH");
				
				 
				if("AMCServiceGroupAdd".equals(action))
				{
					String ServiceGroup=request.getParameter("ServiceGroup");
					acs = con.prepareCall("{call  INV_PRO_SERVICE_CALLGROUP(?,?,?,?,?  )}");
					acs.setString(1, "INSERT");
					acs.setString(2, " ");
					acs.setString(3, branchid);
					acs.setString(4,  ServiceGroup);
					acs.setString(5,  userid);
					acs.execute();
					acs.close();
					con.close();   
					response.sendRedirect("Smart AMC/ServiceGroup.jsp");
				}	
				else if("AMCServiceGroupEdit".equals(action))
				{
					String ServiceGroup=request.getParameter("ServiceGroup");
					String id =request.getParameter("id");
					
					acs = con.prepareCall("{call  INV_PRO_SERVICE_CALLGROUP(?,?,?,?,?  )}");
					acs.setString(1, "UPDATE");
					acs.setString(2, id);
					acs.setString(3, branchid);
					acs.setString(4,  ServiceGroup);
					acs.setString(5,  userid);
					acs.execute();
					acs.close();
					con.close();    
					response.sendRedirect("Smart AMC/ServiceGroup.jsp");
				}
				else if("AMCServiceGroupDelete".equals(action))
				{
					String custids[] = request.getParameterValues("id");
					acs = con.prepareCall("{call  INV_PRO_SERVICE_CALLGROUP(?,?,?,?,?  )}");
					for(int u=0; u<custids.length;u++)
					{
						acs.setString(1, "DELETE");
						acs.setString(2, custids[u]);
						acs.setString(3, "");
						acs.setString(4,  "");
						acs.setString(5,  "");
						acs.addBatch();
					}
					acs.executeBatch();
					con.close();   
					response.sendRedirect("Smart AMC/ServiceGroup.jsp");
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