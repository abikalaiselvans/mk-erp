package com.my.org.erp.JasperReport.FormQ;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import ar.com.fdvs.dj.core.DynamicJasperHelper;
import ar.com.fdvs.dj.core.layout.ClassicLayoutManager;
import ar.com.fdvs.dj.domain.DynamicReport;
import ar.com.fdvs.dj.domain.builders.DynamicReportBuilder;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.data.JRMapCollectionDataSource;
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
//import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.engine.util.SimpleFileResolver;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import net.sf.jasperreports.j2ee.servlets.ImageServlet;

public class ReportFunctions 
{
	
	static String hImageExpression;
	static String fImageExpression;
	static JasperPrint jasperPrint;
	static JasperReport jr;


	//Return JasperPrint
	public static JasperPrint createReport(JasperPrint jasperPrint,HttpServletRequest request,HttpServletResponse response,File reportsDir,String rptfilename,String sql,Connection con, String Path,HashMap<String,Object> map) throws ServletException, IOException
	{
		if (!reportsDir.exists()) 
		{
		    throw new FileNotFoundException(String.valueOf(reportsDir));
		}
		
		//File headerImage = new File(Path + "/images/hImage.jpg");
		//File footerImage = new File(Path + "/images/fImage.jpg");
		
		//hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
		//fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
						
		map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
		//map.put("hImageExpression", hImageExpression);
		//map.put("fImageExpression", fImageExpression);
		try 
		{
			InputStream input = new FileInputStream(reportsDir);
			JasperDesign jasperDesign = JRXmlLoader.load(input);
			JRDesignQuery newQuery = new JRDesignQuery();
			newQuery.setText(sql); 
			jasperDesign.setQuery(newQuery);
			JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
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
	
	
	//Return JasperPrint
	public static JasperPrint createArraylistReport(JasperPrint jasperPrint,HttpServletRequest request,HttpServletResponse response,File reportsDir,String rptfilename,String sql,Connection con, String Path,List<Map<String,Object>> list) throws ServletException, IOException
	{
		if (!reportsDir.exists()) 
		{
		    throw new FileNotFoundException(String.valueOf(reportsDir));
		}
		
		try 
		{
			InputStream input = new FileInputStream(reportsDir);
			JasperDesign jasperDesign = JRXmlLoader.load(input);
			JRDesignQuery newQuery = new JRDesignQuery();
			newQuery.setText(sql); 
			jasperDesign.setQuery(newQuery);
			JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
			jasperPrint = JasperFillManager.fillReport(jasperReport,new HashMap<String,Object>(),  new JRBeanCollectionDataSource(list));

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
	public static void generateAllReport(JRExporter exporter,JasperPrint jasperPrint,HttpServletRequest request,HttpServletResponse response,String reporttype,String rptfilename) throws IOException, ServletException, JRException
	{
		byte[] output=null;
		System.out.println(reporttype);
		OutputStream ouputStream = response.getOutputStream();
		response.setContentType("application/"+reporttype);
		response.setHeader("Content-Disposition", "attachment;filename=\""+rptfilename+"."+reporttype+"\"");
		if( !"txt".equalsIgnoreCase(reporttype) )
		{
			if("pdf".equalsIgnoreCase(reporttype)){
	    		//System.out.println(path+"\\"+fName+"."+type);
	    		output=JasperExportManager.exportReportToPdf(jasperPrint);
	    		
	    	}else if(reporttype.equalsIgnoreCase("html")){
	    		exporter = new JRHtmlExporter();
	    		
	    	}else if(reporttype.equalsIgnoreCase("rtf")){
	    		
		    	exporter=new JRRtfExporter();
		    	
	    	}else if(reporttype.equalsIgnoreCase("xls")){
	    		
		    	exporter  = new JRXlsExporter();
		    	
	    	}else if(reporttype.equalsIgnoreCase("csv")){
	    		
		    	exporter=new JRCsvExporter();
		    	
	    	}
			if(exporter!=null)
	    	 output = exportReportToBytes(jasperPrint, exporter);
			
		}
		
		ouputStream.write(output);
		ouputStream.close();
		//generateTextReport(exporter,jasperPrint, request, response,rptfilename,Path,ouputStream );
	}
	
	
	 private static  byte[] exportReportToBytes(JasperPrint jasperPrint, JRExporter exporter) throws JRException {
	        byte[] output=null;
	       ByteArrayOutputStream baos = new ByteArrayOutputStream();

	        exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
	        exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, baos);

	        exporter.exportReport();

	        output = baos.toByteArray();
	        return output;
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
	
	
	public static JasperPrint createForm3APFReport(JasperPrint jasperPrint,
			HttpServletRequest request,HttpServletResponse response,File reportDir,String rptfilename,
			String asql,Connection con, String Path,HashMap<String,Object> map,File subreportDir1,File subreportDir2,File subreportDir3,
			File subreportDir4,File subreportDir5,File subreportDir6,
			File subreportDir7,File subreportDir8,File subreportDir9,File subreportDir10,File subreportDir11,File subreportDir12,File subreportDir13) 
	throws ServletException, IOException
	{
		
		try 
		{
			System.out.println("createReport");
			JasperReport jasperSubReport1=createSubReport(subreportDir1);
			JasperReport jasperSubReport2=createSubReport(subreportDir2);	
			JasperReport jasperSubReport3=createSubReport(subreportDir3);	
			JasperReport jasperSubReport4=createSubReport(subreportDir4);	
			JasperReport jasperSubReport5=createSubReport(subreportDir5);	
			JasperReport jasperSubReport6=createSubReport(subreportDir6);	
			JasperReport jasperSubReport7=createSubReport(subreportDir7);
			JasperReport jasperSubReport8=createSubReport(subreportDir8);	
			JasperReport jasperSubReport9=createSubReport(subreportDir9);	
			JasperReport jasperSubReport10=createSubReport(subreportDir10);	
			JasperReport jasperSubReport11=createSubReport(subreportDir11);	
			JasperReport jasperSubReport12=createSubReport(subreportDir12);	
			JasperReport jasperSubReport13=createSubReport(subreportDir13);	
			InputStream input = new FileInputStream(reportDir);
			JasperDesign jasperDesign = JRXmlLoader.load(input);
			JRDesignQuery newQuery = new JRDesignQuery();
			newQuery.setText(asql); 
			jasperDesign.setQuery(newQuery);
			JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
			map.put("subreport1Parameter", jasperSubReport1);
			map.put("subreport2Parameter", jasperSubReport2);
			map.put("subreport3Parameter", jasperSubReport3);
			map.put("subreport4Parameter", jasperSubReport4);
			map.put("subreport5Parameter", jasperSubReport5);
			map.put("subreport6Parameter", jasperSubReport6);
			map.put("subreport7Parameter", jasperSubReport7);
			map.put("subreport8Parameter", jasperSubReport8);
			map.put("subreport9Parameter", jasperSubReport9);
			map.put("subreport10Parameter", jasperSubReport10);
			map.put("subreport11Parameter", jasperSubReport11);
			map.put("subreport12Parameter", jasperSubReport12);
			map.put("subreport13Parameter", jasperSubReport13);
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
	

	public static JasperReport createSubReport(File subReportDir) throws FileNotFoundException, JRException
	{
		JasperReport jasperReport=null;
		try {
			System.out.println("createReport1");
			InputStream input = new FileInputStream(subReportDir);
			JasperDesign jasperDesign = JRXmlLoader.load(input);
			jasperReport = JasperCompileManager.compileReport(jasperDesign);
			System.out.println("compiled successfully");
			
		} catch (Exception e) 
		{
			 
			e.printStackTrace();
		}
		return jasperReport;
	}
	
	
	
	
	public static JasperPrint createAppraisalLetterReport(
			JasperPrint jasperPrint, HttpServletRequest request,
			HttpServletResponse response, File reportDir, String rptfilename,
			Collection<Map<String, ?>> al, String Path, HashMap<String, Object> map,
			File subReport1Dir) throws ServletException, IOException {
		if (!reportDir.exists()) 
		{
		    throw new FileNotFoundException(String.valueOf(reportDir));
		}
		
		File headerImage = new File(Path + "/images/hImage.jpg");
		File footerImage = new File(Path + "/images/fImage.jpg");
		
		hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
		fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
						
		map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
		 
		try 
		{	
			JasperReport jasperSubReport1=createSubReport(subReport1Dir);		
			map.put("subreport1Parameter", jasperSubReport1);
			InputStream input = new FileInputStream(reportDir);
			JasperDesign jasperDesign = JRXmlLoader.load(input);
			JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
			System.out.println("aaaaaalllllll:"+al);
			JRMapCollectionDataSource mc = new JRMapCollectionDataSource(al); 
			jasperPrint = JasperFillManager.fillReport(jasperReport, map, mc);
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


	
	


	

   
	public static JasperPrint createDynamicJasperReport(DynamicReportBuilder drb,String path,HashMap<String,Object> map,Collection<Map<String, ?>> al) throws IOException, ServletException, JRException
	{
		drb.setUseFullPageWidth(true);
		drb.setTemplateFile(path);
		DynamicReport dr = drb.build();
		jr = DynamicJasperHelper.generateJasperReport(dr, new ClassicLayoutManager(),map);
		JRMapCollectionDataSource mc = new JRMapCollectionDataSource(al); 
		jasperPrint = JasperFillManager.fillReport(jr, map, mc); 
		return jasperPrint;
	}
		

	public static void generateJasperReport(JasperPrint jasperPrint,HttpServletRequest request,HttpServletResponse response,String reporttype,String Path,String rptfilename,String reportTitle) throws IOException, ServletException, JRException
		{
			JRExporter exporter = null;
			OutputStream ouputStream = response.getOutputStream();
			response.setContentType("application/"+reporttype);
			response.setHeader("Content-Disposition", "attachment;filename=\""+reportTitle+"."+reporttype+"\"");
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
					/*exporter = new JRXlsxExporter();
					exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
					exporter.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, Path + "/" +rptfilename);
					exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, ouputStream);
					*/
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

 
	





	public static JasperPrint createDoubleSubReport(
				JasperPrint jasperPrint, HttpServletRequest request,
				HttpServletResponse response,Connection con, File reportDir, String rptfilename,
				String Path, HashMap<String, Object> map,
				String sql,File subReport1Dir,String sql1) throws ServletException, IOException {
			if (!reportDir.exists()) 
			{
			    throw new FileNotFoundException(String.valueOf(reportDir));
			}
			
			//File headerImage = new File(Path + "/images/hImage.jpg");
			//File footerImage = new File(Path + "/images/fImage.jpg");
			
			//hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
			//fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
							
			map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
			/*map.put("hImageExpression", hImageExpression);
			map.put("fImageExpression", fImageExpression);*/
			try 
			{	
				JasperReport jasperSubReport1=createSubReportWithSQL(subReport1Dir,sql);		
				map.put("subreport1Parameter", jasperSubReport1);
				
				InputStream input = new FileInputStream(reportDir);
				JasperDesign jasperDesign = JRXmlLoader.load(input);
				JRDesignQuery newQuery = new JRDesignQuery();
				newQuery.setText(sql1); 
				jasperDesign.setQuery(newQuery);
				JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
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
		
	

	public static JasperReport createSubReportWithSQL(File subReportDir,String subReportSql) throws FileNotFoundException, JRException
		{
			JasperReport jasperReport=null;
			try {
				System.out.println("createReport1");
				InputStream input = new FileInputStream(subReportDir);
				JasperDesign jasperDesign = JRXmlLoader.load(input);
				JRDesignQuery newQuery = new JRDesignQuery();
				newQuery.setText(subReportSql); 
				System.out.println("compiled successfully subReportSql:"+subReportSql);
				jasperDesign.setQuery(newQuery);
				jasperReport = JasperCompileManager.compileReport(jasperDesign);
				System.out.println("compiled successfully");
			} catch (Exception e) {
				
				e.printStackTrace();
			}
			return jasperReport;
		}





}
