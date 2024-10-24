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
 
import com.my.org.erp.Date.Day;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JHoldingEmpListActionHandler extends AbstractActionHandler 
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
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			String Office= request.getParameter("Office");
			String Dept= request.getParameter("dept");
			
			String fmdate= request.getParameter("frmdate");
			fmdate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fmdate);
			String todate= request.getParameter("todate");
			todate=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate);
			String orderby= request.getParameter("orderby");
			
			String off="";
			String dep="";
			if(!"0".equals(Office))
				off=" AND a.INT_OFFICEID="+Office;
			if(!"0".equals(Dept))
				dep=" AND a.INT_DEPARTID= "+Dept;
					
				
			if (action.equals("PAYRept_JHoldingEmpList")) 
			{
							
				File reportDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				map.put("fdate", fmdate);
				map.put("tdate", todate);
				
				asql="SELECT a.CHR_EMPID,a.CHR_STAFFNAME,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'), ";
			 asql = asql +" DATE_FORMAT(b.DAT_HOLD,'%d-%b-%Y') FROM   com_m_staff a, att_t_hold b ";
			 asql = asql +" WHERE  a.CHR_EMPID = b.CHR_EMPID ";
			 asql = asql+" AND b.DAT_HOLD >= '"+fmdate+"' ";
			 asql = asql+" AND b.DAT_HOLD <= '"+todate+"' ";
			 asql = asql+off;
			 asql = asql+dep;
			 asql = asql + " ORDER BY "+orderby;
			 
						
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