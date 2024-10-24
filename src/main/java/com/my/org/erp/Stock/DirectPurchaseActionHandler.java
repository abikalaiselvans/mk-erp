package com.my.org.erp.Stock;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
public class DirectPurchaseActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			String action=request.getParameter("actionS");
			if(action.equals("STKDirectPurchaseAdd"))
			{
				DirectPurchaseMethod.purchaseAdd(request, response, con);
				 
				response.sendRedirect("SmartStock/Directpurchase.jsp");
			}
			else if(action.equals("STKDirectPurchaseDelete"))
			{
				//Purchaseid;
				DirectPurchaseMethod.purchaseDelete(request, response, con);
				 
				response.sendRedirect("SmartStock/Directpurchase.jsp");
			}
			
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());			
		}
	}	
}
