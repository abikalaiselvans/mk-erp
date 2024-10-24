package com.my.org.erp.SmartAset;
import java.io.IOException;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class ItemActionHandler extends AbstractActionHandler
{
	String proGroupName;
	int proGroupId;
	 
	private void ItemDelete(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{
			String []id= request.getParameterValues("id");							
			acs = con.prepareCall("{call ASSET_PRO_ITEM(?,?,?,?,?,?,?,?,?,?,?,?,? )}");
			for(int u=0;u<id.length;u++)
			{
				
				acs.setString(1, "DELETE");
				acs.setString(2, id[u]);
				acs.setString(3, "");		
				acs.setString(4, "");
				acs.setString(5, "");
				acs.setString(6, "");
				acs.setString(7, "");
				acs.setString(8, "");
				acs.setString(9, "");
				acs.setString(10, "");
				acs.setString(11, "");
				acs.setString(12, "");
				acs.setString(13, "");
				
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
	
	
	private void ItemAdd(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{			
			String  itemgroup= ""+request.getParameter("itemgroup");
			String  itemname= ""+request.getParameter("itemname");
			String  description= ""+request.getParameter("description");
			String  active= ""+request.getParameter("active");
			String  pdescription= ""+request.getParameter("pdescription");
			String  pprice= ""+request.getParameter("pprice");
			String  sdescription= ""+request.getParameter("sdescription");
			String  sprice= ""+request.getParameter("sprice");
			String  warranty= ""+request.getParameter("warranty");
			String  returnable= ""+request.getParameter("returnable");

			acs = con.prepareCall("{call ASSET_PRO_ITEM(?,?,?,?,?,?,?,?,?,?,?,?,? )}");
			acs.setString(1, "INSERT");
			acs.setString(2, "");
			acs.setString(3, itemgroup);	
			acs.setString(4, itemname);
			acs.setString(5, description);
			acs.setString(6, active);
			acs.setString(7, pdescription);
			acs.setString(8, pprice);
			acs.setString(9, sdescription);
			acs.setString(10, sprice);
			acs.setString(11, warranty);
			acs.setString(12, returnable);
			acs.setString(13, auserid);
			 System.out.println(""+acs);
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
	
	private void ItemEdit(HttpServletRequest request,HttpServletResponse response)throws ServletException, IOException
	{
		try
		{	
			String  id=""+request.getParameter("rowid");
			String  itemgroup= ""+request.getParameter("itemgroup");
			String  itemname= ""+request.getParameter("itemname");
			String  description= ""+request.getParameter("description");
			String  active= ""+request.getParameter("active");
			String  pdescription= ""+request.getParameter("pdescription");
			String  pprice= ""+request.getParameter("pprice");
			String  sdescription= ""+request.getParameter("sdescription");
			String  sprice= ""+request.getParameter("sprice");
			String  warranty= ""+request.getParameter("warranty");
			String  returnable= ""+request.getParameter("returnable");

			acs = con.prepareCall("{call ASSET_PRO_ITEM(?,?,?,?,?,?,?,?,?,?,?,?,? )}");
			acs.setString(1, "INSERT");
			acs.setString(2, id);
			acs.setString(3, itemgroup);	
			acs.setString(4, itemname);
			acs.setString(5, description);
			acs.setString(6, active);
			acs.setString(7, pdescription);
			acs.setString(8, pprice);
			acs.setString(9, sdescription);
			acs.setString(10, sprice);
			acs.setString(11, warranty);
			acs.setString(12, returnable);
			acs.setString(13, auserid);
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
				if(action.equals("ASSItemDelete"))
				{					
					ItemDelete(request, response);
					 
					response.sendRedirect("Smart Asset/ItemView.jsp");
				}
				if("ASSItemAdd".equals(action))
				{				
					ItemAdd(request, response);
					 
					response.sendRedirect("Smart Asset/ItemView.jsp");
				}
				else if("ASSItemEdit".equals(action))
				{					
					ItemEdit(request, response);
					 
					response.sendRedirect("Smart Asset/ItemView.jsp");
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

