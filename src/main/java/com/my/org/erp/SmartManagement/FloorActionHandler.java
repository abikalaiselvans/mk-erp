package com.my.org.erp.SmartManagement;

import java.io.IOException;
import java.util.Date;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 

import org.apache.commons.beanutils.BeanUtils;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.bean.management.Floor;
import com.my.org.erp.common.CommonFunctions;
 

public class FloorActionHandler extends AbstractActionHandler {

	@SuppressWarnings("rawtypes")
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session=request.getSession();			
			String userid=""+session.getAttribute("USRID");
			String branchid = session.getAttribute("BRANCHID").toString();
			String officeid=""+session.getAttribute("OFFICEID");
			if ("MGTFloorAdd".equals(action)) 
			{	
				Add(request,response);
				con.close();
				response.sendRedirect("Smart Management/Floor.jsp");
			}
			else if ("MGTFloorEdit".equals(action)) 
			{ 
				Edit(request,response); 
				con.close();
				response.sendRedirect("Smart Management/Floor.jsp");
				
			} 
			else if ("MGTFloorDelete".equals(action)) 
			{ 
				Delete(request,response); 
				con.close();
				response.sendRedirect("Smart Management/Floor.jsp");
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

	
	public void Add(HttpServletRequest request,HttpServletResponse response)throws IOException,ServletException
	{
		try
		{
			 
			Floor c =new Floor();
			Map map=request.getParameterMap();
			BeanUtils.populate(c,map);
			c.setUserdate(new Date());
			c.setStatus("Y");
			HFloorInsertion.insert(c);
			 
			
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
			
			Floor c =new Floor();
			Map map=request.getParameterMap();
			BeanUtils.populate(c,map);
			c.setUserdate(new Date());
			c.setStatus("Y");
			HFloorInsertion.update(c) ;
			
			 
			
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
			Floor c =new Floor();
			Map map=request.getParameterMap();
			BeanUtils.populate(c,map);
			c.setUserdate(new Date());
			c.setStatus("Y");
			  
		 
			for(int i=0;i<rowid.length;i++)
			{
				c.setRowid(Integer.parseInt(rowid[i]));
				HFloorInsertion.delete(c) ;
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
	
	public static String complaintNumber() 
	 {
		try 
	 	{
			
			String sql =" SELECT RIGHT(CONCAT('00000', (SELECT IF( (COUNT(*)>0 ) ," +
			"(MAX(INT_COMPLAINTID)+1),'1')   FROM mgt_t_complaints)),6) ";
			return CommonFunctions.QueryExecute(sql)[0][0];
			
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage());
	 	}
	 	return null;
	 }
	
	public static String complaintLocation(String officeid) 
	 {
		try 
	 	{
			 
			String sql =" SELECT  CHR_OFFICESHORTNAME  FROM  com_m_office  WHERE INT_OFFICEID="+officeid;
			String Officename[][] =CommonFunctions.QueryExecute(sql);
			return Officename[0][0];
	 	}
	 	catch (Exception e) 
	 	{
	 		 System.out.println(e.getMessage()); 
	 	}
	 	return null;
	 }
	
}