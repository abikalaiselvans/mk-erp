package com.my.org.erp.JasperReport.HRM;


import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
 
import java.io.Serializable;
import java.sql.Connection;
import java.util.HashMap;
 
import com.my.org.erp.JasperReport.JdbcUtil;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.design.JRDesignQuery;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.export.JRCsvExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRRtfExporter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.xml.JRXmlLoader;



public class ReportTemplate implements Serializable 
{
	
	
	/**
	  * 
	 */
	private static final long serialVersionUID = 1L;

	public   byte[] generate(String path,String fileName,String type,String query,HashMap<String,Object> param)
	{
			byte[] output=null;
			Connection con=JdbcUtil.getJdbcConnection();
	    	JasperDesign jasperDesign=null;
	    	JasperReport jasperReport=null;
	    	JasperPrint jasperPrint=null;
	    	JRExporter exporter= null;
	    	System.out.println("Exec RT");
	    	try
	    	{
	    		System.out.println("try1: Loaded the .jrxml file");
	    		System.out.println(path+"\\"+fileName);
	    		jasperDesign = JRXmlLoader.load(path+"\\"+fileName);
	    	}
	    	catch(Exception e1)
	    	{
	    		System.out.println("t0:"+e1.getMessage());
	    	}
           
			
            try
            {   
				System.out.println("try2: Load & set the Query" +query);
				JRDesignQuery nQuery=new JRDesignQuery();
				nQuery.setText(query);
				jasperDesign.setQuery(nQuery);
				System.out.println("jasperTemp:"+jasperDesign.getQuery().getText());
			}
            catch(Exception e)
            {
            	System.out.println("t1:"+e.getMessage());
            }
	    	
            System.out.println("Compiling Report Designs");
	    	try
	    	{
	    		System.out.println("try3:");
	    		jasperReport = JasperCompileManager.compileReport(jasperDesign);
	    		System.out.println("Creating JasperPrint Object");
	    	}
	    	catch(Exception e5){}
	    	
	    	try
	    	{
	    		System.out.println("try4:");
	    		jasperPrint = JasperFillManager.fillReport(jasperReport, param, con);
	    	}
	    	catch(Exception e)
	    	{
	    		System.out.println("RT0:"+e.getMessage());
	    	}
	    	String fName=fileName.substring(0,fileName.indexOf("."));
	    	
	    	try
	    	{
	    		System.out.println("try5:");

	    		if(type.equalsIgnoreCase("pdf"))
	    		{
	    			System.out.println(path+"\\"+fName+"."+type);
	    			output=JasperExportManager.exportReportToPdf(jasperPrint);
	    		}
	    		else if(type.equalsIgnoreCase("html"))
	    		{
		    		exporter = new JRHtmlExporter();
		    	}
	    		else if(type.equalsIgnoreCase("rtf"))
	    		{
		    		exporter=new JRRtfExporter();
			    }
	    		else if(type.equalsIgnoreCase("xls"))
	    		{
		    		exporter  = new JRXlsExporter();
			    }
	    		else if(type.equalsIgnoreCase("csv"))
	    		{
		    		exporter=new JRCsvExporter();
			    }
		    	output = exportReportToBytes(jasperPrint, exporter);
	    	}
	    	catch(Exception er)
	    	{
	    		System.out.println("RT2:"+er.getMessage());
	    		er.printStackTrace();    	
	    	} 
		
	    		
	    	return output;
	}

	private byte[] exportReportToBytes(JasperPrint jasperPrint, JRExporter exporter) throws JRException 
	 {
	        byte[] output=null;
	        ByteArrayOutputStream baos = new ByteArrayOutputStream();
	        exporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
	        exporter.setParameter(JRExporterParameter.OUTPUT_STREAM, baos);
	        exporter.exportReport();
	        output = baos.toByteArray();
	        return output;
	    }


	
 
	
	public   byte[] generateJApplication(String path,String fileName,String type,String query,HashMap<String,Object> param)
	{
		byte[] output=null;
		try 
		{
	    	Connection con=JdbcUtil.getJdbcConnection();
	    	InputStream input = new FileInputStream(new File(path+"\\"+fileName));
	    	JasperDesign jasperDesign = JRXmlLoader.load(input);
	    	JRDesignQuery nQuery=new JRDesignQuery();
	    	nQuery.setText(query);
	    	jasperDesign.setQuery(nQuery);
	    	System.out.println("jasperTemp:"+jasperDesign.getQuery().getText());
	    	System.out.println("Compiling Report Designs");
	    	JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);
	    	System.out.println("Creating JasperPrint Object");
	    	JasperPrint jasperPrint=null;
	    	try
	    	{
	    	 jasperPrint = JasperFillManager.fillReport(jasperReport, param, con);
	    	}
	    	catch(Exception e)
	    	{
	    		e.printStackTrace();
	    	}
	    	String fName=fileName.substring(0,fileName.indexOf("."));
	    	System.out.println(fName);
		    
	    	JRExporter exporter= null;
	    	if(type.equalsIgnoreCase("pdf"))
	    	{
	    		System.out.println(path+"\\"+fName+"."+type);
	    		output=JasperExportManager.exportReportToPdf(jasperPrint);
	    	}
	    	else if(type.equalsIgnoreCase("html"))
	    	{
	    		exporter = new JRHtmlExporter();
	    		
	    	}
	    	else if(type.equalsIgnoreCase("rtf"))
	    	{
	    		exporter=new JRRtfExporter();
		    }
	    	else if(type.equalsIgnoreCase("xls"))
	    	{
	    		exporter  = new JRXlsExporter();
		    }
	    	else if(type.equalsIgnoreCase("csv"))
	    	{
	    		exporter=new JRCsvExporter();
		    }
	    	output = exportReportToBytes(jasperPrint, exporter);
	    	
		  }
		catch(Exception e)
		{
        	   e.getMessage();
        }
		return output;
 }


	
}
