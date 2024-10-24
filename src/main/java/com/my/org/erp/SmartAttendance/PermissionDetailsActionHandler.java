package com.my.org.erp.SmartAttendance;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class PermissionDetailsActionHandler extends AbstractActionHandler {

	Statement st;
    String repName;
	ResultSet rs;

	String fline;

	String sql;

	String timein = "";

	String normaltime = "";

	String ids = "";
	String compId,branchId;
	String compName,branchName;

	

	private void PermissionDetailsNotfound(String repName, String repHeader) {
		try {
			String filename = "Report.sys";
			FileWriter fw = new FileWriter(filename);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write("");
			fline = "";
			fline = repName + "\n";
			fline = fline + repHeader + "\n";
			fline = fline + "Record not found...\n";
			bw.write(fline);
			bw.close();
			rs.close();
			st.close();

		} catch (Exception e) {
		}

	}

	private void PermissionDetails(String idcoll, String fdate, String tdate,
			String repName, String repHeader) {
		try {
			int i = 0;
			st = con.createStatement();
			fline = "";
			fline = fline + repName + "\n";
			fline = fline + repHeader + "\n";
			String id[] = idcoll.split("~");
			@SuppressWarnings("unused")
			String shiftcode = "";
			@SuppressWarnings("unused")
			String timein = "";
			@SuppressWarnings("unused")
			String timediff = "";
			for (int j = 0; j < id.length; j++) {
				String sql = "SELECT A.CHR_EMPID ,B.CHR_STAFFNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME,A.DT_PDATE,A.DT_TIME_FROM,DT_TIME_TO,A.CHR_REASON";
				sql = sql
						+ " FROM ATT_T_PERMISSION A , com_m_staff  B,  com_m_depart   C, com_m_desig  D";
				sql = sql + " WHERE A.DT_PDATE >= '" + fdate.trim() + "'";
				sql = sql + " AND A.DT_PDATE <= '" + tdate.trim() + "'";
				sql = sql + " AND A.CHR_EMPID= B.CHR_EMPID ";
				sql = sql + " AND B.INT_DEPARTID  = C.INT_DEPARTID";
				sql = sql + " AND B.INT_DESIGID=D.INT_DESIGID";
				sql = sql + " AND A.CHR_EMPID= '" + id[j].trim() + "'";
				sql = sql + " AND B.INT_COMPANYID="+compId;
				if(!branchId.equals("-1"))
					sql=sql+" AND B.INT_BRANCHID="+branchId;
			    //System.out.println("In Permission Details ----------------->> "+sql);
				rs = st.executeQuery(sql);
				while (rs.next()) {
					fline = fline + " " + rs.getString("CHR_EMPID") + "^";
					fline = fline + " " + rs.getString("CHR_STAFFNAME") + "^";
					fline = fline + " " + rs.getString("CHR_DEPARTNAME") + "^";
					fline = fline + " " + rs.getString("CHR_DESIGNAME") + "^";
					fline = fline + " " + rs.getString("DT_PDATE") + "^";
					fline = fline + " " + rs.getString("DT_TIME_FROM") + "^";
					fline = fline + " " + rs.getString("DT_TIME_TO") + "^";
					fline = fline + " " + rs.getString("CHR_REASON") + "^ \n";
					i = i + 1;
				}
			}
			if (i < 1)
				fline = fline + "Record not found...^\n";

			String filename = "Report.sys";
			FileWriter fw = new FileWriter(filename);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write(fline);
			bw.close();

		} catch (Exception e) {
			 System.out.println(e.getMessage());
			//System.out.println(e);
		}

	}

	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
	try 
	{
			String filename = "Report.sys";
			FileWriter fw = new FileWriter(filename);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write("");
			bw.close();
			String action = request.getParameter("actionS");
			
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

			//System.out.println("CONTROL FROM PERMISSION ACTION HANDLER ::"+ action);
			if (action.equals("ATTPermissionDetailsDateList")) {
				String fdate = request.getParameter("fromdt");
				String tdate = request.getParameter("todt");
				repName = repName +" PERMISSION DETAILS";
				repName = repName + " ( FROM :" + fdate + " TO : " + tdate
						+ " ) ";
				String repHeader = "Emp Id^Name^Department^Designation^Permission Date ^Total Hours^ Remarks";
				String fdt[] = fdate.split("-");
				String tdt[] = tdate.split("-");
				fdate = fdt[2] + "-" + fdt[1] + "-" + fdt[0];
				tdate = tdt[2] + "-" + tdt[1] + "-" + tdt[0];
				ids = "";
				st = con.createStatement();
				sql = "SELECT CHR_EMPID FROM  com_m_staff ";
				rs = st.executeQuery(sql);
				@SuppressWarnings("unused")
				int rcount = 0;
				boolean flag = false;
				if (rs.next())
					ids = "" + rs.getString("CHR_EMPID");
				if ((ids.equals("")) || (ids.equals("null")))
					flag = false;
				else
					flag = true;
				ids = "";
				if (flag) {
					ids = "";
					rs = st.executeQuery(sql);
					while (rs.next())
						ids = ids + "" + rs.getString("CHR_EMPID") + "~";
					fline = "";
					PermissionDetails(ids, fdate, tdate, repName, repHeader);
				} else
					PermissionDetailsNotfound(repName, repHeader);
				 
				response
						.sendRedirect("Smart Attendance/ReportViewPermissionDetails.jsp?er="
								+ ids);
			} else if (action.equals("ATTPermissionDetailsMonthList")) {
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				String fdate = "01-" + month + "-" + year;
				String tdate = "31-" + month + "-" + year;
				repName =repName +" PERMISSION DETAILS  ";
				repName = repName+ " ( MONTH : "+ DateUtil.getMonth(Integer.parseInt(month))
								.toUpperCase() + " -  YEAR :" + year + " ) ";
				String repHeader = "Emp Id^Name^Department^Designation^Permission Date ^Total Hours^ Remarks";
				String fdt[] = fdate.split("-");
				String tdt[] = tdate.split("-");
				fdate = fdt[2] + "-" + fdt[1] + "-" + fdt[0];
				tdate = tdt[2] + "-" + tdt[1] + "-" + tdt[0];
				ids = "";
				st = con.createStatement();
				sql = "SELECT CHR_EMPID FROM  com_m_staff ";
				rs = st.executeQuery(sql);
				@SuppressWarnings("unused")
				int rcount = 0;
				boolean flag = false;
				if (rs.next())
					ids = "" + rs.getString("CHR_EMPID");
				if ((ids.equals("")) || (ids.equals("null")))
					flag = false;
				else
					flag = true;
				if (flag) {
					ids = "";
					rs = st.executeQuery(sql);
					while (rs.next())
						ids = ids + "" + rs.getString("CHR_EMPID") + "~";
					// //System.out.println(ids);
					PermissionDetails(ids, fdate, tdate, repName, repHeader);
				} else
					PermissionDetailsNotfound(repName, repHeader);
				 
				response
						.sendRedirect("Smart Attendance/ReportViewPermissionDetails.jsp");
			} else if (action.equals("ATTPermissionDetailsIndidualList")) {
				String idc[] = request.getParameterValues("ename");
				String fdate = request.getParameter("fromdt");
				String tdate = request.getParameter("todt");
				repName =repName +" PERMISSION DETAILS ";
				repName = repName + " ( FROM :" + fdate + " TO : " + tdate
						+ " ) ";
				String repHeader = "Emp Id^Name^Department^Designation^Permission Date ^Total Hours^ Remarks";
				String fdt[] = fdate.split("-");
				String tdt[] = tdate.split("-");
				fdate = fdt[2] + "-" + fdt[1] + "-" + fdt[0];
				tdate = tdt[2] + "-" + tdt[1] + "-" + tdt[0];
				ids = "";
				for (int y = 0; y < idc.length; y++)
					ids = ids + " " + idc[y] + "~";
				PermissionDetails(ids, fdate, tdate, repName, repHeader);
				 
				response
						.sendRedirect("Smart Attendance/ReportViewPermissionDetails.jsp");
			} else if (action.equals("ATTPermissionDetailsDesignationList")) {
				String desgid = request.getParameter("Designation");
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				String fdate = "01-" + month + "-" + year;
				String tdate = "31-" + month + "-" + year;
				repName =repName +" PERMISSION DETAILS   -DESIGNATION WISE ";
				repName = repName+ " ( MONTH : "
						+ DateUtil.getMonth(Integer.parseInt(month))
								.toUpperCase() + " -  YEAR :" + year + " ) ";
				String repHeader = "Emp Id^Name^Department^Designation^Permission Date ^Total Hours^ Remarks";
				String fdt[] = fdate.split("-");
				String tdt[] = tdate.split("-");
				fdate = fdt[2] + "-" + fdt[1] + "-" + fdt[0];
				tdate = tdt[2] + "-" + tdt[1] + "-" + tdt[0];
				ids = "";
				st = con.createStatement();
				sql = "SELECT CHR_EMPID FROM  com_m_staff  WHERE INT_DESIGID = "
						+ Integer.parseInt(desgid);
				// //System.out.println(sql);
				rs = st.executeQuery(sql);
				@SuppressWarnings("unused")
				int rcount = 0;
				boolean flag = false;
				if (rs.next())
					ids = "" + rs.getString("CHR_EMPID");
				if ((ids.equals("")) || (ids.equals("null")))
					flag = false;
				else
					flag = true;
				if (flag) {
					ids = "";
					rs = st.executeQuery(sql);
					while (rs.next())
						ids = ids + "" + rs.getString("CHR_EMPID") + "~";
					PermissionDetails(ids, fdate, tdate, repName, repHeader);
				} else
					PermissionDetailsNotfound(repName, repHeader);
				con.close();    
				response
						.sendRedirect("Smart Attendance/ReportViewPermissionDetails.jsp");
			} else if (action.equals("ATTPermissionDetailsDepartmentList")) {
				String deptid = request.getParameter("Department");
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				String fdate = "01-" + month + "-" + year;
				String tdate = "31-" + month + "-" + year;
				repName =repName +" PERMISSION DETAILS   -DEPARTMENT WISE ";
				repName = repName+ " ( MONTH : "
						+ DateUtil.getMonth(Integer.parseInt(month))
								.toUpperCase() + " -  YEAR :" + year + " ) ";
				String repHeader = "Emp Id^Name^Department^Designation^Permission Date ^Total Hours^ Reason";
				String fdt[] = fdate.split("-");
				String tdt[] = tdate.split("-");
				fdate = fdt[2] + "-" + fdt[1] + "-" + fdt[0];
				tdate = tdt[2] + "-" + tdt[1] + "-" + tdt[0];
				ids = "";
				st = con.createStatement();
				sql = "SELECT CHR_EMPID FROM  com_m_staff  WHERE INT_DEPARTID = "
						+ Integer.parseInt(deptid);
				// //System.out.println(sql);
				rs = st.executeQuery(sql);
				@SuppressWarnings("unused")
				int rcount = 0;
				boolean flag = false;
				if (rs.next())
					ids = "" + rs.getString("CHR_EMPID");
				if ((ids.equals("")) || (ids.equals("null")))
					flag = false;
				else
					flag = true;
				if (flag) {
					ids = "";
					rs = st.executeQuery(sql);
					while (rs.next())
						ids = ids + "" + rs.getString("CHR_EMPID") + "~";
					// //System.out.println(ids);
					PermissionDetails(ids, fdate, tdate, repName, repHeader);
				} else
					PermissionDetailsNotfound(repName, repHeader);
				con.close();    
				response
						.sendRedirect("Smart Attendance/ReportViewPermissionDetails.jsp");
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
