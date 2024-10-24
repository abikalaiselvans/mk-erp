package com.my.org.erp.SmartUtility;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class MailActionHandler extends AbstractActionHandler 
{
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			if (action.equals("UTIMail")) 
			{	
				String ids[] = request.getParameterValues("ename");
				String desc = request.getParameter("desc");
				String subject = request.getParameter("subject");
				String mailid="";
				for(int u=0;u<ids.length;u++)
				{
					mailid = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM com_m_staff WHERE CHR_EMPID='"+ids[u]+"' AND CHR_EMAILID is not null ")[0][0];
					com.my.org.erp.mail.Mail.SimpleMail( mailid, subject, desc);
				}
				con.close();   
				response.sendRedirect("Utility/Userframe.jsp");
			}
			

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
