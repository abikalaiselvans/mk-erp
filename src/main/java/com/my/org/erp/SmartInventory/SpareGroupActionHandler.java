package com.my.org.erp.SmartInventory;
import java.io.IOException;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class SpareGroupActionHandler extends AbstractActionHandler
{
	private void Delete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			String []id= request.getParameterValues("rowid");							
			asql = "DELETE FROM inv_m_sparegroup WHERE INT_GROUPID=?";
			apstm = con.prepareStatement(asql);
			for(int u=0;u<id.length;u++)
			{
				apstm.setString(1, id[u]);
				apstm.addBatch();
			}
			apstm.executeBatch();
			apstm.close();
		  
			
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	
	
	private void Add(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{			
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");		
			String groupname=""+request.getParameter("groupname").trim();
			asql=" INSERT INTO inv_m_sparegroup (CHR_GROUPNAME,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ) VALUES ";
			asql =asql+" ( ?,?,DATE(NOW()),'Y')";
			apstm = con.prepareStatement(asql);
			apstm.setString(1, groupname);
			apstm.setString(2, userid);
			apstm.execute();
			apstm.close(); 
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	
	
	private void Edit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{	
			String  id=""+request.getParameter("rowid");
			String groupname=request.getParameter("groupname").trim();			
			asql="UPDATE inv_m_sparegroup SET CHR_GROUPNAME=? WHERE INT_GROUPID=?";
			apstm = con.prepareStatement(asql);
			apstm.setString(1, groupname);
			apstm.setString(2, id);
			apstm.execute();
			apstm.close(); 
			
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try
		{
				String action=request.getParameter("actionS");
				if(action.equals("INVSpareGroupDelete"))
				{					
					Delete(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/SpareGroup.jsp");
				}
				if("INVSpareGroupAdd".equals(action))
				{				
					Add(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/SpareGroup.jsp");
				}
				else if("INVSpareGroupEdit".equals(action))
				{					
					Edit(request, response);
					con.close();   
					response.sendRedirect("Smart Inventory/SpareGroup.jsp");
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

