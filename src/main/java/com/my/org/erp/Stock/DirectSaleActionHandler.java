package com.my.org.erp.Stock;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
public class DirectSaleActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			String action=request.getParameter("actionS");
			if(action.equals("STKDirectSaleAdd"))
			{
				DirectSaleMethod.salesAdd(request, response, con);
				 
				response.sendRedirect("SmartStock/Directsales.jsp");
			}
			else if(action.equals("STKDirectSaleDelete"))
			{
				 
				
				DirectSaleMethod.saleDelete(request, response, con);
				 
				response.sendRedirect("SmartStock/Directsales.jsp");
			}
			
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());			
		}
	}	
	
}
