package com.my.org.erp.Stock;
import java.io.IOException;
import java.sql.CallableStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class PaymentActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			HttpSession session=request.getSession();			
			String action=request.getParameter("actionS");
			String userid=""+session.getAttribute("USRID");
			CallableStatement cs ;
			if("STKPaymentAdd".equals(action)) 
			{
				
				String paymentname= request.getParameter("paymentname");
				String description= request.getParameter("description");
				cs = con.prepareCall("{call  CON_INV_PRO_PAYMENT (?,?,?,?,?)}");
				cs.setString(1, "INSERT");
				cs.setString(2, "1");
				cs.setString(3,paymentname);
				cs.setString(4,description);
				cs.setString(5, userid);
				cs.execute();
				cs.close();
				response.sendRedirect("SmartStock/Paymentview.jsp");
			}
			else if("STKPaymentEdit".equals(action))
			{
				String paymentid= request.getParameter("paymentid");
				String paymentname= request.getParameter("paymentname");
				String description= request.getParameter("description");
				cs = con.prepareCall("{call  CON_INV_PRO_PAYMENT (?,?,?,?,?)}");
				cs.setString(1, "UPDATE");
				cs.setString(2, paymentid);
				cs.setString(3, paymentname);
				cs.setString(4, description);
				cs.setString(5, userid);
				cs.execute();
				cs.close();
				response.sendRedirect("SmartStock/Paymentview.jsp");
			}
			else if("STKPaymentDelete".equals(action))
			{
				String data[] =request.getParameterValues("Paymentid");
				 
				try 
				{
					cs = con.prepareCall("{call  CON_INV_PRO_PAYMENT (?,?,?,?,?)}");
					for(int y=0;y<data.length;y++)
					{
						cs.setString(1, "DELETE");
						cs.setString(2,data[y]);
						cs.setString(3,"1");
						cs.setString(4, "1");
						cs.setString(5, userid);
						cs.addBatch();				
					}
					cs.executeBatch();
					cs.close();
				}
				catch(Exception e)
				{
					
				}

				response.sendRedirect("SmartStock/Paymentview.jsp");
				
			}
			 
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());			
		}
	}	
}
