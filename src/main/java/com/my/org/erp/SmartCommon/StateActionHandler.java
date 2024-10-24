package com.my.org.erp.SmartCommon;

import java.io.IOException;
 
 
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class StateActionHandler extends AbstractActionHandler 
{
	String courseName;
	int courseId;
	String userId = "" ;
	 

	
	private void StateDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String[] StateId = request.getParameterValues("id");
			acs = con.prepareCall("{call  COM_PRO_STATE(?,?,?,?,?)}");
			for (int i = 0; i < StateId.length; i++) 
			{
				acs.setString(1, "DELETE");
				acs.setString(2, StateId[i]);
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

	private void StateAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String stateName = request.getParameter("Name").trim();
			String stateDes = request.getParameter("sdescription").trim();
			acs = con.prepareCall("{call  COM_PRO_STATE(?,?,?,?,?)}");
			acs.setString(1, "INSERT");
			acs.setString(2, "1");
			acs.setString(3, stateName.trim());
			acs.setString(4, stateDes.trim());
			acs.setString(5, userId);
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
	
	

	private void StateEdit(HttpServletRequest request, 	HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String stateId = request.getParameter("id");
			String stateName = request.getParameter("Name").trim();
			String stateDes = request.getParameter("sdescription").trim();
			acs = con.prepareCall("{call  COM_PRO_STATE(?,?,?,?,?)}");
			acs.setString(1, "UPDATE");
			acs.setString(2, stateId);
			acs.setString(3, stateName.trim());
			acs.setString(4, stateDes.trim());
			acs.setString(5, userId);
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
			userId = "" + session.getAttribute("USRID");
			
			if (action.equals("GENstateDelete")) 
			{
				 StateDelete(request, response);
				 con.close();    
				 response.sendRedirect("Smart Common/StateView.jsp");
			} 
			else if (action.equals("GENStateAdd")) 
			{
				StateAdd(request, response);
				con.close();   
				response.sendRedirect("Smart Common/StateView.jsp"); 
			} 
			else if (action.equals("GENStateEdit")) 
			{
				StateEdit(request, response);
				con.close();    
				response.sendRedirect("Smart Common/StateView.jsp");
				 
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