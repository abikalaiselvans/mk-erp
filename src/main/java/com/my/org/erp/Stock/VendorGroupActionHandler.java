package com.my.org.erp.Stock;
import java.io.IOException;
import java.sql.CallableStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class VendorGroupActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			HttpSession session=request.getSession();			
			String action=request.getParameter("actionS");
			String userid=""+session.getAttribute("USRID");
			CallableStatement cs ;
			
			if("STKVendorGroupAdd".equals(action)) 
			{
				String VendorGroupName= request.getParameter("VendorGroupName");
				cs = con.prepareCall("{call  CON_INV_PRO_VENDORGROUP (?,?,?,?)}");
				cs.setString(1, "INSERT");
				cs.setString(2, "1");
				cs.setString(3,VendorGroupName);
				cs.setString(4, userid);
				cs.execute();
				cs.close();
				response.sendRedirect("SmartStock/VendorGroupView.jsp");
			}
			else if("STKVendorGroupEdit".equals(action))
			{
				
				String VendorGroupid= request.getParameter("VendorGroupid");
				String VendorGroupName= request.getParameter("VendorGroupName");
				cs = con.prepareCall("{call  CON_INV_PRO_VENDORGROUP (?,?,?,?)}");
				cs.setString(1, "UPDATE");
				cs.setString(2, VendorGroupid);
				cs.setString(3,VendorGroupName);
				cs.setString(4, userid);
				cs.execute();
				cs.close();
				response.sendRedirect("SmartStock/VendorGroupView.jsp");
			}
			else if("STKVendorGroupDelete".equals(action))
			{
				String data[] =request.getParameterValues("VendorGroupid");
				try 
				{
					cs = con.prepareCall("{call CON_INV_PRO_VENDORGROUP (?,?,?,?)}");
					for(int y=0;y<data.length;y++)
					{
						cs.setString(1, "DELETE");
						cs.setString(2,data[y]);
						cs.setString(3,"1");
						cs.setString(4, userid);
						cs.addBatch();				
					}
					cs.executeBatch();
					cs.close();
				}
				catch(Exception e)
				{
					
				}

				response.sendRedirect("SmartStock/VendorGroupView.jsp");
				
			}
			 
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());			
		}
	}	
}
