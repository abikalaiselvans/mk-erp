package com.my.org.erp.SmartUtility;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Statement;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class LeaveUpdationActionHandler extends AbstractActionHandler {
	 
	
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
		try 
		{
			String action = request.getParameter("actionS");
			//System.out.println("PASSWORD RESET :: " + action);
			String sql="";
			if (action.equals("UTILeaveUpdation")) 
			{	
				String len = request.getParameter("length");
				int length = Integer.parseInt(len);
				Statement st= con.createStatement();
				for(int u=0;u<length;u++)
				{
					String rowid=""+request.getParameter("rowid"+(u+1));
					String belowoneyear=""+request.getParameter("belowoneyear"+(u+1));
					String aboveoneyear=""+request.getParameter("aboveoneyear"+(u+1));
					sql= "UPDATE  att_m_leavetype SET INT_BELOWONEYEAR ="+belowoneyear+" , INT_ABOVEONEYEAR="+aboveoneyear+" WHERE INT_LEAVEID="+rowid;
					
					st.executeUpdate(sql);
					
					
				}
				st.close();
				con.close();  
				response.sendRedirect("Utility/LeaveSetting.jsp");
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
