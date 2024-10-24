package com.my.org.erp.SmartPayroll;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



import com.my.org.erp.ServiceLogin.AbstractActionHandler;


public class AllowanceRecoveryRivisionActionHandler extends AbstractActionHandler 
{
	Statement st;
	ResultSet rs;
	PreparedStatement pstm;
	

	

	private String collectAllowanceField() 
	{
		String fields = "";
		try 
		{
			String sql = "SELECT * FROM PAY_M_ALLOWANCE";
			st = con.createStatement();
			rs = st.executeQuery(sql);
			fields = "";
			while (rs.next())
				fields = fields + rs.getString(1) + "~";
			return fields;

		} catch (Exception e) {
			 System.out.println(e.getMessage());
			System.out
					.println("CONTROL FROM STAFF ALLOWANCE ACTION HANDLER :: "
							+ e);
		}
		return null;
	}

	private String collectRecoveryField() {
		String fields = "";
		try {
			String sql = "SELECT * FROM PAY_M_RECOVERY";
			st = con.createStatement();
			rs = st.executeQuery(sql);
			fields = "";
			while (rs.next())
				fields = fields + rs.getString(1) + "~";
			return fields;

		} catch (Exception e) {
			 System.out.println(e.getMessage());
			System.out
					.println("CONTROL FROM STAFF ALLOWANCE ACTION HANDLER :: "
							+ e);
		}
		return null;
	}

	private void StaffDeletion(String staffid) {
		try {
			boolean aflag = StaffRegistration.allowanceRecordExist(staffid
					.trim());
			boolean rflag = StaffRegistration.recoveryRecordExist(staffid
					.trim());
			if (aflag) {
				String query = "DELETE from pay_t_allowance WHERE CHR_EMPID = '"
						+ staffid + "'";
				st = con.createStatement();
				st.executeUpdate(query);
			}
			if (rflag) {
				String query = "DELETE from pay_t_recovery WHERE CHR_EMPID = '"
						+ staffid + "'";
				st = con.createStatement();
				st.executeUpdate(query);
			}
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			//System.out.println("CONTROL FROM STAFF DETAIL INSERTION :: " + e);
		}
	}

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try 
		{
			String action = request.getParameter("actionS");



			if (action.equals("PAYAllowanceRecoveryAdd")) 
			{
				String staff[] = request.getParameterValues("ename");



				String staffid = "";
				for (int k = 0; k < staff.length; k++) 
				{
					staffid = staff[k];
					String allowanceFields = collectAllowanceField();
					String recoveryFields = collectRecoveryField();
					String afields[] = allowanceFields.split("~");
					String rfields[] = recoveryFields.split("~");
					boolean aflag = StaffRegistration.allowanceRecordExist(staffid.trim());
					boolean rflag = StaffRegistration.recoveryRecordExist(staffid.trim());
					String reqallowancefields = "";
					String reqrecoveryfields = "";
					String asqltrue = "";
					String rsqltrue = "";
					String asqlfalse = "";
					String rsqlfalse = "";
					String reqval = "";
					asqltrue = "UPDATE PAY_T_ALLOWANCE SET ";
					reqallowancefields = "";
					for (int i = 0; i < afields.length; i++) 
					{
						reqval = "";
						reqval = "" + request.getParameter(afields[i]);
						if (reqval.equals("") || reqval.equals("null"))
							reqval = "0";
						reqallowancefields = reqallowancefields	+ afields[i].toUpperCase() + " = '" + reqval+ "' ,";
					}
					reqallowancefields.trim();
					reqallowancefields = reqallowancefields.substring(0,reqallowancefields.length() - 1);
					rsqltrue = "UPDATE PAY_T_RECOVERY SET ";
					reqrecoveryfields = "";
					for (int i = 0; i < rfields.length; i++) {
						reqval = "";
						reqval = "" + request.getParameter(rfields[i]);
						if (reqval.equals("") || reqval.equals("null"))
							reqval = "0";
						reqrecoveryfields = reqrecoveryfields
								+ rfields[i].toUpperCase() + " = '" + reqval
								+ "' ,";
					}
					reqrecoveryfields.trim();
					reqrecoveryfields = reqrecoveryfields.substring(0,
							reqrecoveryfields.length() - 1);
					
					
					
					
					asqltrue = asqltrue + rsqltrue+reqallowancefields+reqrecoveryfields
							+ " WHERE CHR_EMPID = '" + staffid + "'";
					asqlfalse = "INSERT INTO PAY_T_RIVISION VALUES ( '"
							+ staffid + "' ,";

					reqallowancefields = "";
					reqrecoveryfields = "";
					for (int i = 0; i < afields.length; i++) {
						reqval = "";
						String reqval1="";
						reqval = "" + request.getParameter(afields[i]);
						reqval1 = "" + request.getParameter(rfields[i]);
						if (reqval.equals("") || reqval.equals("null"))
							reqval = "0";
						reqallowancefields = reqallowancefields + "  '"
								+ reqval + "' ,";
						reqrecoveryfields = reqrecoveryfields + "  '" + reqval1
						+ "' ,";
			
					}
					reqrecoveryfields.trim();
					reqallowancefields.trim();
					reqallowancefields = reqallowancefields.substring(0,
							reqallowancefields.length() - 1);
					reqrecoveryfields = reqrecoveryfields.substring(0,
							reqrecoveryfields.length() - 1);
			
					asqlfalse = asqlfalse + reqallowancefields + "'";					
					rsqlfalse = rsqlfalse + reqrecoveryfields + " )";

					if (aflag) {
						// //System.out.println(asqltrue);
						st = con.createStatement();
						st.executeUpdate(asqltrue);

					} else {
						// //System.out.println(asqlfalse);
						st = con.createStatement();
						st.executeUpdate(asqlfalse);
					}

					if (rflag) {
						// //System.out.println(rsqltrue);
						st = con.createStatement();
						st.executeUpdate(rsqltrue);
					} else {
						// //System.out.println(rsqlfalse);
						st = con.createStatement();
						st.executeUpdate(rsqlfalse);
					}

				}
				con.close();    
				response.sendRedirect("Smart Payroll/AllowanceTransView.jsp");
			} 
			
			
						
			
			
			else if (action.equals("PAYStaffAllowanceRecoveryUpdate")) {
				String staffid = "" + request.getParameter("staffid");
				staffid.trim();
				String allowanceFields = collectAllowanceField();
				String recoveryFields = collectRecoveryField();
				String afields[] = allowanceFields.split("~");
				String rfields[] = recoveryFields.split("~");
				boolean aflag = StaffRegistration.allowanceRecordExist(staffid
						.trim());
				boolean rflag = StaffRegistration.recoveryRecordExist(staffid
						.trim());
				String reqallowancefields = "";
				String reqrecoveryfields = "";
				String asqltrue = "";
				String rsqltrue = "";
				String asqlfalse = "";
				String rsqlfalse = "";
				String reqval = "";
				asqltrue = "UPDATE PAY_T_ALLOWANCE SET ";
				reqallowancefields = "";

				for (int i = 0; i < afields.length; i++) {
					reqval = "";
					reqval = "" + request.getParameter(afields[i]);
					if (reqval.equals("") || reqval.equals("null"))
						reqval = "0";
					reqallowancefields = reqallowancefields
							+ afields[i].toUpperCase() + " = '" + reqval
							+ "' ,";
				}
				reqallowancefields.trim();
				reqallowancefields = reqallowancefields.substring(0,
						reqallowancefields.length() - 1);
				asqltrue = asqltrue + reqallowancefields
						+ " WHERE CHR_EMPID = '" + staffid + "'";
				asqlfalse = "INSERT INTO PAY_T_ALLOWANCE VALUES ( '" + staffid
						+ "' ,";

				reqallowancefields = "";
				for (int i = 0; i < afields.length; i++) {
					reqval = "";
					reqval = "" + request.getParameter(afields[i]);
					if (reqval.equals("") || reqval.equals("null"))
						reqval = "0";
					reqallowancefields = reqallowancefields + "  '" + reqval
							+ "' ,";
				}
				reqallowancefields.trim();
				reqallowancefields = reqallowancefields.substring(0,
						reqallowancefields.length() - 1);
				asqlfalse = asqlfalse + reqallowancefields + " )";
				rsqltrue = "UPDATE PAY_T_RECOVERY SET ";

				reqrecoveryfields = "";
				for (int i = 0; i < rfields.length; i++) {
					reqval = "";
					reqval = "" + request.getParameter(rfields[i]);
					if (reqval.equals("") || reqval.equals("null"))
						reqval = "0";
					reqrecoveryfields = reqrecoveryfields
							+ rfields[i].toUpperCase() + " = '" + reqval
							+ "' ,";
				}
				reqrecoveryfields.trim();
				reqrecoveryfields = reqrecoveryfields.substring(0,
						reqrecoveryfields.length() - 1);
				rsqltrue = rsqltrue + reqrecoveryfields
						+ " WHERE CHR_EMPID = '" + staffid + "'";
				rsqlfalse = "INSERT INTO PAY_T_RECOVERY VALUES ( '" + staffid
						+ "' ,";

				reqrecoveryfields = "";
				for (int i = 0; i < afields.length; i++) {
					reqval = "";
					reqval = "" + request.getParameter(rfields[i]);
					if (reqval.equals("") || reqval.equals("null"))
						reqval = "0";

					reqrecoveryfields = reqrecoveryfields + "  '" + reqval
							+ "' ,";
				}
				reqrecoveryfields.trim();
				reqrecoveryfields = reqrecoveryfields.substring(0,
						reqrecoveryfields.length() - 1);
				rsqlfalse = rsqlfalse + reqrecoveryfields + " )";
				if (aflag) {
					st = con.createStatement();
					st.executeUpdate(asqltrue);
				} else {
					st = con.createStatement();
					st.executeUpdate(asqlfalse);
				}

				if (rflag) {
					st = con.createStatement();
					st.executeUpdate(rsqltrue);
				} else {
					st = con.createStatement();
					st.executeUpdate(rsqlfalse);
				}
				 
				response.sendRedirect("Smart Payroll/AllowanceTransView.jsp");
			} else if (action.equals("PAYStaffAllowanceRecoveryDelete")) {
				String staff[] = request.getParameterValues("staffid");
				String staffid = "";
				for (int i = 0; i < staff.length; i++) {
					staffid = staff[i];
					staffid.trim();
					StaffDeletion(staffid);
				}
				con.close();    
				response.sendRedirect("Smart Payroll/AllowanceTransView.jsp");
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
