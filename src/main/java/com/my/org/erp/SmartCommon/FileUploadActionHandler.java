package com.my.org.erp.SmartCommon;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse; 

import com.my.org.erp.ServiceLogin.AbstractActionHandler; 
import com.my.org.erp.common.CommonFunctions;

@WebServlet("/stafffileUpload")
public class FileUploadActionHandler extends AbstractActionHandler 
{
	
	
	 
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			 
			  
			if (action.equals("GENIdProofDelete")) 
			{ }
			 
			
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
