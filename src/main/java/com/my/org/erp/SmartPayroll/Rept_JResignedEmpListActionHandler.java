package com.my.org.erp.SmartPayroll;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.util.SimpleFileResolver;
 
import com.my.org.erp.Date.Day;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JResignedEmpListActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String cmpyname="";
	String officename="";
	String deptname="";
	String hImageExpression="";
	String fImageExpression="";

	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		System.out.println("insite PAYRept_JAdvanceAll");
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			String Office= request.getParameter("Office");
			String Dept= request.getParameter("dept");
			String fmdate= request.getParameter("frmdate");
			fmdate=DateUtil.FormateDateSQL(fmdate);
			String todate= request.getParameter("todate");
			todate=DateUtil.FormateDateSQL(todate);
			String orderby= request.getParameter("orderby");
			
				
			if (action.equals("PAYRept_JResignedEmpList")) 
			{
			System.out.println("insite PAYRept_JAdvanceAll");
				
				File reportDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				map.put("fdate", fmdate);
				map.put("tdate", todate);
				
				asql="SELECT a.CHR_EMPID,a.CHR_STAFFNAME,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'), ";
			 asql = asql +" DATE_FORMAT(b.DT_TERM_DATE,'%d-%b-%Y'),c.CHR_OFFICENAME,d.CHR_DESIGNAME,e.CHR_CATEGORYNAME,ROUND(f.DOU_ORIGINALCTC)  FROM   com_m_staff a, pay_m_emp_termination b ,  com_m_office  c ,com_m_desig d , com_m_employeecategory  e ,pay_t_salary f ";
			 asql = asql +" WHERE  a.INT_OFFICEID = c.INT_OFFICEID AND a.INT_DESIGID = d.INT_DESIGID AND a.CHR_CATEGORY = e.INT_EMPLOYEECATEGORYID  AND a.CHR_EMPID = b.CHR_EMPID ";
			 asql = asql +" AND a.CHR_EMPID = f.CHR_EMPID ";
			 asql = asql +" AND f.CHR_MONTH = (select  MONTHNAME(DATE_FORMAT(DATE_SUB(b.DT_TERM_DATE, INTERVAL 1 MONTH),'%Y-%m-%d')) ) ";
			 asql = asql +" AND f.INT_YEAR = (select  YEAR(DATE_FORMAT(DATE_SUB(b.DT_TERM_DATE, INTERVAL 1 MONTH),'%Y-%m-%d')) ) ";
		     asql = asql+" AND b.DT_TERM_DATE >= '"+fmdate+"' ";
			 asql = asql+" AND b.DT_TERM_DATE <= '"+todate+"' ";
			 
			 if(!"0".equals(Office))
				asql = asql+" AND a.INT_OFFICEID="+Office;
			 if(!"0".equals(Dept))
				asql = asql+" AND a.INT_DEPARTID= "+Dept;
			 asql = asql + " ORDER BY "+orderby;
						
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, asql, con, Path,map);
				ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
				
			}
		
		} catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response);
		}
	}
}