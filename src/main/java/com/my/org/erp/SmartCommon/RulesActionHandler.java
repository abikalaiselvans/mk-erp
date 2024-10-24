package com.my.org.erp.SmartCommon;

import java.io.IOException;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class RulesActionHandler extends AbstractActionHandler 
{
	 
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userid = "" + session.getAttribute("USRID");
			
			if (action.equals("GENRulesAccept")) 
			{
				asql = "UPDATE  m_user SET CHR_LOGINTERMSANDCONDITIONS=? , DAT_ACCEPTDATETIME=NOW() WHERE CHR_USRNAME =? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,"Y" );
				apstm.setString(2,userid );
				apstm.execute();
				apstm.close();
				con.close();
				response.sendRedirect("Home.jsp");
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
