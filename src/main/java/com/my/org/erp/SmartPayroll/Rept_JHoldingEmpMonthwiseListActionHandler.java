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

public class Rept_JHoldingEmpMonthwiseListActionHandler extends AbstractActionHandler 
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
		
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
					
				
			if (action.equals("PAYRept_JHoldingEmpMonthwiseList")) 
			{
							
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
				 
				
				asql = " SELECT  a.CHR_EMPID,b.CHR_STAFFNAME,c.CHR_OFFICENAME ,a.CHR_MONTH,a.INT_YEAR ";  
				asql = asql + " FROM pay_t_temporarysuspension a, com_m_staff b, com_m_office c ";
				asql = asql + " WHERE a.CHR_EMPID = b.CHR_EMPID ";
				asql = asql + " AND b.INT_OFFICEID = c.INT_OFFICEID ";
				if((!"0".equals(Office))  )
					asql = asql+" AND  b.INT_OFFICEID = "+Office;
				if((!"0".equals(Month))  )
					asql = asql+" AND   a.CHR_MONTH = '"+repmon+"' ";
				if((!"0".equals(Year))  )
					asql = asql+" AND  a.INT_YEAR = "+Year;
				 
				if(!"0".equals(company))
					asql = asql+"  AND b.INT_COMPANYID="+company;
			 
				if(!"0".equals(branch))
					asql = asql+" AND b.INT_BRANCHID="+branch;
				
				asql = asql+"  ORDER BY b.CHR_STAFFNAME	 ";
				System.out.println("sql:"+asql);
				
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