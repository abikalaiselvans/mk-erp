package com.my.org.erp.SmartHRM;

import java.io.IOException;
 


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.Authenticator;

@SuppressWarnings("serial")
@WebServlet("/SmartHRM")
public class HrmAjax extends HttpServlet
{
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{

			String action=request.getParameter("actionS");

			if(Authenticator.isAuthenticated(request))
			{ 
				if(action.equals("JobGradeId"))
				{
					CommonMethod.LoadJobGrade(request,response);
				} 
				else if(action.equals("JobGrade"))
				{
					CommonMethod.loadJobCode(request, response);
				}
				else if(action.equals("LoadDemandJobTitle"))
				{
					CommonMethod.LoadDemandJobTitle(request,response);
				}
				else if(action.equals("JobDemand"))
				{
					CommonMethod.loadJobDemand(request, response);
				}
				else if(action.equals("JobTitle"))
				{
					CommonMethod.LoadJobTitle(request,response);
				}
				else if(action.equals("JobAppView"))
				{
					CommonMethod.loadAppView (request, response);
				}
				else if(action.equals("loadOnlineTestDetails"))
				{
					CommonMethod.loadOnlineTestDetails (request, response);
				}
				else if(action.equals("JobCode"))
				{
					CommonMethod.loadJobCode(request, response);
				}
				else if(action.equals("JobCodes"))
				{
					CommonMethod.loadJobCodes(request, response);
				}
				else if(action.equals("DemandJobGrade"))
				{
					CommonMethod.loadDemandJobGrade(request, response);
				}
				else if(action.equals("Unique"))
				{
					CommonMethod.loadUnique(request,response);
				}
				else if(action.equals("JobApplication"))
				{
					CommonMethod.loadApplication(request, response);
				}
				else if(action.equals("JobPerformance"))
				{
					CommonMethod.loadPerformance(request, response);
				}
				else if(action.equals("JobResult"))
				{
					CommonMethod.loadResult(request, response);
				}
				else if (action.equals("AppointmentOrder"))
				{
					CommonMethod.loadAppOrder(request, response);
				}
				else if (action.equals("ComboPerformance"))
				{
					CommonMethod.ComboPerformance(request, response);
				}
				else if (action.equals("loadEmployeeVerification"))
				{
					CommonMethod.loadEmployeeVerification(request, response);
				}
				else if (action.equals("loadResume"))
				{
					CommonMethod.loadResume(request, response);
				}
				else if (action.equals("loadTestType"))
				{
					CommonMethod.loadTestType(request, response);
				}
				else if (action.equals("loadTestTypeQuestion"))
				{
					CommonMethod.loadTestTypeQuestion(request, response);
				}
				else if (action.equals("loadSkill"))
				{
					CommonMethod.loadSkill(request, response);
				}
				else if (action.equals("loadTechnicalCompetency"))
				{
					CommonMethod.loadTechnicalCompetency(request, response);
				}
				else if(action.equals("loadFirstInterview"))
				{
					CommonMethod.loadFirstInterview (request, response);
				}
				else if(action.equals("loadSecondInterview"))
				{
					CommonMethod.loadSecondInterview (request, response);
				}
				else if(action.equals("loadFinalInterview"))
				{
					CommonMethod.loadFinalInterview (request, response);
				}
				else if(action.equals("loadconclusion"))
				{
					CommonMethod.loadconclusion (request, response);
				}
				else if(action.equals("loadResult"))
				{
					CommonMethod.loadResult (request, response);
				}
				else if(action.equals("LoadOfferview"))
				{
					CommonMethod.LoadOfferview (request, response);
				}
				else if(action.equals("loadOfferLetter"))
				{
					CommonMethod.loadOfferLetter (request, response);
				}
			}
			else
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			
		}
		catch(Exception e)
		{
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
			System.out.println(e.getMessage());
		}
	}  	
 
}
    
