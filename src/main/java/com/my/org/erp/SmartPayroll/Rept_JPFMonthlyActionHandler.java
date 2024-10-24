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

public class Rept_JPFMonthlyActionHandler extends AbstractActionHandler 
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
			
			if (action.equals("PAYRept_JPFMonthly")) 
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
				
				String sql="";
				String company="";
				String branch="";
				String Office="";
				String cpy="";
				String bra="";
				String off="";
				String Month="";
				String Year="";
				company = request.getParameter("company");
				branch = request.getParameter("branch");
				Office = request.getParameter("Office");
				Month = request.getParameter("Month");
				Year = request.getParameter("Year");
				//request.getParameterValues("type");
				
				String repmon = DateUtil.getMonth(Integer.parseInt( Month));
				
				
				asql ="SELECT a.CHR_EMPID,upper(a.CHR_EMPNAME) ,d.CHR_COMPANYNAME,e.CHR_BRANCHNAME,c.CHR_OFFICENAME, ";
				asql = asql +" CONCAT(d.CHR_PFNUMBER,b.CHR_PFNO),ROUND(a.DOU_BASIC),ROUND(a.DOU_PENBASIC),ROUND(a.DOU_PF), ";
				asql = asql +" ROUND(a.DOU_COMPANYPF),ROUND(a.DOU_COMPANYPENSION), ";
				asql = asql +" ROUND(a.DOU_ADMINCHARGE),ROUND(a.DOU_EDLI),ROUND(a.DOU_ADMINCHARGE1),DATE_FORMAT(b.DAT_PFESIDATE,'%d-%b-%Y'),ROUND(DOU_WORKDAYS) ";
				asql = asql +" FROM pay_t_salary a ,com_m_staff b, com_m_office  c,com_m_company d,com_m_branch e ";
				asql = asql +" WHERE a.CHR_EMPID = b.CHR_EMPID ";
				asql = asql +" AND b.INT_OFFICEID = c.INT_OFFICEID ";
				asql = asql +" AND b.INT_COMPANYID=d.INT_COMPANYID ";
				asql = asql +" AND b.INT_BRANCHID=e.INT_BRANCHID AND a.CHR_PF !='N'  ";
				 
				asql = asql +" AND b.INT_COMPANYID=  "+company;
				if(!"0".equals(branch))
					asql = asql +" AND b.INT_BRANCHID=  "+branch;
				if(!"0".equals(Office))
					asql = asql +" AND b.INT_OFFICEID=  "+Office;
				asql = asql +" AND a.INT_YEAR= "+Year;
				asql = asql +" AND a.CHR_MONTH='"+repmon+"' ";
				 
				asql = asql +" ORDER BY b.CHR_PFNO ";  

				map.put("month", repmon);
				map.put("year", Year);
				
						
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