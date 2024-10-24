package com.my.org.erp.SmartInventory;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class ConsumableEntryActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{		
		try
		{
				String action=""+request.getParameter("actionS").trim();
				Statement st = con.createStatement();
				
				HttpSession session = request.getSession();
				String userid= ""+session.getAttribute("USRID");
				if("INVConsumableEntryADD".equals(action))
				{
					String branchid = request.getParameter("branchid");
					String paramlength = request.getParameter("paramlength");
					int loop = Integer.parseInt(paramlength);
					CallableStatement cs = con.prepareCall("{call  INV_PRO_CONSUMABLESTOCKENTRY (?,?,?,?,?)}");
					CallableStatement cs1 = con.prepareCall("{call  INV_PRO_CONSUMABLESTOCKENTRY (?,?,?,?,?)}");
					for(int u=0;u<loop;u++)
					{
						cs.setString(1, "DELETE");
						cs.setString(2,branchid);
						cs.setString(3,request.getParameter("pid"+(u+1)));
						cs.setString(4, request.getParameter("stock"+(u+1)));
						cs.setString(5, userid);
						cs.addBatch();	
						
						cs1.setString(1, "INSERT");
						cs1.setString(2,branchid);
						cs1.setString(3,request.getParameter("pid"+(u+1)));
						cs1.setString(4, request.getParameter("stock"+(u+1)));
						cs1.setString(5, userid);
						cs1.addBatch();
					}
					cs.executeBatch();
					cs1.executeBatch();
					con.close();   
					response.sendRedirect("Smart Inventory/InventoryMain.jsp");
					
				}
				st.close();
						
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


