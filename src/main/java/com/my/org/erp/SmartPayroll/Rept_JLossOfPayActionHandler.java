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
import com.my.org.erp.ServiceLogin.DateUtil;

public class Rept_JLossOfPayActionHandler extends AbstractActionHandler 
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
			
			if (action.equals("PAYRept_JLossOfPay")) 
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
				
				String  company  = request.getParameter("company");
				String  branch  = request.getParameter("branch");
				String  Office  = request.getParameter("Office");
				String  Month  = request.getParameter("Month");
				String  Year  = request.getParameter("Year");
				String repmon = DateUtil.getMonth(Integer.parseInt( Month));
				String off="";
				if(!"0".equals(Office))
					off=" AND e.INT_OFFICEID="+Office;
				
				String cpy="";
				if(!"0".equals(company))
					cpy=" AND e.INT_COMPANYID="+company;
					
				String bch="";
				if(!"0".equals(branch))
					bch=" AND e.INT_BRANCHID="+branch;

				asql=" SELECT a.CHR_EMPID, a.CHR_EMPNAME,  a.DOU_ORIGINALCTC, a.DOU_CTC, a.DOU_LOPDAY,a.DOU_LOP,b.CHR_COMPANYNAME, ";
				asql = asql +" d.CHR_OFFICENAME,c.CHR_DEPARTNAME,f.DOU_ABSENT,f.INT_LATE,f.INT_PERMISSION FROM pay_t_salary a, com_m_staff e ,";
				asql = asql + " com_m_company b ,com_m_depart c , com_m_office  d ,att_t_register f";
				asql = asql+ " WHERE a.CHR_EMPID= f.CHR_EMPID AND a.INT_YEAR="+Year+" AND a.CHR_MONTH='"+repmon+"'  AND a.DOU_LOPDAY>0 AND a.DOU_LOP>0 AND f.INT_YEAR="+Year+" AND f.CHR_MONTH='"+repmon+"' AND ";
				asql = asql+"	e.CHR_EMPID = a.CHR_EMPID AND e.INT_COMPANYID=b.INT_COMPANYID AND e.INT_OFFICEID = d.INT_OFFICEID ";
				asql = asql+ " ANd e.INT_DEPARTID = c.INT_DEPARTID "+off+	 cpy + bch+" ORDER BY a.CHR_EMPNAME";
				
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