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
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.SessionFactory.HColorInsertion;
import com.my.org.erp.bean.inventory.Color;
 
public class ColorActionHandler extends AbstractActionHandler
{
	
	//enum ACTION {INVcolorList,INVcolorAdd,INVcolorEdit,INVcolorDelete; } 
	 
	 
	public void ColorAdd(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
		 	
			Color c =new Color();
			Map map=request.getParameterMap();
			BeanUtils.populate(c,map);
			c.setUserdate(new Date());
			c.setStatus("Y");
			HColorInsertion.insert(c);
			 
			
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	
	
	
	public void ColorEdit(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			
			Color c =new Color();
			Map map=request.getParameterMap();
			BeanUtils.populate(c,map);
			c.setUserdate(new Date());
			c.setStatus("Y");
	
			HColorInsertion.update(c) ;
			
			 
			
		}
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}
	}
	
	
	
	public void ColorDelete(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			
			String []rowid= request.getParameterValues("rowid");							
			Color c =new Color();
			Map map=request.getParameterMap();
			BeanUtils.populate(c,map);
			c.setUserdate(new Date());
			c.setStatus("Y");
			  
		 
			for(int i=0;i<rowid.length;i++)
			{
				c.setRowid(Integer.parseInt(rowid[i]));
				HColorInsertion.delete(c) ;
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
			 
			
			if("INVcolorAdd".equals(action))
			{
				ColorAdd(request,response);
				con.close();    
				response.sendRedirect("Smart Inventory/ColorView.jsp");
				
			}
			else if("INVcolorEdit".equals(action))
			{
				ColorEdit(request,response);
				con.close();    
				response.sendRedirect("Smart Inventory/ColorView.jsp");
				
			}
			else if("INVcolorDelete".equals(action))
			{
				ColorDelete(request,response);
				con.close();   
				response.sendRedirect("Smart Inventory/ColorView.jsp");
				
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
