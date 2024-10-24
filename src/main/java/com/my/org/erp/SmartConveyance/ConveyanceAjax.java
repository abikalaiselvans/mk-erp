package com.my.org.erp.SmartConveyance;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.Authenticator;

@WebServlet("/Conveyance")
public class ConveyanceAjax extends HttpServlet
{
    public  void doGet(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
		try
		{
			String action=request.getParameter("actionS");
			System.out.println(action);
			if(Authenticator.isAuthenticated(request))
			{ 
				if(  "Conveyance" .equals(action) )
					ConveyanceMethod.ConveyancedateCheck(request, response);
				else if( "ConveyanceReport" .equals(action)) 
					ConveyanceMethod.LoadConveyanceReport(request, response);	
				else if( "ConveyanceAdvance" .equals(action)) 
					ConveyanceMethod.ConveyanceAdvance(request, response);
				else if( "ConveyanceManual" .equals(action)) 
					ConveyanceMethod.ConveyanceManual(request, response);
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
    
