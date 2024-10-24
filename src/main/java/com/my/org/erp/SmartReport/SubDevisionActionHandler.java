package com.my.org.erp.SmartReport;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.design.JRDesignQuery;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.export.JRCsvExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRRtfExporter;
import net.sf.jasperreports.engine.export.JRTextExporter;
import net.sf.jasperreports.engine.export.JRTextExporterParameter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXmlExporter;
import net.sf.jasperreports.engine.util.SimpleFileResolver;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.j2ee.servlets.ImageServlet;
 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class SubDevisionActionHandler extends AbstractActionHandler 
{

	String courseName;
	int courseId;
	String userid = "" ;
	JasperPrint jasperPrint;
	JRExporter exporter;
	public String getSqlQuery(String companyId,String id)
	{
		String sql =" SELECT INT_SUBDIVISIONID,CHR_SUBDIVISIONNAME,INT_DIVISIONID FROM com_m_subdivision ";
		if(!"0".equalsIgnoreCase(id))		
			sql=sql+" WHERE INT_SUBDIVISIONID="+id;
			return sql;
	}
	
	public JasperPrint createReport(HttpServletRequest request,HttpServletResponse response,String rptfilename,String sql) throws ServletException, IOException
	{
		File reportsDir = new File(Path + "/report/SmartCommon/" + rptfilename+".jrxml");
		if (!reportsDir.exists()) {
		    throw new FileNotFoundException(String.valueOf(reportsDir));
		}
		HashMap<Object,Object> map = new HashMap<Object,Object>();
		map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
		try 
		{
			InputStream input = new FileInputStream(reportsDir);
			JasperDesign jasperDesign = JRXmlLoader.load(input);
			JRDesignQuery newQuery = new JRDesignQuery();
			newQuery.setText(sql); 
			jasperDesign.setQuery(newQuery);
			JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
			jasperPrint = JasperFillManager.fillReport(jasperReport, map, con);
			
		} catch (JRException e) {
			
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response);
		}
		return jasperPrint;
	}
	
	
	
	public void generateTextReport(JasperPrint jasperPrint,HttpServletRequest request,HttpServletResponse response,String rptfilename) throws IOException, ServletException
	{
		
		exporter = new JRTextExporter();
		exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, Path + "/" +rptfilename+".txt");
		exporter.setParameter(JRTextExporterParameter.CHARACTER_WIDTH, new Float(7.0));
		exporter.setParameter(JRTextExporterParameter.CHARACTER_HEIGHT, new Float(11.0));
		try {
			exporter.exportReport();
		} catch (JRException e) {
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response);
		}
		
		File f=new File(Path + "/" + rptfilename+".txt");
		FileInputStream fin = new FileInputStream(f);
		ServletOutputStream outStream = response.getOutputStream();
		response.setContentType("application/text");
		response.setHeader("Content-Disposition", "attachment;filename="+rptfilename+".txt");
		byte[] buffer = new byte[1024];
		int n = 0;
		while ((n = fin.read(buffer)) != -1) {
		outStream.write(buffer, 0, n);
		}
		outStream.flush();
		fin.close();
		outStream.close();
		
	}
	public void generateAllReport(JasperPrint jasperPrint,HttpServletRequest request,HttpServletResponse response,String reporttype,String rptfilename) throws IOException, ServletException
	{
		OutputStream ouputStream = response.getOutputStream();
		response.setContentType("application/"+reporttype);
		response.setHeader("Content-Disposition", "attachment;filename=\""+rptfilename+"."+reporttype+"\"");
		if( !"txt".equalsIgnoreCase(reporttype) )
		{
			if( "pdf".equalsIgnoreCase(reporttype) )
			{
				exporter = new JRPdfExporter();
				exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
				exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, Path + "/" +rptfilename);
				exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, ouputStream);
			}
			else if( "rtf".equalsIgnoreCase(reporttype) )
			{
				exporter = new JRRtfExporter();
				exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
				exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, Path + "/" +rptfilename);
				exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, ouputStream);
			}
			else if( "html".equalsIgnoreCase(reporttype) )
			{
				exporter = new JRHtmlExporter();
				exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
				exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, Path + "/" +rptfilename);
				exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, ouputStream);
				
				((HttpServletRequest) request).getSession().setAttribute(ImageServlet.DEFAULT_JASPER_PRINT_SESSION_ATTRIBUTE, jasperPrint);
				exporter.setParameter(JRHtmlExporterParameter.IMAGES_URI, "image?image=");
			}
			else if( "xls".equalsIgnoreCase(reporttype) )
			{
				exporter = new JRXlsExporter();
				exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
				exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, Path + "/" +rptfilename);
				exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, ouputStream);
			}
			else if( "csv".equalsIgnoreCase(reporttype) )
			{
				exporter = new JRCsvExporter();
				exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
				exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, Path + "/" +rptfilename);
				exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, ouputStream);
			}
			else if( "xml".equalsIgnoreCase(reporttype) )
			{
				exporter = new JRXmlExporter();
				exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
				exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, Path + "/" +rptfilename);
				exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, ouputStream);
			}
			try
			{
				exporter.exportReport();
			}
			catch (JRException e)
			{
				throw new ServletException(e);
			}
			finally
			{	
				if (ouputStream != null)
				{
					try
					{
						ouputStream.close();
					}
					catch (IOException ex)
					{
					}
				}
			}
		}
		else 
			generateTextReport(jasperPrint, request, response,rptfilename );
	}
	
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
	
		try 
		{ 
			
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			userid = "" + session.getAttribute("USRID");
			
			
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			String companyid = request.getParameter("companyid");
			String id = request.getParameter("subDevId");
		
			if (action.equals("RPTSubDevisionGenerate")) 
			{
				String sqlQuery=getSqlQuery(companyid,id);
				jasperPrint=createReport(request, response, rptfilename,sqlQuery );
				generateAllReport(jasperPrint,request,response, reporttype, rptfilename);
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
