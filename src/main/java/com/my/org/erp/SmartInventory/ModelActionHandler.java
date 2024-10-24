package com.my.org.erp.SmartInventory;
import java.io.IOException;


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class ModelActionHandler extends AbstractActionHandler
{
 
	public void ModelAdd(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{	
			HttpSession session=request.getSession();
			String userid=""+session.getAttribute("USRID");
			String name=""+request.getParameter("ModelCode");
			asql=" INSERT INTO inv_m_model "; 
			asql = asql + " (CHR_MODELCODE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS )";
			asql = asql + " VALUES ( ?,?, DATE(NOW()),'Y') ";
			apstm =con.prepareStatement(asql);
			apstm.setString(1,name);
			apstm.setString(2,userid);
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
	public void ModelEdit(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			HttpSession session=request.getSession();
			String userid=""+session.getAttribute("USRID");
			String rowid=request.getParameter("ModelId");
			String name=request.getParameter("ModelCode");
			asql=" UPDATE inv_m_model SET ";
			asql = asql + " CHR_MODELCODE=?, CHR_USRNAME=?,DT_UPDATEDATE=DATE(NOW()),CHR_UPDATESTATUS='Y' WHERE INT_MODELID=?"; 
			apstm =con.prepareStatement(asql);
			apstm.setString(1,name);
			apstm.setString(2,userid);
			apstm.setString(3,rowid);
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
	public void ModelDelete(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			String []rowid= request.getParameterValues("rowid");							
			asql ="DELETE FROM inv_m_model   WHERE INT_MODELID=?";
			apstm = con.prepareStatement(asql);
			for(int i=0;i<rowid.length;i++)
			{	
				apstm.setString(1,rowid[i]);
				apstm.addBatch();	
				System.out.println(""+apstm);
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
	public void handle(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			String action=request.getParameter("actionS");
			if(action.equals("INVmodelAdd"))
			{
				ModelAdd(request,response);
				con.close();    
				response.sendRedirect("Smart Inventory/ModelView.jsp");
			}
			else if(action.equals("INVmodelEdit"))
			{
				ModelEdit(request,response);
				con.close();    
				response.sendRedirect("Smart Inventory/ModelView.jsp");
			}
			else if(action.equals("INVmodelDelete"))
			{
				ModelDelete(request,response);
				con.close();    
				response.sendRedirect("Smart Inventory/ModelView.jsp");
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
