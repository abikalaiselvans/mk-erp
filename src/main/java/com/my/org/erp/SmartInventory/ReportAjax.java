package com.my.org.erp.SmartInventory;
import java.io.IOException;
 


import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 


import com.my.org.erp.ServiceLogin.AbstractActionHandler;
@WebServlet("/inventoryReport")
public class ReportAjax extends AbstractActionHandler
{
	
	 public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	 {
		try
		{
				String action=request.getParameter("actionS");
				 
				 
				if(action.equals("INVSerQuo")){
					ReportCustomerActionHandler.loadQuotation(request, response);
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