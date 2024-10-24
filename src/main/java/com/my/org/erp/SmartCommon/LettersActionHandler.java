package com.my.org.erp.SmartCommon;

import java.io.IOException;
 

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
public class LettersActionHandler extends AbstractActionHandler 
{
	 
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userid = "" + session.getAttribute("USRID");
			String empid = "" + session.getAttribute("EMPID");
			
			if (action.equals("GENOfferLetter")) 
				response.sendRedirect("SmartLoginAuth?actionS=PAYRept_JStaffOfferLetter&filename=Rept_JStaffOfferLetter&rptfilename=Rept_JOfferLetter&reportType=pdf&ename="+empid);  
			else if (action.equals("GENAnnexture"))
				response.sendRedirect("SmartLoginAuth?actionS=PAYAppointmentAnnexure&filename=Rept_JAppointmentAnnexure&rptfilename=PayrollAnnexure&reportType=pdf&ename="+empid);
			else if (action.equals("GENAppoinmentLetter"))
				response.sendRedirect("SmartLoginAuth?actionS=PAYRept_JAppointmentOrderWithAnnexure&filename=Rept_JAppointmentOrderWithAnnexure&rptfilename=Rept_JAppointmentOrderWithAnnexureMain&subRptfilename1=Rept_JAppointmentOrderWithAnnexureS1&subRptfilename2=Rept_JAppointmentOrder_subreport1&reportType=pdf&ename="+empid);
			

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
