package com.my.org.erp.SmartHRM;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/AjaxUniq")
public class AjaxUniq extends HttpServlet
{
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			
			chkval (request, response);
	
		}catch(Exception e)
		{
			System.out.println(e);
		}
	}  	
 
	public static void chkval(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
	{
			
		String id = request.getParameter("ID");
		@SuppressWarnings("unused")
		String table_name = request.getParameter("tname");
		@SuppressWarnings("unused")
		String field_name = request.getParameter("fname");
	 
		 
		
			response.setContentType("text/xml");
     		response.getWriter().write(id);	
	}
	
}
    
