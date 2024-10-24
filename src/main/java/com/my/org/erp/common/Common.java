package com.my.org.erp.common;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Common extends HttpServlet
{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public  void doGet(HttpServletRequest request, HttpServletResponse  response)
    throws IOException, ServletException 
    {
		try
			{
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
    
