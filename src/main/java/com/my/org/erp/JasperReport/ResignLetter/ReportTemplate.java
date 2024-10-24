package com.my.org.erp.JasperReport.ResignLetter;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.export.JRCsvExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRRtfExporter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import net.sf.jasperreports.engine.xml.JRXmlLoader;


public class ReportTemplate {
	
	public  byte[] generate(String path,String fileName,String type,String empid){
		byte[] output=null;
		try {
	    	Connection con=com.my.org.erp.JasperReport.JdbcUtil.getJdbcConnection();

	    	InputStream input = new FileInputStream(new File(path+"\\"+fileName));
	    	JasperDesign jasperDesign = JRXmlLoader.load(input);
            System.out.println(path+"\\"+fileName+"  "+empid);
	    	System.out.println("Compiling Report Designs");
	    	JasperReport jasperReport = JasperCompileManager.compileReport(jasperDesign);

	    	System.out.println("Creating JasperPrint Object");
	    	Map<String, Object> parameters = new HashMap<String, Object>();
	    	parameters.put("ReportTitle", "RTF JasperReport");
            parameters.put("empid", empid) ;
	    	System.out.println("Filling Report to File");
	    	JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, con);
	    	String fName=fileName.substring(0,fileName.indexOf("."));
	    	System.out.println(fName);
	    	
	    	JRExporter exporter= null;
	    	if(type.equalsIgnoreCase("pdf")){
	    		System.out.println(path+"\\"+fName+"."+type);
	    		output=JasperExportManager.exportReportToPdf(jasperPrint);
	    		
	    	}else if(type.equalsIgnoreCase("html")){
	    		exporter = new JRHtmlExporter();
	    		
	    	}else if(type.equalsIgnoreCase("rtf")){
	    		
		    	exporter=new JRRtfExporter();
		    	
	    	}else if(type.equalsIgnoreCase("xls")){
	    		
		    	exporter  = new JRXlsExporter();
		    	
	    	}else if(type.equalsIgnoreCase("csv")){
	    		
		    	exporter=new JRCsvExporter();
		    	
	    	}
	    	 output = exportReportToBytes(jasperPrint, exporter);
		}catch(Exception e){
			e.getMessage();
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

}
