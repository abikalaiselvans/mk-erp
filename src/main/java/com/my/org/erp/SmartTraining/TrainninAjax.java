package com.my.org.erp.SmartTraining;

import java.io.IOException;
 


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.Authenticator;

@SuppressWarnings("serial")
@WebServlet("/SmartTrainning")
public class TrainninAjax extends HttpServlet
{
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{

			String action=request.getParameter("actionS");
			if(Authenticator.isAuthenticated(request))
			{ 
			    if (action.equals("loadTestType"))
				{
					CommonMethod.loadTestType(request, response);
				}
				else if (action.equals("loadTestTypeQuestion"))
				{
					CommonMethod.loadTestTypeQuestion(request, response);
				}
				else if (action.equals("loadTrainingDetails"))
				{
					CommonMethod.loadTrainingDetails(request, response);
				}
				else if (action.equals("loadOnlineTestDetails"))
				{
					CommonMethod.loadOnlineTestDetails(request, response);
				}
			}
			else
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);
			
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}  	
 
}
    
