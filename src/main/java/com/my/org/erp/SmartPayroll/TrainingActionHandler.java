package com.my.org.erp.SmartPayroll;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class TrainingActionHandler extends AbstractActionHandler {
	String TxtProgramName, fdate, fromdate, todate, tdate, TxtProgDate,
			TxtTime, TxtVenu, TxtTrainer, TxtSubject, TxtDate;

	int Count;

	private void TrainingList(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		try {
			ArrayList<Training> trainingList = new ArrayList<Training>();
			HttpSession session = request.getSession();
			Statement st = con.createStatement();
			String fdate = "" + session.getAttribute("fromdate");
			String tdate = "" + session.getAttribute("todate");

			ResultSet rs = st
					.executeQuery("SELECT * FROM PAY_M_EMP_TRAINING WHERE DT_PDATE>='"
							+ fdate + "' AND DT_PDATE<='" + tdate + "'");

					while (rs.next()) {
				//System.out.println("InSide Fun");
				String progId = rs.getString(1);
				String progName = rs.getString(2);
				String pdate = rs.getString(3);
				String ptime = rs.getString(4);
				String venu = rs.getString(5);
				String trainer = rs.getString(6);
				String subject = rs.getString(7);
				Training train = new Training(progId, progName, pdate, ptime,
						venu, trainer, subject);
				trainingList.add(train);
			}

			session.setAttribute("trainingList", trainingList);
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void TrainingAdd(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String staffname[] = request.getParameterValues("ename");
			String TxtProgramName = request.getParameter("TxtProgramName");
			if (TxtProgramName == null) {
				this.TxtProgramName = "";
			} else {
				this.TxtProgramName = TxtProgramName;
			}

			// //System.out.println(TxtProgramName);
			TxtDate = request.getParameter("TxtProgDate");
			TxtProgDate = DateUtil.FormateDateSQL(TxtDate);
			TxtTime = "" + request.getParameter("TxtTime");
			for (int i = 0; i < staffname.length; i++) {
				CallableStatement cs = con
						.prepareCall("{call PAY_PRO_TRAINING(?,?,?,?,?,?,?,?,?,?)}");
				cs.setString(1, "INSERT");
				cs.setString(2, "1");
				cs.setString(3, staffname[i]);
				cs.setString(4, this.TxtProgramName);
				cs.setString(5, this.TxtProgDate);
				cs.setString(6, this.TxtTime);
				cs.setString(7, this.TxtVenu);
				cs.setString(8, this.TxtTrainer);
				cs.setString(9, this.TxtSubject);
				cs.setString(10, "ADMIN");
				cs.execute();
			}
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void TrainingDelete(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String[] programId = request.getParameterValues("training");
			CallableStatement cs = con
					.prepareCall("{call PAY_PRO_TRAINING(?,?,?,?,?,?,?,?,?,?)}");
			for (int i = 0; i < programId.length; i++) {
				cs.setString(1, "DELETE");
				cs.setString(2, programId[i]);
				cs.setString(3, "");
				cs.setString(4, "");
				cs.setString(5, "");
				cs.setString(6, "");
				cs.setString(7, "");
				cs.setString(8, "");
				cs.setString(9, "");
				cs.setString(10, "");
				cs.addBatch();
			}
			cs.executeBatch();
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String action = request.getParameter("actionS");
			//System.out.println("action" + action);
			if (action.equals("PAYtrainingAdd")) {
				TrainingAdd(request, response);
				TrainingList(request, response);
				con.close();   
				response
						.sendRedirect("Smart Payroll/TrainingView.jsp?fromDate="
								+ fromdate + "&toDate=" + todate);
			}
			if (action.equals("PAYtrainingView")) {
				TrainingList(request, response);
				fromdate = request.getParameter("fromdt");
				todate = request.getParameter("todt");
				HttpSession session = request.getSession();
				session.setAttribute("fromdate", DateUtil
						.FormateDateSQL(fromdate));
				session.setAttribute("todate", DateUtil.FormateDateSQL(todate));
				con.close();   
				response
						.sendRedirect("Smart Payroll/TrainingView.jsp?fromDate="
								+ fromdate + "&toDate=" + todate);
			}
			if (action.equals("PaytrainingDelete")) {
				TrainingDelete(request, response);
				TrainingList(request, response);
				con.close();   
				response
						.sendRedirect("Smart Payroll/TrainingView.jsp?fromDate="
								+ fromdate + "&toDate=" + todate);
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
