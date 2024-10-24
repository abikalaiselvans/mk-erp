package com.my.org.erp.SmartPayroll;

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

public class RecoveryActionHandler extends AbstractActionHandler 
{
	
	 
	

	private void witeFile(String sql, String repName) {
		try {
			String fline = "";
			String columns = "";
			String sql1 = "";
			int rcount = 0;
			Statement st = con.createStatement();
			ResultSet rs = st.executeQuery("SELECT * FROM PAY_M_RECOVERY");
			while (rs.next()) {
				columns = columns + rs.getString("CHR_RNAME") + "~";
			}
			fline = fline + repName + "\n";
			fline = fline + "Emp Id~Name~Department~Designation~" + columns	+ "\n";
			//System.out.println(fline);
			sql1 = sql;
			rs = st.executeQuery(sql1);
			while (rs.next()) {
				fline = fline + rs.getString(1) + "^";
				fline = fline + rs.getString(2) + "^";
				fline = fline + rs.getString(3) + "^";
				fline = fline + rs.getString(4) + "^";
				fline = fline + rs.getString(5) + "^";
				fline = fline + rs.getString(6) + "^";
				fline = fline + rs.getString(7) + "^";
				fline = fline + rs.getString(8) + "^";
				fline = fline + rs.getString(9) + "^";
				fline = fline + rs.getString(10) + "^";
				fline = fline + rs.getString(11) + "^\n";
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

		}
	}

	private void RecoveryAdd(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			Statement st = null;
			st = con.createStatement();
			String recCode = request.getParameter("rcode");
			String recName = request.getParameter("rname");
			String changes  = ""+request.getParameter("changes").trim();
			if("M".equals(changes))
				changes="Y";
			else if("Y".equals(changes))
				changes="N";
			else if("null".equals(changes))
				changes="N";
			
			String sql = "INSERT INTO pay_m_recovery(CHR_RCODE,CHR_RNAME, CHR_MONTHFLAG) VALUES('"+recCode+"','"+recName+"',  '"+changes+"')";
			st.execute(sql);
			String f =recCode.replace("R00","");
			sql =" ALTER TABLE PAY_T_RECOVERY ADD COLUMN " + recCode+ " INT(10) default '0' after  R00"+(Integer.parseInt(f)-1);
			st.execute(sql);
			sql =" ALTER TABLE pay_t_salaryrecovery ADD COLUMN " + recCode+ " INT(10) default '0' after  R00"+(Integer.parseInt(f)-1);
			st.execute(sql);
			sql =" ALTER TABLE pay_t_salary ADD COLUMN " + recCode+ " INT(10) default '0' after  R00"+(Integer.parseInt(f)-1);
			st.execute(sql);
			
			 
		}

		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
		}
	}

	
	
	private void RecoveryEdit(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String rowid = request.getParameter("rowid");
			String changes = request.getParameter("changes");
			String recName = request.getParameter("rname");
			asql = " UPDATE pay_m_recovery SET CHR_RNAME=?, CHR_MONTHFLAG=? WHERE INT_RECOVERYID=?";
			apstm = con.prepareStatement(asql);
			apstm.setString(1, recName);
			apstm.setString(2, changes);
			apstm.setString(3, rowid);
			apstm.execute();
			System.out.println(""+apstm);
			apstm.close();
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
			 
		}
	}

	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			if (action.equals("PAYrecoveryAdd")) 
			{
				RecoveryAdd(request, response);
				response.sendRedirect("Smart Payroll/RecoveryView.jsp");
			}
			else if (action.equals("PAYrecoveryEdit")) 
			{
				RecoveryEdit(request, response);
				con.close();    
				response.sendRedirect("Smart Payroll/RecoveryView.jsp");
			}
			else if (action.equals("PAYRecoveryDepartmentView")) 
			{
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
				String departmentid = request.getParameter("Department");
				repName =repName + " ~ Recovery Details - Department Wise";
				sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME,B.R001,B.R002,B.R003,B.R003,B.R004,B.R005,B.R006,B.R007 ";
				sql = sql + " FROM  com_m_staff  A,PAY_T_SALARYRECOVERY B,  com_m_depart   C, com_m_desig  D WHERE A.CHR_EMPID=B.CHR_EMPID";
				sql = sql + " AND A.INT_DESIGID=D.INT_DESIGID AND A.INT_DEPARTID=C.INT_DEPARTID AND ";
				if (departmentid.equals("-1"))
					sql = sql + " A.INT_DEPARTID IN (SELECT INT_DEPARTID FROM   com_m_depart  )";
				else
					sql = sql + " A.INT_DEPARTID=" + departmentid;
				sql=sql+" AND A.INT_COMPANYID="+compId;
				if(!branchId.equals("-1"))
					sql=sql+" AND A.INT_BRANCHID="+branchId;
				witeFile(sql, repName);
				 
				response.sendRedirect("Smart Payroll/ReportViewRecovery.jsp");
			} else if (action.equals("PAYRecoveryDesignationView")) {
				//System.out.println("CONTROL FROM PAYROLL RECOVERY_DESIGNATION_VIEW IN ReciveryActionHandler");
				String compId= request.getParameter("company");
				String branchId= request.getParameter("branch");
				String compName= com.my.org.erp.common.CommonInfo.stringGetAnySelectField("Select CHR_COMPANYNAME from  com_m_company  where INT_COMPANYID="+compId, "CHR_COMPANYNAME");
				String sql="Select CHR_BRANCHNAME from  com_m_branch  where INT_BRANCHID="+branchId;
				//System.out.println("SQL :"+sql);
				String repName = "Company : "+compName;
				if(!branchId.equals("-1")){
					String branchName=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql,"CHR_BRANCHNAME");
					repName=repName+ " ~ Branch : "+branchName;
				}
				else				
					repName=repName+ " ~ Branch : All ";
				
				String desigid = request.getParameter("Designation");
				repName =repName + " ~ Recovery Details - Designation Wise";
				sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME,B.R001,B.R002,B.R003,B.R003,B.R004,B.R005,B.R006,B.R007 ";
				sql = sql + " FROM  com_m_staff  A,PAY_T_SALARYRECOVERY B,  com_m_depart   C, com_m_desig  D WHERE A.CHR_EMPID=B.CHR_EMPID ";
				sql = sql + " AND A.INT_DEPARTID=C.INT_DEPARTID ";
				sql = sql + " AND A.INT_DESIGID=D.INT_DESIGID AND ";
				 
				if (desigid.equals("-1"))
					sql = sql+ " A.INT_DESIGID IN (SELECT INT_DESIGID FROM  com_m_desig )";
				else
					sql = sql + "A.INT_DESIGID=" + desigid;
				sql=sql+" AND A.INT_COMPANYID="+compId;
				//System.out.println("SQL : "+sql);
				if(!branchId.equals("-1"))
					sql=sql+" AND A.INT_BRANCHID="+branchId;
				witeFile(sql, repName);
				
				response.sendRedirect("Smart Payroll/ReportViewRecovery.jsp");
			} 
			else if (action.equals("PAYRecoveryMonthView")) 
			{
				//System.out.println("CONTROL FROM PAYROLL RECOVERY_MONTH_VIEW IN ReciveryActionHandler");
				String compId= request.getParameter("company");
				String branchId= request.getParameter("branch");
				String month = request.getParameter("month");
				String mon = DateUtil.getMonth(Integer.parseInt(month));
				String year = request.getParameter("year");
				String sql="";
				String ksql="company="+compId+"&branch="+branchId+"&month="+mon+"&year="+year;
				
				/*
				 * 
				 String compName= com.my.org.erp.common.CommonInfo.stringGetAnySelectField("Select CHR_COMPANYNAME from  com_m_company  where INT_COMPANYID="+compId, "CHR_COMPANYNAME");
				String sql="Select CHR_BRANCHNAME from  com_m_branch  where INT_BRANCHID="+branchId;
				//System.out.println("SQL :"+sql);
				String repName = "Company : "+compName;
				if(!branchId.equals("-1")){
					String branchName=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql,"CHR_BRANCHNAME");
					repName=repName+ " ~ Branch : "+branchName;
				}
				else				
					repName=repName+ " ~ Branch : All ";
				repName =repName + " ~ Recovery  Details - Month Wise";
				repName = repName + "  ( " + month.toUpperCase() + " - "+ year.toUpperCase() + " ) ";
				*/
				sql = "SELECT A.CHR_EMPID,A.CHR_STAFFNAME,C.CHR_DEPARTNAME,D.CHR_DESIGNAME,B.* ";
				sql = sql+ " FROM  com_m_staff  A,PAY_T_SALARYRECOVERY B,  com_m_depart   C, com_m_desig  D WHERE A.CHR_EMPID=B.CHR_EMPID";
				sql = sql+ " AND A.INT_DESIGID=D.INT_DESIGID AND A.INT_DEPARTID=C.INT_DEPARTID AND B.CHR_MONTH='"+ month + "'AND ";
				sql = sql + " B.INT_YEAR=" + Integer.parseInt(year);
				sql=sql+" AND A.INT_COMPANYID="+compId;
				if(!branchId.equals("-1"))
					sql=sql+" AND A.INT_BRANCHID="+branchId;
				 
				//reportWiteFile(sql, repName);
				//response.sendRedirect("Smart Payroll/ReportViewRecovery.jsp");
				response.sendRedirect("Smart Payroll/ReptViewRecovery.jsp?"+ksql);
				
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
