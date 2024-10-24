package com.my.org.erp.SmartAttendance;

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

import com.my.org.erp.bean.Attendance.ManualAttendance;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class ManualAttendanceActionHandler extends AbstractActionHandler {
	String ComboDay, ChkLate, stint, stout, sesUser;

	int courseId;

	public void insertUserInformation(String staffid, String dat) {
		@SuppressWarnings("unused")
		java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		@SuppressWarnings("unused")
		java.util.Date date = new java.util.Date();
		try {
			CallableStatement cs = con
					.prepareCall("{call ATT_PRO_MANUALATTENDANCE(?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, "INSERT");
			cs.setString(2, staffid);
			cs.setString(3, stint);
			cs.setString(4, stout);
			cs.setString(5, dat);
			cs.setString(6, dat);
			String data[] = dat.split("-");
			String month = DateUtil.getMonth(Integer.parseInt(data[1]));
			cs.setString(7, month);
			cs.setInt(8, Integer.parseInt(data[0]));
			cs.setString(9, ChkLate);
			cs.setString(10, ComboDay);
			cs.setString(11, sesUser);
			cs.execute();
		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
	}

	private void ManualDelete(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {

			String[] EmpId = request.getParameterValues("OptManualName");
			CallableStatement cs = con
					.prepareCall("{call ATT_PRO_MANUALATTENDANCE(?,?,?,?,?,?,?,?,?,?,?)}");
			for (int i = 0; i < EmpId.length; i++) {
				String emp[] = EmpId[i].split("@");
				cs.setString(1, "DELETE");
				cs.setString(2, emp[0]);
				cs.setString(3, "1");
				cs.setString(4, "1");
				cs.setString(5, emp[1]);
				cs.setString(6, "1");
				cs.setString(7, "1");
				cs.setString(8, "1");
				cs.setString(9, "1");
				cs.setString(10, "1");
				cs.setString(11, "");
				cs.addBatch();
			}
			cs.executeBatch();

		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void ManualAdd(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			sesUser = (String) session.getAttribute("USRID");
			String staffname[] = request.getParameterValues("ename");
			ComboDay = request.getParameter("ComboDay");
			ChkLate = request.getParameter("ChkLate");
			stint = request.getParameter("int");
			stout = request.getParameter("out");
			String fdate = request.getParameter("fromdt");
			String tdate = request.getParameter("todt");
			String date1 = DateUtil.FormateDateSQL(fdate);
			String date2 = DateUtil.FormateDateSQL(tdate);
			for (int i = 0; i < staffname.length; i++) {
				date1 = DateUtil.FormateDateSQL(fdate);
				date2 = DateUtil.FormateDateSQL(tdate);
				while (true) {					
					insertUserInformation(staffname[i], date1);
					if (date1.equalsIgnoreCase(date2))	break;
					date1 = DateUtil.addDate(date1, 1);
				}
			}
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void ManualView(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			sesUser = (String) session.getAttribute("USRID");
			String staffname[] = request.getParameterValues("ename");
			String fdate = request.getParameter("fromdt");
			String tdate = request.getParameter("todt");
			String date1 = DateUtil.FormateDateSQL(fdate);
			String date2 = DateUtil.FormateDateSQL(tdate);
			ArrayList<ManualAttendance> manualList = new ArrayList<ManualAttendance>();

			if (staffname == null) {
				String sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.DT_LOGIN,B.DT_TIMEIN,B.DT_TIMEOUT FROM ";
				sql = sql
						+ "  com_m_staff  A,ATT_SMART_ATTENDANCE B WHERE A.CHR_EMPID=B.CHR_EMPID AND B.DT_LOGIN>='"
						+ date1 + "' AND B.DT_LOGIN<='" + date2 + "'";

				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery(sql);
				while (rs.next()) {
					ManualAttendance manual = new ManualAttendance();
					manual.setEmpId(rs.getString(1));
					manual.setEmpName(rs.getString(2));
					manual.setDate(rs.getString(3));
					manual.setInTime(rs.getString(4));
					manual.setOutTime(rs.getString(5));
					manualList.add(manual);
				}
			} else

				for (int i = 0; i < staffname.length; i++) {
					date1 = DateUtil.FormateDateSQL(fdate);
					date2 = DateUtil.FormateDateSQL(tdate);
					String sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.DT_LOGIN,B.DT_TIMEIN,B.DT_TIMEOUT FROM ";
					sql = sql
							+ "  com_m_staff  A,ATT_SMART_ATTENDANCE B WHERE A.CHR_EMPID=B.CHR_EMPID AND B.DT_LOGIN>='"
							+ date1 + "' AND B.DT_LOGIN<='" + date2
							+ "' AND B.CHR_EMPID='" + staffname[i] + "'";
					Statement st = con.createStatement();
					ResultSet rs = st.executeQuery(sql);
					while (rs.next()) {
						ManualAttendance manual = new ManualAttendance();
						manual.setEmpId(rs.getString(1));
						manual.setEmpName(rs.getString(2));
						manual.setDate(rs.getString(3));
						manual.setInTime(rs.getString(4));
						manual.setOutTime(rs.getString(5));
						manualList.add(manual);
					}

				}
			session.setAttribute("manualList", manualList);

		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String action = request.getParameter("actionS");
			//System.out.println("Action Delete :" + action);
			String act = "" + request.getParameter("Submit");
			//System.out.println("Action Submit :" + act);
			act = act.trim();
			if (action.equals("ATTmanualAdd") && act.equals("Submit")) {
				ManualAdd(request, response);
				con.close();    
				response
						.sendRedirect("Smart Attendance/Manual Attendance.jsp?message='Successfuly Added'");
			} else if (action.equals("ATTmanualAdd") && act.equals("View")) {
				ManualView(request, response);
				con.close();    
				response
						.sendRedirect("Smart Attendance/ManualAttendanceView.jsp");
			} else if (action.equals("ATTmanualDelete")) {
				// //System.out.println("SDFDSF");
				ManualDelete(request, response);
				con.close();    
				response
						.sendRedirect("Smart Attendance/Manual Attendance.jsp?message=Successfuly Deleted");
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
