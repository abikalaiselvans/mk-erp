package com.my.org.erp.SmartManagement;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.Authenticator;

@SuppressWarnings("serial")
@WebServlet("/management")
public class ManagementAjax extends HttpServlet
{
    public  void doGet(HttpServletRequest request, HttpServletResponse  response)   throws IOException, ServletException
    {
		try
		{
				String action=request.getParameter("actionS");
				if(Authenticator.isAuthenticated(request))
				{ 
					if("MGTstaff".equals(action) )
					{
			  	 		ManagementMethod.loadContraStaff(request, response);
					}
					else if("MGTstaffSearch".equals(action) )
					{
						ManagementMethod.loadContraStaffSearch(request, response);
					}
					else if("loadComplaints".equals(action) )
					{
						ManagementMethod.loadComplaints(request, response);
					}
					else if("loadComplaintsResponse".equals(action) )
					{
						ManagementMethod.loadComplaintsResponse(request, response);
					}
					else if("loadBuilding".equals(action) )
					{
						VisitorsPassMethod.loadBuilding(request, response);
					}
					else if("loadFloor".equals(action) )
					{
						VisitorsPassMethod.loadFloor(request, response);
					}
					else if("loadPurpose".equals(action) )
					{
						VisitorsPassMethod.loadPurpose(request, response);
					}
					else if("loadVisitors".equals(action) )
					{
						VisitorsPassMethod.loadVisitors(request, response);
					}
					else if("loadPettyCash".equals(action) )
					{
						PettyCashMethod.loadPettyCash(request, response);
					}
					else if("loadDayBook".equals(action) )
					{
						PettyCashMethod.loadDayBook(request, response);
					}
					else if("LoadPettyCashIncome".equals(action) )
					{
						PettyCashMethod.LoadPettyCashIncome(request, response);
					}
					else if("LoadPettyCashExpense".equals(action) )
					{
						PettyCashMethod.LoadPettyCashExpense(request, response);
					}
					else if("loadPettyCashSample".equals(action) )
					{
						PettyCashMethod.loadPettyCashSample(request, response);
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
    
