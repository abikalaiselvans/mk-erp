package com.my.org.erp.SmartTransport;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.Authenticator;
@WebServlet("/Transport")
public class TransportAjax extends HttpServlet
{
	public static final long serialVersionUID=1l;
    
	public  void doGet(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
		try
			{
				String action=request.getParameter("actionS");
				if(Authenticator.isAuthenticated(request))
				{ 
					if(action.equals("LoadReminder"))
					{
						 TransactionMethod.LoadReminder(request,response);  
					}
					else if(action.equals("LoadIssuer"))
					{
						 TransactionMethod.LoadIssuer(request,response);  
					}	
					else if(action.equals("LoadInsuranceTransaction"))
					{
						 TransactionMethod.LoadInsuranceTransaction(request,response); 
					}
					else  if(action.equals("LoadFuelType"))
					{
						TransactionMethod.LoadFuelType(request,response);   
					}
					else if(action.equals("LoadVehicleType"))
					{
						TransactionMethod.LoadVehicleType(request,response);   
					}
					else if(action.equals("LoadMake"))
					{
						TransactionMethod.LoadMake(request,response);   
					}
					else if(action.equals("LoadModel"))
					{
						TransactionMethod.LoadModel(request,response);   
					}
					else if(action.equals("LoadSelectMake"))
					{
						TransactionMethod.LoadSelectMake(request,response);   
					}
					else if(action.equals("LoadSelectModel"))
					{
						TransactionMethod.LoadSelectModel(request,response);   
					}
					else if(action.equals("LoadSelectState"))
					{
						TransactionMethod.LoadSelectState(request,response);   
					}
					else if(action.equals("LoadSelectDistrict"))
					{
						TransactionMethod.LoadSelectDistrict(request,response);   
					}
					else if(action.equals("LoadVarriant"))
					{
						TransactionMethod.LoadVarriant(request,response);
					}
					else if(action.equals("LoadAccessories"))
					{
						TransactionMethod.LoadAccessories(request,response);
					}
					else if(action.equals("LoadAccessoriesinfo"))
					{
						TransactionMethod.LoadAccessoriesinfo(request,response);
					}
					else if(action.equals("LoadSelectHomeMake"))
					{
						TransactionMethod.LoadSelectHomeMake(request,response);
					}
					else if(action.equals("LoadSelectHomeModel"))
					{
						TransactionMethod.LoadSelectHomeModel(request,response);
					}
					else if(action.equals("LoadSelectHomeVarriant"))
					{
						TransactionMethod.LoadSelectHomeVarriant(request,response);
					}
					else if(action.equals("LoadVechicleInfo"))
					{
						TransactionMethod.LoadVechicleInfo(request,response);
					}
					else if(action.equals("LoadDriverAssign"))
					{
						TransactionMethod.LoadDriverAssign(request,response);
					}
					else if(action.equals("loadVehicleTransaction"))
					{
						TransactionMethod.loadVehicleTransaction(request,response);
					}
					else if(action.equals("LoadVechicleExpense"))
					{
						TransactionMethod.LoadVechicleExpense(request,response);
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
    
