package com.my.org.erp.Stock;
import java.io.IOException;
import java.sql.CallableStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class TaxActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			HttpSession session=request.getSession();			
			String action=request.getParameter("actionS");
			String userid=""+session.getAttribute("USRID");
			CallableStatement cs ;
			if("STKTaxAdd".equals(action)) 
			{
				
				String taxname= request.getParameter("taxname");
				String taxvalue= request.getParameter("taxvalue");
				String description= request.getParameter("description");
				cs = con.prepareCall("{call CON_INV_PRO_TAX (?,?,?,?,?,?)}");
				cs.setString(1, "INSERT");
				cs.setString(2, "1");
				cs.setString(3,taxname);
				cs.setString(4,description);
				cs.setString(5,taxvalue);
				cs.setString(6, userid);
				cs.execute();
				cs.close();
				response.sendRedirect("SmartStock/Taxview.jsp");
			}
			else if("STKTaxEdit".equals(action))
			{
				String taxid= request.getParameter("taxid");
				String taxname= request.getParameter("taxname");
				String taxvalue= request.getParameter("taxvalue");
				String description= request.getParameter("description");
				cs = con.prepareCall("{call CON_INV_PRO_TAX (?,?,?,?,?,?)}");
				cs.setString(1, "UPDATE");
				cs.setString(2, taxid);
				cs.setString(3,taxname);
				cs.setString(4,description);
				cs.setString(5,taxvalue);
				cs.setString(6, userid);
				cs.execute();
				cs.close();
				response.sendRedirect("SmartStock/Taxview.jsp");
			}
			else if("STKTaxDelete".equals(action))
			{
				String data[] =request.getParameterValues("Taxid");
				 
				try 
				{
					cs = con.prepareCall("{call  CON_INV_PRO_TAX (?,?,?,?,?,?)}");
					for(int y=0;y<data.length;y++)
					{
						cs.setString(1, "DELETE");
						cs.setString(2,data[y]);
						cs.setString(3,"1");
						cs.setString(4, "1");
						cs.setString(5, "1");
						cs.setString(6, userid);
						cs.addBatch();				
					}
					cs.executeBatch();
					cs.close();
				}
				catch(Exception e)
				{
					
				}

				response.sendRedirect("SmartStock/Taxview.jsp");
				
			}
			 
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());			
		}
	}	
}
