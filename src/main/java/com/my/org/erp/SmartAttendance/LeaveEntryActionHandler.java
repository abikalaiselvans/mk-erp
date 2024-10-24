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

import com.my.org.erp.bean.Attendance.LeaveEntry;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class LeaveEntryActionHandler extends AbstractActionHandler {
	String day, fromTime, toTime, TxtLeaveType, reason, ComboDay, sesUser,
			date1, date2, fdate;

	int courseId;

	String message;

	public void insertUserInformation(String staffid, String dat, String lid) {

		@SuppressWarnings("unused")
		java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		@SuppressWarnings("unused")
		java.util.Date date = new java.util.Date();
		try {
			CallableStatement cs = con
					.prepareCall("{call ATT_PRO_LEAVENTRY(?,?,?,?,?,?,?)}");
			cs.setString(1, "INSERT");
			cs.setString(2, staffid);
			cs.setString(3, lid);
			cs.setString(4, dat);
			cs.setString(5, TxtLeaveType);
			cs.setString(6, ComboDay);
			cs.setString(7, sesUser);
			cs.execute();
		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}
	}

	private void LeaveDelete(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			// String sql="DELETE FROM ATT_T_LEAVE WHERE CHR_EMPID=? AND
			// DT_LDATE=?";
			String[] leavID = request.getParameterValues("OptLeaveName");
			CallableStatement cs = con
					.prepareCall("{call ATT_PRO_LEAVENTRY(?,?,?,?,?,?,?)}");
			for (int i = 0; i < leavID.length; i++) {
				cs.setString(1, "DELETE");
				cs.setString(2, "1");
				cs.setString(3, leavID[i]);
				cs.setString(4, "1");
				cs.setString(5, "1");
				cs.setString(6, "1");
				cs.setString(7, "1");
				cs.addBatch();
			}
			cs.executeBatch();
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void LeaveAdd(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			HttpSession session = request.getSession();
			sesUser = (String) session.getAttribute("USRID");
			String staffname[] = request.getParameterValues("ename");
			TxtLeaveType = request.getParameter("Leavetype");
			ComboDay = request.getParameter("ComboDay");
			String fdate = request.getParameter("fromdt");
			String tdate = request.getParameter("todt");
			String sql_id = "SELECT MAX(INT_LEAVEID) AS MAXID FROM ATT_T_LEAVE ";
			int leaveid = 0;
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(sql_id);
			while (rs.next()) {
				leaveid = rs.getInt("MAXID");
			}
			if (leaveid <= 0)
				leaveid = 0;

			leaveid = leaveid + 1;
			String ld = "" + leaveid;
			ld.trim();
			String sql = "";
			message = "";
			for (int i = 0; i < staffname.length; i++) {
				date1 = DateUtil.FormateDateSQL(fdate);
				date2 = DateUtil.FormateDateSQL(tdate);
				while (true) 
				{
					String year = date1.substring(0, 4);
					sql = "SELECT * FROM ATT_M_LEAVE WHERE CHR_EMPID='"
							+ staffname[i] + "' ";
					 sql = sql + "AND INT_YEAR=" + year;
					//System.out.println("LM" + sql);
					double rLeave = 0;
					String lBalance = "";
					int t = 1;
					st = con.createStatement();
					rs = st.executeQuery(sql);
					if (rs.next()) {
						for (int k = 2; k < 14; k = k + 3) {
							String tLName = rs.getString(k);
							//System.out.println("LNAME :" + tLName);
							if (tLName.equalsIgnoreCase(TxtLeaveType)) {
								rLeave = rs.getFloat(k + 2);
								lBalance = "INT_NOD" + t;
								//System.out.println("LNAME DAYS:" + rLeave);
							}
							t++;
						}
						if (rLeave <= 0) {
							message = "Leave Days is Completed";
							break;
						}
					} else {
						message = "Leave Day is Not Alloted";
					}
					if (ComboDay.equalsIgnoreCase("Full Day")) {
						rLeave = rLeave - 1;
					} else {
						rLeave = rLeave - 0.5;
					}
					lBalance = lBalance + "BALANCE";
					sql = "UPDATE ATT_M_LEAVE SET " + lBalance + "=" + rLeave
							+ " WHERE CHR_EMPID='" + staffname[i];
					sql = sql + "' AND INT_YEAR=" + year;
					st = con.createStatement();
					st.execute(sql);
					insertUserInformation(staffname[i], date1, ld);
					if (date1.equalsIgnoreCase(date2))
						break;
					date1 = DateUtil.addDate(date1, 1);
				}
				leaveid = leaveid + 1;
				ld = "" + leaveid;
				ld.trim();
			}

		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void LeaveView(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			sesUser = (String) session.getAttribute("USRID");
			// String staffname[] = request.getParameterValues("ename");
			String fdate = request.getParameter("fromdt");
			String date1 = DateUtil.FormateDateSQL(fdate);
			String tdate = request.getParameter("todt");
			String date2 = DateUtil.FormateDateSQL(tdate);
			// String Leavetype=request.getParameter("Leavetype");

			ArrayList<LeaveEntry> leaveList = new ArrayList<LeaveEntry>();
			// if(staffname==null) {
			String sql = "SELECT DISTINCT  INT_LEAVEID FROM  ATT_T_LEAVE where dt_ldate>='"
					+ date1 + "' ";
			sql = sql + "and dt_ldate<='" + date2 + "' ORDER BY INT_LEAVEID";
			Statement st1 = con.createStatement();
			ResultSet rs1 = st1.executeQuery(sql);
			// //System.out.println("F SQL :"+sql);
			String[] leaveID = new String[10000];
			int i = 0;
			while (rs1.next()) {
				leaveID[i] = rs1.getString(1);
				i++;
			}
			for (int j = 0; j < i; j++) {
				sql = "SELECT L.CHR_EMPID,S.CHR_STAFFNAME,L.CHR_LEAVETYPE,L.INT_LEAVEID,L.DT_LDATE ";
				sql = sql + "FROM  ATT_T_LEAVE L, com_m_staff  S WHERE ";
				sql = sql + "L.CHR_EMPID=S.CHR_EMPID AND L.INT_LEAVEID="
						+ leaveID[j] + " ORDER BY DT_LDATE";
				// //System.out.println("S SQL :"+sql);
				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery(sql);
				if (rs.next()) {
					LeaveEntry leave = new LeaveEntry();
					leave.setEmpId(rs.getString(1));
					leave.setEmpName(rs.getString(2));
					leave.setLeaveType(rs.getString(3));
					leave.setLeaveId(rs.getString(4));
					leave.setFromDate(rs.getString(5));
					leave.setToDate(rs.getString(5));
					while (rs.next()) {
						leave.setToDate(rs.getString(5));
					}
					leaveList.add(leave);
				}
			}
			/*
			 * } else if(staffname==null && Leavetype==null) { String
			 * sql="SELECT
			 * A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_LEAVETYPE,B.DT_LDATE FROM ";
			 * sql=sql+"  com_m_staff  A,ATT_T_LEAVE B WHERE
			 * A.CHR_EMPID=B.CHR_EMPID AND B.DT_LDATE>='"+date1+"' AND
			 * B.DT_LDATE<='"+date2+"'"; Statement st=con.createStatement();
			 * ResultSet rs=st.executeQuery(sql); while(rs.next()){ LeaveEntry
			 * leave=new LeaveEntry(); leave.setEmpId(rs.getString(1));
			 * leave.setEmpName(rs.getString(2));
			 * leave.setLeaveType(rs.getString(3));
			 * leave.setDate(rs.getString(4)); leaveList.add(leave); } } else
			 * for(int i=0;i<staffname.length;i++) { String sql="SELECT
			 * A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_LEAVETYPE,B.DT_LDATE FROM ";
			 * sql=sql+"  com_m_staff  A,ATT_T_LEAVE B WHERE
			 * A.CHR_EMPID=B.CHR_EMPID AND B.DT_LDATE>='"+date1+"' AND
			 * B.DT_LDATE<='"+date2+"' AND B.CHR_EMPID='"+staffname[i]+"'";
			 * Statement st=con.createStatement(); ResultSet
			 * rs=st.executeQuery(sql); while(rs.next()){ LeaveEntry leave=new
			 * LeaveEntry(); leave.setEmpId(rs.getString(1));
			 * leave.setEmpName(rs.getString(2));
			 * leave.setLeaveType(rs.getString(3));
			 * leave.setDate(rs.getString(4)); leaveList.add(leave); } }
			 */
			session.setAttribute("leaveList", leaveList);
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
			if (action.equals("ATTleaveAdd") && act.equals("Submit")) {
				LeaveAdd(request, response);
				con.close();    
				response
						.sendRedirect("Smart Attendance/Leave%20EntryAdd.jsp?message="
								+ message);
			} else if (action.equals("ATTleaveView")) {
				LeaveView(request, response);
				con.close();   
				response.sendRedirect("Smart Attendance/LeaveEntryView.jsp");
			} else if (action.equals("ATTleaveDelete")) {
				// //System.out.println("SDFDSF");
				LeaveDelete(request, response);
				con.close();    
				response
						.sendRedirect("Smart Attendance/Leave Entry.jsp?message=Successfuly Deleted");
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
