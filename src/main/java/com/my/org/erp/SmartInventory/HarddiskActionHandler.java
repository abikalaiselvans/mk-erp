package com.my.org.erp.SmartInventory;
import java.io.IOException;
 
 
 
import java.util.Date;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.SessionFactory.HHarddiskInsertion;
import com.my.org.erp.bean.inventory.Harddisk;
 
public class HarddiskActionHandler extends AbstractActionHandler
{
	 
	 
	public void Add(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
		 
			
			
			Harddisk c =new Harddisk();
			Map map=request.getParameterMap();
			BeanUtils.populate(c,map);
			c.setUserdate(new Date());
			c.setStatus("Y");
			HHarddiskInsertion.insert(c);
			 
			
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	
	
	
	public void Edit(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			
			Harddisk c =new Harddisk();
			Map map=request.getParameterMap();
			BeanUtils.populate(c,map);
			c.setUserdate(new Date());
			c.setStatus("Y");
	
			HHarddiskInsertion.update(c) ;
			
			 
			
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	public void Delete(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			
			String []rowid= request.getParameterValues("rowid");							
			Harddisk c =new Harddisk();
			Map map=request.getParameterMap();
			BeanUtils.populate(c,map);
			c.setUserdate(new Date());
			c.setStatus("Y");
			  
		 
			for(int i=0;i<rowid.length;i++)
			{
				c.setRowid(Integer.parseInt(rowid[i]));
				HHarddiskInsertion.delete(c) ;
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
	
	public void handle(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			
			String action=request.getParameter("actionS");
			 
			
			if("INVHarddiskAdd".equals(action))
			{
				Add(request,response);
				con.close();    
				response.sendRedirect("Smart Inventory/Harddisk.jsp");
				
			}
			else if("INVHarddiskEdit".equals(action))
			{
				Edit(request,response);
				con.close();    
				response.sendRedirect("Smart Inventory/Harddisk.jsp");
				
			}
			else if("INVHarddiskDelete".equals(action))
			{
				Delete(request,response);
				con.close();   
				response.sendRedirect("Smart Inventory/Harddisk.jsp");
				
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
