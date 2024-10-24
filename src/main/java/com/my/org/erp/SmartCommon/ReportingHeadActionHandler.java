package com.my.org.erp.SmartCommon;

import java.io.IOException;
 
 
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class ReportingHeadActionHandler extends AbstractActionHandler 
{
	 
  	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			 
			if (action.equals("GENReportingHeadEdit")) 
			{
				String id = request.getParameter("id");
				String repto = request.getParameter("repto");
				String carry = request.getParameter("carry");
				String management = request.getParameter("management");
				String reporinghead = request.getParameter("reporinghead");
				String hold = request.getParameter("hold");
				String interview = request.getParameter("interview");
				String payslip = request.getParameter("payslip");
				String conveyance = request.getParameter("conveyance");
				String salarycalculation = request.getParameter("salarycalculation");
				String professionaltax = request.getParameter("professionaltax");
				
				if(!"Y".equals(carry))
					carry = "N";
				if(!"Y".equals(management))
					management = "N";
				if(!"Y".equals(reporinghead))
					reporinghead = "N";
				if(!"Y".equals(hold))
					hold = "N";
				if(!"Y".equals(interview))
					interview = "N";
				if(!"Y".equals(payslip))
					payslip = "N";
				if(!"Y".equals(conveyance))
					conveyance = "N";
				if(!"Y".equals(salarycalculation))
					salarycalculation = "N";
				if(!"Y".equals(professionaltax))
					professionaltax = "N";
				
				asql = " UPDATE com_m_staff SET CHR_REPTO=?, ";
				asql = asql + " CHR_LEAVECARRY =? ,";
				asql = asql + " CHR_MANAGEMENT =? ,";
				asql = asql + " CHR_REP =? ,";
				asql = asql + " CHR_HOLD =? ,";
				asql = asql + " CHR_INTERVIEW =? ,";
				asql = asql + " CHR_PAYSLIPHIDE =? , ";
				asql = asql + " CHR_CONVEYANCECLEAR =? , ";
				asql = asql + " CHR_SALARYCALCULATE =? , ";
				asql = asql + " CHR_PROFESSIONALTAX =? ";
				asql = asql + " WHERE CHR_EMPID=? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, repto);
				apstm.setString(2, carry);
				apstm.setString(3, management);
				apstm.setString(4, reporinghead);
				apstm.setString(5, hold);
				apstm.setString(6, interview);
				apstm.setString(7, payslip);
				apstm.setString(8, conveyance);
				apstm.setString(9, salarycalculation);
				apstm.setString(10, professionaltax);
				apstm.setString(11, id);
				System.out.println(""+apstm);
				apstm.execute();
				apstm.close();
				//com.my.org.erp.common.CommonFunctions.Execute(" UPDATE com_m_staff SET CHR_REPTO='"++"' WHERE CHR_EMPID='"+id+"' ");
				con.close();   
				response.sendRedirect("Smart Common/ReportingHeadChange.jsp");
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