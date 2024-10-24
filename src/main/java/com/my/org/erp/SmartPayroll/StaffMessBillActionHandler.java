package com.my.org.erp.SmartPayroll;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class StaffMessBillActionHandler extends AbstractActionHandler {
	Statement st;

	ResultSet rs;

	PreparedStatement pstm;

	private void staffMessBillInsertion(String sql) {
		try {
			st = con.createStatement();
			st.executeUpdate(sql);
		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
	}

	private void staffMessBillUpdation(String sql) {
		try {
			st = con.createStatement();
			st.executeUpdate(sql);
		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
	}

	private void staffMessBillDeletion(String staffid, int year, String month) {
		try {
			
				String sql = "DELETE FROM PAY_M_MESSBILL ";
				sql = sql + " WHERE  CHR_EMPID = '" + staffid + "' ";
				sql = sql + " AND INT_YEAR =" + year + " AND CHR_MONTH = '"
						+ month + "'";
				////System.out.println(sql);
				st = con.createStatement();
				st.executeUpdate(sql);
		
		} catch (Exception e) {
			 System.out.println(e.getMessage());

		}
	}

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//System.out.println("\n\nINside Handle");
		try {
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userId = (String) session.getAttribute("USRID");
			
			
			java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat("yyyy-MM-dd");
			java.util.Date date = new java.util.Date();
			String updatedate = "" + datetime.format(date);
//			String month = DateUtil.getMonth(date.getMonth() + 1);
//			int year = 1900 + date.getYear();

			//System.out.println("CONTROL FROM STAFF-MESS BILL ACTION HANDLER ::"	+ action);

/*			if (action.equals("PAYStaffMessBillAdd")) {
				String staffid = "" + request.getParameter("ename");
				staffid.trim();
				String yr = "" + request.getParameter("year");
				String mth = "" + request.getParameter("Month");
				int amount = Integer.parseInt(request.getParameter("TxtAmount"));
				String chequeno = "" + request.getParameter("TxtChequeno");
				if(chequeno.equalsIgnoreCase("")||chequeno.equalsIgnoreCase("null"))
				{
					chequeno="0";					
				}
				String sql1="DELETE FROM PAY_M_MESSBILL WHERE CHR_EMPID='"+staffid+"' ";
				st = con.createStatement();
				st.executeUpdate(sql1);
				
				String sql =" INSERT INTO PAY_M_MESSBILL VALUES (";
				sql = sql + "'" + staffid + "' ,";
				sql = sql + year + " ,";
				sql = sql + "'" + mth + "' ,";
				sql = sql + chequeno + " ,";
				sql = sql + "'" + amount + "' ,";
				sql = sql + "'" + userId + "' , ";
				sql = sql + "'" + updatedate + "' , ";
				sql = sql + "'Y' ) ";
				//System.out.println("sql"+sql);				
				staffMessBillInsertion(sql);
				response.sendRedirect("Smart Payroll/Mess Bill.jsp");
			}
*/
			if (action.equals("PAYStaffMessBillAdd")) {
				String staffid = "" + request.getParameter("ename");
				staffid.trim();
				String yr = "" + request.getParameter("Year");
				String mth = "" + request.getParameter("Month");
				int amount = Integer.parseInt(request.getParameter("TxtAmount"));
				String chequeno = "" + request.getParameter("TxtChequeno");
				if(chequeno.equalsIgnoreCase("")||chequeno.equalsIgnoreCase("null"))
				{
					chequeno="0";					
				}	

//				String sql1="SELECT * FROM PAY_M_MESSBILL WHERE CHR_EMPID='"+staffid+"'";
//				
				
				String sql1 = "SELECT A.CHR_EMPID, A.INT_CASHAMT, A.CHR_CHEQUENO, B.CHR_STAFFNAME ";
				sql1 = sql1+" FROM PAY_M_MESSBILL A, com_m_staff B WHERE A.CHR_EMPID=B.CHR_EMPID ";
				sql1 = sql1+" AND B.CHR_EMPID='"+staffid+"'";
				sql1=sql1+" AND A.CHR_MONTH='"+mth+"' AND A.INT_YEAR="+yr;
				//System.out.println("\n---------------------\n"+sql1);

				String Datas[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql1);

				if (Datas.length>0) {
					//System.out.println ("\n\nMess Bill : "+Datas.length+", This Record Already Exists\n");
					
					String urrl="Smart Payroll/MessBillAdd.jsp?ID="+Datas[0][0]+"&Name="+Datas[0][3]+"&Amount="+Datas[0][1]+"&Cheque="+Datas[0][2]+"&Month="+mth+"&Year="+yr;
					response.sendRedirect(urrl);
				}
				else {
					//System.out.println ("\n\nMess Bill : "+Datas.length+", Insert new one\n");
					String sql =" INSERT INTO PAY_M_MESSBILL VALUES (";
					sql = sql + "'" + staffid + "' ,";
					sql = sql + yr + " ,";
					sql = sql + "'" + mth + "' ,";
					sql = sql + chequeno + " ,";
					sql = sql + "'" + amount + "' ,";
					sql = sql + "'" + userId + "' , ";
					sql = sql + "'" + updatedate + "' , ";
					sql = sql + "'Y' ) ";
					//System.out.println("\nsql : "+sql);				
					staffMessBillInsertion(sql);
					response.sendRedirect("Smart Payroll/Mess Bill.jsp");
				}
			
		}
			else if (action.equals("PAYStaffMessBillUpdate")) {
				String staffid = "" + request.getParameter("staffid");
				staffid.trim();
				String yr = "" + request.getParameter("year");
				String mth = "" + request.getParameter("Month");
				int amount = Integer.parseInt(request.getParameter("TxtAmount"));
				String chequeno = "" + request.getParameter("TxtChequeno");
				String sql = "UPDATE PAY_M_MESSBILL SET ";
				sql = sql + " INT_CASHAMT = " + amount + " ,";
				sql = sql + " CHR_CHEQUENO = '" + chequeno + "' ";
				sql = sql + " WHERE CHR_EMPID = '" + staffid + "' ";
				sql = sql + " AND INT_YEAR = " + Integer.parseInt(yr) + " ";
				sql = sql + " AND CHR_MONTH = '" + mth + "' ";
				////System.out.println(sql);
				staffMessBillUpdation(sql);
				response.sendRedirect("Smart Payroll/Mess Bill.jsp");
			} 
			else if (action.equals("PAYStaffMessBillDelete")) {
				String staff[] = request.getParameterValues("staffid");
				String yr = "" + request.getParameter("year");
				String mth = "" + request.getParameter("month");
				String staffid = "";
				for (int i = 0; i < staff.length; i++) {
					staffid = staff[i].trim();
					staffid.trim();
					staffMessBillDeletion(staffid, Integer.parseInt(yr), ""+com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(mth)));
				}
				response.sendRedirect("Smart Payroll/Mess Bill.jsp");
			}

		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}
}
