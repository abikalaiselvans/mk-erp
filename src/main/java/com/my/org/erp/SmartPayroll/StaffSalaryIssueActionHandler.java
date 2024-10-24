package com.my.org.erp.SmartPayroll;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class StaffSalaryIssueActionHandler extends AbstractActionHandler 
{

	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{

		try 
		{

			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String loginempid = (String) session.getAttribute("EMPID");
 			
			if ("PAYSalaryIssue".equals(action)) 
			{
				String monthname= request.getParameter("monthname");
				String year= request.getParameter("year");
				String issuedate= request.getParameter("issuedate");
				String issuemode= request.getParameter("issuemode");
				String bankgroup= request.getParameter("bankgroup");
				String memo= request.getParameter("memo");
				String dec= request.getParameter("dec");
				int row = Integer.parseInt(dec) ;
				String issue;
				asql = "UPDATE pay_t_salary SET ";
				asql = asql + " CHR_ISSUEDATE =? ,";
				asql = asql + " CHR_ISSUEMODE =? ,";
				asql = asql + " CHR_ISSUEBANK =? ,";
				asql = asql + " CHR_ISSUE_DESC =? ,";
				asql = asql + " CHR_ISSUEDBY =? ";
				asql = asql + "  WHERE CHR_EMPID=? AND CHR_MONTH=? AND INT_YEAR=? ";
				apstm = con.prepareStatement(asql);
				for(int i=1; i<=row;i++)
				{
					issue = request.getParameter("issue"+i);
					apstm.setString(1,issuedate );
					apstm.setString(2,issuemode );
					apstm.setString(3,bankgroup );
					apstm.setString(4,memo );
					apstm.setString(5,loginempid );
					apstm.setString(6,request.getParameter("empid"+i) );
					apstm.setString(7,monthname );
					apstm.setString(8,year );
					if("Y".equals(issue))
							apstm.addBatch();
				}
				System.out.println(""+apstm);
				 
				apstm.executeBatch();
				apstm.close();
				con.close();
				response.sendRedirect("Smart Payroll/SalaryIssueBefore.jsp ");
				
				
			}
			else if ("PAYSalaryIssueEmployeeWise".equals(action)) 
			{

				String empid[] = request.getParameter("empid").split(",");
				String  Month= request.getParameter("Month");
				String  Year= request.getParameter("Year");
				String  issuedate= request.getParameter("issuedate");
				String  issuemode= request.getParameter("issuemode");
				String  bankgroup= request.getParameter("bankgroup");
				String  memo= request.getParameter("memo");
				String monthname= DateUtil.getMonth(Integer.parseInt(Month));
				issuedate = DateUtil.FormateDateSQL(issuedate);
				
				 
				asql = "UPDATE pay_t_salary SET ";
				asql = asql + " CHR_ISSUEDATE =? ,";
				asql = asql + " CHR_ISSUEMODE =? ,";
				asql = asql + " CHR_ISSUEBANK =? ,";
				asql = asql + " CHR_ISSUE_DESC =? ,";
				asql = asql + " CHR_ISSUEDBY =? ";
				asql = asql + "  WHERE CHR_EMPID=? AND CHR_MONTH=? AND INT_YEAR=? ";
				apstm = con.prepareStatement(asql);
				for(int i=0; i<empid.length;i++)
				{
					 
					apstm.setString(1,issuedate );
					apstm.setString(2,issuemode );
					apstm.setString(3,bankgroup );
					apstm.setString(4,memo );
					apstm.setString(5,loginempid );
					apstm.setString(6,empid[i] );
					apstm.setString(7,monthname );
					apstm.setString(8,Year );
					apstm.addBatch();
				}
				System.out.println(""+apstm);
				
				apstm.executeBatch();
				
				apstm.close();
				con.close();
				response.sendRedirect("Smart Payroll/SalaryIssueBefore.jsp ");
				
				
			
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