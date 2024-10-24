package com.my.org.erp.SmartAMC;
import java.io.IOException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class ServiceItemActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
		try
		{
				String action=request.getParameter("actionS");
				HttpSession session=request.getSession();			
				String userId=""+session.getAttribute("USRID");
				Statement st = con.createStatement();
				String sql="";
							
				if("AMCServiceItemAdd".equals(action))
				{
					String ServiceItem=request.getParameter("ServiceItem");
					sql = "INSERT INTO inv_m_serviceitems ( CHR_SERVICEITEMNAME,CHR_USRNAME, DT_UPDATEDATE, CHR_UPDATESTATUS )  VALUES (";
					sql = sql +" '"+ServiceItem+"' ,";
					sql = sql +" '"+userId +"' , ";
					sql = sql +" now() , 'Y' )";
					st.execute(sql);
					con.close();    
					response.sendRedirect("Smart AMC/ServiceItems.jsp");
				}	
				else if("AMCServiceItemEdit".equals(action))
				{
					String ServiceItem=request.getParameter("ServiceItem");
					String id =request.getParameter("id");
					sql = "UPDATE inv_m_serviceitems SET " ;
					sql = sql +" CHR_SERVICEITEMNAME = '"+ServiceItem +"' , ";
					sql = sql +" CHR_USRNAME ='"+userId +"'  ";
					sql = sql +" Where  INT_SERVICEITEMID = "+id;
					st.execute(sql);
					con.close();   
					response.sendRedirect("Smart AMC/ServiceItems.jsp");
				}
				else if("AMCServiceItemDelete".equals(action))
				{
					String custids[] = request.getParameterValues("id");
					for(int u=0; u<custids.length;u++)
					{
						sql = "DELETE FROM inv_m_serviceitems Where  INT_SERVICEITEMID = "+Integer.parseInt(custids[u]);
						st.execute(sql);
					}
					con.close();   
					response.sendRedirect("Smart AMC/ServiceItems.jsp");
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