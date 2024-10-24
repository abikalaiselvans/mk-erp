package com.my.org.erp.SmartReport;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
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

public class Rept_JStaffAddrEnvelopeActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String cmpyname="";
	String officename="";
	String deptname="";
	String hImageExpression="";
	String fImageExpression="";
	String defaultImageExpression="";
	String exitInterview="";
	String workingDays="";
	String salary="";
	String advance="";
	String loan="";
	String total="";
	String settlement="";
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		System.out.println("Rept_JStaffAddrEnvelope");
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			if (action.equals("RPTRept_JStaffAddrEnvelope")) 
			{
			System.out.println("inside RPTRept_JStaffAddrEnvelope");
				
				File reportDir = new File(Path + "/report/SmartCommon/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				File defaultImage = new File(Path + "/images/icon-user.gif");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
				defaultImageExpression=(defaultImage.exists())?"../../images/icon-user.gif":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				map.put("defaultImageExpression", defaultImageExpression);
			
				asql = "SELECT b.IMG_IMAGE,a.CHR_EMPID,a.CHR_STAFFNAME,FUN_GET_ADDRESS( a.CHR_EMPID,'P','\\n'),FUN_GET_ADDRESS( a.CHR_EMPID,'S','\\n') ,a.CHR_MOBILE,a.CHR_PERMAILID FROM com_m_staff  a , com_m_staffaddressproof b WHERE a.CHR_EMPID =b.CHR_EMPID ORDER BY a.CHR_STAFFNAME";
				
				System.out.println("asql:"+asql);
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, asql, con, Path,map);
				ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
				
			}
		
		} catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response);
		}
	}
}