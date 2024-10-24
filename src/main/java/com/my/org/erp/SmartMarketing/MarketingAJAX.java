package com.my.org.erp.SmartMarketing;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.Authenticator;
 
@WebServlet("/marketing")
public class MarketingAJAX extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	String readData[][];	    
 
	public  void doGet(HttpServletRequest request, HttpServletResponse  response)    throws IOException, ServletException 
	{
	 	try
        {
	 		if(Authenticator.isAuthenticated(request))
	 		{
	 			 String action=request.getParameter("actionS");	
			     if("LoadCustomerGroup".equals(action) )
	    		 {
			    	 MarketingMethods.LoadCustomerGroup(request, response);
	    		 }
			     else if("loadDepart".equals(action))
	    		 {
			    	 MarketingMethods.loadDepart(request, response);
	    		 }
			     else if("loadDesign".equals(action) )
	    		 {
			    	 MarketingMethods.loadDesign(request, response);
	    		 }

			     else if(action.equals("LoadCustomerName"))
				 {
			    	 MarketingMethods.LoadCustomerName(request,response);		
				 }
			     if("LoadStage".equals(action) )
	    		 {
			    	 MarketingMethods.LoadStage(request, response);
	    		 }
			     else if(action.equals("LoadCustomerContactPerson"))
				 {
			    	 MarketingMethods.LoadCustomerContactPerson(request,response);		
				 }
			     else if(action.equals("LoadCustomerNameAddress"))
				 {
			    	 MarketingMethods.LoadCustomerNameAddress(request,response);		
				 }
			     
			     else if("LoadCustomerinfos".equals(action) )
	    		 {
			    	 MarketingMethods.LoadCustomerinfos(request, response);
	    		 }
			     else if("loadCall".equals(action) )
	    		 {
			    	 MarketingMethods.loadCallSearch(request, response);
	    		 }
			     else if("LoadDaillyCalls".equals(action) )
	    		 {
			    	 MarketingMethods.LoadDaillyCalls(request, response);
	    		 }
			     else if(action.equals("LoadQuotationRegardsCustomer"))
				 {
			    	 MarketingMethods.LoadQuotationRegardsCustomer(request, response);		
				 }
			     else if("LoadMovetoCPO".equals(action) )
	    		 {
			    	 MarketingMethods.LoadMovetoCPO(request, response);
	    		 }
			     else if("LoadFunnel".equals(action) )
	    		 {
			    	 MarketingMethods.LoadFunnel(request, response);
	    		 }
			     else if("LoadEnquiryEntry".equals(action) )
	    		 {
			    	 MarketingMethods.loadEnquirySearch(request, response);
	    		 }
			     else if("LoadMobileContacts".equals(action) )
	    		 {
			    	 MarketingMethods.LoadMobileContacts(request, response);
	    		 }
			     else if("LoadScheduleEntry".equals(action) )
	    		 {
			    	 MarketingMethods.LoadScheduleEntry(request, response);
	    		 }
			     else if("loadMobileSearch".equals(action) )
				 {
					MarketingMethods.loadMobileSearch(request, response);
				 }
			     else if("marketingQuotation".equals(action) )
				 {
					MarketingMethods.marketingQuotation(request, response);
				 }
			     else if("marketingQuotationCPO".equals(action) )
				 {
					MarketingMethods.marketingQuotationCPO(request, response);
				 }
			     else if(action.equals("CustomerAddress"))
				 {
			    	 MarketingMethods.loadCustomerAddress(request,response);    
				 }
			     //Move to inventory
			     else if(action.equals("LoadMovetoCustomerName"))
				 {
			    	 MarketingMethods.LoadMovetoCustomerName(request,response);		
				 }
			     else if("LoadMovetoCustomerinfos".equals(action) )
	    		 {
			    	 MarketingMethods.LoadMovetoCustomerinfos(request, response);
	    		 }
	 		}
	 		else
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
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
     
	
    
	
    
	 
    
