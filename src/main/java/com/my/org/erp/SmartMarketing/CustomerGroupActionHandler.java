package com.my.org.erp.SmartMarketing;

import java.io.IOException; 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
 
public class CustomerGroupActionHandler extends AbstractActionHandler {
	
	 
	 

	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{

		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			
			if (action.equals("MKTCustomerGroupDelete")) 
			{
				
				String ids[] = request.getParameterValues("id");
				asql = " DELETE FROM mkt_m_customergroup WHERE INT_GROUPID =?";
				apstm = con.prepareStatement(asql);
				for (int i = 0; i < ids.length; i++) 
				{
					apstm.setString(1, ids[i]);
					apstm.addBatch();
					
				}
				apstm.executeBatch();
				apstm.close();
				con.close();
				response.sendRedirect("Smart Marketing/CustomerGroup.jsp");
			}
			else if (action.equals("MKTCustomerGroupAdd")) 
			{
				String name=request.getParameter("name");
				name=name.trim();
				acs = con.prepareCall("{call MKT_PRO_CUSTOMERGROUP(?,?,?,?,?,?)}");
				acs.setString(1, "INSERT");
				acs.setString(2, "1");
				acs.setString(3, name);
				acs.setString(4, DateUtil.getCurrentDate());
				acs.setString(5, "Y");
				acs.setString(6, user);
				acs.execute();
				acs.close();
				response.sendRedirect("Smart Marketing/CustomerGroup.jsp");
			} 
			else if (action.equals("MKTCustomerGroupEdit")) 
			{
				String id=request.getParameter("id");
				String name=request.getParameter("name");
				name=name.trim();
				acs = con.prepareCall("{call MKT_PRO_CUSTOMERGROUP(?,?,?,?,?,?)}");
				acs.setString(1, "UPDATE");
				acs.setString(2, id);
				acs.setString(3, name);
				acs.setString(4, DateUtil.getCurrentDate());
				acs.setString(5, "Y");
				acs.setString(6, user);
				acs.execute();
				acs.close();
				response.sendRedirect("Smart Marketing/CustomerGroup.jsp");
				
			}
			
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage());
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
			dispatchers.forward(request, response);
		}
	}

}
