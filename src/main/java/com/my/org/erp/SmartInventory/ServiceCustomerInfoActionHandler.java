package com.my.org.erp.SmartInventory;
import java.io.IOException;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class ServiceCustomerInfoActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
		try
		{
				String action=request.getParameter("actionS");
				HttpSession session=request.getSession();			
				String userid=""+session.getAttribute("USRID");
				String branchid=""+session.getAttribute("BRANCHID");
				 
							
				if("INVServiceCustomerInfoAdd".equals(action))
				{
					String group=request.getParameter("group");
					String name=request.getParameter("name");
					String street=request.getParameter("street");
					String city=request.getParameter("city");
					String state=request.getParameter("state");
					String pin="0"+request.getParameter("pin");
					String country=request.getParameter("country");
					String phone=request.getParameter("phone");
					String mobile=request.getParameter("mobile");
					String fax=request.getParameter("fax");
					String email=request.getParameter("email");
					String website=request.getParameter("website");
					String servicecenter=request.getParameter("servicecenter");
					acs = con.prepareCall("{call  INV_PRO_SERVICE_CUSTOMERINFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?  )}");
					acs.setString(1, "INSERT");
					acs.setString(2, " ");
					acs.setString(3, branchid);
					acs.setString(4,  group );
					acs.setString(5,  name );
					acs.setString(6,  servicecenter);
					acs.setString(7, street );
					acs.setString(8,  city);
					acs.setString(9,   state);
					acs.setString(10,  pin );
					acs.setString(11,  country);
					acs.setString(12,  phone);
					acs.setString(13, mobile );
					acs.setString(14,   fax);
					acs.setString(15,   email);
					acs.setString(16, website);
					acs.setString(17, "1");
					acs.setString(18, userid);
					acs.execute();
					con.close();   
					response.sendRedirect("Smart Inventory/ServiceCustomerInfo.jsp");
				}	
				else if("INVServiceCustomerInfoUpdate".equals(action))
				{
					String group=request.getParameter("group");
					String custid =request.getParameter("custid");
					String name=request.getParameter("name");
					String street=request.getParameter("street");
					String city=request.getParameter("city");
					String state=request.getParameter("state");
					String pin="0"+request.getParameter("pin");					
					String country=request.getParameter("country");
					String phone=""+request.getParameter("phone");
					String mobile=request.getParameter("mobile");
					String fax=request.getParameter("fax");
					String email=request.getParameter("email");
					String website=request.getParameter("website");
					String status=request.getParameter("status");
					String servicecenter=request.getParameter("servicecenter");		
					if("on".equals(status))
						status="1";
					else
						status="0"; 					
					
					acs = con.prepareCall("{call  INV_PRO_SERVICE_CUSTOMERINFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?  )}");
					acs.setString(1, "INSERT");
					acs.setString(2, custid);
					acs.setString(3, branchid);
					acs.setString(4,  group );
					acs.setString(5,  name );
					acs.setString(6,  servicecenter);
					acs.setString(7, street );
					acs.setString(8,  city);
					acs.setString(9,   state);
					acs.setString(10,  pin );
					acs.setString(11,  country);
					acs.setString(12,  phone);
					acs.setString(13, mobile );
					acs.setString(14,   fax);
					acs.setString(15,   email);
					acs.setString(16, website);
					acs.setString(17, status);
					acs.setString(18, userid);
					acs.execute();
					 
					con.close();    
					response.sendRedirect("Smart Inventory/ServiceCustomerInfo.jsp");
				}
				else if("INVServiceCustomerInfoDelete".equals(action))
				{
					String custids[] = request.getParameterValues("custid");
					acs = con.prepareCall("{call  INV_PRO_SERVICE_CUSTOMERINFO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?  )}");
					for(int u=0; u<custids.length;u++)
					{
						acs.setString(1, "DELETE");
						acs.setString(2, custids[u]);
						acs.setString(3, "");
						acs.setString(4,  "" );
						acs.setString(5,  "" );
						acs.setString(6,  "");
						acs.setString(7, "" );
						acs.setString(8,  "");
						acs.setString(9,   "");
						acs.setString(10,  "" );
						acs.setString(11,  "");
						acs.setString(12,  "");
						acs.setString(13, "" );
						acs.setString(14,   "");
						acs.setString(15,   "");
						acs.setString(16, "");
						acs.setString(17, "");
						acs.setString(18, "");
						acs.addBatch();
					}
					acs.executeBatch();
					con.close();    
					response.sendRedirect("Smart Inventory/ServiceCustomerInfo.jsp");
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