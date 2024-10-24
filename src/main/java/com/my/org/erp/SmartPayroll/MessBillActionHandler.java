package com.my.org.erp.SmartPayroll;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.bean.payroll.Messbill;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

public class MessBillActionHandler extends AbstractActionHandler {
	String empId, empName, msg;
	int courseId;
	private void messBillList(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {

			ArrayList<Messbill> messList = new ArrayList<Messbill>();
			Statement st = con.createStatement();
			empId = request.getParameter("ename");
			ResultSet rs = st.executeQuery("SELECT A.*,B.CHR_STAFFNAME FROM PAY_M_MESSBILL A, com_m_staff  B WHERE A.CHR_EMPID=B.CHR_EMPID AND A.CHR_EMPID='"	+ empId + "'");
			if (rs.next()) {
				empId = rs.getString("CHR_EMPID");
				int year = rs.getInt("INT_YEAR");
				String month = rs.getString("CHR_MONTH");
				String chequeNo = rs.getString("CHR_CHEQUENO");
				int cashAmt = rs.getInt("INT_CASHAMT");
				empName = rs.getString("CHR_STAFFNAME");
				Messbill messbill = new Messbill();
				messbill.setEmpId(empId);
				messbill.setEmpName(empName);
				messbill.setMonth(month);
				messbill.setYear(year);
				messbill.setChequeNo(chequeNo);
				messbill.setCashAmt(cashAmt);
				messList.add(messbill);
				msg = "List";
				
				HttpSession session = request.getSession();
				session.setAttribute("messList", messList);
			} else
				msg = "No Record Found";
			HttpSession session = request.getSession();
			session.removeAttribute("messList");
			session.setAttribute("messList", messList);
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void messBillAdd(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String empId, year, chequeNo, month;
			int amt;

			empId = request.getParameter("ename");
			year = request.getParameter("Year");
			month = request.getParameter("OptMonth");
			amt = Integer.parseInt(request.getParameter("TxtAmount"));
			chequeNo = request.getParameter("TxtChequeno");

			CallableStatement cs = con
					.prepareCall("{call PAY_PRO_MESSBILL(?,?,?,?,?,?)}");
			cs.setString(1, "INSERT");
			cs.setString(2, empId);
			cs.setString(3, year);
			cs.setString(4, month);
			cs.setInt(5, amt);
			cs.setString(6, chequeNo);
			cs.execute();
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

	private void messBillUpdate(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		try {
			String empId, year, chequeNo, month;
			int amt;

			empId = request.getParameter("empId");
			year = request.getParameter("Year");
			month = request.getParameter("OptMonth");
			amt = Integer.parseInt(request.getParameter("TxtAmount"));
			chequeNo = request.getParameter("TxtChequeno");

			CallableStatement cs = con
					.prepareCall("{call PAY_PRO_MESSBILL(?,?,?,?,?,?)}");
			cs.setString(1, "UPDATE");
			cs.setString(2, empId);
			cs.setString(3, year);
			cs.setString(4, month);
			cs.setInt(5, amt);
			cs.setString(6, chequeNo);
			cs.execute();
			//System.out.println("In Mess Bill UPDATE  FUNCTION " + empId);
		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}
	
	private void witeFile(String sql, String repName, String repHeader) {
		try {
			String fline = "";
			String sql1 = "";
			int rcount = 0;
			Statement st = con.createStatement();
			ResultSet rs;
			String filename = "Report.sys";
			FileWriter fw = new FileWriter(filename);
			BufferedWriter bw = new BufferedWriter(fw);
			bw.write("");
			fline = fline + repName + "\n";
			fline = fline + repHeader + "\n";
			sql1 = sql;
			rs = st.executeQuery(sql1);
			while (rs.next()) {
				fline = fline + "  " + rs.getString(1) + "^";
				fline = fline + "  " + rs.getString(2) + "^";
				fline = fline + "  " + rs.getString(3) + "^";
				fline = fline + "  " + rs.getString(4) + "^";
				fline = fline + "  " + rs.getString(5) + "^";
				fline = fline + "  " + rs.getString(6) + "^\n";
				rcount = rcount + 1;
			}
			if (rcount < 1)
				fline = fline + "Record not found...^\n";
			//System.out.println(fline);

			bw.write(fline);
			bw.close();

		} catch (Exception e) {
		}
	}

	public void handle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		try {
			String sumAct = null;
			String action = request.getParameter("actionS");
			//System.out.println("In Mess Bill Action " + action);
			if (action.equals("PAYMessBillDepartmentView")) {
				String deptid = request.getParameter("Department");
				String compId= request.getParameter("company");
				String branchId= request.getParameter("branch");
				String compName= com.my.org.erp.common.CommonInfo.stringGetAnySelectField("Select CHR_COMPANYNAME from  com_m_company  where INT_COMPANYID="+compId, "CHR_COMPANYNAME");
				String sql="Select CHR_BRANCHNAME from  com_m_branch  where INT_BRANCHID="+branchId;				
				String repName = "Company : "+compName;
				if(!branchId.equals("-1")){
					String branchName=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql,"CHR_BRANCHNAME");
					repName=repName+ " ~ Branch : "+branchName;
				}
				else				
					repName=repName+ " ~ Branch : All ";				
				repName = repName+ " ~ Mess Bill Details - Department Wise";
				String repHeader = "Emp Id^Name^Department^Designation^Cheque No^Amount";				
				sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_DEPARTNAME,D.CHR_DESIGNAME,C.CHR_CHEQUENO,C.INT_CASHAMT ";
				sql = sql+ " FROM  com_m_staff  A,  com_m_depart   B, PAY_M_MESSBILL C , com_m_desig  D";
				sql = sql+ " WHERE A.CHR_EMPID=C.CHR_EMPID  AND A.INT_DEPARTID=B.INT_DEPARTID";
				sql = sql + " AND A.INT_DESIGID=D.INT_DESIGID AND  ";
				if (deptid.equals("-1"))
					sql = sql+ "B.INT_DEPARTID IN (SELECT INT_DEPARTID FROM   com_m_depart  )";
				else
					sql = sql + "B.INT_DEPARTID=" + deptid;
				sql=sql+" AND A.INT_COMPANYID="+compId;
				if(!branchId.equals("-1"))
					sql=sql+" AND A.INT_BRANCHID="+branchId;	
				witeFile(sql, repName, repHeader);
				response.sendRedirect("Smart Payroll/ReportViewMessBill.jsp");
			} else if (action.equals("PAYMessBillDesignationView")) {
				String desgid = request.getParameter("Designation");
								
				String compId= request.getParameter("company");
				String branchId= request.getParameter("branch");
				String compName= com.my.org.erp.common.CommonInfo.stringGetAnySelectField("Select CHR_COMPANYNAME from  com_m_company  where INT_COMPANYID="+compId, "CHR_COMPANYNAME");
				String sql="Select CHR_BRANCHNAME from  com_m_branch  where INT_BRANCHID="+branchId;				
				String repName = "Company : "+compName;
				if(!branchId.equals("-1")){
					String branchName=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql,"CHR_BRANCHNAME");
					repName=repName+ " ~ Branch : "+branchName;
				}
				else				
					repName=repName+ " ~ Branch : All ";
				
				repName = repName+  " ~ Mess Bill Details - Designation Wise";
				String repHeader = "Emp Id^Name^Department^Designation^Cheque No^Amount";

				sql = " SELECT A.CHR_EMPID,A.CHR_STAFFNAME,B.CHR_DESIGNAME, D.CHR_DEPARTNAME,C.CHR_CHEQUENO,C.INT_CASHAMT ";
				sql = sql+ " FROM  com_m_staff  A, com_m_desig  B, PAY_M_MESSBILL C ,  com_m_depart   D WHERE A.CHR_EMPID=C.CHR_EMPID ";
				sql = sql+ " AND A.INT_DEPARTID = D.INT_DEPARTID  AND A.INT_DESIGID=B.INT_DESIGID AND ";
				if (desgid.equals("-1"))
					sql = sql + "B.INT_DESIGID IN (SELECT INT_DESIGID FROM  com_m_desig )";
				else
					sql = sql + "B.INT_DESIGID=" + desgid;
				sql=sql+" AND A.INT_COMPANYID="+compId;
				if(!branchId.equals("-1"))
					sql=sql+" AND A.INT_BRANCHID="+branchId;					
				witeFile(sql, repName, repHeader);
				response.sendRedirect("Smart Payroll/ReportViewMessBill.jsp");
			} else if (action.equals("PAYMessBillYearView")) {
				String year = request.getParameter("year");
				String repName = "Mess Bill Details - YearWise";
				repName = repName + " ( " + year + " ) ";
				String repHeader = "Emp Id^Name^Department^Designation^Cheque No^Amount";
				
				String sql = " SELECT A.CHR_EMPID,A.CHR_STAFFNAME,E.CHR_DEPARTNAME,D.CHR_DESIGNAME,C.CHR_CHEQUENO,C.INT_CASHAMT";
				sql = sql
						+ " FROM  com_m_staff  A,PAY_M_MESSBILL C , com_m_desig  D,   com_m_depart   E";
				sql = sql + " WHERE A.CHR_EMPID=C.CHR_EMPID ";
				sql = sql + " AND A.INT_DEPARTID =E.INT_DEPARTID ";
				sql = sql + " AND A.INT_DESIGID = D.INT_DESIGID  ";
				sql = sql + " AND C.INT_YEAR =" + Integer.parseInt(year);
				witeFile(sql, repName, repHeader);
				response.sendRedirect("Smart Payroll/ReportViewMessBill.jsp");
			} 
			else if (action.equals("PAYMessBillMonthView")) 
			{
				String month = request.getParameter("Month");				
				month=DateUtil.getMonth(Integer.parseInt(month));
				
				response.sendRedirect("Smart Payroll/ReptViewMessBill.jsp");
				
			}

			if (action.equals("PAYMessBillAdd")) {

				sumAct = request.getParameter("Submit");
				//System.out.println("In Mess Bill Action " + sumAct);
				sumAct = sumAct.trim();
			}
			if (action.equals("messBillList")) {
				messBillList(request, response);
				response
						.sendRedirect("Smart Payroll/Mess Bill.jsp?message=View");
			} else if (action.equals("PAYMessBillAdd")
					&& sumAct.equalsIgnoreCase("Submit")) {
				messBillAdd(request, response);
				// PfEsiView(request,response);
				response
						.sendRedirect("Smart Payroll/Mess Bill.jsp?message=MESS BILL Added Sucessfully");
			} else if (action.equals("PAYMessBillAdd")
					&& sumAct.equalsIgnoreCase("List")) {
				empId = request.getParameter("ename");
				//System.out.println("In Messsbill list");
				messBillList(request, response);
				response.sendRedirect("Smart Payroll/Mess Bill.jsp?message="
						+ msg + "&empId=" + empId + "&empName=" + empName);
			} else if (action.equals("PAYMessBillAdd")
					&& sumAct.equalsIgnoreCase("Update")) {
				empId = request.getParameter("empId");
				messBillUpdate(request, response);
				//System.out.println("In Mess Bill UPDATE ");
				response
						.sendRedirect("Smart Payroll/Mess Bill.jsp?message=View");
			}

		} catch (Exception e) {
			response.sendRedirect("error/index.jsp?error=" + e.getMessage());
			 System.out.println(e.getMessage());
		}
	}

}
