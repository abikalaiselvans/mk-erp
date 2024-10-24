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

public class Rept_JExistingEmpListActionHandler extends AbstractActionHandler 
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
			String company = request.getParameter("company");
			String branch = request.getParameter("branch");
			String Resigned = request.getParameter("Resigned");
		
			if (action.equals("PAYRept_JExistingEmpList")) 
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
				
				
				asql="Select CHR_EMPID,CHR_STAFFNAME,DATE_FORMAT(DT_DOJCOLLEGE,'%d-%b-%Y'),  ";
			 asql = asql+" CHR_MOBILE, CHR_EMAILID ,CHR_PF,CHR_PFNO,CHR_ESI,CHR_ESINO From com_m_staff   ";
			 asql = asql+" Where CHR_EMPID IS NOT NULL " ;
			  if(!"Y".equals(Resigned))
				asql = asql+"  AND CHR_TYPE !='T' " ;
				
			 asql = asql +" AND INT_COMPANYID=  "+company;
			 if(!"0".equals(branch))
				asql = asql +"  AND  INT_BRANCHID=  "+branch;
			 if(!"0".equals(Office))
				asql = asql+"  AND INT_OFFICEID="+Office;
			 if(!"0".equals(Dept))
				asql = asql+"  AND INT_DEPARTID= "+Dept;
			 asql = asql + " ORDER BY CHR_STAFFNAME";
			 
			 System.out.println("asql:"+asql);
			 
						
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