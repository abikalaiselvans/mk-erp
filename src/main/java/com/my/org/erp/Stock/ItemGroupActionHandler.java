package com.my.org.erp.Stock;
import java.io.IOException;
 

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class ItemGroupActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			HttpSession session=request.getSession();			
			String action=request.getParameter("actionS");
			String userid=""+session.getAttribute("USRID");
			 
			
			if("STKItemGroupAdd".equals(action)) 
			{
				String itemgroup= request.getParameter("itemgroup");
				String description= request.getParameter("description");
				String unit= request.getParameter("unit");
				acs = con.prepareCall("{call  CON_INV_PRO_ITEMGROUP (?,?,?,?,?,?)}");
				acs.setString(1, "INSERT");
				acs.setString(2, "1");
				acs.setString(3,itemgroup);
				acs.setString(4,description);
				acs.setString(5,unit);
				acs.setString(6, userid);
				acs.execute();
				acs.close();
				con.close();
				response.sendRedirect("SmartStock/ItemGroupview.jsp");
			}
			else if("STKItemGroupEdit".equals(action))
			{
				String itemgroup= request.getParameter("itemgroup");
				String description= request.getParameter("description");
				String unit= request.getParameter("unit");
				String itemgroupid= request.getParameter("itemgroupid");
				acs = con.prepareCall("{call  CON_INV_PRO_ITEMGROUP (?,?,?,?,?,?)}");
				acs.setString(1, "UPDATE");
				acs.setString(2, itemgroupid);
				acs.setString(3,itemgroup);
				acs.setString(4,description);
				acs.setString(5,unit);
				acs.setString(6, userid);
				acs.execute();
				acs.close();
				con.close();
				response.sendRedirect("SmartStock/ItemGroupview.jsp");
			}
			else if("STKUnitDelete".equals(action))
			{
				String data[] =request.getParameterValues("itemgroupid");
				 
				try 
				{
					acs = con.prepareCall("{call  CON_INV_PRO_ITEMGROUP (?,?,?,?,?,?)}");
					for(int y=0;y<data.length;y++)
					{
						acs.setString(1, "DELETE");
						acs.setString(2,data[y]);
						acs.setString(3,"1");
						acs.setString(4, "1");
						acs.setString(5, "1");
						acs.setString(6, "1");
						acs.addBatch();				
					}
					acs.executeBatch();
					acs.close();
				}
				catch(Exception e)
				{
					
				}
				con.close();
				response.sendRedirect("SmartStock/ItemGroupview.jsp");
				
			}
			 
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());			
		}
	}	
}
