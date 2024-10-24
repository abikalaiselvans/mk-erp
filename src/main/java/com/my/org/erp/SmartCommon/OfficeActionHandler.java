package com.my.org.erp.SmartCommon;

import java.io.IOException;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class OfficeActionHandler extends AbstractActionHandler 
{
	String courseName;
	int courseId;
	String userid = "";
	 
	
	private void OfficeDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String[] OfficeId = request.getParameterValues("id");
			acs = con.prepareCall("{call  COM_PRO_OFFICE (?,?,?,?,?,?,?,?,?)}");
			for (int i = 0; i < OfficeId.length; i++) 
			{
				acs.setString(1, "DELETE");
				acs.setString(2, OfficeId[i]);
				acs.setString(3, "");
				acs.setString(4, "");
				acs.setString(5, "");
				acs.setString(6, "");
				acs.setString(7, "");
				acs.setString(8, "");
				acs.setString(9, "");
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

	
	
	private void OfficeAdd(HttpServletRequest request, 	HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String Name = request.getParameter("Name");
			String shortname = request.getParameter("shortname");
			String sdescription = request.getParameter("sdescription");
			String status=request.getParameter("status");
			String emailid=request.getParameter("emailid");
			
			String state=request.getParameter("state");
			if(!"Y".equals(status))
				status="N";
			acs = con.prepareCall("{call  COM_PRO_OFFICE (?,?,?,?,?,?,?,?,?)}");
			acs.setString(1, "INSERT");
			acs.setString(2, "1");
			acs.setString(3, Name);
			acs.setString(4, state);
			acs.setString(5, shortname);
			acs.setString(6, sdescription);
			acs.setString(7, status);
			acs.setString(8, emailid);
			acs.setString(9, userid);
			System.out.println(""+acs);
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

	
	
	private void OfficeEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String OfficeId = request.getParameter("id");
			String Name = request.getParameter("Name");
			String shortname = request.getParameter("shortname");
			String sdescription = request.getParameter("sdescription");
			String emailid=request.getParameter("emailid");
			String status=request.getParameter("status");
			String state=request.getParameter("state");
			if(!"Y".equals(status))
				status="N";
			acs = con.prepareCall("{call  COM_PRO_OFFICE (?,?,?,?,?,?,?,?,?)}");
			acs.setString(1, "UPDATE");
			acs.setString(2, OfficeId);
			acs.setString(3, Name);
			acs.setString(4, state);
			acs.setString(5, shortname);
			acs.setString(6, sdescription);
			acs.setString(7, status);
			acs.setString(8, emailid);
			acs.setString(9, userid);
			System.out.println(""+acs);
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

	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{

		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			userid = "" + session.getAttribute("USRID");
			
			if (action.equals("GENOfficeDelete")) 
			{
				OfficeDelete(request, response);
				con.close();   
				response.sendRedirect("Smart Common/OfficeView.jsp");
			} 
			else if (action.equals("GENOfficeAdd")) 
			{
				OfficeAdd(request, response);
				con.close();   
				response.sendRedirect("Smart Common/OfficeView.jsp");
			} 
			else if (action.equals("GENOfficeEdit")) 
			{
				OfficeEdit(request, response);
				con.close();   
				response.sendRedirect("Smart Common/OfficeView.jsp");
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
