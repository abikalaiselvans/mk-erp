package com.my.org.erp.DAOImplementation.SmartCommon;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.DAO.SmartCommon.Country;
public class CountryImpl implements Country
{

	public void Add(HttpServletRequest request, HttpServletResponse response,
			Connection con, PreparedStatement apstm, CallableStatement acs) throws ServletException, IOException 
	{
		try 
		{
			HttpSession session = request.getSession();
			String userid = (String) session.getAttribute("USRID");
			
			String Name = request.getParameter("Name").trim();
			String Des = request.getParameter("sdescription").trim();
			acs = con.prepareCall("{call  COM_PRO_COUNTRY(?,?,?,?,?)}");
			acs.setString(1, "INSERT");
			acs.setString(2, "1");
			acs.setString(3, Name.trim());
			acs.setString(4, Des.trim());
			acs.setString(5, userid);
			System.out.println(  ""+acs);
			acs.execute();
			acs.close();
			
			 
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
		
	}

	public void Edit(HttpServletRequest request, HttpServletResponse response,
			Connection con, PreparedStatement apstm, CallableStatement acs)
			throws ServletException, IOException {
		 
		
		try 
		{
			HttpSession session = request.getSession();
			String userid = (String) session.getAttribute("USRID");
			
			String Id = request.getParameter("id");
			String Name = request.getParameter("Name").trim();
			String Des = request.getParameter("sdescription").trim();
			acs = con.prepareCall("{call  COM_PRO_COUNTRY(?,?,?,?,?)}");
			acs.setString(1, "UPDATE");
			acs.setString(2, Id);
			acs.setString(3, Name.trim());
			acs.setString(4, Des.trim());
			acs.setString(5, userid);
			acs.execute();
			acs.close();
			 
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
		
	}

	public void Delete(HttpServletRequest request,
			HttpServletResponse response, Connection con,
			PreparedStatement apstm, CallableStatement acs)
			throws ServletException, IOException {
		 
		
		try 
		{
			String[] Id = request.getParameterValues("id");
			acs = con.prepareCall("{call  COM_PRO_COUNTRY(?,?,?,?,?)}");
			for (int i = 0; i < Id.length; i++) 
			{
				acs.setString(1, "DELETE");
				acs.setString(2, Id[i]);
				acs.setString(3, "");
				acs.setString(4, "");
				acs.setString(5, "");
				acs.addBatch();
			}
			acs.executeBatch();
			acs.close();
			 
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
