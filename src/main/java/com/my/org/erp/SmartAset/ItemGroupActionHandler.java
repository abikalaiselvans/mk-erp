package com.my.org.erp.SmartAset;
import java.io.IOException;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class ItemGroupActionHandler extends AbstractActionHandler
{
	String proGroupName;
	int proGroupId;
	 
	private void GroupDelete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			String []GroupId= request.getParameterValues("optprogroupid");							
			acs = con.prepareCall("{call ASSET_PRO_ITEMGROUP(?,?,?,? )}");
			for(int u=0;u<GroupId.length;u++)
			{
				
				acs.setString(1, "DELETE");
				acs.setString(2, GroupId[u]);
				acs.setString(3, "");		
				acs.setString(4, "");
				acs.addBatch();
			}
			acs.executeBatch();
			acs.close();
			 
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}
	
	
	private void GroupAdd(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{			
			String GroupName=""+request.getParameter("TxtproGroup").trim();
			acs = con.prepareCall("{call ASSET_PRO_ITEMGROUP(?,?,?,? )}");
			acs.setString(1, "INSERT");
			acs.setString(2, "");
			acs.setString(3, GroupName);		
			acs.setString(4, auserid);
			acs.execute();
			acs.close();
			 
			
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}
	
	private void GroupEdit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{	
			String  id=""+request.getParameter("proGroupId");
			String GroupName=request.getParameter("TxtproGroup").trim();			
			acs = con.prepareCall("{call ASSET_PRO_ITEMGROUP(?,?,?,? )}");
			acs.setString(1, "UPDATE");
			acs.setString(2, id);
			acs.setString(3, GroupName);		
			acs.setString(4, auserid);
			acs.execute();
			acs.close();
			 
			
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
				if(action.equals("ASSAssetGroupDelete"))
				{					
					GroupDelete(request, response);
					 
					response.sendRedirect("Smart Asset/ItemgroupView.jsp");
				}
				if("ASSAssetGroupAdd".equals(action))
				{				
					GroupAdd(request, response);
					 
					response.sendRedirect("Smart Asset/ItemgroupView.jsp");
				}
				else if("ASSAssetGroupEdit".equals(action))
				{					
					GroupEdit(request, response);
					 
					response.sendRedirect("Smart Asset/ItemgroupView.jsp");
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

