package com.my.org.erp.Stock;
import java.io.IOException;
 
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class CustomerGroupActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			HttpSession session=request.getSession();			
			String action=request.getParameter("actionS");
			String userid=""+session.getAttribute("USRID");
			 
			
			if("STKCustomerGroupAdd".equals(action)) 
			{
				String CustomerGroupName= request.getParameter("CustomerGroupName");
				acs = con.prepareCall("{call  CON_INV_PRO_CUSTOMERGROUP (?,?,?,?)}");
				acs.setString(1, "INSERT");
				acs.setString(2, "1");
				acs.setString(3,CustomerGroupName);
				acs.setString(4, userid);
				acs.execute();
				acs.close();
				con.close();
				response.sendRedirect("SmartStock/CustomerGroupView.jsp");
			}
			else if("STKCustomerGroupEdit".equals(action))
			{
				
				String CustomerGroupid= request.getParameter("CustomerGroupid");
				String CustomerGroupName= request.getParameter("CustomerGroupName");
				acs = con.prepareCall("{call  CON_INV_PRO_CUSTOMERGROUP (?,?,?,?)}");
				acs.setString(1, "UPDATE");
				acs.setString(2, CustomerGroupid);
				acs.setString(3,CustomerGroupName);
				acs.setString(4, userid);
				acs.execute();
				con.close();
				acs.close();
				 
				response.sendRedirect("SmartStock/CustomerGroupView.jsp");
			}
			else if("STKCustomerGroupDelete".equals(action))
			{
				String data[] =request.getParameterValues("CustomerGroupid");
				try 
				{
					acs = con.prepareCall("{call CON_INV_PRO_CUSTOMERGROUP (?,?,?,?)}");
					for(int y=0;y<data.length;y++)
					{
						acs.setString(1, "DELETE");
						acs.setString(2,data[y]);
						acs.setString(3,"1");
						acs.setString(4, userid);
						acs.addBatch();				
					}
					acs.executeBatch();
					acs.close();
					con.close();
					response.sendRedirect("SmartStock/CustomerGroupView.jsp");
				}
				catch(Exception e)
				{
					response.sendRedirect("error/index.jsp?error=" + e.getMessage());
					 System.out.println(e.getMessage());
				}

				
				
			}
			 
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
			 response.sendRedirect("error/index.jsp?error=" + e.getMessage());
		}
	}	
}
