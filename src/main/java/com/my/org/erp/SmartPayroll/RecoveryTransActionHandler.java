package com.my.org.erp.SmartPayroll;

import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.bean.payroll.Recovery;
import com.my.org.erp.bean.payroll.RecoveryTransaction;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class RecoveryTransActionHandler extends AbstractActionHandler {
	String empId = null, msg = null, empName = null;

	private void RecoveryView(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			ArrayList<Recovery> recoveryList = new ArrayList<Recovery>();
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT * FROM PAY_M_RECOVERY");
			while (rs.next()) {
				String recId = rs.getString(1);
				String recName = rs.getString(2);
				String changes = rs.getString(3);
				
				Recovery recovery = new Recovery(recId, recName,changes);
				recoveryList.add(recovery);
			}
			//System.out.println("Inside Recovery View");
			HttpSession session = request.getSession();
			session.setAttribute("recoveryList", recoveryList);
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void RecoveryList(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			ArrayList<RecoveryTransaction> recoveryTranList = new ArrayList<RecoveryTransaction>();
			String massql, transql;
			String allCode[] = new String[7];
			massql = "SELECT * FROM PAY_M_RECOVERY";
			Statement masst = con.createStatement();
			ResultSet masrs = masst.executeQuery(massql);
			int i, n = 0;
			while (masrs.next()) {
				n = n + 1;
			}
			transql = "SELECT A.*,B.CHR_STAFFNAME FROM PAY_T_RECOVERY A, com_m_staff  B WHERE A.CHR_EMPID=B.CHR_EMPID AND A.CHR_EMPID='"
					+ empId + "'";
			Statement transt = con.createStatement();
			ResultSet tranrs = transt.executeQuery(transql);
			RecoveryTransaction recoverytran = new RecoveryTransaction();
			if (tranrs.next()) {
				empId = tranrs.getString("CHR_EMPID");
				empName = tranrs.getString("CHR_STAFFNAME");
				i = 0;
				while (i < n) {
					System.out.println("Inside Trans list "
							+ tranrs.getString(i + 2));
					allCode[i] = tranrs.getString(i + 2);
					i = i + 1;
				}
				recoverytran.setEmpId(empId);
				recoverytran.setReccode(allCode);
				recoveryTranList.add(recoverytran);
				msg = "List";
			} else
				msg = "No Record Found";
			HttpSession session = request.getSession();
			session.removeAttribute("recoveryTranList");
			session.setAttribute("recoveryTranList", recoveryTranList);
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void RecoveryAdd(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			PreparedStatement pstm;
			Statement st = con.createStatement();
			int max;
			String sqlIns, rec;
			String staffname[] = request.getParameterValues("ename");
			max = Integer.parseInt(request.getParameter("recsize"));
			for (int i = 0; i < staffname.length; i++) {
				st.execute("DELETE FROM PAY_T_RECOVERY WHERE CHR_EMPID='"
						+ staffname[i] + "'");
				sqlIns = "INSERT INTO PAY_T_RECOVERY VALUES('" + staffname[i]
						+ "'";
				for (int j = 1; j <= max; j++) {
					rec = "" + request.getParameter("R00" + j);
					if (rec.equals("null") || rec.equals(""))
						sqlIns = sqlIns + ",0";
					else
						sqlIns = sqlIns + "," + rec;
				}
				sqlIns = sqlIns + ")";
				pstm = con.prepareStatement(sqlIns);
				pstm.execute();
			}
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void RecoveryUpdate(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			PreparedStatement pstm;
			Statement st = con.createStatement();
			int max;
			String sqlIns, rec;
			max = Integer.parseInt(request.getParameter("recsize"));
			st.execute("DELETE FROM PAY_T_RECOVERY WHERE CHR_EMPID='" + empId
					+ "'");
			sqlIns = "INSERT INTO PAY_T_RECOVERY VALUES('" + empId + "'";
			for (int j = 1; j <= max; j++) {
				rec = "" + request.getParameter("R00" + j);
				if (rec.equals("null") || rec.equals(""))
					sqlIns = sqlIns + ",0";
				else
					sqlIns = sqlIns + "," + rec;

			}
			sqlIns = sqlIns + ")";
			//System.out.println("Sql Query " + sqlIns);
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
			//System.out.println("Inside Recovery Transaction Handler " + action);
			if (action.equals("PAYrecoveryAdd")) {
				sumAct = request.getParameter("Submit");
				sumAct = sumAct.trim();
			}
			//System.out.println("Inside Recovery Transaction Handler " + sumAct);
			if (action.equals("PAYrecoveryList")) {
				RecoveryView(request, response);
				con.close();    
				response
						.sendRedirect("Smart Payroll/RecoveryTransView.jsp?message=View");
			} else if (action.equals("PAYrecoveryAdd")
					&& sumAct.equalsIgnoreCase("Submit")) {
				//System.out.println("Inside Recovery Transaction Add ");
				RecoveryAdd(request, response);
				RecoveryView(request, response);
				con.close();   
				response
						.sendRedirect("Smart Payroll/RecoveryTransView.jsp?message=Recovery Added Sucessfully");
			} else if (action.equals("PAYrecoveryAdd")
					&& sumAct.equalsIgnoreCase("List")) {
				empId = request.getParameter("ename");
				RecoveryList(request, response);
				con.close();    
				response
						.sendRedirect("Smart Payroll/RecoveryTransView.jsp?message="
								+ msg
								+ "&empId="
								+ empId
								+ "&empName="
								+ empName);
			} else if (action.equals("PAYrecoveryAdd")
					&& sumAct.equalsIgnoreCase("Update")) {
				empId = request.getParameter("empId");
				RecoveryUpdate(request, response);
				con.close();   
				response
						.sendRedirect("Smart Payroll/RecoveryTransView.jsp?message=View");
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
