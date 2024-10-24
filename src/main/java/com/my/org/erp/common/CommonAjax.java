package com.my.org.erp.common;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse; 

import com.my.org.erp.ServiceLogin.Authenticator;


@WebServlet("/Common")
public class CommonAjax extends HttpServlet
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
				String action=request.getParameter("actionS");
				if(Authenticator.isAuthenticated(request))
				{ 
					if(action.equals("LoadUserName"))
					{
						CommonMethod.LoadUserNames(request, response);
					}	
					else if(action.equals("ATTdistrict"))
					{
						CommonMethod.LoadDistrict(request, response);
					}
					else if(action.equals("ATTbranch"))
					{
						CommonMethod.loadBranchData(request, response);
					}
					else if("ATTstaff".equals(action))
					{
						CommonMethod.loadStaff(request, response);
					}
					else if("ATTstaffsearch".equals(action))
					{
						CommonMethod.loadStaffSearch(request, response);
					}
					else if("LoadSearchStaffids".equals(action))
					{
						CommonMethod.LoadSearchStaffids(request, response);
					}
					else if(action.equals("INVUniqueId"))
					{
						CommonMethod.AMCUniqueId(request,response);    
					}
					else if(action.equals("UniqueId"))
					{
						CommonMethod.UniqueId(request,response);    
					}
					else if(action.equals("UniqueIdWithData"))
					{
						CommonMethod.UniqueIdWithData(request,response);    
					}
					else if(action.equals("UniqueIdSale"))
					{
						CommonMethod.UniqueIdSale(request,response);    
					}
					else if(action.equals("UniqueIdSales"))
					{
						CommonMethod.UniqueIdSales(request,response);    
					}
					else if(action.equals("CheckUnique"))
					{	
						CommonMethod.CheckUnique(request,response);			    
					}
					else if(action.equals("INVsearch"))
					{	
						CommonMethod.Search(request,response);			    
					}
					else if(action.equals("Ticket"))
					{	
						CommonMethod.Ticket(request,response);			    
					}
					else if(action.equals("ServerCheckSession"))
					{	
						CommonMethod.ServerCheckSession(request,response);			    
					}
					else if(action.equals("commonsearch"))
					{	
						CommonMethod.commonSearch(request,response);			    
					}
					else if(action.equals("MailServerSession"))
					{	
						CommonMethod.MailServerSession(request,response);			    
					}
					else if(action.equals("loadNotification"))
					{	
						CommonMethod.loadNotification(request,response);			    
					}
					
					else if(action.equals("loadSearchStaff"))
					{	
						CommonMethod.loadSearchStaff(request,response);			    
					}
					if(action.equals("LoadSelectState"))
					{	
						CommonMethod.LoadSelectState(request,response);			    
					}
					else if(action.equals("LoadSelectDistrict"))
					{	
						CommonMethod.LoadSelectDistrict(request,response);			    
					}
					else if(action.equals("LoadSelectCity"))
					{	
						CommonMethod.LoadSelectCity(request,response);			    
					}
					else if("AssignPincode".equals(action))
					{
						CommonMethod.AssignPincode(request,response);
					}
					else if("AssignPincode".equals(action))
					{
						CommonMethod.AssignPincode(request,response);
					}
					else if(action.equals("LoadISD"))
					{	
						CommonMethod.LoadISD(request,response);			    
					}
					else if(action.equals("LoadSTD"))
					{	
						CommonMethod.LoadSTD(request,response);			    
					}
					else if(action.equals("LoadCity"))
					{	
						CommonMethod.LoadCity(request,response);			    
					}
					else if(action.equals("LoadPINCODE"))
					{	
						CommonMethod.LoadPINCODE(request,response);			    
					}
					else if(action.equals("CheckUniqueInResigned"))
					{	
						CommonMethod.CheckUniqueInResigned(request,response);			    
					}
    	 		}
    	 		else 
	 			{
    	 			response.setStatus(HttpServletResponse.SC_NO_CONTENT);
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
}
    
