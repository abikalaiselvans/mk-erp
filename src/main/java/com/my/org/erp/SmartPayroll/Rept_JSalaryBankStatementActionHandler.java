package com.my.org.erp.SmartPayroll;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JasperPrint;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.SmartReport.ReportFunctions;

public class Rept_JSalaryBankStatementActionHandler extends AbstractActionHandler 
{
	 
	JasperPrint jasperPrint;
	JRExporter exporter;
	String company,branch,Office,bg,month,year,repmon;
	String Category,dept,reportheader; 
	public String getSqlQuery()
	{
		
		asql = "  SELECT "; 
		asql = asql +"  if(FIND_A_BANKGROUP_NAME(b.CHR_BANK) ='STANDARD CHARTERED BANK','BT','ACH'  ) paymentType,DATE_FORMAT(NOW(),'%d/%m/%Y'), ";
		asql = asql +"  FLOOR(ROUND(a.DOU_MONTHSAL,2)), ";
		asql = asql +"  a.CHR_EMPNAME,CONCAT('',a.CHR_ACCNO), ";
		asql = asql +"  if(FIND_A_BANKGROUP_NAME(b.CHR_BANK) ='STANDARD CHARTERED BANK','SCBLINBBXXX', b.CHR_IFSC  ) IFSC";
		asql = asql +"  ,b.CHR_EMAILID,a.CHR_EMPNAME, ";
		asql = asql +"  CONCAT('Salary for the month of "+repmon.toUpperCase()+"','"+year+"') descri ,d.CHR_OFFICENAME,f.CHR_CATEGORYNAME ";
		asql = asql +"  FROM  pay_t_salary a , com_m_staff b,  com_m_office d, com_m_depart e, com_m_employeecategory f  ";
		asql = asql +"   WHERE  a.CHR_EMPID =b.CHR_EMPID  ";
		asql = asql +"  AND a.INT_OFFICEID = d.INT_OFFICEID  ";
		asql = asql +"  AND a.INT_DEPARTID = e.INT_DEPARTID  "; 
		asql = asql +"  AND  b.CHR_CATEGORY=f.INT_EMPLOYEECATEGORYID  ";
		if(!"0".equals(company))
			asql = asql +"  AND b.INT_COMPANYID="+company;
		if(!"0".equals(branch))
			asql = asql +"  AND b.INT_BRANCHID="+branch;
		if(!"0".equals(Office))
			asql = asql +"  AND b.INT_OFFICEID="+Office;
		if(!"0".equals(dept))
			asql = asql +"  AND b.INT_DEPARTID="+dept;
		if(!"0".equals(Category))
			asql = asql +"   AND b.CHR_CATEGORY='"+Category +"' ";	
	
		asql = asql +"   AND a.CHR_MONTH='"+repmon+"' AND a.INT_YEAR="+year;
 		asql = asql+ " GROUP BY a.CHR_EMPID ORDER BY FIND_A_BANKGROUP_NAME(b.CHR_BANK),a.CHR_EMPNAME   "; 
 		System.out.println("PAYSalaryBankReport sql:"+asql);
 		
		 return asql;
	}
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			company = request.getParameter("company");
			branch = request.getParameter("branch");
			Office = request.getParameter("Office");
			bg = request.getParameter("bg");
			month= ""+request.getParameter("Month");
			year= ""+request.getParameter("Year");
			repmon = DateUtil.getMonth(Integer.parseInt( month));
			Category= ""+request.getParameter("Category");
			dept= ""+request.getParameter("dept");
			reportheader="SALARY BANK LIST REPORT FOR THE MONTH  "+repmon.toUpperCase() +"   YEAR  "+year; 
			
	
				
			 HashMap<Object,Object> map = new HashMap<Object,Object>();
			
			if(action.equals("PAYSalaryBankReport")) 
			{
				asql=getSqlQuery();
				File reportsDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportsDir, rptfilename, asql, con, Path,map);
				ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
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
