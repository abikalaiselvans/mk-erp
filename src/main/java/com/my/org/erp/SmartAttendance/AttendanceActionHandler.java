package com.my.org.erp.SmartAttendance;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Calendar;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class AttendanceActionHandler extends AbstractActionHandler {
	String courseName;
	int courseId;
	Statement st;
	ResultSet rs;
	ResultSet rsemp;
	String sql;
	String fline = "";
	String empid;
	String empname;
	int rcount = 0;
	String erro = "";
	Calendar calDate1 = Calendar.getInstance();
	Calendar calDate2 = Calendar.getInstance();
	HttpSession seesion=null;
	String sesUserId=null;
	String compId,branchId;
	String compName,branchName;
	private void attDepartCalculation(String deptid, String fdate,
			String tdate, String repName, String repHeader,
			String sqlIdCollection) {
		try {
			String sqlFDate=DateUtil.FormateDateSQL(fdate);
			String sqlTDate=DateUtil.FormateDateSQL(tdate);	
			
			sql = sqlIdCollection;
			st = con.createStatement();
			rs = st.executeQuery(sql);
			empid = "";
			empname = "";
			String dbEmpId = "";
			String dbEmpName = "";
			while (rs.next()) {
				dbEmpId = rs.getString(1);
				dbEmpName = rs.getString(2);
				if (!dbEmpId.equals(""))
					empid = empid + dbEmpId + ",";
				if (!dbEmpName.equals(""))
					empname = empname + dbEmpName + ",";
			}
			//System.out.println(empid);

			String userid[] = empid.split(",");
			String username[] = empname.split(",");
			fline = "";
			fline = fline + repName + "\n";
			fline = fline + repHeader + "\n";
			rcount = 0;
			erro = "";
			for (int i = 0; i < userid.length; i++) {
				sqlFDate=DateUtil.FormateDateSQL(fdate);
				while (true) {				

					sql = "SELECT A.CHR_EMPID,D.CHR_STAFFNAME,C.CHR_DEPARTNAME,B.CHR_DESIGNAME,A.DT_LOGIN,A.DT_TIMEIN,A.DT_TIMEOUT,A.DT_LOGOUT";
					sql = sql
							+ " FROM ATT_SMART_ATTENDANCE A , com_m_desig  B ,  com_m_depart   C, com_m_staff  D";
					sql = sql + " WHERE A.DT_LOGIN >='" + sqlFDate + "'";
					sql = sql + " AND A.DT_LOGOUT <='" + sqlFDate + "'";
					sql = sql + " AND A.CHR_EMPID='" + userid[i] + "' ";
					sql = sql + " AND A.CHR_EMPID=D.CHR_EMPID";
					sql = sql + " AND D.INT_DEPARTID  = C.INT_DEPARTID";
					sql = sql + " AND D.INT_DESIGID=B.INT_DESIGID ";
					//System.out.println("IN SIDE: "+sql);
					rs = st.executeQuery(sql);
					if (rs.next()) {
						fline = fline + userid[i] + "^";
						fline = fline + username[i] + "^";
						fline = fline + " " + rs.getString("CHR_DEPARTNAME")
								+ "^";
						fline = fline + " " + rs.getString("CHR_DESIGNAME")
								+ "^";
						fline = fline + " " + rs.getString("DT_LOGIN") + "^";
						fline = fline + " " + rs.getString("DT_TIMEIN") + "^";
						String outtime = rs.getString("DT_TIMEOUT") + "^";
						while (rs.next()) {
							if (rs.getString(4) != null)
								outtime = rs.getString(3);
						}
						fline = fline + "  " + outtime + "^";
						fline = fline + " " + "\n";
					}
					if(sqlFDate.equalsIgnoreCase(sqlTDate)) break;
					sqlFDate=DateUtil.addDate(sqlFDate, 1);
				}
				rcount = rcount + 1;
			}
			if (rcount <= 1)
				fline = fline + "Record not found...^\n";
			String filename = "Report.sys";
			FileWriter fw = new FileWriter(filename);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write(fline);
			bw.close();
		} catch (Exception e) {
			//System.out.println("ERROR ::" + e.getMessage());
		}
	}

	private void attIndidualCalculation(String empid, String month,
			String year, String repName, String repHeader) {
		try {
			st = con.createStatement();
			sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,D.CHR_DEPARTNAME,C.CHR_DESIGNAME,B.DT_LOGIN,B.DT_TIMEIN,B.DT_TIMEOUT,B.CHR_PRESENTTYPE";
			sql = sql
					+ " FROM  com_m_staff  A,ATT_SMART_ATTENDANCE B,  com_m_desig  C ,  com_m_depart   D";
			sql = sql + " WHERE B.CHR_LOGMONTH='" + month + "'";
			sql = sql + " AND B.INT_LOGYEAR=" + Integer.parseInt(year);
			sql = sql + " AND A.CHR_EMPID=B.CHR_EMPID";
			sql = sql + " AND A.CHR_EMPID='" + empid + "'";
			sql = sql + " AND A.INT_DEPARTID  = D.INT_DEPARTID";
			sql = sql + " AND A.INT_DESIGID=C.INT_DESIGID ";
			//System.out.println("SQL :"+sql);
			rs = st.executeQuery(sql);
			fline = "";
			fline = fline + repName + "\n";
			fline = fline + repHeader + "\n";
			rcount = 0;
			while (rs.next()) {
				fline = fline + " " + rs.getString(1) + "^";
				fline = fline + " " + rs.getString(2) + "^";
				fline = fline + " " + rs.getString(3) + "^";
				fline = fline + " " + rs.getString(4) + "^";
				fline = fline + " " + rs.getString(5) + "^";
				fline = fline + " " + rs.getString(6) + "^";
				String outtime = "" + rs.getString(7);
				if (outtime.equals("null"))
					outtime = "--";
				fline = fline + " " + outtime + "\n";
				rcount = rcount + 1;
			}

			if (rcount < 1)
				fline = fline + "Record not found...^\n";
			String filename = "Report.sys";
			FileWriter fw = new FileWriter(filename);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write(fline);
			bw.close();

		} catch (Exception e) {
			//System.out.println("ERROR ::" + e.getMessage());
		}
	}
	private void attCalculationSheet(String empid, String month,
			String year, String repName, String repHeader) {
		try {
			st = con.createStatement();
			sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,D.CHR_DEPARTNAME,C.CHR_DESIGNAME,B.DT_LOGIN,B.DT_TIMEIN,";
			sql=sql+" B.DT_MOR_TEAOUT,B.DT_MOR_TEAIN,B.DT_LUNCHOUT,B.DT_LUNCHIN,B.DT_EVE_TEAOUT,";
			sql=sql+" B.DT_EVE_TEAIN,B.DT_TIMEOUT,B.CHR_LATE";
			sql = sql+ " FROM  com_m_staff  A,att_smart_attendance_rex B,  com_m_desig  C ,  com_m_depart   D";
			sql = sql + " WHERE B.CHR_LOGMONTH='" + month + "'";
			sql = sql + " AND B.INT_LOGYEAR=" + Integer.parseInt(year);
			sql = sql + " AND A.CHR_EMPID=B.CHR_EMPID";
			sql = sql + " AND A.CHR_EMPID='" + empid + "'";
			sql = sql + " AND A.INT_DEPARTID  = D.INT_DEPARTID";
			sql = sql + " AND A.INT_DESIGID=C.INT_DESIGID ";	
			sql=sql+" AND INT_COMPANYID="+compId;
			if(!branchId.equals("-1"))
				sql=sql+" AND A.INT_BRANCHID="+branchId;
			rs = st.executeQuery(sql);
			fline = "";
			fline = fline + repName + "\n";
			fline = fline + repHeader + "\n";
			rcount = 0;
			while (rs.next()) {
				fline = fline + " " + rs.getString(1) + "^"; //EMPID
				fline = fline + " " + rs.getString(2) + "^"; 
			//	fline = fline + " " + rs.getString(3) + "^"; //DEP
			//	fline = fline + " " + rs.getString(4) + "^"; //DES
				fline = fline + " " + rs.getString(5) + "^"; //LOGIN DATE
				fline = fline + " " + rs.getString(6) + "^"; //LOGIN TIME
				fline = fline + " " + rs.getString(7) + "^"; //MOR TEA OUT
				fline = fline + " " + rs.getString(8) + "^"; //MOR TEA IN
				fline = fline + " " + rs.getString(9) + "^"; //LUNCH OUT
				fline = fline + " " + rs.getString(10) + "^"; //LUNCH IN
				fline = fline + " " + rs.getString(11) + "^"; //EVE TEA OUT
				fline = fline + " " + rs.getString(12) + "^"; //EVE TEA IN				
				String outtime = "" + rs.getString(13);
				if (outtime.equals("null"))	outtime = "--";
				fline = fline + " " + outtime + "^"; //EVE TEA IN
				outtime = "" + rs.getString(14);
				if (outtime.equals("null")) outtime = "--";
				fline = fline + " " + outtime + "\n";
				rcount = rcount + 1;
			}
			if (rcount < 1)
				fline = fline + "Record not found...^\n";
			String filename = "Report.sys";
			FileWriter fw = new FileWriter(filename);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write(fline);
			bw.close();
		} catch (Exception e) {
			//System.out.println("ERROR ::" + e.getMessage());
		}
	}
	private void attCalculation(String fdate, String tdate, String repName,
			String repHeader) {
		try {
			String sqlFDate=DateUtil.FormateDateSQL(fdate);
			String sqlTDate=DateUtil.FormateDateSQL(tdate);
			st = con.createStatement();
			sql = "SELECT DISTINCT A.CHR_EMPID,A.CHR_STAFFNAME FROM  com_m_staff  A,att_smart_attendance B ";
			sql = sql + " WHERE A.CHR_EMPID=B.CHR_EMPID AND B.DT_LOGIN>='"+sqlFDate+"' AND B.DT_LOGIN<='"+sqlTDate+"'";
			sql=sql+" AND INT_COMPANYID="+compId;
			if(!branchId.equals("-1"))
				sql=sql+" AND A.INT_BRANCHID="+branchId;
			sql=sql+" ORDER BY A.CHR_EMPID";			
			st = con.createStatement();
			//System.out.println("SQL ::::sss:: "+sql);
			rs = st.executeQuery(sql);
			empid = "";
			empname = "";
			while (rs.next()) {
				if (!empid.equalsIgnoreCase("")) {
					empid = empid + ",";
					empname = empname + ",";
				}
				empid = empid + rs.getString(1);
				empname = empname + rs.getString(2);
			}
			String userid[] = empid.split(",");
			String username[] = empname.split(",");
			fline = "";
			fline = fline + repName + "\n";
			fline = fline + repHeader + "\n";
			rcount = 0;
			for (int i = 0; i < userid.length; i++) {
				sqlFDate=DateUtil.FormateDateSQL(fdate);
				while (true) {
					sql = " SELECT A.CHR_EMPID,C.CHR_DEPARTNAME,D.CHR_DESIGNAME,A.DT_TIMEIN,A.DT_TIMEOUT,A.DT_LOGIN,A.DT_LOGOUT";
					sql = sql
							+ " FROM ATT_SMART_ATTENDANCE A ,  com_m_staff  B ,  com_m_depart   C , com_m_desig  D";
					sql = sql + " WHERE A.DT_LOGIN='" + sqlFDate + "'";
					sql = sql + " AND A.CHR_EMPID='" + userid[i] + "'";
					sql = sql + " AND A.CHR_EMPID=B.CHR_EMPID  ";
					sql = sql + " AND B.INT_DEPARTID  = C.INT_DEPARTID";
					sql = sql + " AND B.INT_DESIGID=D.INT_DESIGID  ";
					////System.out.println("SQL :::::: "+sql);
					rs = st.executeQuery(sql);
					if (rs.next()) {
						fline = fline + " " + userid[i] + "^";
						fline = fline + " " + username[i] + "^";
						fline = fline + " " + rs.getString(2) + "^";
						fline = fline + " " + rs.getString(3) + "^";
						fline = fline + " " + rs.getString(6) + "^";
						fline = fline + " " + rs.getString(4) + "^";
						String outtime = "--";// +rs.getString(6);
						if (rs.getString(7) != null)
							outtime = rs.getString(5);
						while (rs.next()) {
							if (rs.getString(7) != null)
								outtime = rs.getString(5);
						}
						fline = fline + " " + outtime + "^";
						fline = fline + " " + "\n";
					}
					if(sqlFDate.equalsIgnoreCase(sqlTDate)) break;
					sqlFDate=DateUtil.addDate(sqlFDate, 1);
				}
				rcount = rcount + 1;
			}			
			if (rcount < 1)
				fline = fline + "Record not found...^\n";
			String filename = "Report.sys";
			FileWriter fw = new FileWriter(filename);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write(fline);
			bw.close();

		} catch (Exception e) {
			//System.out.println(e);
			 System.out.println(e.getMessage());
		}
	}
	private void attCalculationStaff(String fdate, String tdate, String repName,
			String repHeader) {
		try {
			String sqlFDate=DateUtil.FormateDateSQL(fdate);
			String sqlTDate=DateUtil.FormateDateSQL(tdate);					
			
			sql = "SELECT * FROM M_USER WHERE CHR_USRNAME = '"+sesUserId+"'";
			String staff  = com.my.org.erp.bean.Attendance.StaffRegistration.getAnyValue2(sql,"CHR_USRDES");
			
			st = con.createStatement();
			sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME FROM  com_m_staff  A,att_smart_attendance B ";
			sql = sql + " WHERE A.CHR_EMPID=B.CHR_EMPID AND B.DT_LOGIN>='"+sqlFDate+"' AND B.DT_LOGIN<='"+sqlTDate+"'";
			sql=sql+ " AND A.CHR_EMPID='"+staff+"'";
			sql=sql+" ORDER BY A.CHR_EMPID";		
			st = con.createStatement();
			rs = st.executeQuery(sql);
			empid = "";
			empname = "";
			while (rs.next()) {
				if (!empid.equalsIgnoreCase("")) {
					empid = empid + ",";
					empname = empname + ",";
				}
				empid = empid + rs.getString(1);
				empname = empname + rs.getString(2);
			}
			String userid[] = empid.split(",");
			String username[] = empname.split(",");
			fline = "";
			fline = fline + repName + "\n";
			fline = fline + repHeader + "\n";
			rcount = 0;
			for (int i = 0; i < userid.length; i++) {
				sqlFDate=DateUtil.FormateDateSQL(fdate);
				while (true) {
					sql = " SELECT A.CHR_EMPID,C.CHR_DEPARTNAME,D.CHR_DESIGNAME,A.DT_TIMEIN,A.DT_TIMEOUT,A.DT_LOGIN,A.DT_LOGOUT";
					sql = sql
							+ " FROM ATT_SMART_ATTENDANCE A ,  com_m_staff  B ,  com_m_depart   C , com_m_desig  D";
					sql = sql + " WHERE A.DT_LOGIN='" + sqlFDate + "'";
					sql = sql + " AND A.CHR_EMPID='" + userid[i] + "'";
					sql = sql + " AND A.CHR_EMPID=B.CHR_EMPID  ";
					sql = sql + " AND B.INT_DEPARTID  = C.INT_DEPARTID";
					sql = sql + " AND B.INT_DESIGID=D.INT_DESIGID  ";					
					rs = st.executeQuery(sql);
					if (rs.next()) {
						fline = fline + " " + userid[i] + "^";
						fline = fline + " " + username[i] + "^";
						fline = fline + " " + rs.getString(2) + "^";
						fline = fline + " " + rs.getString(3) + "^";
						fline = fline + " " + rs.getString(6) + "^";
						fline = fline + " " + rs.getString(4) + "^";
						String outtime = "--";// +rs.getString(6);
						if (rs.getString(7) != null)
							outtime = rs.getString(5);
						while (rs.next()) {
							if (rs.getString(7) != null)
								outtime = rs.getString(5);
						}
						fline = fline + " " + outtime + "^";
						fline = fline + " " + "\n";
					}
					if(sqlFDate.equalsIgnoreCase(sqlTDate)) break;
					sqlFDate=DateUtil.addDate(sqlFDate, 1);
				}
				rcount = rcount + 1;
			}			
			if (rcount < 1)
				fline = fline + "Record not found...^\n";
			String filename = "Report.sys";
			FileWriter fw = new FileWriter(filename);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write(fline);
			bw.close();

		} catch (Exception e) {
			//System.out.println(e);
			 System.out.println(e.getMessage());
		}
	}
	private void attIndidual(String id[], String fdate, String tdate,
			String repName, String repHeader) {
		try {
			int i = 0;
			st = con.createStatement();
			fline = "";
			fline = fline + repName + "\n";
			fline = fline + repHeader + "\n";
			for (int j = 0; j < id.length; j++) {
				sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,D.CHR_DEPARTNAME,C.CHR_DESIGNAME,B.DT_LOGIN,B.DT_TIMEIN,B.DT_TIMEOUT,B.CHR_PRESENTTYPE";
				sql = sql
						+ " FROM  com_m_staff  A,ATT_SMART_ATTENDANCE B,  com_m_desig  C ,  com_m_depart   D";
				sql = sql + " WHERE B.DT_LOGIN >='" + fdate + "'";
				sql = sql + " AND B.DT_LOGIN <='" + tdate + "' ";
				sql = sql + " AND B.CHR_EMPID='" + id[j] + "'";
				sql = sql + " AND A.CHR_EMPID=B.CHR_EMPID";
				sql = sql + " AND A.INT_DEPARTID  = D.INT_DEPARTID";
				sql = sql + " AND A.INT_DESIGID=C.INT_DESIGID ";
				rs = st.executeQuery(sql);
				while (rs.next()) {
					fline = fline + " " + rs.getString(1) + "^";
					fline = fline + " " + rs.getString(2) + "^";
					fline = fline + " " + rs.getString(3) + "^";
					fline = fline + " " + rs.getString(4) + "^";
					fline = fline + " " + rs.getString(5) + "^";
					fline = fline + " " + rs.getString(6) + "^";
					String outtime = "" + rs.getString(7);
					if (outtime.equals("null"))
						outtime = "--";
					fline = fline + " " + outtime + "\n";
					i = i + 1;
				}
			}
			if (i < 1)
				fline = fline + "Record not found...^\n";
			String filename = "Report.sys";
			FileWriter fw = new FileWriter(filename);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write("");
			bw.write(fline);
			bw.close();			
		} catch (Exception e) {
		}

	}

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			seesion=request.getSession();
			sesUserId=""+seesion.getAttribute("USRID");
			String action = request.getParameter("actionS");
			//System.out.println("NEW ATTENDANCE ::"+ action);

			String filename = "Report.sys";
			FileWriter fw = new FileWriter(filename);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write("");
			bw.close();
			compId= ""+request.getParameter("company");
			branchId= ""+request.getParameter("branch");
			compName= com.my.org.erp.common.CommonInfo.stringGetAnySelectField("Select CHR_COMPANYNAME from  com_m_company  where INT_COMPANYID="+compId, "CHR_COMPANYNAME");
			sql="Select CHR_BRANCHNAME from  com_m_branch  where INT_BRANCHID="+branchId;
			//System.out.println("SQL :"+sql);
			String repName = "Company : "+compName;
			if(!branchId.equals("-1")){
				branchName=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql,"CHR_BRANCHNAME");
				repName=repName+ " ~ Branch : "+branchName;
			}
			else				
				repName=repName+ " ~ Branch : All ";
			
			repName=repName+ " ~ Attendance Details";
			branchName= request.getParameter("branch");
			if (action.equals("ATTAttendanceDateList")) {
				String fdate = request.getParameter("fromdt");
				String tdate = request.getParameter("todt");				
				repName = repName + " (  FROM : " + fdate.toUpperCase();
				repName = repName + " To : " + tdate.toUpperCase() + " )";
				String repHeader = "Emp Id^Name^Department^Designation^Login Date ^Time In^Time Out^Remarks";
				attCalculation(fdate, tdate, repName, repHeader);
				response.sendRedirect("Smart Attendance/ReportViewAtten.jsp");
			}else if (action.equals("ATTStaffAttDateList")) {
				String fdate = request.getParameter("fromdt");
				String tdate = request.getParameter("todt");				
				repName = repName + " (  FROM : " + fdate.toUpperCase();
				repName = repName + " To : " + tdate.toUpperCase() + " )";
				String repHeader = "Emp Id^Name^Department^Designation^Login Date ^Time In^Time Out^Remarks";
				attCalculationStaff(fdate, tdate, repName, repHeader);
				response.sendRedirect("Smart Attendance/ReportViewStaff.jsp");
			} 
			else if (action.equals("ATTAttendanceStaffMonth")) {
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				//System.out.println("MONTH :"+month);
				
				String fdate = "01-" + month + "-" + year;
				int tot = DateUtil.totalDays(Integer.parseInt(month), Integer.parseInt(year));
				String tdate = tot + "-" + month + "-" + year;				
				repName = repName + " (  FROM : " + fdate.toUpperCase();
				repName = repName + " To : " + tdate.toUpperCase() + " )";
				String repHeader = "Emp Id^Name^Department^Designation^Login Date ^Time In^Time Out^Remarks";
				attCalculationStaff(fdate, tdate, repName, repHeader);
				response.sendRedirect("Smart Attendance/ReportViewStaff.jsp");
			}
			else if (action.equals("ATTAttendanceMonthList")) {
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				//System.out.println("MONTH :"+month);
				String fdate = "01-" + month + "-" + year;
				int tot = DateUtil.totalDays(Integer.parseInt(month), Integer
						.parseInt(year));
				String tdate = tot + "-" + month + "-" + year;				
				repName = repName + " (  FROM : " + fdate.toUpperCase();
				repName = repName + " To : " + tdate.toUpperCase() + " )";
				String repHeader = "Emp Id^Name^Department^Designation^Login Date ^Time In^Time Out^Remarks";
				//System.out.println("kalai");
				attCalculation(fdate, tdate, repName, repHeader);
				response.sendRedirect("Smart Attendance/ReportViewAtten.jsp");
			} else if (action.equals("ATTAttendanceMonthList")) {
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				//System.out.println("MONTH :"+month);
				String fdate = "01-" + month + "-" + year;
				int tot = DateUtil.totalDays(Integer.parseInt(month), Integer
						.parseInt(year));
				String tdate = tot + "-" + month + "-" + year;				
				repName = repName + " (  FROM : " + fdate.toUpperCase();
				repName = repName + " To : " + tdate.toUpperCase() + " )";
				String repHeader = "Emp Id^Name^Department^Designation^Login Date ^Time In^Time Out^Remarks";
				attCalculation(fdate, tdate, repName, repHeader);
				response.sendRedirect("Smart Attendance/ReportViewAtten.jsp");
			} else if (action.equals("ATTAttendanceIndidualList")) {
				String cat = request.getParameter("Report");
				if (cat.equalsIgnoreCase("Month")) {
					String empid = request.getParameter("ename");
					String month = request.getParameter("Month");
					String year = request.getParameter("Year");					
					String repHeader = "Emp Id^Name^Department^Designation^Login Date ^Time In^Time Out^Remarks";
					attIndidualCalculation(empid, month, year, repName,	repHeader);					
					response.sendRedirect("Smart Attendance/ReportViewAtten.jsp");
				}
				if (cat.equalsIgnoreCase("Date")) {
					String empid[] = request.getParameterValues("ename");
					//System.out.println(empid);
					String fdate = request.getParameter("fromdt");
					String tdate = request.getParameter("todt");
					String fdt[] = fdate.split("-");
					String tdt[] = tdate.split("-");
					fdate = fdt[2] + "-" + fdt[1] + "-" + fdt[0];
					tdate = tdt[2] + "-" + tdt[1] + "-" + tdt[0];					
					repName = repName + "( From : " + fdate + "  To : " + tdate	+ " )";
					String repHeader = "Emp Id^Name^Department^Designation^Login Date ^Time In^Time Out^Remarks";
					attIndidual(empid, fdate, tdate, repName, repHeader);
					response.sendRedirect("Smart Attendance/ReportViewAtten.jsp");
				}
			}else if (action.equals("ATTAttendanceSheet"))
			{

				String cat = request.getParameter("Report");
				if (cat.equalsIgnoreCase("Month")) {
					String empid = request.getParameter("ename");
					String month = request.getParameter("Month");
					String year = request.getParameter("Year");				
					String repHeader = "Emp Id^Name^Department^Designation^Login Date ^Time In^MorTeaOut^MorTeaIn^LunchOut^LunchIn^EveTeaOut^EveTeaIn^Time Out^Remarks";
					attCalculationSheet(empid, month, year, repName,repHeader);
					response.sendRedirect("Smart Attendance/ReportViewAttenSheet.jsp");
				}

				if (cat.equalsIgnoreCase("Date")) {
					String empid[] = request.getParameterValues("ename");
					//System.out.println(empid);
					String fdate = request.getParameter("fromdt");
					String tdate = request.getParameter("todt");
					String fdt[] = fdate.split("-");
					String tdt[] = tdate.split("-");
					fdate = fdt[2] + "-" + fdt[1] + "-" + fdt[0];
					tdate = tdt[2] + "-" + tdt[1] + "-" + tdt[0];
					repName = repName + "( From : " + fdate + "  To : " + tdate
							+ " )";
					String repHeader = "Emp Id^Name^Department^Designation^Login Date ^Time In^Time Out^Remarks";
					attIndidual(empid, fdate, tdate, repName, repHeader);
					response.sendRedirect("Smart Attendance/ReportViewAtten.jsp");
				}
			}  
			else if (action.equals("ATTADesignationList")) {
				String desid = request.getParameter("Designation");
				String month = request.getParameter("Month");
				String year = request.getParameter("Year");
				String fdate = "01-" + month + "-" + year;
				int tot = DateUtil.totalDays(Integer.parseInt(month), Integer
						.parseInt(year));
				String tdate = tot + "-" + month + "-" + year;						
				String repHeader = "Emp Id^Name^Department^Designation^Login Date ^Time In^Time Out^Remarks";
				// attDesignCalculation(desid,fdate,tdate,repName,repHeader);
				String sqlIdCollection = "SELECT CHR_EMPID,CHR_STAFFNAME ";
				sqlIdCollection = sqlIdCollection + " FROM  com_m_staff  ";
				sqlIdCollection = sqlIdCollection + " WHERE INT_DESIGID=" + Integer.parseInt(desid);
				
				sqlIdCollection = sqlIdCollection + " ORDER BY CHR_EMPID";
				//System.out.println("SQL COL"+sqlIdCollection);
				attDepartCalculation(desid, fdate, tdate, repName, repHeader,
						sqlIdCollection);
				
				response.sendRedirect("Smart Attendance/ReportViewAtten.jsp");
			} else if (action.equals("ATTAttendanceDepartmentList")) {
				String deptid = request.getParameter("Department");
				String month = request.getParameter("Month");
				String year = request.getParameter("Year");
				String fdate = "01-" + month + "-" + year;
				int tot = DateUtil.totalDays(Integer.parseInt(month), Integer
						.parseInt(year));
				String tdate = tot + "-" + month + "-" + year;	
				String repHeader = "Emp Id^Name^Department^Designation^Login Date ^Time In^Time Out^Remarks";
				String sqlIdCollection = "SELECT CHR_EMPID,CHR_STAFFNAME ";
				sqlIdCollection = sqlIdCollection + " FROM  com_m_staff  ";
				sqlIdCollection = sqlIdCollection + " WHERE INT_DEPARTID="
						+ Integer.parseInt(deptid);
				sqlIdCollection = sqlIdCollection + " ORDER BY CHR_EMPID";
				//System.out.println("SQL COL"+sqlIdCollection);
				attDepartCalculation(deptid, fdate, tdate, repName, repHeader,
						sqlIdCollection);
				response.sendRedirect("Smart Attendance/ReportViewAtten.jsp");
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
