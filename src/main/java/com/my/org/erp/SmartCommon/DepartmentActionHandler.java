package com.my.org.erp.SmartCommon;

import java.io.IOException;
import java.sql.CallableStatement;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class DepartmentActionHandler extends AbstractActionHandler 
{

	String courseName;
	int courseId;
	String userid = "" ;
	 

	private void DepartDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String[] DepartId = request.getParameterValues("id");
			CallableStatement cs = con.prepareCall("{call  COM_PRO_DEPARTMENT (?,?,?,?,?,?)}");
			for (int i = 0; i < DepartId.length; i++) 
			{
				cs.setString(1, "DELETE");
				cs.setString(2, DepartId[i]);
				cs.setString(3, "");
				cs.setString(4, "");
				cs.setString(5, "");
				cs.setString(6, "");
				cs.addBatch();
			}
			cs.executeBatch();
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response);
		}
	}

	
	
	
	private void DepartAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String departName = request.getParameter("Name");
			String departDes = request.getParameter("sdescription");
			String status=request.getParameter("status");
			if(!"Y".equals(status))
				status="N";
			acs = con.prepareCall("{call  COM_PRO_DEPARTMENT (?,?,?,?,?,?)}");
			acs.setString(1, "INSERT");
			acs.setString(2, "1");
			acs.setString(3, departName);
			acs.setString(4, departDes);
			acs.setString(5, status);
			acs.setString(6, userid);
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

	
	
	private void DepartEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String departId = request.getParameter("id");
			String departName = request.getParameter("Name");
			String departDes = request.getParameter("sdescription");
			String status=request.getParameter("status");
			if(!"Y".equals(status))
				status="N";
			acs = con.prepareCall("{call  COM_PRO_DEPARTMENT (?,?,?,?,?,?)}");
			acs.setString(1, "UPDATE");
			acs.setString(2, departId);
			acs.setString(3, departName);
			acs.setString(4, departDes);
			acs.setString(5, status);
			acs.setString(6, userid);
			System.out.println(""+acs);
			acs.execute();
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
			 
	
			if (action.equals("GENDepartmentDelete")) 
			{
				DepartDelete(request, response);
				con.close();   
				response.sendRedirect("Smart Common/DepartmentView.jsp");
	 		}
			else if (action.equals("GENDepartmentAdd")) 
			{
				DepartAdd(request, response);
				con.close();    
				response.sendRedirect("Smart Common/DepartmentView.jsp");
			} 
			else if (action.equals("GENDepartmentEdit")) 
			{
				DepartEdit(request, response);
				con.close();   
				response.sendRedirect("Smart Common/DepartmentView.jsp");
			} 
			 
			 
 
		} catch (Exception e) 
		{
			 
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response);
		}
	}

}
