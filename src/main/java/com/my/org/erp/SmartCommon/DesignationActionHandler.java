package com.my.org.erp.SmartCommon;

import java.io.IOException;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class DesignationActionHandler extends AbstractActionHandler 
{

	String courseName;
	int courseId;
	String userid = "" ;
	 
	
	private void DesigDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String[] DesigId = request.getParameterValues("id");
			acs = con.prepareCall("{call  COM_PRO_DESIGNATION (?,?,?,?,?,?)}");
			for (int i = 0; i < DesigId.length; i++) 
			{
				acs.setString(1, "DELETE");
				acs.setString(2, DesigId[i]);
				acs.setString(3, "");
				acs.setString(4, "");
				acs.setString(5, "");
				acs.setString(6, "");
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

	
	
	private void DesigAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String desigName = request.getParameter("Name");
			String desigDes = request.getParameter("sdescription");
			String status=request.getParameter("status");
			if(!"Y".equals(status))
				status="N";
			 
			acs = con.prepareCall("{call  COM_PRO_DESIGNATION (?,?,?,?,?,?)}");
			acs.setString(1, "INSERT");
			acs.setString(2, "1");
			acs.setString(3, desigName);
			acs.setString(4, desigDes);
			acs.setString(5, status);
			acs.setString(6, userid);
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
	
	

	private void DesigEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String desigId = request.getParameter("id");
			String desigName = request.getParameter("Name");
			String desigDes = request.getParameter("sdescription");
			String status=request.getParameter("status");
			if(!"Y".equals(status))
				status="N";
			
			acs = con.prepareCall("{call  COM_PRO_DESIGNATION (?,?,?,?,?,?)}");
			acs.setString(1, "UPDATE");
			acs.setString(2, desigId);
			acs.setString(3, desigName);
			acs.setString(4, desigDes);
			acs.setString(5, status);
			acs.setString(6, userid);
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

	
	
	 
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{

		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			userid = "" + session.getAttribute("USRID");
			 
			if (action.equals("GENDesignationDelete")) 
			{
				DesigDelete(request, response);
				con.close();    
				response.sendRedirect("Smart Common/DesignationView.jsp");
	 		 
			}
			else if (action.equals("GENDesignationAdd")) 
			{
				DesigAdd(request, response);
				con.close();    
				response.sendRedirect("Smart Common/DesignationView.jsp");
			} 
			else if (action.equals("GENDesignationEdit")) 
			{
				DesigEdit(request, response);
				con.close();    
				response.sendRedirect("Smart Common/DesignationView.jsp");
				 
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
