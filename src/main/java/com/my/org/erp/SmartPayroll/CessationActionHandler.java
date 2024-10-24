package com.my.org.erp.SmartPayroll;

import java.io.IOException;
import java.sql.CallableStatement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class CessationActionHandler extends AbstractActionHandler {
	String OptEmpName, TxtType, TxtDoc, TxtReason, TxtDate;

	private void CessationAdd(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			OptEmpName = request.getParameter("ename");
			TxtType = request.getParameter("TxtType");
			TxtDoc = request.getParameter("TxtDoc");
			TxtDate = DateUtil.FormateDateSQL(TxtDoc);
			TxtReason = request.getParameter("TxtReason");
			// String sql="INSERT INTO
			// PAY_M_EMP_TERMINATION(CHR_EMPID,DT_TERM_DATE,CHR_REASON,CHR_TER_TYPE)values(?,?,?,?)";
			CallableStatement cs = con
					.prepareCall("{call PAY_PRO_CESSATION(?,?,?,?,?)}");
			cs.setString(1, "INSERT");
			cs.setString(2, OptEmpName);
			// recName=recName.toUpperCase();
			cs.setString(3, TxtDate);
			cs.setString(4, TxtReason);
			cs.setString(5, TxtType);
			cs.execute();
		}

		catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String action = request.getParameter("actionS");
			if (action.equals("PAYcessationAdd")) {
				CessationAdd(request, response);
				con.close();    
				response
						.sendRedirect("Smart Payroll/Employee Cessation.jsp?message=Cessation Added Sucessfully");
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
