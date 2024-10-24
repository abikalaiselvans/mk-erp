package com.my.org.erp.SmartPayroll;

import java.io.IOException;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

import org.apache.commons.beanutils.BeanUtils;
  
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 
public class StaffLoanDebitActionHandler extends AbstractActionHandler {

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {

			String action = request.getParameter("actionS");
			String empid =request.getParameter("Empid");
			StaffLoanDebit d = new StaffLoanDebit();
			@SuppressWarnings("rawtypes")
			Map map = request.getParameterMap();
			BeanUtils.populate(d, map);
			if ("PAYStaffLoanDebitAdd".equals(action)) {

				asql = " INSERT INTO pay_t_loandebit (INT_LOANID,CHR_EMPID,DAT_DEBIT,INT_DEBIT_AMOUNT,";
				asql = asql + " CHR_MODE,CHR_DESCRIPTION,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ) VALUES ";
				asql = asql + " (?,?,?,?,?,?,?,DATE(NOW()),'Y' )";
				apstm = con.prepareStatement(asql);
				apstm.setString(1,d.getLoantype() );
				apstm.setString(2, empid);
				apstm.setString(3, d.getDebitdate());
				apstm.setString(4,""+d.getDebitloanamount());
				apstm.setString(5, d.getMode());
				apstm.setString(6, d.getDesc());
				apstm.setString(7, auserid);
				System.out.println("" + apstm);
				apstm.execute();
				apstm.close();
				con.close();
				response.sendRedirect("Smart Payroll/LoanDebitView.jsp");
			} else if ("PAYStaffLoanDebitEdit".equals(action)) {
				String loandebitid =request.getParameter("idloan");
				asql = " UPDATE  pay_t_loandebit SET INT_LOANID= ?,";
				asql = asql + "	DAT_DEBIT = ?,";
				asql = asql + "	INT_DEBIT_AMOUNT =?,";
				asql = asql + "	CHR_MODE = ? ,";
				asql = asql + "	CHR_DESCRIPTION = ? ";
				asql = asql + "	WHERE  INT_LOAN_DEBITID = ? ";
				apstm = con.prepareStatement(asql);
				apstm.setString(1, d.getLoantype());
				apstm.setString(2, d.getDebitdate());
				apstm.setString(3, ""+d.getDebitloanamount());
				apstm.setString(4, d.getMode());
				apstm.setString(5, d.getDesc());
				apstm.setString(6, loandebitid);
				System.out.println("" + apstm);
				apstm.execute();
				apstm.close();
				con.close();
				response.sendRedirect("Smart Payroll/LoanDebitView.jsp");
			} else if ("PAYStaffLoanDebitDELETE".equals(action)) {
				try {
					String staffiddel[] = request.getParameterValues("id");
					asql = " DELETE FROM pay_t_loandebit WHERE INT_LOAN_DEBITID = ? ";
					apstm = con.prepareStatement(asql);
					for (int u = 0; u < staffiddel.length; u++) {
						apstm.setString(1, staffiddel[u]);
						System.out.println("" + apstm);
						apstm.addBatch();
					}
					apstm.executeBatch();
					apstm.close();
					con.close();
					response.sendRedirect("Smart Payroll/LoanDebitView.jsp");
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