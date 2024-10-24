package com.my.org.erp.SmartPayroll;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.bean.payroll.Allowance;
import com.my.org.erp.bean.payroll.AllowanceTransaction;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class AllowanceTransActionHandler extends AbstractActionHandler {
	String empId = null, msg = null, empName = null;

	private void AllowanceView(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			ArrayList<Allowance> allowanceList = new ArrayList<Allowance>();
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT * FROM PAY_M_ALLOWANCE");
			while (rs.next()) {
				String allId = rs.getString(1);
				String allName = rs.getString(2);
				String flag =  rs.getString(3);
				String mflag =  rs.getString(4);
				String bflag =rs.getString(5);
				Allowance allowance = new Allowance(allId, allName,flag,mflag,bflag);
				allowanceList.add(allowance);
			}
			HttpSession session = request.getSession();
			session.setAttribute("allowanceList", allowanceList);
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void AllowanceList(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			ArrayList<AllowanceTransaction> allowanceTranList = new ArrayList<AllowanceTransaction>();

			String massql, transql;
			String allCode[] = new String[7];

			massql = "SELECT * FROM PAY_M_ALLOWANCE";
			Statement masst = con.createStatement();
			ResultSet masrs = masst.executeQuery(massql);
			int i, n = 0;
			while (masrs.next()) {
				n = n + 1;
			}
			transql = "SELECT A.*,B.CHR_STAFFNAME FROM PAY_T_ALLOWANCE A, com_m_staff  B WHERE A.CHR_EMPID=B.CHR_EMPID AND A.CHR_EMPID='"
					+ empId + "'";
			Statement transt = con.createStatement();
			ResultSet tranrs = transt.executeQuery(transql);
			AllowanceTransaction allowancetran = new AllowanceTransaction();
			if (tranrs.next()) {
				empId = tranrs.getString("CHR_EMPID");
				empName = tranrs.getString("CHR_STAFFNAME");
				i = 0;
				while (i < n) {
					//System.out.println(tranrs.getString(i + 2));
					allCode[i] = tranrs.getString(i + 2);
					i = i + 1;
				}
				allowancetran.setEmpId(empId);
				allowancetran.setAllode(allCode);
				allowanceTranList.add(allowancetran);
				msg = "List";
			} else
				msg = "No Record Found";
			HttpSession session = request.getSession();
			session.removeAttribute("allowanceTranList");
			session.setAttribute("allowanceTranList", allowanceTranList);
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void AllowanceAdd(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			PreparedStatement pstm;
			Statement st = con.createStatement();
			int max;
			String sqlIns, all;
			String staffname[] = request.getParameterValues("ename");
			max = Integer.parseInt(request.getParameter("allsize"));
			for (int i = 0; i < staffname.length; i++) {
				st.execute("DELETE FROM PAY_T_ALLOWANCE WHERE CHR_EMPID='"
						+ staffname[i] + "'");
				sqlIns = "INSERT INTO PAY_T_ALLOWANCE VALUES('" + staffname[i]
						+ "'";
				for (int j = 1; j <= max; j++) {
					all = "" + request.getParameter("A00" + j);

					if (all.equals("null") || all.equals(""))
						sqlIns = sqlIns + ",0";
					else
						sqlIns = sqlIns + "," + all;
				}

				sqlIns = sqlIns + ")";
				//System.out.println("in allowance::: " + sqlIns);
				pstm = con.prepareStatement(sqlIns);
				pstm.execute();
			}
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void AllowanceUpdate(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			PreparedStatement pstm;
			Statement st = con.createStatement();
			int max;
			String sqlIns, all;
			max = Integer.parseInt(request.getParameter("allsize"));
			st.execute("DELETE FROM PAY_T_ALLOWANCE WHERE CHR_EMPID='" + empId
					+ "'");
			sqlIns = "INSERT INTO PAY_T_ALLOWANCE VALUES('" + empId + "'";
			for (int j = 1; j <= max; j++) {
				all = "" + request.getParameter("A00" + j);
				if (all.equals("null") || all.equals(""))
					sqlIns = sqlIns + ",0";
				else
					sqlIns = sqlIns + "," + all;
			}
			sqlIns = sqlIns + " )";
			//System.out.println("CONTROL FROM ::" + sqlIns);
			pstm = con.prepareStatement(sqlIns);
			pstm.execute();
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String sumAct = null;
			String action = request.getParameter("actionS");
			//System.out.println("Action ::" + action);
			if (action.equals("PAYallowanceAdd")) {
				sumAct = request.getParameter("Submit");
				sumAct = sumAct.trim();
			}
			if (action.equals("PAYallowanceList")) {
				AllowanceView(request, response);
				con.close();    
				response
						.sendRedirect("Smart Payroll/AllowanceTransaction.jsp?message=View");
			} else if (action.equals("PAYallowanceAdd")
					&& sumAct.equalsIgnoreCase("Submit")) {
				AllowanceAdd(request, response);
				AllowanceView(request, response);
				con.close();    
				response
						.sendRedirect("Smart Payroll/AllowanceTransView.jsp?message=Allowance Added Sucessfully");
			} else if (action.equals("PAYallowanceAdd")
					&& sumAct.equalsIgnoreCase("List")) {
				empId = request.getParameter("ename");
				AllowanceList(request, response);
				con.close();    
				response
						.sendRedirect("Smart Payroll/AllowanceTransView.jsp?message="
								+ msg
								+ "&empId="
								+ empId
								+ "&empName="
								+ empName);
			} else if (action.equals("PAYallowanceAdd")
					&& sumAct.equalsIgnoreCase("Update")) {
				empId = request.getParameter("empId");
				AllowanceUpdate(request, response);
				con.close();    
				response
						.sendRedirect("Smart Payroll/AllowanceTransView.jsp?message=View");
			}

		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

}
