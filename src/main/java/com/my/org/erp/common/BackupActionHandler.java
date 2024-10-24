package com.my.org.erp.common;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class BackupActionHandler extends AbstractActionHandler 
{
 	//HttpSession session = request.getSession();
	//String userId = "" + session.getAttribute("USRID");
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			if (action.equals("COM_ATTBackup")) 
			{
				//System.out.println("inside backup");
				 
				response.sendRedirect("");
			} 
			 
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

}