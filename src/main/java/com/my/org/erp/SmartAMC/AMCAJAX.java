package com.my.org.erp.SmartAMC;

import java.io.IOException;
 


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.Authenticator;
 

@WebServlet("/AMC")
public class AMCAJAX extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	 
    public AMCAJAX() 
    {
		super();
		 
		 
	}
    
    public void init(ServletConfig config) throws ServletException 
    {        
        try
        {
          
        }
        catch(Exception e)
        {
        	 
        	 
        }   
    }   
 
    
 
    
    
    
    public  void doGet(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException 
    {
		try
        {
			String action=request.getParameter("actionS");	
			action=action.trim();
			if(Authenticator.isAuthenticated(request))
			{
				if(action.equals("LoadServiceGroup")) 
				{	
					AMCMethod.LoadServiceGroup(request, response);
				}
				else if(action.equals("LoadAMCCustomer")) 
				{	
					AMCMethod.LoadAMCCustomer(request, response);
				}
				else if(action.equals("LoadRuntimeNonCustomerGroup")) 
				{	
					AMCMethod.LoadRuntimeNonCustomerGroup(request, response);
				}
				else if(action.equals("LoadServiceCenter")) 
				{	
					AMCMethod.LoadServiceCenter(request, response);
				}
				else if(action.equals("LoadServiceItems")) 
				{	
					AMCMethod.LoadServiceItems(request, response);
				}
				else if(action.equals("LoadServiceAMC")) 
				{	
					AMCMethod.LoadServiceAMC(request, response);
				}
				else if(action.equals("LoadAMCPersonalinfo")) 
				{	
					AMCMethod.LoadAMCPersonalinfo(request, response);
				}
				else if(action.equals("LoadAMCCallBooking")) 
				{	
					AMCMethod.LoadAMCCallBooking(request, response);
				}
				else if(action.equals("LoadRuntimeCustomer")) 
				{	
					AMCMethod.LoadRuntimeCustomer(request, response);
				}
				else if(action.equals("LoadAMCSerialnumber")) 
				{	
					AMCMethod.LoadAMCSerialnumber(request, response);
				}
				else if(action.equals("CustomerServiceCallSerialnumberCheck")) 
				{	
					AMCMethod.CustomerServiceCallSerialnumberCheck(request, response);
				}
				else if(action.equals("LoadAMCSerialNumberCustomerwise")) 
				{	
					AMCMethod.LoadAMCSerialNumberCustomerwise(request, response);
				}
				else if(action.equals("LoadAMCCallAssign"))//
				{	
					AMCMethod.LoadAMCCallAssign(request, response);
				}
				else if(action.equals("INVCustomerServiceCallCreditLimit"))//
				{	
					AMCMethod.INVCustomerServiceCallCreditLimit(request, response);
				}
				else if(action.equals("LoadAMCcustomerinfo"))//
				{	
					AMCMethod.LoadAMCcustomerinfo(request, response);
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
  