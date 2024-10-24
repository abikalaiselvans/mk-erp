package com.my.org.erp.SmartUploadDownload;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.Authenticator;

@WebServlet("/UploadAjax")
public class UploadAJAX extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	String readData[][];	    
        
    public  void doGet(HttpServletRequest request, HttpServletResponse  response)    throws IOException, ServletException 
    {
	 
    	try
    	{
			String action=request.getParameter("actionS");	
			if(Authenticator.isAuthenticated(request))
			{
				if("loadUploadCategory".equals(action) )
				{
					UploadMethods.loadUploadCategory(request, response);
				}
			}
			else
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
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
     
	
    
	
    
	 
    
