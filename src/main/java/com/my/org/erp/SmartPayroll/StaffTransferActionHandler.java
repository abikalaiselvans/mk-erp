package com.my.org.erp.SmartPayroll;

import java.io.IOException;
 
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class StaffTransferActionHandler extends AbstractActionHandler {
	Statement st;

	ResultSet rs;

	PreparedStatement pstm;

	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String userid = (String) session.getAttribute("USRID");
			String sql="";
			if (action.equals("PAYStaffTransferAdd")) 
			{
				String empid = "" + request.getParameter("staffid");
				String fromcompany = "" + request.getParameter("fromcompany");
				String frombranch = "" + request.getParameter("frombranch");
				String fromdesig = "" + request.getParameter("fromdesig");
				String fromdepart = "" + request.getParameter("fromdepart");
				String fromoffice = "" + request.getParameter("fromoffice");
				String fromlocation = "" + request.getParameter("fromlocation");
				String fromcategory = "" + request.getParameter("fromcategory");
				String fromattendancecycle = "" + request.getParameter("fromattendancecycle");
				String fromreportingto = "" + request.getParameter("fromreportingto");
				String fromstafftype = "" + request.getParameter("fromstafftype");
				String frompfcalculationtype = "" + request.getParameter("frompfcalculationtype");
				String fromemployeetype = "" + request.getParameter("fromemployeetype");

				String company = "" + request.getParameter("company");
				String branch = "" + request.getParameter("branch");
				String desigination = "" + request.getParameter("desigination");
				String department = "" + request.getParameter("department");
				String office = "" + request.getParameter("office");
				String location = "" + request.getParameter("location");
				String Category = "" + request.getParameter("category");
				String attendancecycle = "" + request.getParameter("attendancecycle");
				String repto = "" + request.getParameter("repto");
				String stafftype = "" + request.getParameter("stafftype");
				String pfcalculationtype = "" + request.getParameter("pfcalculationtype");
				String Transferdate = "" + request.getParameter("transferdate");
				Transferdate = DateUtil.FormateDateSQL(Transferdate);
				String releavingdate = "" + request.getParameter("releavingdate");
				releavingdate = DateUtil.FormateDateSQL(releavingdate);
				String TxtAuthorised = "" + request.getParameter("txtauthorised");
				String reason = "" + request.getParameter("reason");
				String employeetype = "" + request.getParameter("employeetype");
				
				
				acs = con.prepareCall("{call  PAY_PRO_EMPLOYEETRANSFER (?,?,?,?,?,?,?,?,?,?,?,?," +
						"?,?,?,?,?,?,?,?,?,?," +
						"?,?,?,?,?,?,?,?,?,?)}");
				acs.setString(1, "INSERT");
				acs.setString(2, "");
				acs.setString(3, empid.trim());
				acs.setString(4, fromcompany.trim());
				acs.setString(5, frombranch.trim());
				acs.setString(6, fromdesig.trim());
				acs.setString(7, fromdepart.trim());
				acs.setString(8, fromoffice.trim());
				acs.setString(9, company.trim() );
				acs.setString(10, branch.trim());
				acs.setString(11, desigination.trim());
				acs.setString(12, department.trim());
				acs.setString(13, office.trim());
				acs.setString(14, Transferdate.trim());
				acs.setString(15, releavingdate.trim());
				acs.setString(16, TxtAuthorised.trim());
				acs.setString(17, reason.trim());
				acs.setString(18, userid.trim());
				acs.setString(19, fromcategory.trim());
				acs.setString(20, Category.trim());
				acs.setString(21,fromattendancecycle);
				acs.setString(22, attendancecycle);
				acs.setString(23, fromreportingto.trim());
				acs.setString(24, repto.trim());
				acs.setString(25, fromstafftype);
				acs.setString(26, stafftype);
				acs.setString(27, fromlocation);
				acs.setString(28, location);
				acs.setString(29, frompfcalculationtype);
				acs.setString(30, pfcalculationtype);
				acs.setString(31,fromemployeetype );
				acs.setString(32,employeetype );
				
				System.out.println(""+acs);
				acs.execute();
				acs.close();
				con.close();    
				response.sendRedirect("Smart Payroll/EmployeTransfer.jsp");
			} 
			else if (action.equals("PAYStaffTransferUpdate")) 
			{ 
				String rowid = request.getParameter("rowid");
				String fromcompany = "" + request.getParameter("fromcompany");
				String frombranch = "" + request.getParameter("frombranch");
				String fromdesig = "" + request.getParameter("fromdesig");
				String fromdepart = "" + request.getParameter("fromdepart");
				String fromoffice = "" + request.getParameter("fromoffice");
				String fromcategory = "" + request.getParameter("fromcategory");
				String fromlocation = "" + request.getParameter("fromlocation");
				String fromattendancecycle = "" + request.getParameter("fromattendancecycle");
				String fromreportingto = "" + request.getParameter("fromreportingto");
				String fromstafftype = "" + request.getParameter("fromstafftype");
				String frompfcalculationtype = "" + request.getParameter("frompfcalculationtype");
				String fromemployeetype = "" + request.getParameter("fromemployeetype");

				String company = "" + request.getParameter("company");
				String branch = "" + request.getParameter("branch");
				String desigination = "" + request.getParameter("desigination");
				String department = "" + request.getParameter("department");
				String office = "" + request.getParameter("office");
				String Category = "" + request.getParameter("category");
				String location = "" + request.getParameter("location");
				String attendancecycle = "" + request.getParameter("attendancecycle");
				String repto = "" + request.getParameter("repto");
				String stafftype = "" + request.getParameter("stafftype");
				String pfcalculationtype = "" + request.getParameter("pfcalculationtype");
				String employeetype = "" + request.getParameter("employeetype");
				String Transferdate = "" + request.getParameter("transferdate");
				Transferdate = DateUtil.FormateDateSQL(Transferdate);
				String releavingdate = "" + request.getParameter("releavingdate");
				releavingdate = DateUtil.FormateDateSQL(releavingdate);
				String TxtAuthorised = "" + request.getParameter("txtauthorised");
				String reason = "" + request.getParameter("reason");
				acs = con.prepareCall("{call  PAY_PRO_EMPLOYEETRANSFER (?,?,?,?,?,?,?,?,?,?,?,?," +
						"?,?,?,?,?,?,?,?,?,?," +
						"?,?,?,?,?,?,?,?,?,?)}");
				acs.setString(1, "UPDATE");
				acs.setString(2, rowid);
				acs.setString(3, "");
				acs.setString(4, fromcompany.trim());
				acs.setString(5, frombranch.trim());
				acs.setString(6, fromdesig.trim());
				acs.setString(7, fromdepart.trim());
				acs.setString(8, fromoffice.trim());
				acs.setString(9, company.trim() );
				acs.setString(10, branch.trim());
				acs.setString(11, desigination.trim());
				acs.setString(12, department.trim());
				acs.setString(13, office.trim());
				acs.setString(14, Transferdate.trim());
				acs.setString(15, releavingdate.trim());
				acs.setString(16, TxtAuthorised.trim());
				acs.setString(17, reason.trim());
				acs.setString(18, userid.trim());
				acs.setString(19, fromcategory.trim());
				acs.setString(20, Category.trim());
				acs.setString(21,fromattendancecycle);
				acs.setString(22, attendancecycle);
				acs.setString(23, fromreportingto.trim());
				acs.setString(24, repto.trim());
				acs.setString(25, fromstafftype);
				acs.setString(26, stafftype);
				acs.setString(27, fromlocation);
				acs.setString(28, location);
				acs.setString(29, frompfcalculationtype);
				acs.setString(30, pfcalculationtype);
				acs.setString(31,fromemployeetype );
				acs.setString(32,employeetype );
				System.out.println(""+acs);
				acs.execute();
				acs.close();
				con.close();    
				response.sendRedirect("Smart Payroll/EmployeTransfer.jsp");
			
			} 
			else if (action.equals("PAYStaffTransferDelete")) 
			{
				String staffid[] = request.getParameterValues("staffid");
				acs = con.prepareCall("{call  PAY_PRO_EMPLOYEETRANSFER (?,?,?,?,?,?,?,?,?,?," +
						"?,?,?,?,?,?,?,?,?,?," +
						"?,?,?,?,?,?,?,?,?,?," +
						"?,?)}");
				
				for (int u = 0; u < staffid.length; u++) 
				{
					
					sql = " SELECT  ";
					sql = sql +" CHR_EMPID,INT_FROM_COMPANYID,INT_FROM_BRANCHID,INT_FROM_DESIGID,INT_FROM_DEPARTID,INT_FROM_OFFICEID, ";
					sql = sql +" INT_TO_COMPANYID,INT_TO_BRANCHID,INT_TO_DESIGID,INT_TO_DEPARTID,INT_TO_OFFICEID, ";
					sql = sql +" DT_TRANSFERDATE,DT_RELEAVINGFROM,CHR_AUTHORITY,CHR_REASON,INT_TRANSFER_ID ,INT_FROM_CATEGORY,";
					sql = sql +" INT_TO_CATEGORY, INT_FROMATTENDANCECYCLE , INT_ATTENDANCECYCLE, CHR_FROM_REPTO,CHR_TO_REPTO,CHR_FROM_TYPE,CHR_TO_TYPE , ";
					sql = sql +" INT_FROM_LOCATIONID,INT_TO_LOCATIONID,CHR_FROM_PFCALCULATIONTYPE,CHR_TO_PFCALCULATIONTYPE,CHR_EMPLOYEE_FROM,CHR_EMPLOYEE_TO ";
					sql = sql +" FROM pay_m_emp_transfer ";
					sql = sql +" WHERE   CHR_EMPID='"+staffid[u]+"'   ORDER BY INT_TRANSFER_ID DESC ";
					String Datas[][] = CommonFunctions.QueryExecute(sql);
					if(Datas.length >0)
					{
						acs.setString(1, "DELETE");
						acs.setString(2, Datas[0][15]);
						acs.setString(3, Datas[0][0]);
						acs.setString(4, Datas[0][1]);
						acs.setString(5, Datas[0][2]);
						acs.setString(6, Datas[0][3]);
						acs.setString(7, Datas[0][4]);
						acs.setString(8, Datas[0][5]);
						acs.setString(9, Datas[0][6] );
						acs.setString(10, Datas[0][7]);
						acs.setString(11, Datas[0][8]);
						acs.setString(12, Datas[0][9]);
						acs.setString(13, Datas[0][10]);
						acs.setString(14, Datas[0][11]);
						acs.setString(15, Datas[0][12]);
						acs.setString(16, Datas[0][13]);
						acs.setString(17, Datas[0][14]);
						acs.setString(18, "");
						acs.setString(19, Datas[0][16]);
						acs.setString(20, Datas[0][17] );
						acs.setString(21, Datas[0][18]);
						acs.setString(22, Datas[0][19]);
						acs.setString(23, Datas[0][20]);
						acs.setString(24, Datas[0][21]);
						acs.setString(25, Datas[0][22]);
						acs.setString(26, Datas[0][23]);
						acs.setString(27, Datas[0][24]);
						acs.setString(28, Datas[0][25]);
						acs.setString(29, Datas[0][26]);
						acs.setString(30, Datas[0][27]);
						acs.setString(31, Datas[0][28]);
						acs.setString(32, Datas[0][29]);
						System.out.println(""+acs);
						acs.addBatch();
					} 
				}
				acs.executeBatch();
				acs.close();
				con.close();    
				response.sendRedirect("Smart Payroll/EmployeTransfer.jsp");
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
