package com.my.org.erp.SmartPayroll;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;


public class StaffAdvanceActionHandler extends AbstractActionHandler {
	Statement st;
	
	ResultSet rs;

	PreparedStatement pstm;
	
	private void staffAdvanceInsertion(String sql) {
		try {
			st = con.createStatement();
			
			st.executeUpdate(sql);
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			//System.out.println("CONTROL FROM STAFF DETAIL INSERTION :: " + e);
		}
	}

	

	

	@SuppressWarnings("deprecation")
	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			 String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userId = (String) session.getAttribute("USRID");

			java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat(
					"yyyy-MM-dd");
			java.util.Date date = new java.util.Date();
			String updatedate = "" + datetime.format(date);
			String month = DateUtil.getMonth(date.getMonth() + 1);
			int year = 1900 + date.getYear();

			System.out.println("CONTROL FROM STAFF-ADVANCE ACTION HANDLER ::"
					+ action);

			if (action.equals("PAYStaffAdvanceAdd")) {
				String staffid = "" + request.getParameter("ename");
				staffid.trim();
				String advanceId = "" + request.getParameter("advanceid");
				String type = "" + request.getParameter("type");
				String openDate = "" + request.getParameter("opendate");
				openDate=DateUtil.FormateDateSQL(openDate);
				String dueMonth = "" + request.getParameter("duemonth");
				String advAmount = "" + request.getParameter("advamount");
				String noofInstalment = ""
						+ request.getParameter("noinstalment");
				String dueAmount = "" + request.getParameter("dueamount");

				String sql = "";
				if (type.equals("A")) {
					sql = sql + "INSERT INTO PAY_M_ADVANCE VALUES (";
					sql = sql + " '" + staffid + "' , ";
					sql = sql + "'" + advanceId + "' , ";
					sql = sql + " '" + openDate + "' , ";
					sql = sql + year + " , ";
					sql = sql + " '" + month + "' , ";
					sql = sql + Integer.parseInt(advAmount) + " , ";
					sql = sql + Integer.parseInt(noofInstalment) + " , ";
					sql = sql + Integer.parseInt(dueAmount) + " , ";
					sql = sql + Integer.parseInt(advAmount) + " , ";
					sql = sql + Integer.parseInt(noofInstalment) + " , ";
					sql = sql + " '" + dueMonth + "' , ";
					sql = sql + " '" + type + "' , ";
					sql = sql + " 'O' , ";
					sql = sql + null + " , ";
					sql = sql + " '" + userId + "' , ";
					sql = sql + " '" + updatedate + "' , ";
					sql = sql + " 'Y' ) ";

				} else {
					sql = sql + "INSERT INTO PAY_M_ADVANCE VALUES (";
					sql = sql + " '" + staffid + "' , ";
					sql = sql + "'" + advanceId + "' , ";
					sql = sql + " '" + openDate + "' , ";
					sql = sql + year + " , ";
					sql = sql + " '" + month + "' , ";
					sql = sql + Integer.parseInt(advAmount) + " , ";
					sql = sql + "0 , ";
					sql = sql + "0 , ";
					sql = sql + "0 , ";
					sql = sql + "0 , ";
					sql = sql + " '" + dueMonth + "' , ";
					sql = sql + " '" + type + "' , ";
					sql = sql + " 'O' , ";
					sql = sql + null + " , ";
					sql = sql + " '" + userId + "' , ";
					sql = sql + " '" + updatedate + "' , ";
					sql = sql + " 'Y' ) ";
				}
				staffAdvanceInsertion(sql);
				con.close();    
				response.sendRedirect("Smart Payroll/Advance.jsp");
			} else if (action.equals("PAYStaffAdvanceUpdate")) {
				String advid = "" + request.getParameter("advid");
				String closedt = "" + request.getParameter("closedate");
				String dt[] = closedt.split("-");
				closedt = dt[2] + "-" + dt[1] + "-" + dt[0];
				advid.trim();
				String sql = " UPDATE PAY_M_ADVANCE SET ";
				sql = sql + " DT_CLOSEDATE = '" + closedt + "' ,";
				sql = sql + " CHR_DUESTATUS ='C' ";
				sql = sql + " WHERE CHR_ADVID = '" + advid + "'";
				st = con.createStatement();
				st.executeUpdate(sql);
				con.close();   
				response.sendRedirect("Smart Payroll/Advance.jsp");
			}
			else if (action.equals("PAYStaffAdvanceDelete")) {
				String staff[] = request.getParameterValues("staffid");
				String staffid = "";
				for (int i = 0; i < staff.length; i++) {
					staffid = staff[i];
					staffid.trim();
					String query = "DELETE FROM PAY_M_ADVANCE WHERE CHR_ADVID = '"
							+ staffid + "'";
					st = con.createStatement();
					st.executeUpdate(query);
				}
				con.close();    
				response.sendRedirect("Smart Payroll/Advance.jsp");
			}
			else if (action.equals("PAYAdvanceCashReturn")) 
			{
				 
				con.close();    
				response.sendRedirect("Smart Payroll/Advance.jsp");
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
