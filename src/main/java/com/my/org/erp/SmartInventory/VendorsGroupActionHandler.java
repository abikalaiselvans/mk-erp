package com.my.org.erp.SmartInventory;
import java.io.IOException;
 
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class VendorsGroupActionHandler extends AbstractActionHandler
{
	 
	private void Delete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		
		
		try
		{
			String []rowid= request.getParameterValues("rowid");							
			asql ="DELETE FROM inv_m_vendorsgroup   WHERE INT_GROUPID=?";
			apstm = con.prepareStatement(asql);
			for(int i=0;i<rowid.length;i++)
			{	
				apstm.setString(1,rowid[i]);
				apstm.addBatch();				
			}
			apstm.executeBatch();
			apstm.close();
		}
		catch(Exception e)
		{
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
			System.out.println(e.getMessage());
		}
		
		
		
		 
	}
	
	
	private void Add(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{			
			
			String name=""+request.getParameter("TxtvenGroup").trim();
			asql=" INSERT INTO inv_m_vendorsgroup "; 
			asql = asql + " (CHR_NAME,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
			asql = asql + " VALUES ( ?,?, DATE(NOW()),'Y') ";
			apstm =con.prepareStatement(asql);
			apstm.setString(1,name.toUpperCase());
			apstm.setString(2,auserid);
			apstm.execute();
			apstm.close();
			 
		}
		catch(Exception e)
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
			String  rowid=""+request.getParameter("Rowid");
			String name=request.getParameter("TxtvenGroup").trim();			
			asql=" UPDATE inv_m_vendorsgroup SET ";
			asql = asql + " CHR_NAME=?, CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y' WHERE INT_GROUPID=?"; 
			apstm =con.prepareStatement(asql);
			apstm.setString(1,name.toUpperCase());
			apstm.setString(2,auserid);
			apstm.setString(3,rowid);
			apstm.execute();
			apstm.close();
			 
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
				String action=request.getParameter("actionS");
				if(action.equals("INVvenGroupDelete"))
				{					
					Delete(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/VendorsGroupView.jsp");
				}
				if("INVvenGroupAdd".equals(action))
				{				
					Add(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/VendorsGroupView.jsp");
				}
				else if("INVvenGroupEdit".equals(action)){					
					Edit(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/VendorsGroupView.jsp");
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

