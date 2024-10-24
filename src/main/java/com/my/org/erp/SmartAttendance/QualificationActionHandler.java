package com.my.org.erp.SmartAttendance;
import java.io.IOException;
import java.sql.CallableStatement;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class QualificationActionHandler extends AbstractActionHandler{
	 
	
	private void QualificationDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String[] qualificationid = request.getParameterValues("id");
			CallableStatement cs = con.prepareCall("{call  COM_PRO_QUALIFICATION(?,?,?,?,?)}");
			for (int i = 0; i < qualificationid.length; i++) 
			{
				cs.setString(1, "DELETE");
				cs.setString(2, qualificationid[i]);
				cs.setString(3, "a");
				cs.setString(4, "a");
				cs.setString(5, "1");
				cs.addBatch();
			}
			cs.executeBatch();
			
		} 
		catch (Exception e) 
		{
			
		}
	}

	private void QualificationEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String qualification =  (request.getParameter("Name"));
			String qualificationdesc = request.getParameter("qualificationdesc");
			String qualificationid = request.getParameter("id");
			HttpSession session = request.getSession();
			String userId = "" + session.getAttribute("USRID");
			CallableStatement cs = con.prepareCall("{call  COM_PRO_QUALIFICATION(?,?,?,?,?)}");
			cs.setString(1, "UPDATE");
			cs.setString(2, qualificationid);
			cs.setString(3, qualification);
			cs.setString(4, qualificationdesc);
			cs.setString(5, "" + userId);
			cs.execute();
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
		}
	}

	
	
	private void QualificationAdd(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			HttpSession session = request.getSession();
			String userId = "" + session.getAttribute("USRID");
			String qualification =  (request.getParameter("Name"));
			String qualificationdesc = request.getParameter("qualificationdesc");
			CallableStatement cs = con.prepareCall("{call  COM_PRO_QUALIFICATION(?,?,?,?,?)}");
			cs.setString(1, "INSERT");
			cs.setString(2, "1");
			cs.setString(3, qualification);
			cs.setString(4, qualificationdesc);
			cs.setString(5, userId);
			cs.execute();
			 
		} 
		catch (Exception e) 
		{
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}
	
	
	
	
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		try
		{
				String action=request.getParameter("actionS");
				 		
				 if(action.equals("ATTQualificationDelete"))
				 {					
					 QualificationDelete(request, response);
					 con.close();   
					response.sendRedirect("Smart Attendance/Qualification.jsp");
					
				 }
				 else if(action.equals("ATTQualificationAdd"))
				 {					
					 QualificationAdd(request, response);
					 con.close();   
					response.sendRedirect("Smart Attendance/Qualification.jsp");
					
				}else if(action.equals("ATTQualificationEdit"))
				{					
					QualificationEdit(request, response);
					con.close();   
					response.sendRedirect("Smart Attendance/Qualification.jsp");
					
     			}
				
			} 
		catch (Exception e)
		{
				 System.out.println(e.getMessage());			
				request.setAttribute("loginmsg", e.getMessage().toString());
				RequestDispatcher dispatcher= application.getRequestDispatcher("/InValidSession.jsp");			
				dispatcher.forward(request,response);						
			}
	}	
}
