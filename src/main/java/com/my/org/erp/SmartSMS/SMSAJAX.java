package com.my.org.erp.SmartSMS;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/SMS")
public class SMSAJAX extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	String readData[][];	    
        
    
   
    


public  void doGet(HttpServletRequest request, HttpServletResponse  response)    throws IOException, ServletException 
{
	 	try
       {
	 			 String action=request.getParameter("actionS");	
			     if("LoadCustomerGroup".equals(action) )
	    		 {
			    	 SMSMethods.LoadCustomerGroup(request, response);
	    		 }
			     else if("LoadCustomerinfos".equals(action) )
	    		 {
			    	 SMSMethods.LoadCustomerinfos(request, response);
	    		 }
			     else if("LoadMobileContacts".equals(action) )
	    		 {
			    	 SMSMethods.LoadMobileContacts(request, response);
	    		 }
			     else if("loadMobileSearch".equals(action) )
	    		 {
			    	 SMSMethods.loadMobileSearch(request, response);
	    		 }
		     
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
     
	
    
	
    
	 
    
