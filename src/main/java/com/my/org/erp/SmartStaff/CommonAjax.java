package com.my.org.erp.SmartStaff;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.Authenticator;

@WebServlet("/StaffCommon")
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
					if(action.equals("LoadDailyEngineerReport"))
					{
						CommonMethod.LoadDailyEngineerReport(request, response);
					}
					/*else if(action.equals("INVloadEMD"))
					{	
						CommonMethod.INVloadEMDAsset(request, response);
					} */
					else if(action.equals("INVloadStaffEMD"))
					{	
						CommonMethod.INVloadStaffEMD(request, response);
					} 
					else if("LoadCustomerinfos".equals(action) )
		    		{
						CommonMethod.LoadCustomerinfos(request, response);
		    		}
					else if("LoadScheduleEntrystaff".equals(action) )
		    		 {
						CommonMethod.LoadScheduleEntrystaff(request, response);
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
    
