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

import com.my.org.erp.bean.Attendance.OnDuty;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class OnDutyActionHandler extends AbstractActionHandler {
	String TxtReason, TxtPlace, TxtAuthorised, daytype, sesUser;

	int courseId;

	public void insertUserInformation(String staffid, String dat) {
		@SuppressWarnings("unused")
		java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		@SuppressWarnings("unused")
		java.util.Date date = new java.util.Date();
		try {
			CallableStatement cs = con.prepareCall("{call ATT_PRO_ONDUTY(?,?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, "INSERT");
			
			cs.setString(2, staffid);
			cs.setString(3, dat);
			cs.setString(4, daytype);
			cs.setString(5, TxtPlace);
			cs.setString(6, TxtReason);
			cs.setString(7, "AA");
			cs.setString(8, TxtAuthorised);
			String data[] = dat.split("-");
			String month = DateUtil.getMonth(Integer.parseInt(data[1]));
			cs.setString(9, month);
			cs.setInt(10, Integer.parseInt(data[0]));
			cs.setString(11, sesUser);
			cs.execute();
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			 

		}	
	}

	private void OnDutyDelete(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			@SuppressWarnings("unused")
			String sql = "DELETE FROM ATT_T_ONDUTY  WHERE CHR_EMPID=? AND DT_ODDATE=?";
			String[] EmpId = request.getParameterValues("OptOnDutyName");
			//System.out.println("Lengthvvvvv" + EmpId.length);

			CallableStatement cs = con
					.prepareCall("{call ATT_PRO_ONDUTY(?,?,?,?,?,?,?,?,?,?,?)}");
			for (int i = 0; i < EmpId.length; i++) {
				String emp[] = EmpId[i].split("@");
				cs.setString(1, "DELETE");
				cs.setString(2, emp[0]);
				cs.setString(3, emp[1]);
				cs.setString(4, "");
				cs.setString(5, "");
				cs.setString(6, "");
				cs.setString(7, "");
				cs.setString(8, "");
				cs.setString(9, "1");
				cs.setString(10, "1");
				cs.setString(11, "");
				cs.addBatch();
			}
			cs.executeBatch();
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

		}	
	}

	private void OnDutyAdd(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			sesUser = (String) session.getAttribute("USRID");
			String staffname[] = request.getParameterValues("ename");
			TxtReason = request.getParameter("TxtReason");
			//System.out.println("TxtReason");
			TxtPlace = request.getParameter("TxtPlace");
			TxtAuthorised = request.getParameter("TxtAuthorised");
			daytype = request.getParameter("ComboDay");
			String fdate = request.getParameter("fromdt");
			String tdate = request.getParameter("todt");
			String date1 = DateUtil.FormateDateSQL(fdate);
			String date2 = DateUtil.FormateDateSQL(tdate);
			for (int i = 0; i < staffname.length; i++) {
				date1 = DateUtil.FormateDateSQL(fdate);
				date2 = DateUtil.FormateDateSQL(tdate);
				while (true) {
					insertUserInformation(staffname[i], date1);
					if (date1.equalsIgnoreCase(date2))
						break;
					date1 = DateUtil.addDate(date1, 1);
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

	private void OnDutyView(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			String fdate = request.getParameter("fromdt");
			String tdate = request.getParameter("todt");
			String date1 = DateUtil.FormateDateSQL(fdate);
			String date2 = DateUtil.FormateDateSQL(tdate);
			ArrayList<OnDuty> dutyList = new ArrayList<OnDuty>();
			String sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.DT_ODDATE,B.CHR_PLACE,B.CHR_REASON,B.CHR_TYPE FROM ";
			sql = sql
					+ "  com_m_staff  A,ATT_T_ONDUTY B WHERE A.CHR_EMPID=B.CHR_EMPID AND B.DT_ODDATE>='"
					+ date1 + "' AND B.DT_ODDATE<='" + date2 + "'";
			//System.out.println("DT SQL :" + sql);
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(sql);
			while (rs.next()) {
				OnDuty duty = new OnDuty();
				duty.setEmpId(rs.getString(1));
				duty.setEmpName(rs.getString(2));
				duty.setODDate(rs.getString(3));
				duty.setPlace(rs.getString(4));
				duty.setReason(rs.getString(5));
				duty.setDayType(rs.getString(6));
				dutyList.add(duty);
			}
			session.setAttribute("dutyList", dutyList);
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
	        RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
	    	dispatchers.forward(request, response); 

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
			if (action.equals("ATTondutyAdd") && act.equals("Submit")) {
				OnDutyAdd(request, response);
				OnDutyView(request, response);
				con.close();    
				response
						.sendRedirect("Smart Attendance/OnDutyView.jsp?message='Successfuly Added'");
			} else if (action.equals("ATTondutyView")) {
				OnDutyView(request, response);
				con.close();    
				response.sendRedirect("Smart Attendance/OnDutyView.jsp");
			} else if (action.equals("ATTondutyDelete")) {
				// //System.out.println("SDFDSF");
				OnDutyDelete(request, response);
				con.close();    
				response
						.sendRedirect("Smart Attendance/OnDuty.jsp?message=Successfuly Deleted");
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
