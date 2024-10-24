package com.my.org.erp.SmartInventory;



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
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
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
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.j2ee.servlets.ImageServlet;

public class subReportCalling 
{
	
	static String hImageExpression;
	static String fImageExpression;
	
	public static JasperReport createSubReport(File subReportDir,String subReportSql) throws FileNotFoundException, JRException
	{
		JasperReport jasperReport=null;
		try {
			InputStream input = new FileInputStream(subReportDir);
			JasperDesign jasperDesign = JRXmlLoader.load(input);
			JRDesignQuery newQuery = new JRDesignQuery();
			newQuery.setText(subReportSql); 
			jasperDesign.setQuery(newQuery);
			jasperReport = JasperCompileManager.compileReport(jasperDesign);
			
		} catch (Exception e) {
			 
			e.printStackTrace();
		}
		return jasperReport;
	}
	
	//Return JasperPrint
	
	public static JasperPrint createReport(JasperPrint jasperPrint,
			HttpServletRequest request,HttpServletResponse response,File reportDir,String rptfilename,
			String asql,Connection con, String Path,HashMap<Object,Object> map,File subreportDir1,
			File subreportDir2,File subreportDir3,File subreportDir4,String subRept1Sql,String s2,String s3) 
	throws ServletException, IOException
	{
		
		try 
		{
			System.out.println("subreportDir1:"+subreportDir1);
			JasperReport jasperSubReport=createSubReport(subreportDir1,null);
			System.out.println("subreportDir2:"+subreportDir2);
			JasperReport jasperSubReport1=createSubReport(subreportDir2,subRept1Sql);
			System.out.println("subreportDir3:"+subreportDir3);
			JasperReport jasperSubReport2=createSubReport(subreportDir3,s2);	
			System.out.println("subreportDir4:"+subreportDir4);
			JasperReport jasperSubReport3=createSubReport(subreportDir4,s3);
		
			
			InputStream input = new FileInputStream(reportDir);
			JasperDesign jasperDesign = JRXmlLoader.load(input);
			JRDesignQuery newQuery = new JRDesignQuery();
			newQuery.setText(asql); 
			jasperDesign.setQuery(newQuery);
			JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
			map.put("subreportParameter", jasperSubReport);
			map.put("subreport1Parameter", jasperSubReport1);
			map.put("subreport2Parameter", jasperSubReport2);
			map.put("subreport3Parameter", jasperSubReport3);
			
			jasperPrint = JasperFillManager.fillReport(jasperReport, map, con);
			
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

	public static JasperPrint employeeWiseSaleReport(JasperPrint jasperPrint,
			HttpServletRequest request, HttpServletResponse response,
			File reportDir,  Object object,
			Connection con, String path, HashMap<Object, Object> map,
			File reportDir1, File reportDir2,File reportDir3, File reportDir4,String s1, String s2, String s3)
	throws ServletException, IOException{
		 

		try 
		{
			System.out.println("subreportDir1:"+reportDir1);
			JasperReport jasperSubReport=createSubReport(reportDir1,null);
			System.out.println("subreportDir2:"+reportDir2);
			JasperReport jasperSubReport1=createSubReport(reportDir2,s1);
			
			JasperReport jasperSubReport2=createSubReport(reportDir3,s2);	
			
			JasperReport jasperSubReport3=createSubReport(reportDir4,s3);
		
			
			InputStream input = new FileInputStream(reportDir);
			JasperDesign jasperDesign = JRXmlLoader.load(input);
			JRDesignQuery newQuery = new JRDesignQuery();
			newQuery.setText(null); 
			jasperDesign.setQuery(newQuery);
			JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
			map.put("subreportParameter", jasperSubReport);
			map.put("subreport1Parameter", jasperSubReport1);
			map.put("subreport2Parameter", jasperSubReport2);
			map.put("subreport3Parameter", jasperSubReport3);
			
			jasperPrint = JasperFillManager.fillReport(jasperReport, map, con);
			
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
}
