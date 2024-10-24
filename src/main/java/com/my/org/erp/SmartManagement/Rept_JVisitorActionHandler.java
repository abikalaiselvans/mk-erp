package com.my.org.erp.SmartManagement;

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

public class Rept_JVisitorActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String cmpyname="";
	String officename="";
	String deptname="";
	String hImageExpression="";
	String fImageExpression="";
	String visitorphoto=null;
	public String getSqlQuery(String id)
	{
		asql="";
		asql = asql + " SELECT a.CHR_VISITORNO ref,a.CHR_VISITORNAME name,DATE_FORMAT(NOW(),'%d-%b-%Y %h:%i:%s %p') dt, CHR_ADDRESS addr, ";
		asql = asql + " b.CHR_BUILDINGNAME building, c.CHR_FLOOR flor, d.CHR_PURPOSE purpose,  a.CHR_WHOMTOMEET meet, "; 
		asql = asql + " DATE_FORMAT(a.DT_TIMEIN,'%d-%b-%Y') datein, DATE_FORMAT(a.DT_TIMEIN,' %h:%i:%s %p') timein, "; 
		asql = asql + " a.INT_MOBILE mobile,DATE_FORMAT(NOW(),'%d-%b-%d %h:%i:%s %p') ctime ";
		asql = asql + " FROM mgt_m_visitor a, mgt_m_buildingname b, mgt_m_floor c, mgt_m_purpose d ";
		asql = asql + " WHERE a.INT_BUILDINGID = b.INT_BUILDINGID ";
		asql = asql + " AND a.INT_FLOORID = c.INT_FLOORID ";
		asql = asql + " AND a.INT_PURPOSEID = d.INT_PURPOSEID ";
		asql = asql + " AND a.INT_VISITORID ="+id;
		return asql;
	}
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			String id = request.getParameter("id");
			
				
			if (action.equals("MGTVisitorsPrint")) 
			{ 
				File reportsDir = new File(Path + "/report/SmartManagement/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				File visitorImage = new File(Path + "/uploadfiles/VisitorPhoto/"+id+".jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
				visitorphoto=(visitorImage.exists())?"../../uploadfiles/VisitorPhoto/"+id+".jpg":null;		
				
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				map.put("visitorphoto", visitorphoto);
				asql=getSqlQuery(id);
				
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportsDir, rptfilename, asql, con, Path,map);
				
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