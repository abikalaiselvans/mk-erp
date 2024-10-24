package com.my.org.erp.SmartReport;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.util.HashMap;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.SmartPayroll.PDF_PayslipActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
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

public class ReportFunctions1 
{
	
	static String hImageExpression;
	static String fImageExpression;
	
	//Return JasperPrint
	public static JasperPrint createReport(JasperPrint jasperPrint,HttpServletRequest request,HttpServletResponse response,File reportsDir,String rptfilename,String sql,Connection con, String Path,HashMap<Object,Object> map) throws ServletException, IOException
	{
		if (!reportsDir.exists()) 
		{
		    throw new FileNotFoundException(String.valueOf(reportsDir));
		}
		
		File headerImage = new File(Path + "/images/hImage.jpg");
		File footerImage = new File(Path + "/images/fImage.jpg");
		
		hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
		fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
						
		map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
		map.put("hImageExpression", hImageExpression);
		map.put("fImageExpression", fImageExpression);
		try 
		{
			InputStream input = new FileInputStream(reportsDir);
			JasperDesign jasperDesign = JRXmlLoader.load(input);
			JRDesignQuery newQuery = new JRDesignQuery();
			newQuery.setText(sql); 
			jasperDesign.setQuery(newQuery);
			JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
			jasperPrint = JasperFillManager.fillReport(jasperReport, map, con);
			//response.setContentType("application/pdf");
			JasperExportManager.exportReportToPdfFile(jasperPrint,Path + "/seven.pdf"); 
			
			String to="pushpalakshmi.c@gmail.com";
			String subject="Payslip for the month ";
			String bodyText="This is a important message with Payslip attachment";
			String filename=Path+"/seven.pdf";
			PDF_PayslipActionHandler ps=new PDF_PayslipActionHandler();
			//if(!"-".equals(to) || !"".equals(to) || "null".equals(to))
				ps.sendEmail(to,subject,bodyText,filename ) ;
			System.out.println("mail sent");
			//response.sendRedirect("/SmartCommon/commonmain.jsp");
		} 
		catch (JRException e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response);
		}
		return jasperPrint;
	}
	
	
	
	
	
	//Return Reporting Type
	public static void generateAllReport(JRExporter exporter,JasperPrint jasperPrint,HttpServletRequest request,HttpServletResponse response,String reporttype,String Path,String rptfilename) throws IOException, ServletException, JRException
	{
		System.out.println("inside generateAllReport");
		OutputStream ouputStream = response.getOutputStream();
		response.setContentType("application/"+reporttype);
		response.setHeader("Content-Disposition", "attachment;filename=\""+rptfilename+"."+reporttype+"\"");
		if( !"txt".equalsIgnoreCase(reporttype) )
		{
			if( "pdf".equalsIgnoreCase(reporttype) )
			{
				System.out.println("bbbbbbbbbbbbsssssssssssssssssssssss");
				JasperExportManager.exportReportToPdfFile(jasperPrint,Path + "/two.pdf");  
				System.out.println("sssssssssssssssssssssss");
				//exporter = new JRPdfExporter();
				//exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
				//exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, Path + "/" +rptfilename);
				//exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, ouputStream);
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
				//exporter.exportReport();
			}
			catch (Exception e)
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
			
		generateTextReport(exporter,jasperPrint, request, response,rptfilename,Path,ouputStream );
	}
	
	//Return Text File
	public static void generateTextReport(JRExporter exporter,JasperPrint jasperPrint,HttpServletRequest request,HttpServletResponse response,String rptfilename,String Path,OutputStream ouputStream) throws IOException, ServletException
	{
		System.out.println("generateTextReport");
		exporter = new JRTextExporter();
		exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, Path + "/" +rptfilename+".txt");
		exporter.setParameter(JRTextExporterParameter.CHARACTER_WIDTH, new Float(7.0));
		exporter.setParameter(JRTextExporterParameter.CHARACTER_HEIGHT, new Float(11.0));
		try 
		{
			
			exporter.exportReport();
		}
		catch (JRException e) 
		{
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
		while((n = fin.read(buffer)) != -1) {
			outStream.write(buffer, 0, n);
		}
		outStream.flush();
		fin.close();
		outStream.close();
		
		
		
	}
}
