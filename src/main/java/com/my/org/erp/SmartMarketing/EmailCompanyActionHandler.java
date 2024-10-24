package com.my.org.erp.SmartMarketing;
import java.io.IOException;
import java.sql.CallableStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 

public class EmailCompanyActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session=request.getSession();			
			String user=""+session.getAttribute("USRID");			
			if ("MKTEmailCompanyAdd".equals(action)) 
			{
				String Name=request.getParameter("Name");
				String groupid=request.getParameter("group");
				CallableStatement cs = con.prepareCall("{call MKT_PRO_EMAILCOMPANY(?,?,?,?,?)}");
				cs.setString(1, "INSERT");
				cs.setString(2, "");
				cs.setString(3, Name);	
				cs.setString(4, groupid);
				cs.setString(5, user);		
				cs.execute();
				cs.close();
				 
				response.sendRedirect("Smart Marketing/EmailCompanyAction.jsp?action1=Add&msg=Record Added Successfully");
			} 		
			else if ("MKTEmailCompanyEdit".equals(action)) 
			{
				String id=request.getParameter("id");
				String Name=request.getParameter("Name");
				String groupid=request.getParameter("group");
				
				CallableStatement cs = con.prepareCall("{call MKT_PRO_EMAILCOMPANY(?,?,?,?,?)}");
				cs.setString(1, "UPDATE");
				cs.setString(2, id);
				cs.setString(3, Name);	
				cs.setString(4, groupid);
				cs.setString(5, user);	
				cs.execute();
				cs.close();
				 				
				response.sendRedirect("Smart Marketing/EmailCompany.jsp");
			} 	
			else if ("MKTEmailCompanyDelete".equals(action)) 
			{
				String id[]=request.getParameterValues("id");
				CallableStatement cs = con.prepareCall("{call MKT_PRO_EMAILCOMPANY(?,?,?,?,?)}");
				for(int u=0;u<id.length;u++)
				{	
					cs.setString(1, "DELETE");
					cs.setString(2, id[u]);
					cs.setString(3, "");	
					cs.setString(4, "");
					cs.setString(5, user);	
					cs.execute();
				}	
				cs.close();
				 				
				response.sendRedirect("Smart Marketing/EmailCompany.jsp");
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
