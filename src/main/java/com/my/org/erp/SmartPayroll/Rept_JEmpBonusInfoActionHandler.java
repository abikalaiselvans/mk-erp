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
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
 

public class Rept_JEmpBonusInfoActionHandler extends AbstractActionHandler 
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
		System.out.println("insite Rept_JEmpBonusInfo");
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			
			
				
			if (action.equals("PAYRept_JEmpBonusInfo")) 
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
				
				String company =request.getParameter("company");
				String branch=request.getParameter("branch");
				String Office=request.getParameter("Office");
				String dept=request.getParameter("dept");
				String year=request.getParameter("year");
				String Category=request.getParameter("Category");
				 				 
				asql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME ,b.DOU_TOTALBASIC,b.DOU_BONUS,b.DOU_BONUSAMOUNT,a.CHR_TYPE,a.CHR_HOLD  ";
				asql = asql +" ,c.CHR_COMPANYNAME,d.CHR_BRANCHNAME,e.CHR_DEPARTNAME,f.CHR_OFFICENAME,h.CHR_CATEGORYNAME ,b.DOU_APR,b.DOU_MAY";
				asql=asql+",b.DOU_JUN,b.DOU_JUL,b.DOU_AUG,b.DOU_SEP,b.DOU_OCT,b.DOU_NOV,b.DOU_DEC,b.DOU_JAN,b.DOU_FEB,b.DOU_MAR";
				asql = asql +" ,a.CHR_ACCNO ,FIND_A_BANKGROUP_NAME(a.CHR_BANK),b.DOU_WORKDAYS FROM com_m_staff a,pay_t_bonus b,com_m_company c,com_m_branch d ,";
				asql = asql +" com_m_depart e , com_m_office  f , com_m_employeecategory  h WHERE  a.CHR_EMPID is not null ";//a.CHR_TYPE !='T' 
				 
				asql = asql +" AND b.CHR_EMPID=a.CHR_EMPID  ";
				asql = asql +" AND a.INT_COMPANYID =c.INT_COMPANYID  ";
				
				asql = asql +" AND a.INT_BRANCHID =d.INT_BRANCHID   AND a.CHR_CATEGORY = h.INT_EMPLOYEECATEGORYID";
				asql = asql +" AND a.INT_DEPARTID = e.INT_DEPARTID  ";
				asql = asql +" AND a.INT_OFFICEID= f.INT_OFFICEID AND b.INT_YEAR="+year; 
				if(!"0".equals(Category))
					asql = asql+" AND a.CHR_CATEGORY ="+ Category;
				
			   if(!"0".equals(company))
					asql = asql+" AND a.INT_COMPANYID ="+ company;
					
				if(!"0".equals(branch))
					asql = asql+" AND a.INT_BRANCHID ="+ branch;
					
				if(!"0".equals(dept))
					asql = asql+" AND a.INT_DEPARTID ="+ dept;
					
				if(!"0".equals(Office))
					asql = asql+" AND a.INT_OFFICEID ="+ Office;
					
				 asql= asql+" ORDER BY a.CHR_STAFFNAME ";
				System.out.println(asql);
				map.put("year", year);		
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