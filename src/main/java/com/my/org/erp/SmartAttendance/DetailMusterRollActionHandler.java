package com.my.org.erp.SmartAttendance;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class DetailMusterRollActionHandler extends AbstractActionHandler {
	
	String fdate = null, tdate = null;
	String month = null;
	String year = null;
	String depId = null;
	String sql = null;
	String repName = null;
	String repHeader = null;
	int totDays = 0;
	String compId,branchId;
	String compName,branchName;
	private void WriteFile(HttpServletRequest request,HttpServletResponse response, int noField) throws ServletException,IOException
	{
		try {

			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery(sql);
			String fline = "";
			String filename = "Report.sys";
			FileWriter fw = new FileWriter(filename);
			BufferedWriter bw = new BufferedWriter(fw);
			fline = fline + repName + "\n";
			fline = fline + repHeader + "\n";
			String cvalue = "";
			int rcount = 0;
			while (rs.next()) 
			{
				cvalue = rs.getString("CHR_EMPID");
				if (cvalue == null)
					cvalue = "";
				cvalue = cvalue.trim();
				if (cvalue == "")
					cvalue = "-";
				fline = fline + cvalue + "^";

				cvalue = rs.getString("CHR_STAFFNAME");
				if (cvalue == null)
					cvalue = "";
				cvalue = cvalue.trim();
				if (cvalue == "")
					cvalue = "-";
				fline = fline + cvalue + "^";

				cvalue = rs.getString("DOU_PRESENT");
				if (cvalue == null)
					cvalue = "";
				cvalue = cvalue.trim();
				if (cvalue == "")
					cvalue = "-";
				fline = fline + cvalue + "^";

				cvalue = rs.getString("DOU_ABSENT");
				if (cvalue == null)
					cvalue = "";
				cvalue = cvalue.trim();
				if (cvalue == "")
					cvalue = "-";
				fline = fline + cvalue + "^";

				cvalue = rs.getString("DOU_LEAVE");
				if (cvalue == null)
					cvalue = "";
				cvalue = cvalue.trim();
				if (cvalue == "")
					cvalue = "-";
				fline = fline + cvalue + "^";

				cvalue = rs.getString("DOU_OD");
				if (cvalue == null)
					cvalue = "";
				cvalue = cvalue.trim();
				if (cvalue == "")
					cvalue = "-";
				fline = fline + cvalue + "^";

				cvalue = rs.getString("INT_LATE");
				if (cvalue == null)
					cvalue = "";
				cvalue = cvalue.trim();
				if (cvalue == "")
					cvalue = "-";
				fline = fline + cvalue + "^";

				for (int i = 1; i <= totDays; i++) {
					cvalue = rs.getString("LOGDATE" + i);
					if (cvalue == null)
						cvalue = "";
					cvalue = cvalue.trim();
					if (cvalue == "")
						cvalue = "-";
					fline = fline + cvalue + "^";
				}
				 
				fline = fline + "^\n";
				rcount = rcount + 1;
			}
			if (rcount < 1)
				fline = fline + "Record not found...";
			bw.write(fline);
			bw.close();
			////System.out.println("File Write Sucessfully");
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void MusterRollCalculation(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String dId = request.getParameter("select");
			String compID = request.getParameter("company");
			String branchId = request.getParameter("branch");
			CallableStatement cs = con
					.prepareCall("{call PRO_MUSTERROLL(?,?,?,?,?)}");
			cs.setString(1, compID);
			cs.setString(2, branchId);
			cs.setString(3, dId);
			cs.setString(4, fdate);
			cs.setString(5, tdate);
			cs.execute();
			//System.out.println("Muster Roll Calculated Sucessfully");
		} catch (Exception e) {
			 System.out.println(e.getMessage());
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
		}
	}

	private void MusterRollView(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			repName =repName+" Muster Roll";
			repHeader = "Emp Id^Name^";
			for (int i = 1; i <= totDays; i++) {
				repHeader = repHeader + i + "^";
			}
			repHeader = repHeader + "Present^Absent^Leave^OD^Late";
			WriteFile(request, response, 10);
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	@SuppressWarnings("rawtypes")
	public void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
			{
				String filename = "DetailedAttendance.sys";
				FileWriter fw = new FileWriter(filename);
				BufferedWriter bw = new BufferedWriter(fw);
				bw.write("");
				bw.close();
				String action = request.getParameter("actionS");
				action = action.trim();
				//System.out.println("CONTROL FROM MUSTER ROLL ::" + action);
				
				compId= request.getParameter("company");
				branchId= request.getParameter("branch");
				compName= com.my.org.erp.common.CommonInfo.stringGetAnySelectField("Select CHR_COMPANYNAME from  com_m_company  where INT_COMPANYID="+compId, "CHR_COMPANYNAME");
				sql="Select CHR_BRANCHNAME from  com_m_branch  where INT_BRANCHID="+branchId;
				repName = "Company : "+compName;
				if(!branchId.equals("-1"))
				{
					branchName=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql,"CHR_BRANCHNAME");
					repName=repName+ " ~ Branch : "+branchName;
				}
				else				
					repName=repName+ " ~ Branch :  ";
				 
				String mon = request.getParameter("Month");
				year = request.getParameter("Year");
				month = com.my.org.erp.ServiceLogin.DateUtil.getMonth(Integer.parseInt(mon));
				fdate = "" + year + "-" + mon + "-01";
				totDays = com.my.org.erp.ServiceLogin.DateUtil.totalDays(
				Integer.parseInt(mon), Integer.parseInt(year));
				tdate = "" + year + "-" + mon + "-" + totDays;
				String btnAction = request.getParameter("Submit2");
				btnAction = btnAction.trim();
				if (action.equals("DetailMusterRoll")&& btnAction.equalsIgnoreCase("Calculate")) 
				{
					depId = request.getParameter("select");
					if (depId.equals("-1")) 
					{
						HttpSession session = request.getSession();
						java.util.ArrayList departmentList = (java.util.ArrayList) session.getAttribute("departmentList");
						for (int i = 0; i < departmentList.size(); i++) 
						{
							com.my.org.erp.bean.Department depart = (com.my.org.erp.bean.Department) departmentList.get(i);
							depId = depId + "," + depart.getDepartId();
						}
					}
					String compID = request.getParameter("company");
					String branchId = ""+request.getParameter("branch");
					
					if(branchId.equals("-1")){
						sql = "SELECT A.*,B.CHR_STAFFNAME ";
						sql = sql+ "FROM ATT_T_ATTENDANCEDETAIL A,  com_m_staff  B WHERE A.CHR_EMPID=B.CHR_EMPID AND INT_COMPANYID="+compID +" AND B.INT_DEPARTID in("+ depId + ") AND LOGMONTH='" + month + "' AND LOGYEAR="+ year;
					}
					else
					{
						sql = "SELECT A.*,B.CHR_STAFFNAME ";
						sql = sql+  "FROM ATT_T_ATTENDANCEDETAIL A,  com_m_staff  B WHERE A.CHR_EMPID=B.CHR_EMPID AND INT_COMPANYID="+compID +" AND B.INT_DEPARTID in("+ depId + ") AND LOGMONTH='" + month + "' AND LOGYEAR="+ year;
						sql =sql +" AND INT_BRANCHID="+branchId;					
					}
					MusterRollCalculation(request, response);
					MusterRollView(request, response);
					response.sendRedirect("Smart Attendance/ReportViewMusterCal.jsp");
				} 
				else if (action.equals("ATTmusterCal")&& btnAction.equalsIgnoreCase("View")) 
				{
					depId = request.getParameter("select");
					if (depId.equals("-1")) 
					{
						HttpSession session = request.getSession();
						java.util.ArrayList departmentList = (java.util.ArrayList) session.getAttribute("departmentList");
						for (int i = 0; i < departmentList.size(); i++) 
						{
							com.my.org.erp.bean.Department depart = (com.my.org.erp.bean.Department) departmentList.get(i);
							depId = depId + "," + depart.getDepartId();
						}
					}
					String compID = request.getParameter("company");
					String branchId = ""+request.getParameter("branch");
					
					if(branchId.equals("-1")){
						sql = "SELECT A.*,B.CHR_STAFFNAME ";
						sql = sql+ "FROM ATT_T_ATTENDANCEDETAIL A,  com_m_staff  B WHERE A.CHR_EMPID=B.CHR_EMPID AND INT_COMPANYID="+compID +" AND B.INT_DEPARTID in("+ depId + ") AND LOGMONTH='" + month + "' AND LOGYEAR="+ year;
					}
					else
					{
						sql = "SELECT A.*,B.CHR_STAFFNAME ";
						sql = sql+  "FROM ATT_T_ATTENDANCEDETAIL A,  com_m_staff  B WHERE A.CHR_EMPID=B.CHR_EMPID AND INT_COMPANYID="+compID +" AND B.INT_DEPARTID in("+ depId + ") AND LOGMONTH='" + month + "' AND LOGYEAR="+ year;
						sql =sql +" AND INT_BRANCHID="+branchId;					
					}
					MusterRollView(request, response);
					response.sendRedirect("Smart Attendance/ReportViewMusterCal.jsp");
				} 
				else if (action.equals("ATTmusterMonth")) 
				{
					sql = "SELECT A.*,B.CHR_STAFFNAME ";
					sql = sql+ "FROM ATT_T_ATTENDANCEDETAIL A,  com_m_staff  B WHERE A.CHR_EMPID=B.CHR_EMPID AND LOGMONTH='"+ month + "' AND LOGYEAR=" + year;sql = sql + " AND B.INT_COMPANYID="+compId;
					if(!branchId.equals("-1"))
						sql=sql+" AND B.INT_BRANCHID="+branchId;
					MusterRollView(request, response);
					response.sendRedirect("Smart Attendance/ReportViewMuster.jsp");
				} 
				else if (action.equals("ATTMUSTERMONTHDEPT")) 
				{
					depId = request.getParameter("select");
					sql = "SELECT A.*,B.CHR_STAFFNAME ";
					sql = sql
						+ "FROM ATT_T_ATTENDANCEDETAIL A,  com_m_staff  B WHERE A.CHR_EMPID=B.CHR_EMPID AND B.INT_DEPARTID in("
						+ depId + ") AND LOGMONTH='" + month + "' AND LOGYEAR="
						+ year;
					MusterRollView(request, response);
					response.sendRedirect("Smart Attendance/ReportViewMuster.jsp");
				} 
				else if (action.equals("ATTMUSTERMONTHDESIG")) 
				{
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














