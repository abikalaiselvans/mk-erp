package com.my.org.erp.SmartAttendance;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DBConnection.DBCon;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;


public class MusterMonthActionHandler extends AbstractActionHandler {

	String repName = null;
	String repHeader = null;
	int totDays = 0;
	String compId,branchId;
	String compName,branchName;


	private static String MusterMonthReport(String psql, int totColumn) {
		String fline = "";
		try {
			Connection co = null;
			String sql = psql;
			DBCon con = new DBCon();
			co = con.getConnection();
			Statement st = co.createStatement();
			ResultSet rs;
			rs = st.executeQuery(sql);
			int i = 0;
			fline = "";
			while (rs.next()) {

				fline = fline + "  " + rs.getString("CHR_EMPID") + "^";
				fline = fline + "  " + rs.getString("CHR_STAFFNAME") + "^";
				fline = fline + "  " + rs.getString("DOU_PRESENT") + "^";
				fline = fline + "  " + rs.getString("DOU_ABSENT") + "^";
				fline = fline + "  " + rs.getString("DOU_LEAVE") + "^";
				fline = fline + "  " + rs.getString("DOU_OD") + "^";
				fline = fline + "  " + rs.getString("INT_LATE") + "^";
				for (int j = 1; j <= totColumn; j++)
					fline = fline + "  " + rs.getString("LOGDATE" + j) + "^";
				fline = fline + "\n";
				i = i + 1;
			}
			rs.close();
			if (i < 1)
				fline = fline + "Record not found...^\n";
			 

		} catch (Exception e) {

		}
		return fline;
	}

	private void MusterRollView(HttpServletRequest request,HttpServletResponse response, int cat) throws ServletException,
			IOException {
		try {
			if (cat == 1)
				repName =repName+" Muster Roll ( Designation Wise)";
			else
				repName =repName+" Muster Roll";

			if (cat == 0)
				repName =repName+" Muster Roll ( Department Wise)";
			else
				repName =repName+" Muster Roll";

			repHeader = "Emp Id^Name^";
			for (int i = 1; i <= totDays; i++) {
				repHeader = repHeader + i + "^";
			}
			repHeader = repHeader + "Present^Absent^Leave^OD^Late";

		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String action = request.getParameter("actionS");
			action = action.trim();
			String deptid = "";
			String month = "";
			String year = "";
			String filename = "Report.sys";
			FileWriter fw = new FileWriter(filename);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write("");
			bw.close();
			String sql = "";
			compId= request.getParameter("company");
			branchId= request.getParameter("branch");
			compName= com.my.org.erp.common.CommonInfo.stringGetAnySelectField("Select CHR_COMPANYNAME from  com_m_company  where INT_COMPANYID="+compId, "CHR_COMPANYNAME");
			sql="Select CHR_BRANCHNAME from  com_m_branch  where INT_BRANCHID="+branchId;
			//System.out.println("SQL :"+sql);
			repName = "Company : "+compName;
			if(!branchId.equals("-1"))
			{
				branchName=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql,"CHR_BRANCHNAME");
				repName=repName+ " ~ Branch : "+branchName;
			}
			else				
				repName=repName+ " ~ Branch : All ";


			if (action.equals("ATTMUSTERMONTHDESIG")) {
				deptid = request.getParameter("Designation");
				String mon = request.getParameter("Month");
				year = request.getParameter("Year");
				month = com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(mon));
				totDays = com.my.org.erp.ServiceLogin.DateUtil.totalDays(Integer.parseInt(mon), Integer.parseInt(year));
				MusterRollView(request, response, 1);
				sql = "SELECT A.*, B.CHR_STAFFNAME";
				sql = sql + " FROM ATT_T_ATTENDANCEDETAIL A,  com_m_staff  B";
				sql = sql + " WHERE A.CHR_EMPID=B.CHR_EMPID ";
				sql = sql + "  AND B.INT_DESIGID = " + Integer.parseInt(deptid);
				sql = sql + " AND A.LOGMONTH = '" + month + "' ";
				sql = sql + " AND A.LOGYEAR = " + Integer.parseInt(year);
				@SuppressWarnings("unused")
				String fline = MusterMonthReport(sql, totDays);
				//WriteContents.writeFiles(fline, repName, repHeader);
				 
				response.sendRedirect("Smart Attendance/ReportViewMuster.jsp");
			} else if (action.equals("ATTMUSTERMONTHDEPT")) {
				deptid = request.getParameter("Department");
				String mon = request.getParameter("Month");
				year = request.getParameter("Year");
				month = com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(mon));
				totDays = com.my.org.erp.ServiceLogin.DateUtil.totalDays(Integer.parseInt(mon), Integer.parseInt(year));
				MusterRollView(request, response, 0);
				sql = "SELECT A.*, B.CHR_STAFFNAME";
				sql = sql + " FROM ATT_T_ATTENDANCEDETAIL A,  com_m_staff  B";
				sql = sql + " WHERE A.CHR_EMPID=B.CHR_EMPID ";
				sql = sql + " AND B.INT_DEPARTID = " + Integer.parseInt(deptid);
				sql = sql + " AND A.LOGMONTH = '" + month + "' ";
				sql = sql + " AND A.LOGYEAR = " + Integer.parseInt(year);
				@SuppressWarnings("unused")
				String fline = MusterMonthReport(sql, totDays);
				//WriteContents.writeFiles(fline, repName, repHeader);
				 
				response.sendRedirect("Smart Attendance/ReportViewMuster.jsp");
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