package com.my.org.erp.SmartAMC;

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

public class Rept_JserviceCustomerInfoActionHandler extends AbstractActionHandler 
{
	  
	JasperPrint jasperPrint;
	JRExporter exporter;
	String hImageExpression="";
	String fImageExpression="";
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			HashMap<Object,Object> map = new HashMap<Object,Object>();
			
			if(action.equals("AMCRept_JserviceCustomerInfo")) 
			{
				System.out.println("insite AMCRept_JcustomerServiceGroupList");
				asql="SELECT b.CHR_GROUPNAME,a.CHR_CUSTOMERNAME,c.CHR_CENTERNAME,a.CHR_STREET,a.CHR_CITY,a.CHR_STATE,a.CHR_POSTAL,a.CHR_COUNTRY,a.CHR_PHONE,a.CHR_MOBILE,a.CHR_FAX,a.CHR_EMAIL,a.CHR_WEBSITE,if(a.INT_ACTIVE=1,'Active','Inactive') FROM inv_m_servicecustomerinfo a , inv_m_servicecustomergroup b, inv_m_servicecenter c WHERE a.INT_GROUPID = b.INT_GROUPID AND a.INT_SERVICECENTERID= c.INT_SERVICECENTERID ORDER BY a.CHR_CUSTOMERNAME";
				System.out.println("asql:"+asql);
			
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;

				File reportDir = new File(Path + "/report/CRM/" + rptfilename+".jrxml");
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, asql, con, Path,map);
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
