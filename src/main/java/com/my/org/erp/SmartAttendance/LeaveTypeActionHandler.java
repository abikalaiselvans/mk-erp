package com.my.org.erp.SmartAttendance;

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

import com.my.org.erp.bean.Attendance.LeaveType;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class LeaveTypeActionHandler extends AbstractActionHandler {
	String TxtLeaveName, TxtLeaveType,Txtcheckbox,TxtLimit;
	int TxtID=0; 
	Statement st;

	int i = 0, k = 0;

	float leavevalue[] = new float[5];

	String leavename[] = new String[5];

	String day[] = new String[20];

	String empid[] = new String[20];

	private void LeaveTypeDelete(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String[] LeaveName = request.getParameterValues("leavename");
			for (int i = 0; i < LeaveName.length; i++) {
				String sql = "DELETE FROM ATT_M_LEAVETYPE WHERE CHR_LEAVENAME='"+LeaveName[i]+"'";
				Statement st = con.createStatement();
				st.execute(sql);
			}

		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void LeaveTypeAdd(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			@SuppressWarnings("unused")
			java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat(
					"yyyy-MM-dd HH:mm:ss");
			@SuppressWarnings("unused")
			java.util.Date date = new java.util.Date();
			String userId = (String) session.getAttribute("USRID");

			String sql="SELECT MAX(INT_LEAVEID) FROM att_m_leavetype";
			String max[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			
			if (max.length>0){
				if (max[0][0].equals(null) || max[0][0].equals(""))
					TxtID=0;
				else
					TxtID=Integer.parseInt(max[0][0])+1;
			}

			
			TxtLeaveName = request.getParameter("TxtLeaveName");
			TxtLeaveType = request.getParameter("TxtLeaveType");
			Txtcheckbox=request.getParameter("Txtcheckbox");
			TxtLimit=request.getParameter("TxtLimit");
			if (TxtLimit.equals(null) ||TxtLimit.equals(""))
				TxtLimit="0";
			
			if("on".equals(Txtcheckbox))
				Txtcheckbox="Y";
			else
				Txtcheckbox="N";

			sql ="INSERT INTO ATT_M_LEAVETYPE (INT_LEAVEID,CHR_LEAVENAME,CHR_SYMBOL,CHR_CARRY,INT_LIMIT,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES(";
			sql = sql + TxtID +", ";
			sql = sql+" '"+TxtLeaveName+"', ";
			sql = sql+" '"+TxtLeaveType+"', ";
			sql = sql+" '"+Txtcheckbox+"', ";
			sql = sql+ TxtLimit+", ";
			sql = sql+" '"+userId+"', ";
			sql = sql+" now(), ";
			sql = sql+" 'Y')";


			st = con.createStatement();
			st.execute(sql);
			
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void LeaveMasterAdd(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			HttpSession session = request.getSession();
			java.text.SimpleDateFormat datetime = new java.text.SimpleDateFormat(
					"yyyy-MM-dd HH:mm:ss");
			java.util.Date date = new java.util.Date();
			String userId = (String) session.getAttribute("USRID");
			Statement st = con.createStatement();
			String sql = "select * from att_m_leavetype";
			ResultSet rs = st.executeQuery(sql);
			//System.out.println("HI WELCOME");
			i = 0;
			while (rs.next()) {
				leavename[i] = rs.getString("chr_LEAVENAME");
				//System.out.println(request.getParameter(leavename[i]));
				String value = "" + request.getParameter(leavename[i]);
				if (value.equals(""))
					value = "0";
				leavevalue[i] = Float.parseFloat(value);
				// out.println(leavename[i]);
				// out.println(request.getParameter(leavename[i]));
				i++;
			}
			rs.close();
			String sqlDel = "DELETE FROM ATT_M_LEAVE WHERE CHR_EMPID=? AND INT_YEAR=?";
			String empid[] = request.getParameterValues("ename");
			int year = Integer.parseInt(request.getParameter("Year"));
			//System.out.println("Leave NAme Length :" + leavename.length);
			//System.out.println("Leave 4:" + empid[0]);
			for (int j = 0; j < empid.length; j++) {
				PreparedStatement ptsm = null;
				ptsm = con.prepareStatement(sqlDel);
				ptsm.setString(1, empid[j]);
				ptsm.setInt(2, year);
				ptsm.execute();
				sql = "INSERT INTO ATT_M_LEAVE(CHR_EMPID,CHR_LEAVE1,INT_NOD1,INT_NOD1BALANCE,CHR_LEAVE2,INT_NOD2,INT_NOD2BALANCE,CHR_LEAVE3,INT_NOD3,INT_NOD3BALANCE,CHR_LEAVE4,INT_NOD4,INT_NOD4BALANCE,CHR_LEAVE5,INT_NOD5,INT_NOD5BALANCE,INT_YEAR,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				ptsm = con.prepareStatement(sql);
				ptsm.setString(1, empid[j]);
				// //System.out.println("EMP ID :"+empid[j]);
				k = 2;
				for (i = 0; i < 5; i++) {
					// //System.out.println(leavename[i]);
					if (leavename[i] != null) { // 234 567 8910
						ptsm.setString(k, leavename[i]);
						// //System.out.println(leavevalue[i]);
						ptsm.setFloat(k + 1, leavevalue[i]);
						ptsm.setFloat(k + 2, leavevalue[i]);
					} else {
						ptsm.setString(k, "");
						ptsm.setString(k + 1, "0");
						ptsm.setString(k + 2, "0");
					}
					k = k + 3;
				}
				ptsm.setInt(17, year);
				ptsm.setString(18, userId);
				ptsm.setString(19, datetime.format(date));
				ptsm.setString(20, "Y");
				ptsm.execute();
				ptsm.close();
				// //System.out.println("HI Final");
			}
		}

		catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void LeaveTypeView(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			ArrayList<LeaveType> leaveList = new ArrayList<LeaveType>();
			String sql = "SELECT CHR_LEAVENAME,CHR_SYMBOL FROM ATT_M_LEAVETYPE";
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(sql);
			while (rs.next()) {
				LeaveType leaveType = new LeaveType();
				leaveType.setLeaveCode(rs.getString(2));
				leaveType.setLeaveName(rs.getString(1));
				leaveList.add(leaveType);
			}
			HttpSession session = request.getSession();
			session.setAttribute("leaveType", leaveList);
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String action = request.getParameter("actionS");
			if (action.equals("ATTleaveType")) {
				LeaveTypeView(request, response);
				con.close();    
				response.sendRedirect("Smart Attendance/Leave MasterView.jsp");
			} else if (action.equals("ATTleaveTypeadd")) {
				LeaveTypeAdd(request, response);
				LeaveTypeView(request, response);
				con.close();    
				response
						.sendRedirect("Smart Attendance/LeaveType.jsp?message=Successfully Added");
			} else if (action.equals("ATTleaveTypedelete")) {
				LeaveTypeDelete(request, response);
				LeaveTypeView(request, response);
				con.close();    
				response
						.sendRedirect("Smart Attendance/LeaveType.jsp?message=Successfully Deleted");
			} else if (action.equals("ATTleaveMasteradd")) {
				LeaveMasterAdd(request, response);
				LeaveTypeView(request, response);
				con.close();    
				response
						.sendRedirect("Smart Attendance/Leave MasterView.jsp?message=Successfully Added");
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
