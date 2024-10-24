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

import com.my.org.erp.bean.Attendance.Permission;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class PermissionActionHandler extends AbstractActionHandler {
	String day, fromTime, toTime, reason, sesUser, date1, fdate;

	int courseId;

	public void insertUserInformation(String staffid) {
		@SuppressWarnings("unused")
		java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat(
				"yyyy-MM-dd HH:mm:ss");
		@SuppressWarnings("unused")
		java.util.Date date = new java.util.Date();
		try {
			CallableStatement cs = con
					.prepareCall("{call ATT_PRO_PERMISSION(?,?,?,?,?,?,?,?,?,?)}");
			cs.setString(1, "INSERT");
			cs.setString(2, staffid);
			cs.setString(3, date1);
			cs.setString(4, fromTime);
			cs.setString(5, toTime);
			cs.setString(6, day);
			cs.setString(7, reason);
			String data[] = date1.split("-");
			String month = DateUtil.getMonth(Integer.parseInt(data[1]));
			cs.setString(8, month);
			cs.setInt(9, Integer.parseInt(data[0]));
			cs.setString(10, sesUser);
			cs.execute();
		} catch (Exception e) {
			 System.out.println(e.getMessage());
		}

	}

	private void PermissionDelete(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String[] EmpId = request.getParameterValues("OptPermissionName");

			CallableStatement cs = con
					.prepareCall("{call ATT_PRO_PERMISSION(?,?,?,?,?,?,?,?,?,?)}");
			for (int i = 0; i < EmpId.length; i++) {
				String emp[] = EmpId[i].split("@");
				cs.setString(1, "DELETE");
				cs.setString(2, emp[0]);
				cs.setString(3, emp[1]);
				cs.setString(4, "1");
				cs.setString(5, "1");
				cs.setString(6, "1");
				cs.setString(7, "1");
				cs.setString(8, "1");
				cs.setString(9, "1");
				cs.setString(10, "1");
				cs.addBatch();
			}
			cs.executeBatch();

		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void PermissionAdd(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			sesUser = (String) session.getAttribute("USRID");
			String staffname[] = request.getParameterValues("ename");
			day = request.getParameter("ComboDay");
			fromTime = request.getParameter("int");
			toTime = request.getParameter("out");
			reason = request.getParameter("reason");
			fdate = request.getParameter("fromdt");
			date1 = DateUtil.FormateDateSQL(fdate);

			for (int i = 0; i < staffname.length; i++) {
				insertUserInformation(staffname[i]);
			}

		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void PermissionView(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			sesUser = (String) session.getAttribute("USRID");
			String staffname[] = request.getParameterValues("ename");
			String fdate = request.getParameter("fromdt");
			String date1 = DateUtil.FormateDateSQL(fdate);

			ArrayList<Permission> permissionList = new ArrayList<Permission>();
			if (staffname == null) {
				String sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.DT_PDATE,B.DT_TIME_FROM,B.DT_TIME_TO,B.CHR_PTYPE FROM ";
				sql = sql
						+ "  com_m_staff  A,ATT_T_PERMISSION B WHERE A.CHR_EMPID=B.CHR_EMPID AND B.DT_PDATE>='"
						+ date1 + "'";

				Statement st = con.createStatement();
				ResultSet rs = st.executeQuery(sql);
				while (rs.next()) {
					Permission perm = new Permission();
					perm.setEmpId(rs.getString(1));
					perm.setEmpName(rs.getString(2));
					perm.setDate(rs.getString(3));
					perm.setFromTime(rs.getString(4));
					perm.setToTime(rs.getString(5));
					String ptype = rs.getString(6);
					if (ptype.equalsIgnoreCase("F")) {
						perm.setReason("Forenoon");
					} else {
						perm.setReason("Afternoon");
					}
					permissionList.add(perm);
				}
			} else

				for (int i = 0; i < staffname.length; i++) {
					String sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.DT_PDATE,B.DT_TIME_FROM,B.DT_TIME_TO,B.CHR_REASON FROM ";
					sql = sql
							+ "  com_m_staff  A,ATT_T_PERMISSION B WHERE A.CHR_EMPID=B.CHR_EMPID AND B.DT_PDATE>='"
							+ date1 + "' AND B.CHR_EMPID='" + staffname[i]
							+ "'";
					Statement st = con.createStatement();
					ResultSet rs = st.executeQuery(sql);
					while (rs.next()) {
						Permission perm = new Permission();
						perm.setEmpId(rs.getString(1));
						perm.setEmpName(rs.getString(2));
						perm.setDate(rs.getString(3));
						perm.setFromTime(rs.getString(4));
						perm.setToTime(rs.getString(5));
						perm.setReason(rs.getString(6));
						permissionList.add(perm);
					}

				}
			session.setAttribute("permissionList", permissionList);

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
			if (action.equals("ATTpermissionAdd") && act.equals("Submit")) {
				PermissionAdd(request, response);
				PermissionView(request, response);
				 
				response
						.sendRedirect("Smart Attendance/PermissionView.jsp?message=Successfuly Added");
			} else if (action.equals("ATTpermissionView")) {
				PermissionView(request, response);
				 
				response.sendRedirect("Smart Attendance/PermissionView.jsp");
			} else if (action.equals("ATTpermissionDelete")) {
				// //System.out.println("SDFDSF");
				PermissionDelete(request, response);
				 
				response
						.sendRedirect("Smart Attendance/Permission.jsp?message=Successfuly Deleted");
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
