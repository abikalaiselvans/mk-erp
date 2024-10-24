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

public class Rept_JPFOrganisationActionHandler extends AbstractActionHandler 
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
			
			if (action.equals("PAYRept_JPFOrganisation")) 
			{
				String company = request.getParameter("company");
				String branch = request.getParameter("branch");
				String Office = request.getParameter("Office");
				String Month = request.getParameter("Month");
				String Year = request.getParameter("Year");
				String rptfilename = request.getParameter("rptfilename");
				String reporttype = request.getParameter("reportType");
				String repmon = DateUtil.getMonth(Integer.parseInt( Month));
				
				File reportDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				  
				map.put("parameter1", "1");
				map.put("parameter2", "2");
				map.put("parameter3", "3");
				map.put("parameter4", "4");
				map.put("parameter5", "5");
				map.put("parameter6", "6");
				map.put("parameter7", "7");
				map.put("parameter8", "8");
				map.put("parameter9", "9");
				map.put("parameter10", "10");
				map.put("parameter11", "11");
				map.put("parameter12", "12");
				map.put("parameter13", "13");
				map.put("parameter14", "14");
				map.put("parameter15", "15");
				map.put("parameter16", "16");
				map.put("parameter17", "17");
				map.put("parameter18", "18");
				map.put("parameter19", "19");
				map.put("parameter20", "20");
				map.put("parameter21", "21");
				map.put("parameter22", "22");
				map.put("parameter23", "23");
				map.put("parameter24", "24");
				map.put("parameter25", "25");
				map.put("parameter26", "26");
				map.put("parameter27", "27");
				map.put("parameter28", "28");
				map.put("parameter29", "29");
				map.put("parameter30", "30");
				map.put("parameter31", "31");
				map.put("parameter32", "32");
				map.put("parameter33", "33");
				map.put("parameter34", "34");
				map.put("parameter35", "35");
				map.put("parameter36", "36");
				map.put("parameter37", "37");
				map.put("parameter38", "38");
				map.put("parameter39", "39");
				map.put("parameter40", "40");
				
				asql = "SELECT CHR_EMPID FROM com_m_staff WHERE CHR_EMPID='ADMIN'";
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