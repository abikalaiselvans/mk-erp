package com.my.org.erp.SmartPayroll;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRExporter; 
import net.sf.jasperreports.engine.JasperPrint; 
  
import com.my.org.erp.SmartReport.OneSubReportFunctions;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
 

public class Rept_JAppointmentOrderActionHandler extends AbstractActionHandler 
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
		System.out.println("inside Rept_JAppointmentOrder");
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			String SubRptfilename1 = request.getParameter("subRptfilename1");
			
			if (action.equals("PAYRept_JAppointmentOrder")) 
			{
			System.out.println("inside Rept_JAppointmentOrder");
				
				File reportDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				
				String staffid=""+request.getParameter("ename");
				//String staffid="admin";
				asql="select A.CHR_STAFFNAME,CONCAT(if(a.CHR_GENDER='Male','Mr. ',(if(a.CHR_MARITALSTATUS ='M','Mrs.' ,'Ms.'))),' ',a.CHR_STAFFNAME),A.DT_DOJCOLLEGE,A.CHR_SADD1,A.CHR_SADD2,A.CHR_SCITY,A.CHR_SSTATE,A.CHR_SPIN, ";
				asql=asql+"B.CHR_DESIGNAME,C.CHR_COMPANYNAME,A.CHR_GENDER,A.CHR_MARITALSTATUS , RIGHT(CHR_EMPID,6),A.CHR_PERMAILID ,D.CHR_DEPARTNAME,E.CHR_OFFICENAME,A.CHR_PF,A.CHR_ESI  ";
				asql=asql+"from com_m_staff A, com_m_desig B,com_m_company C,com_m_depart D,  com_m_office  E  ";
				asql=asql+" where A.CHR_EMPID='"+staffid+"' AND A.INT_DESIGID=B.INT_DESIGID ";
				asql=asql+" AND A.INT_COMPANYID=C.INT_COMPANYID   AND A.INT_DEPARTID = D.INT_DEPARTID AND A.INT_OFFICEID = E.INT_OFFICEID ";
				System.out.println("asql:"+asql);
				
				String staffdata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(asql);
				String appointed=DateUtil.FormateDateSys(staffdata[0][2]);
				String app=com.my.org.erp.common.CommonFunctions.Appointmentyear(appointed);
				String id[]=app.split("~");
				String apdate=DateUtil.FormateDateSys(DateUtil.getCurrentDBDate());
				String dateid[]=apdate.split("-");
				String appdate=dateid[0]+" "+ DateUtil.getMonth(Integer.parseInt(dateid[1]))+" "+dateid[2]; 
			
				map.put("ref1", id[0]);
				map.put("date", appdate);
				map.put("eid", staffid);
				
				File subReport1Dir = new File(Path + "/report/SmartPayroll/" + SubRptfilename1+".jrxml");
				String subReptSql=null;
	
				jasperPrint=OneSubReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, asql, con, Path,map,subReport1Dir,subReptSql);
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