package com.my.org.erp.SmartUtility;
import java.io.IOException;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.Authenticator;
@WebServlet("/Utility")
public class UtilityAJAX extends HttpServlet
{
    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void init(ServletConfig config) throws ServletException 
    {        
    	             
    }   
    
    public  void doGet(HttpServletRequest request, HttpServletResponse  response)  throws IOException, ServletException 
    {
		try
		{
			String action=request.getParameter("actionS");	
			if(Authenticator.isAuthenticated(request))
			{ 
				if(action.equals("LoadStaff"))
				{
					UtilityMethod.LoadStaffData(request, response);
				}	
			}
			else
				response.setStatus(HttpServletResponse.SC_NO_CONTENT);	
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			response.sendRedirect("Utility/error.jsp?error="+e.getMessage());				
			System.out.println(e.getMessage());
		}			
    }
   
}
    
   