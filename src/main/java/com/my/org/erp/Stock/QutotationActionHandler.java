package com.my.org.erp.Stock;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
public class QutotationActionHandler extends AbstractActionHandler
{
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try
		{
			String action=request.getParameter("actionS");
			if(action.equals("STKQutotationAdd"))
			{
				QutotationMethod.QutotationAdd(request, response, con);
				 
				response.sendRedirect("SmartStock/Quotation.jsp");
			}
			else if(action.equals("STKQutotationDelete"))
			{
				 
				
				QutotationMethod.QutotationDelete(request, response, con);
				 
				response.sendRedirect("SmartStock/Quotation.jsp");
			}
			
		} 
		catch (Exception e) 
		{
				 System.out.println(e.getMessage());			
		}
	}	
	
}
