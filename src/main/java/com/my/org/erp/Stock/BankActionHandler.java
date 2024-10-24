package com.my.org.erp.Stock;
import java.io.IOException;
 

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class BankActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			HttpSession session=request.getSession();			
			String action=request.getParameter("actionS");
			String userid=""+session.getAttribute("USRID");
			 
			if("STKBankAdd".equals(action)) 
			{
				
				String bank= request.getParameter("bank");
				String shortname= request.getParameter("shortname");
				
				acs = con.prepareCall("{call  CON_INV_PRO_BANK (?,?,?,?,?)}");
				acs.setString(1, "INSERT");
				acs.setString(2, "1");
				acs.setString(3,bank);
				acs.setString(4,shortname);
				acs.setString(5,userid);
				acs.execute();
				acs.close();
				con.close();
				response.sendRedirect("SmartStock/Bankview.jsp");
			}
			else if("STKBankEdit".equals(action))
			{
				String bank= request.getParameter("bank");
				String bankid= request.getParameter("bankid");
				String shortname= request.getParameter("shortname");
				acs = con.prepareCall("{call CON_INV_PRO_BANK (?,?,?,?,?)}");
				acs.setString(1, "UPDATE");
				acs.setString(2, bankid);
				acs.setString(3,bank);
				acs.setString(4,shortname);
				acs.setString(5,userid);
				acs.execute();
				acs.close();
				con.close();
				response.sendRedirect("SmartStock/Bankview.jsp");
			}
			else if("STKBankDelete".equals(action))
			{
				String data[] =request.getParameterValues("Bankid");
				try 
				{
					acs = con.prepareCall("{call  CON_INV_PRO_BANK (?,?,?,?)}");
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
				}
				catch(Exception e)
				{
					
				}

				response.sendRedirect("SmartStock/Bankview.jsp");
				
			}
			 
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());			
		}
	}	
}
