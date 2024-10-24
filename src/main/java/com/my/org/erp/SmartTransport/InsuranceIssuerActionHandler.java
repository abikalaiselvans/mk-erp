package com.my.org.erp.SmartTransport;
import java.io.IOException;
import java.sql.CallableStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class InsuranceIssuerActionHandler extends AbstractActionHandler
{
	
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
				
		try
		{
		
			String action=request.getParameter("actionS");
			HttpSession session=request.getSession();
			String user=""+session.getAttribute("USRID");			
			if(action.equals("TRSInsuranceIssuerAdd"))
			{
				String name=request.getParameter("Name");
				String TxtAdd1=request.getParameter("TxtAdd1");
				String TxtAdd2=request.getParameter("TxtAdd2");
				String city=request.getParameter("city");
				String state=request.getParameter("state");
				String pin=request.getParameter("pin");
				String phone=request.getParameter("phone");
				String fax=request.getParameter("fax");
				String email=request.getParameter("email");
				String website=request.getParameter("website");
				//action,id,Name,TxtAdd1,TxtAdd2, city,state,pin,phone,fax,email,website, user
				
				CallableStatement cs = con.prepareCall("{call VEH_PRO_INSURANCEISSUER(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				cs.setString(1, "INSERT");
				cs.setString(2, "1");
				cs.setString(3, name);
				cs.setString(4, TxtAdd1);
				cs.setString(5, TxtAdd2);
				cs.setString(6, city);
				cs.setString(7, state);
				cs.setString(8, pin);
				cs.setString(9, phone);
				cs.setString(10, fax);
				cs.setString(11, email);
				cs.setString(12, website);
				cs.setString(13, user);
				cs.execute();
			 
				response.sendRedirect("Smart Transport/InsuranceIssuer.jsp");

			}
			else if(action.equals("TRSInsuranceIssuerEdit"))
			{
				
				String id=request.getParameter("id");
				String name=request.getParameter("Name");
				String TxtAdd1=request.getParameter("TxtAdd1");
				String TxtAdd2=request.getParameter("TxtAdd2");
				String city=request.getParameter("city");
				String state=request.getParameter("state");
				String pin=request.getParameter("pin");
				String phone=request.getParameter("phone");
				String fax=request.getParameter("fax");
				String email=request.getParameter("email");
				String website=request.getParameter("website");
				CallableStatement cs = con.prepareCall("{call VEH_PRO_INSURANCEISSUER(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				cs.setString(1, "UPDATE");
				cs.setString(2, id);
				cs.setString(3, name);
				cs.setString(4, TxtAdd1);
				cs.setString(5, TxtAdd2);
				cs.setString(6, city);
				cs.setString(7, state);
				cs.setString(8, pin);
				cs.setString(9, phone);
				cs.setString(10, fax);
				cs.setString(11, email);
				cs.setString(12, website);
				cs.setString(13, user);
				cs.execute();
				 
				
				response.sendRedirect("Smart Transport/InsuranceIssuer.jsp");
			}
			else if(action.equals("TRSInsuranceIssuerDelete"))
			{
				String ids[] = request.getParameterValues("id");
				CallableStatement cs = con.prepareCall("{call VEH_PRO_INSURANCEISSUER(?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				for (int i = 0; i < ids.length; i++) {
					cs.setString(1, "DELETE");
					cs.setString(2, ids[i]);
					cs.setString(3, "");
					cs.setString(4, "");
					cs.setString(5, "");
					cs.setString(6, "");
					cs.setString(7, "");
					cs.setString(8, "");
					cs.setString(9, "");
					cs.setString(10, "");
					cs.setString(11, "");
					cs.setString(12, "");
					cs.setString(13, "");
					cs.addBatch();
				}
				cs.executeBatch();
				 
				response.sendRedirect("Smart Transport/InsuranceIssuer.jsp");
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