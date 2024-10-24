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



public class LateComersActionHandler extends AbstractActionHandler {

	Statement st;

	ResultSet rs;

	String fline;

	String sql;

	String timein = "";

	String normaltime = "";
	String compId,branchId;
	String compName,branchName;

	private void LateComersNotfound(String repName, String repHeader) {
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

	@SuppressWarnings("unused")
	private String Timeget() {
		try {
			st = con.createStatement();
			rs = st.executeQuery("SELECT TIM_GRACEIN FROM  ATT_BASICSETTINGS");
			String t = "";
			String t1 = "";
			boolean flag = false;

			if (rs.next()) {
				t1 = "" + rs.getString("TIM_GRACEIN");
				t = t1;
			}
			if ((t1.equalsIgnoreCase("null")) || (t1.equals("")))
				flag = true;
			else
				flag = false;

			if (flag) {
				t = "09:30:00";
				normaltime = t;
			} else
				normaltime = t;
			t = normaltime;

			return t;
		} catch (Exception e) {

		}
		return null;
	}

	@SuppressWarnings("unused")
	private String ShiftTimeget(String sql) {
		try {
			st = con.createStatement();
			rs = st.executeQuery(sql);
			String t = "";
			String t1 = "";
			boolean flag = false;
			if (rs.next())
				t1 = "" + rs.getString("DT_TIMEFROM");
			normaltime = t1;
			return t;
		} catch (Exception e) {

		}
		return null;
	}

	private void LateComers(String idcoll, String fdate, String tdate,String repName, String repHeader) {
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

				String sql = "SELECT A.CHR_EMPID,B.CHR_STAFFNAME,CHR_SHIFTCODE,C.CHR_DEPARTNAME,D.CHR_DESIGNAME,A.DT_LOGIN,A.DT_TIMEIN,A.CHR_LATE";
				sql = sql+ " FROM ATT_SMART_ATTENDANCE A ,  com_m_staff  B ,  com_m_depart   C , com_m_desig  D";
				sql = sql + " WHERE A.DT_LOGIN >= '" + fdate.trim() + "'";
				sql = sql + " AND A.DT_LOGIN <= '" + tdate.trim() + "'";
				sql = sql + " AND A.CHR_EMPID= '" + id[j].trim() + "'";
				sql = sql + " AND A.CHR_EMPID= B.CHR_EMPID ";
				sql = sql + " AND B.INT_DEPARTID  = C.INT_DEPARTID";
				sql = sql + " AND B.INT_DESIGID=D.INT_DESIGID";
				sql = sql + " AND A.CHR_LATE = 'L'";
				sql = sql + " AND INT_COMPANYID="+compId;
				if(!branchId.equals("-1"))
					sql=sql+" AND A.INT_BRANCHID="+branchId;
			    	sql=sql+" ORDER BY A.CHR_EMPID";			
			
				 //System.out.println("In Late Comers -------------------------------------->>"+sql);

				rs = st.executeQuery(sql);
				while (rs.next())
				{
					fline = fline + " " + rs.getString("CHR_EMPID") + "^";
					fline = fline + " " + rs.getString("CHR_STAFFNAME") + "^";
					shiftcode = "" + rs.getString("CHR_SHIFTCODE");

					/*
					 * if(shiftcode.equalsIgnoreCase("null")) normaltime =
					 * Timeget(); else normaltime = ShiftTimeget("SELECT
					 * DT_TIMEFROM FROM ATT_M_SHIFT WHERE CHR_SHIFTCODE = '"
					 * +shiftcode+"'");
					 */

					fline = fline + " " + rs.getString("CHR_DEPARTNAME") + "^";
					fline = fline + " " + rs.getString("CHR_DESIGNAME") + "^";
					fline = fline + " " + rs.getString("DT_LOGIN") + "^";
					fline = fline + " " + rs.getString("DT_TIMEIN") + "^";
					// timein = " " +rs.getString("DT_TIMEIN");
					// fline = fline +" " +timein+"^ ";

					fline = fline + " " + rs.getString("CHR_LATE") + "^ \n";
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
			String action = request.getParameter("actionS");
			//System.out.println("CONTROL FROM LATE COMERS ACTION HANDLER ::"	+ action);

			String filename = "Report.sys";
			FileWriter fw = new FileWriter(filename);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write("");
			bw.close();
			
			compId= request.getParameter("company");
			branchId= request.getParameter("branch");
			compName= com.my.org.erp.common.CommonInfo.stringGetAnySelectField("Select CHR_COMPANYNAME from  com_m_company  where INT_COMPANYID="+compId, "CHR_COMPANYNAME");
			sql="Select CHR_BRANCHNAME from  com_m_branch  where INT_BRANCHID="+branchId;
			//System.out.println("SQL :"+sql);
			String repName = "Company : "+compName;
			if(!branchId.equals("-1"))
			{
				branchName=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql,"CHR_BRANCHNAME");
				repName=repName+ " ~ Branch : "+branchName;
			}
			else				
				repName=repName+ " ~ Branch : All ";

			if (action.equals("ATTLateComersDateList"))
			{
				String fdate = request.getParameter("fromdt");
				String tdate = request.getParameter("todt");
				repName= repName + " ~ LATE COMERS DETAILS";
				repName = repName + " ( FROM :" + fdate + " TO : " + tdate + " ) ";
				String repHeader = "Emp Id^Name^Department^Designation^Login Date ^Time In^ Late";
				String fdt[] = fdate.split("-");
				String tdt[] = tdate.split("-");
				fdate = fdt[2] + "-" + fdt[1] + "-" + fdt[0];
				tdate = tdt[2] + "-" + tdt[1] + "-" + tdt[0];
				String ids = "";
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
					//System.out.println(ids);
					LateComers(ids, fdate, tdate, repName, repHeader);
				} else
					LateComersNotfound(repName, repHeader);
				 
response.sendRedirect("Smart Attendance/ReportViewLateComers.jsp?er="+ normaltime);
			} 
			else if (action.equals("ATTLateComersMonthList")) 
			{
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				String fdate = "01-" + month + "-" + year;
				String tdate = "31-" + month + "-" + year;

				repName =repName + " ~ LATE COMERS DETAILS ";
				repName = repName
						+ " ( MONTH : "
						+ DateUtil.getMonth(Integer.parseInt(month))
								.toUpperCase() + " -  YEAR :" + year + " ) ";
				String repHeader = "Emp Id^Name^Department^Designation^Login Date ^Time In^ Late";
				String fdt[] = fdate.split("-");
				String tdt[] = tdate.split("-");
				fdate = fdt[2] + "-" + fdt[1] + "-" + fdt[0];
				tdate = tdt[2] + "-" + tdt[1] + "-" + tdt[0];
				String ids = "";
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
					rs = st.executeQuery(sql);
					while (rs.next())
						ids = ids + "" + rs.getString("CHR_EMPID") + "~";
					//System.out.println(ids);
					LateComers(ids, fdate, tdate, repName, repHeader);
				} else
					LateComersNotfound(repName, repHeader);
				 
				response
						.sendRedirect("Smart Attendance/ReportViewLateComers.jsp");
			} else if (action.equals("ATTLateComersIndidualList")) {
				String idc[] = request.getParameterValues("ename");
				String fdate = request.getParameter("fromdt");
				String tdate = request.getParameter("todt");
				repName = repName + " ~ LATE COMERS DETAILS";
				repName = repName + " ( FROM :" + fdate + " TO : " + tdate + " ) ";
				String repHeader = "Emp Id^Name^Department^Designation^Login Date ^Time In^ Late";
				String fdt[] = fdate.split("-");
				String tdt[] = tdate.split("-");
				fdate = fdt[2] + "-" + fdt[1] + "-" + fdt[0];
				tdate = tdt[2] + "-" + tdt[1] + "-" + tdt[0];
				String ids = "";
				for (int y = 0; y < idc.length; y++)
					ids = ids + " " + idc[y] + "~";

				LateComers(ids, fdate, tdate, repName, repHeader);
				 
				response.sendRedirect("Smart Attendance/ReportViewLateComers.jsp");
			} 
			else if (action.equals("ATTLateComersDesignationList")) {
				String desgid = request.getParameter("Designation");
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				String fdate = "01-" + month + "-" + year;
				String tdate = "31-" + month + "-" + year;
				repName = repName + " ~ LATE COMERS DETAILS -DESIGNATION WISE ";
				repName = repName
						+ " ( MONTH : "
						+ DateUtil.getMonth(Integer.parseInt(month))
								.toUpperCase() + " -  YEAR :" + year + " ) ";
				String repHeader = "Emp Id^Name^Department^Designation^Login Date ^Time In^ Late";
				String fdt[] = fdate.split("-");
				String tdt[] = tdate.split("-");
				fdate = fdt[2] + "-" + fdt[1] + "-" + fdt[0];
				tdate = tdt[2] + "-" + tdt[1] + "-" + tdt[0];
				String ids = "";
				st = con.createStatement();
				sql = "SELECT CHR_EMPID FROM  com_m_staff  WHERE INT_DESIGID = "
						+ Integer.parseInt(desgid);
				//System.out.println(sql);
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
					//System.out.println(ids);
					LateComers(ids, fdate, tdate, repName, repHeader);
				} else
					LateComersNotfound(repName, repHeader);
				 
				response.sendRedirect("Smart Attendance/ReportViewLateComers.jsp");
			} else if (action.equals("ATTLateComersDepartmentList")) {
				String deptid = request.getParameter("Department");
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				String fdate = "01-" + month + "-" + year;
				String tdate = "31-" + month + "-" + year;
				repName =repName + " ~ LATE COMERS DETAILS -DEPARTMENT WISE ";
				repName = repName
						+ " ( MONTH : "
						+ DateUtil.getMonth(Integer.parseInt(month))
								.toUpperCase() + " -  YEAR :" + year + " ) ";
				String repHeader = "Emp Id^Name^Department^Designation^Login Date ^Time In^ Late";
				String fdt[] = fdate.split("-");
				String tdt[] = tdate.split("-");
				fdate = fdt[2] + "-" + fdt[1] + "-" + fdt[0];
				tdate = tdt[2] + "-" + tdt[1] + "-" + tdt[0];
				String ids = "";
				st = con.createStatement();
				sql = "SELECT CHR_EMPID FROM  com_m_staff  WHERE INT_DEPARTID = "
						+ Integer.parseInt(deptid);
				//System.out.println(sql);

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
					//System.out.println(ids);
					LateComers(ids, fdate, tdate, repName, repHeader);
				} else
					LateComersNotfound(repName, repHeader);
				 
				response
						.sendRedirect("Smart Attendance/ReportViewLateComers.jsp");
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
