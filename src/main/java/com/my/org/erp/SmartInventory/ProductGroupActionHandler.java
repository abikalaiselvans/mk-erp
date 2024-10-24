package com.my.org.erp.SmartInventory;
import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class ProductGroupActionHandler extends AbstractActionHandler
{	 
	private void Delete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			String []rowid= request.getParameterValues("rowid");							
			asql ="DELETE FROM inv_m_productgroup WHERE INT_PRODUCTGROUPID=?";
			apstm = con.prepareStatement(asql);
			for(int i=0;i<rowid.length;i++)
			{	
				apstm.setString(1,rowid[i]);
				apstm.addBatch();				
			}
			System.out.println("\n"+apstm);
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
			
			String name=""+request.getParameter("TxtproGroup").trim();
			String innerconfiguration=""+request.getParameter("innerconfiguration");
			 
			if(!"Y".equals(innerconfiguration))
				innerconfiguration= "N";
			
			asql=" INSERT INTO inv_m_productgroup ( CHR_NAME,CHR_CONFIGURATION,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
			asql = asql + " VALUES (?,?,?,DATE(NOW()),'Y' )  ";
			apstm =con.prepareStatement(asql);
			apstm.setString(1,name);
			apstm.setString(2,innerconfiguration);
			apstm.setString(3,auserid);
			System.out.println("\n"+apstm);
			apstm.execute();
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
	
	
	
	private void Edit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{	
			String  rowid=""+request.getParameter("Rowid");
			String name=request.getParameter("TxtproGroup").trim();	
			String innerconfiguration=""+request.getParameter("innerconfiguration") ;
			if(!"Y".equals(innerconfiguration))
				innerconfiguration= "N";
			
			asql=" UPDATE inv_m_productgroup SET ";
			asql = asql + " CHR_NAME=?, CHR_CONFIGURATION=?, CHR_USRNAME=?, DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y' WHERE INT_PRODUCTGROUPID=?"; 
			apstm =con.prepareStatement(asql);
			apstm.setString(1,name);
			apstm.setString(2,innerconfiguration);
			apstm.setString(3,auserid);
			apstm.setString(4,rowid);
			System.out.println("\n"+apstm);
			apstm.execute();
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
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
				String action=request.getParameter("actionS");
				if(action.equals("INVproGroupDelete"))
				{					
					Delete(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/ProductGroupView.jsp");
				}
				if("INVproGroupAdd".equals(action))
				{				
					Add(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/ProductGroupView.jsp");
				}
				else if("INVproGroupEdit".equals(action))
				{					
					Edit(request, response);
					con.close();    
					response.sendRedirect("Smart Inventory/ProductGroupView.jsp");
				}
			
		} 
		catch (Exception e) 
		{
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
			System.out.println(e.getMessage());
		}
	}
	
}

