package com.my.org.erp.SmartCommon;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.DAOImplementation.SmartCommon.CountryImpl;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class CountryActionHandler extends AbstractActionHandler 
{
 	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			CountryImpl ct = new CountryImpl();
			if (action.equals("GENCountryDelete")) 
			{
				 ct.Delete(request, response, con, apstm, acs);
				 con.close();   
				 response.sendRedirect("Smart Common/CountryView.jsp");
			} 
			else if (action.equals("GENCountryAdd")) 
			{
				ct.Add(request, response, con, apstm, acs);
				con.close();   
				response.sendRedirect("Smart Common/CountryView.jsp"); 
			} 
			else if (action.equals("GENCountryEdit")) 
			{
				
				ct.Edit(request, response, con, apstm, acs);
				con.close();   
				response.sendRedirect("Smart Common/CountryView.jsp");
				 
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