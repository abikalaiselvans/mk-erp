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

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class OTDetailsActionHandler extends AbstractActionHandler {

	Statement st;
	ResultSet rs;
	String fline;
	String sql;
	String timein = "";
	String normaltime = "";
	String ids = "";
	String empid = "";
	String empname = "";
	String compId,branchId,repName;
	String compName,branchName;
	Calendar calDate1 = Calendar.getInstance();

	Calendar calDate2 = Calendar.getInstance();

	private void setDate(String fDate, String tDate) {
		int date = Integer.parseInt(fDate.substring(0, 2));
		int month = Integer.parseInt(fDate.substring(3, 5));
		int year = Integer.parseInt(fDate.substring(6));
		calDate1.set(year, month, date);
		date = Integer.parseInt(tDate.substring(0, 2));
		month = Integer.parseInt(tDate.substring(3, 5));
		year = Integer.parseInt(tDate.substring(6));
		calDate2.set(year, month, date + 1);
	}

	private String getDate() {
		String date = "" + calDate1.get(Calendar.DATE);
		String month = "" + calDate1.get(Calendar.MONTH);
		String year = "" + calDate1.get(Calendar.YEAR);
		if (date.length() == 1)
			date = "0" + date;
		if (month.length() == 1)
			month = "0" + month;
		return ("" + year + "-" + month + "-" + date);
	}

	private String getEmpid(String sql) {
		try {
			st = con.createStatement();
			rs = st.executeQuery(sql);
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
			}
			return ids;
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			//System.out.println(e);
		}
		return null;
	}

	@SuppressWarnings("unused")
	private void getTimeinTimeout(String empid, String fdate, String tdate) {
		try {
			String userid[] = empid.split(",");
			fline = "";
			int rcount = 0;

			for (int i = 0; i < userid.length; i++) {
				setDate(fdate, tdate);
				while (!calDate1.equals(calDate2)) {
					sql = " SELECT A.CHR_EMPID,C.CHR_DEPARTNAME,D.CHR_DESIGNAME,A.DT_TIMEIN,A.DT_TIMEOUT,A.DT_LOGIN,A.DT_LOGOUT";
					sql = sql
							+ " FROM ATT_SMART_ATTENDANCE A ,  com_m_staff  B ,  com_m_depart   C , com_m_desig  D";
					sql = sql + " WHERE A.DT_LOGIN='" + getDate() + "'";
					sql = sql + " AND A.CHR_EMPID='" + userid[i] + "'";
					sql = sql + " AND B.INT_DEPARTID  = C.INT_DEPARTID";
					sql = sql + " AND B.INT_DESIGID=D.INT_DESIGID  ";
					sql = sql + " AND INT_COMPANYID="+compId;
					if(!branchId.equals("-1"))
						sql=sql+" AND A.INT_BRANCHID="+branchId;
					
					rs = st.executeQuery(sql);

					if (rs.next()) {
						fline = fline + " " + userid[i] + "^";
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
					calDate1.add(Calendar.DATE, 1);

				}
				rcount = rcount + 1;
			}
			if (rcount < 1)
				fline = fline + "Record not found...^\n";

			//System.out.println(fline);
			String filename = "Report.sys";
			FileWriter fw = new FileWriter(filename);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write("");
			bw.write(fline + "\n\n\n\n\n");
			bw.close();
			rs.close();
			st.close();

		} catch (Exception e) {
			//System.out.println(e);
			 System.out.println(e.getMessage());
		}
	}	
	private void getOverTime(String empid, String fdate, String tdate,String fHeader) {
	try {
			String userid[] = empid.split("~");
			fline = "";
			fline = repName + "\n";
			fline = fline + fHeader+ "\n";
			
			int rcount = 0;
			fdate=DateUtil.FormateDateSQL(fdate);
			tdate=DateUtil.FormateDateSQL(tdate);
			for (int i = 0; i < userid.length; i++) {
					sql = " SELECT A.CHR_EMPID,B.CHR_STAFFNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME,A.DT_OTDATE,A.INT_MINS,A.CHR_BATTA,A.CHR_WASHING,A.CHR_DIS";
					sql = sql+ " FROM att_t_ot A ,  com_m_staff  B ,  com_m_depart   C , com_m_desig  D";
					sql = sql + " WHERE A.DT_OTDATE>='" + fdate + "'";
					sql = sql + " AND A.DT_OTDATE<='" + tdate + "'";
					sql = sql + " AND a.CHR_EMPID=b.CHR_EMPID AND b.CHR_EMPID='" + userid[i] + "'";
					sql = sql + " AND B.INT_DEPARTID=C.INT_DEPARTID";
					sql = sql + " AND B.INT_DESIGID=D.INT_DESIGID  ";
					rs = st.executeQuery(sql);
					while (rs.next()) {
						fline = fline + " " + userid[i] + "^";
						fline = fline + " " + rs.getString(2) + "^";
						fline = fline + " " + rs.getString(3) + "^";
						fline = fline + " " + rs.getString(4) + "^";
						fline = fline + " " + rs.getString(5) + "^";						
						fline = fline + " " + rs.getString(6) + "^";
						fline = fline + " " + rs.getString(7) + "^";
						fline = fline + " " + rs.getString(8) + "";
						//fline = fline + " " + rs.getString(9) + "^";  //Remarks
						fline = fline + " " + "\n";
					}				
					rcount = rcount + 1;
				}
				
			if (rcount == 0)
				fline = fline + "Record not found...^\n";

			//System.out.println(fline);
			String filename = "Report.sys";
			FileWriter fw = new FileWriter(filename);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write("");
			bw.write(fline + "\n\n\n\n\n");
			bw.close();
			rs.close();
			st.close();

		} catch (Exception e) {
			//System.out.println(e);
			 System.out.println(e.getMessage());
		}

	}


	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
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
			//System.out.println("CONTROL FROM OTDetails ACTION HANDLER ::"+ action);
			if (action.equals("ATTOTDetailsDateList")) {
				String fdate = request.getParameter("fromdt");
				String tdate = request.getParameter("todt");
			
							
				repName =repName+" O.T DETAILS";
				repName = repName + " ( FROM :" + fdate + " TO : " + tdate
						+ " ) ";
				String repHeader = "Emp Id^Name^Department^Designation^Permission Date ^Total Hours^ Remarks";
				
				sql = "SELECT CHR_EMPID FROM  com_m_staff where INT_COMPANYID="+compId;
				if(!branchId.equals("-1"))
					sql=sql+" AND INT_BRANCHID="+branchId;
				ids = getEmpid(sql);
				//getTimeinTimeout(ids, fdate, tdate);  This for get Over Timer From ATT table ~~ Not Completed
				getOverTime(ids, fdate, tdate,repHeader);
				 
				response.sendRedirect("Smart Attendance/ReportViewOTDetails.jsp");
			} else if (action.equals("ATTOTDetailsMonthList")) {
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				int tot=DateUtil.totalDays(Integer.parseInt(month),Integer.parseInt(year));
				String fdate = "01-" + month + "-" + year;
				String tdate = tot +"-"+ month + "-" + year;
				repName =repName+" O.T DETAILS ";
				repName = repName
						+ " ( MONTH : "
						+ DateUtil.getMonth(Integer.parseInt(month))
								.toUpperCase() + " -  YEAR :" + year + " ) ";
				String repHeader = "Emp Id^Name^Department^Designation^Permission Date ^Total Hours^ Remarks";				
				sql = "SELECT CHR_EMPID FROM  com_m_staff where INT_COMPANYID="+compId;
				if(!branchId.equals("-1"))
					sql=sql+" AND INT_BRANCHID="+branchId;
				ids = getEmpid(sql);				
				getOverTime(ids, fdate, tdate,repHeader);
				 
				response.sendRedirect("Smart Attendance/ReportViewOTDetails.jsp");
			} else if (action.equals("ATTOTDetailsIndidualList")) {
				@SuppressWarnings("unused")
				String idc[] = request.getParameterValues("ename");
				String fdate = request.getParameter("fromdt");
				String tdate = request.getParameter("todt");
				repName =repName+" O.T  DETAILS";
				repName = repName + " ( FROM :" + fdate + " TO : " + tdate
						+ " ) ";
				@SuppressWarnings("unused")
				String repHeader = "Emp Id^Name^Department^Designation^Permission Date ^Total Hours^ Remarks";
				String fdt[] = fdate.split("-");
				String tdt[] = tdate.split("-");
				fdate = fdt[2] + "-" + fdt[1] + "-" + fdt[0];
				tdate = tdt[2] + "-" + tdt[1] + "-" + tdt[0];
				ids = "";
				 
				response
						.sendRedirect("Smart Attendance/ReportViewOTDetails.jsp");
			} else if (action.equals("ATTOTDetailsDesignationList")) {
				@SuppressWarnings("unused")
				String desgid = request.getParameter("Designation");
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				String fdate = "01-" + month + "-" + year;
				String tdate = "31-" + month + "-" + year;
				repName =repName+" O.T.  DETAILS -DESIGNATION WISE ";
				repName = repName
						+ " ( MONTH : "
						+ DateUtil.getMonth(Integer.parseInt(month))
								.toUpperCase() + " -  YEAR :" + year + " ) ";
				@SuppressWarnings("unused")
				String repHeader = "Emp Id^Name^Department^Designation^Permission Date ^Total Hours^ Remarks";
				String fdt[] = fdate.split("-");
				String tdt[] = tdate.split("-");
				fdate = fdt[2] + "-" + fdt[1] + "-" + fdt[0];
				tdate = tdt[2] + "-" + tdt[1] + "-" + tdt[0];
				ids = "";
				 
				response
						.sendRedirect("Smart Attendance/ReportViewOTDetails.jsp");
			} else if (action.equals("ATTOTDetailsDepartmentList")) {
				@SuppressWarnings("unused")
				String deptid = request.getParameter("Department");
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				String fdate = "01-" + month + "-" + year;
				String tdate = "31-" + month + "-" + year;
				repName =repName+" O.T  DETAILS -DEPARTMENT WISE ";
				repName = repName
						+ " ( MONTH : "
						+ DateUtil.getMonth(Integer.parseInt(month))
								.toUpperCase() + " -  YEAR :" + year + " ) ";
				@SuppressWarnings("unused")
				String repHeader = "Emp Id^Name^Department^Designation^Permission Date ^Total Hours^ Reason";
				String  fdt[] = fdate.split("-");
				String  tdt[] = tdate.split("-");
				fdate = fdt[2] + "-" + fdt[1] + "-" + fdt[0];
				tdate = tdt[2] + "-" + tdt[1] + "-" + tdt[0];
				ids = "";
				 
				response.sendRedirect("Smart Attendance/ReportViewOTDetails.jsp");
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
