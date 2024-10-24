package com.my.org.erp.SmartMarketing;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.Authenticator;
@WebServlet("/EmailCampaignAJAX")
public class MailCampaignAJAX extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	
	
	public  void doGet(HttpServletRequest request, HttpServletResponse  response) throws IOException, ServletException 
    {
	  	try
	  	{
			String action=request.getParameter("actionS");

			if(Authenticator.isAuthenticated(request))
			{ 
				if(action.equals("LoadEmailCustomerGroup"))
	    		{
			    	MailCampaignMethod.LoadEmailCustomerGroup(request, response);
	    		}
			    else if(action.equals("LoadEmailCompany"))
			    {
			    	MailCampaignMethod.LoadEmailCompany(request, response);
	   		 	}
			    else if(action.equals("LoadEmailBranch"))
			    {
			    	MailCampaignMethod.LoadEmailBranch(request, response);
	   		 	}
			    else if(action.equals("LoadSelectEmailCompany"))
			    {
			    	MailCampaignMethod.LoadSelectEmailCompany(request, response);
	   		 	}
			    else if(action.equals("LoadSelectEmailBranch"))
			    {
			    	MailCampaignMethod.LoadSelectEmailBranch(request, response);
	   		 	}
			    else if(action.equals("LoadEmailCustomer"))
			    {
			    	MailCampaignMethod.LoadEmailCustomer(request, response);
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
     
	
    
	
    
	 
    
