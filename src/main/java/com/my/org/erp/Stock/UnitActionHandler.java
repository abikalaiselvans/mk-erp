package com.my.org.erp.Stock;
import java.io.IOException;
import java.sql.CallableStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class UnitActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			HttpSession session=request.getSession();			
			String action=request.getParameter("actionS");
			String userid=""+session.getAttribute("USRID");
			CallableStatement cs ;
			
			if("STKUnitAdd".equals(action)) 
			{
				String unitname= request.getParameter("unitname");
				String shortname= request.getParameter("shortname");
				cs = con.prepareCall("{call  CON_INV_PRO_UNIT (?,?,?,?,?)}");
				cs.setString(1, "INSERT");
				cs.setString(2, "1");
				cs.setString(3,unitname);
				cs.setString(4,shortname);
				cs.setString(5, userid);
				cs.execute();
				cs.close();
				response.sendRedirect("SmartStock/Unitsview.jsp");
			}
			else if("STKUnitEdit".equals(action))
			{
				String unitname= request.getParameter("unitname");
				String shortname= request.getParameter("shortname");
				String unitid= request.getParameter("unitid");
				cs = con.prepareCall("{call  CON_INV_PRO_UNIT (?,?,?,?,?)}");
				cs.setString(1, "UPDATE");
				cs.setString(2, unitid);
				cs.setString(3,unitname);
				cs.setString(4,shortname);
				cs.setString(5, userid);
				cs.execute();
				cs.close();
				 
				response.sendRedirect("SmartStock/Unitsview.jsp");
			}
			else if("STKUnitDelete".equals(action))
			{
				String data[] =request.getParameterValues("unitid");
				 
				try 
				{
					cs = con.prepareCall("{call  CON_INV_PRO_UNIT (?,?,?,?,?)}");
					for(int y=0;y<data.length;y++)
					{
						cs.setString(1, "DELETE");
						cs.setString(2,data[y]);
						cs.setString(3,"1");
						cs.setString(4, "1");
						cs.setString(5, "1");
						cs.addBatch();				
					}
					cs.executeBatch();
					cs.close();
				}
				catch(Exception e)
				{
					
				}

				response.sendRedirect("SmartStock/Unitsview.jsp");
				
			}
			 
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());			
		}
	}	
}
