package com.my.org.erp.SmartCommon;

import java.io.IOException;
 
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
 
public class EmployeeCategoryActionHandler extends AbstractActionHandler 
{
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			if (action.equals("GENEmployeeCategoryDelete")) 
			{
				String ids[] = request.getParameterValues("id");
				acs = con.prepareCall("{call  COM_PRO_EMPLOYEECATEGORY(?,?,?,?,?,?,? )}");
				for (int i = 0; i < ids.length; i++) 
				{
					acs.setString(1, "DELETE");
					acs.setString(2, ids[i]);
					acs.setString(3, "");
					acs.setString(4, null);
					acs.setString(5, null);
					acs.setString(6, null);
					acs.setString(7, null);
					acs.addBatch();
				}
				acs.executeBatch();
				acs.close();
				con.close();    
				response.sendRedirect("Smart Common/EmployeeCategory.jsp");
			}
			else if ( "GENEmployeeCategoryAdd".equals(action) ) 
			{
				String name=request.getParameter("Name");
				String attendancecycle=request.getParameter("attendancecycle");
				String status=request.getParameter("status");
				String pfcalculationtype=request.getParameter("pfcalculationtype");
				if(!"Y".equals(status))
					status="N";
				name=name.trim();
				acs = con.prepareCall("{call  COM_PRO_EMPLOYEECATEGORY(?,?,?,?,?,?,? )}");
				acs.setString(1, "INSERT");
				acs.setString(2, "1");
				acs.setString(3, name);
				acs.setString(4, status);
				acs.setString(5, attendancecycle);
				acs.setString(6, pfcalculationtype);
				acs.setString(7, user);
				acs.execute();
				acs.close();
				 
				acs.close();
				con.close();   
				response.sendRedirect("Smart Common/EmployeeCategory.jsp");//EmployeeCategoryAction.jsp?action1=Add
			} 
			else if (action.equals("GENEmployeeCategoryEdit")) 
			{
				String id=request.getParameter("id");
				String name=request.getParameter("Name");
				String attendancecycle=request.getParameter("attendancecycle");
				String pfcalculationtype=request.getParameter("pfcalculationtype");
				String status=request.getParameter("status");
				if(!"Y".equals(status))
					status="N";
				acs = con.prepareCall("{call  COM_PRO_EMPLOYEECATEGORY(?,?,?,?,?,?,? )}");
				acs.setString(1, "UPDATE");
				acs.setString(2, id);
				acs.setString(3, name);
				acs.setString(4, status);
				acs.setString(5, attendancecycle);
				acs.setString(6, pfcalculationtype);
				acs.setString(7, user);
				acs.execute();
				acs.close();
				acs.close();
				con.close();    
				response.sendRedirect("Smart Common/EmployeeCategory.jsp");
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
