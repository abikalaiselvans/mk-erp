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
import com.my.org.erp.SessionFactory.HEquipementPartNumberInsertion;
import com.my.org.erp.bean.inventory.EquipementPartNumber;
 
public class EquipementPartNumberActionHandler extends AbstractActionHandler
{
	 
	 
	public void Add(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			 
			EquipementPartNumber c =new EquipementPartNumber();
			Map map=request.getParameterMap();
			BeanUtils.populate(c,map);
			c.setUserdate(new Date());
			c.setStatus("Y");
			HEquipementPartNumberInsertion.insert(c);
			 
			
		}
		catch (Exception e) 
		{
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	
	
	
	public void Edit(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			
			EquipementPartNumber c =new EquipementPartNumber();
			Map map=request.getParameterMap();
			BeanUtils.populate(c,map);
			c.setUserdate(new Date());
			c.setStatus("Y");
			HEquipementPartNumberInsertion.update(c) ;
			
			 
			
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
			EquipementPartNumber c =new EquipementPartNumber();
			Map map=request.getParameterMap();
			BeanUtils.populate(c,map);
			c.setUserdate(new Date());
			c.setStatus("Y");
			  
		 
			for(int i=0;i<rowid.length;i++)
			{
				c.setRowid(Integer.parseInt(rowid[i]));
				HEquipementPartNumberInsertion.delete(c) ;
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
			 
			
			if("INVEquipementPartNumberAdd".equals(action))
			{
				Add(request,response);
				con.close();    
				response.sendRedirect("Smart Inventory/EquipementPartNumber.jsp");
				
			}
			else if("INVEquipementPartNumberEdit".equals(action))
			{
				Edit(request,response);
				con.close();    
				response.sendRedirect("Smart Inventory/EquipementPartNumber.jsp");
				
			}
			else if("INVEquipementPartNumberDelete".equals(action))
			{
				Delete(request,response);
				con.close();   
				response.sendRedirect("Smart Inventory/EquipementPartNumber.jsp");
				
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
