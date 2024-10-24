package com.my.org.erp.SmartReport;

import java.io.File;
import java.io.FileNotFoundException;
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

import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class ServiceCardActionHandler extends AbstractActionHandler 
{

	
	JasperPrint jasperPrint;
	JRExporter exporter;
	public String getSqlQuery()
	{
		asql =" SELECT a.CHR_EMPID,a.CHR_STAFFNAME,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'), c.CHR_OFFICENAME," +
				"if(isnull(b.IMG_IMAGE) =false ,'','Photo Need'),if(isnull(b.IMG_CERTIFICATE) =false ,'','Certificate Need')," +
				"if(isnull(b.IMG_PROFILE) =false ,'','Profile Need') FROM com_m_staff a , com_m_staffaddressproof b, com_m_office c " +
				"WHERE a.CHR_EMPID = b.CHR_EMPID AND a.INT_OFFICEID= c.INT_OFFICEID  AND a.DT_DOJCOLLEGE >= '2013-08-01' " +
				"AND a.CHR_TYPE != 'T' AND ((isnull(b.IMG_IMAGE)) or (isnull(b.IMG_CERTIFICATE)) or (isnull(b.IMG_PROFILE))) ORDER BY a.CHR_STAFFNAME ";
		return asql;
	}

	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			HashMap<Object,Object> map = new HashMap<Object,Object>();
			
			if (action.equals("RPTServiceCard")) 
			{
				System.out.println("RPTServiceCard :");
				
				File reportDir = new File(Path + "/report/SmartCommon/" + rptfilename+".jrxml");
				if (!reportDir.exists()) 
				{
				    throw new FileNotFoundException(String.valueOf(reportDir));
				}
				
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				String hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				String fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				
				asql=getSqlQuery();
				String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(asql);
				
				if(data.length<=0 )
					map.put("dataLength", "0");
				else
					map.put("dataLength", "1");
				
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, asql, con, Path,map);
				ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
				System.out.println("RPTServiceCard generated");
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
