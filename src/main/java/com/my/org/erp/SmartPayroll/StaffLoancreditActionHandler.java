package com.my.org.erp.SmartPayroll;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

import org.apache.commons.beanutils.BeanUtils;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
public class StaffLoancreditActionHandler extends AbstractActionHandler {

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {

			String action = request.getParameter("actionS");
			String empid =request.getParameter("ename");

			StaffLoanCredit d = new StaffLoanCredit();
			@SuppressWarnings("rawtypes")
			Map map = request.getParameterMap();
			BeanUtils.populate(d, map);
			if ("PAYStaffLoanCreditAdd".equals(action)) {

				asql = " INSERT INTO pay_t_loancredit (INT_LOANID,CHR_EMPID,DAT_CREDIT,INT_CREDIT_AMOUNT,";
				asql = asql + " CHR_AUTHORISED,CHR_DESC,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ) VALUES ";
				asql = asql + " (?,?,?,?,?,?,?,DATE(NOW()),'Y' )";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,d.getLoantype() );
				apstm.setString(2, empid);
				apstm.setString(3, d.getCreditdate());
				apstm.setString(4,""+d.getLoanamount());
				apstm.setString(5, d.getAuthorised());
				apstm.setString(6, d.getDesc());
				apstm.setString(7, auserid);
				System.out.println("" + apstm);
				apstm.execute();
				apstm.close();
				con.close();
				response.sendRedirect("Smart Payroll/LoanCreditorView.jsp");
			} else if ("PAYStaffLoanCreditEdit".equals(action)) {
				String loancreditid =request.getParameter("idloan");
				asql = " UPDATE  pay_t_loancredit SET INT_LOANID= ?,";
				asql = asql + "	DAT_CREDIT = ?,";
				asql = asql + "	INT_CREDIT_AMOUNT =?,";
				asql = asql + "	CHR_AUTHORISED = ? ,";
				asql = asql + "	CHR_DESC = ? ";
				asql = asql + "	WHERE  INT_LOAN_CREDITID = ? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, d.getLoantype());
				apstm.setString(2, d.getCreditdate());
				apstm.setString(3, ""+d.getLoanamount());
				apstm.setString(4, d.getAuthorised());
				apstm.setString(5, d.getDesc());
				apstm.setString(6, loancreditid);
				System.out.println("" + apstm);
				apstm.execute();
				apstm.close();
				con.close();
				response.sendRedirect("Smart Payroll/LoanCreditorView.jsp");
			} else if ("PAYStaffLoanCreditDELETE".equals(action)) {
				try {
					String staffiddel[] = request.getParameterValues("id");
					asql = " DELETE FROM pay_t_loancredit WHERE INT_LOAN_CREDITID = ? ";
					apstm = con.prepareStatement(asql);
					for (int u = 0; u < staffiddel.length; u++) {
						apstm.setString(1, staffiddel[u]);
						System.out.println("" + apstm);
						apstm.addBatch();
					}
					apstm.executeBatch();
					apstm.close();
					con.close();
					response.sendRedirect("Smart Payroll/LoanCreditorView.jsp");
				} catch (Exception e) {

					System.out.println(e.getMessage());
					request.setAttribute("error", e.getMessage());
					RequestDispatcher dispatchers = request
							.getRequestDispatcher("/error/index.jsp");
					dispatchers.forward(request, response);
				}
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