package com.my.org.erp.Stock;
import java.io.IOException;
import java.sql.CallableStatement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class ItemListActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			HttpSession session=request.getSession();			
			String action=request.getParameter("actionS");
			String userid=""+session.getAttribute("USRID");
			CallableStatement cs ;
			if("STKItemListAdd".equals(action)) 
			{
				
				String item= request.getParameter("item");
				String itemgroupid= request.getParameter("itemgroupid");
				String description= request.getParameter("description");
				String pprice= request.getParameter("pprice");
				String sprice= request.getParameter("sprice");
				cs = con.prepareCall("{call  CON_INV_PRO_ITEMLIST (?,?,?,?,?,?,?,?)}");
				cs.setString(1, "INSERT");
				cs.setString(2, "1");
				cs.setString(3,itemgroupid);
				cs.setString(4,item);
				cs.setString(5,description);
				cs.setString(6,pprice);
				cs.setString(7,sprice);
				cs.setString(8, userid);
				cs.execute();
				cs.close();
				response.sendRedirect("SmartStock/ItemListAction.jsp?action1=Add&itemgroupid="+itemgroupid);
			}
			else if("STKItemListEdit".equals(action))
			{
				
				String itemlistid= request.getParameter("itemlistid");
				String item= request.getParameter("item");
				String itemgroupid= request.getParameter("itemgroupid");
				String description= request.getParameter("description");
				String pprice= request.getParameter("pprice");
				String sprice= request.getParameter("sprice");
				cs = con.prepareCall("{call  CON_INV_PRO_ITEMLIST (?,?,?,?,?,?,?,?)}");
				cs.setString(1, "UPDATE");
				cs.setString(2, itemlistid);
				cs.setString(3, itemgroupid);
				cs.setString(4, item);
				cs.setString(5, description);
				cs.setString(6, pprice);
				cs.setString(7, sprice);
				cs.setString(8, userid);
				cs.execute();
				cs.close();
				response.sendRedirect("SmartStock/ItemListview.jsp");
			}
			else if("STKItemListDelete".equals(action))
			{
				String data[] =request.getParameterValues("itemlistid");
				 
				try 
				{
					cs = con.prepareCall("{call  CON_INV_PRO_ITEMLIST (?,?,?,?,?,?,?,?)}");
					for(int y=0;y<data.length;y++)
					{
						cs.setString(1, "DELETE");
						cs.setString(2,data[y]);
						cs.setString(3,"1");
						cs.setString(4, "1");
						cs.setString(5, "1");
						cs.setString(6, "1");
						cs.setString(7, "1");
						cs.setString(8, "1");
						cs.addBatch();				
					}
					cs.executeBatch();
					cs.close();
				}
				catch(Exception e)
				{
					
				}

				response.sendRedirect("SmartStock/ItemListview.jsp");
				
			}
			 
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());			
		}
	}	
}
