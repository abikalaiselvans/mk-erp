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
  
import com.my.org.erp.SmartReport.OneSubReportFunctions;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil; 

public class Rept_JPFForm_5ActionHandler extends AbstractActionHandler 
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
		 
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			String SubRptfilename1 = request.getParameter("subRptfilename1");
			
			if (action.equals("PAYRept_JPFForm_5")) 
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
				
				
				String comid=request.getParameter("company");
				String branchid=request.getParameter("branch");
				String officeid=request.getParameter("Office");
				String mth=request.getParameter("Month");
				String mont = DateUtil.getMonth(Integer.parseInt(mth));
				String year=request.getParameter("Year");
			  	
			  	map.put("month", mont);
				map.put("year", year);
				asql = " SELECT UPPER(a.CHR_COMPANYNAME),a.CHR_STREET,f.CHR_CITYNAME,a.INT_PINCODE,a.CHR_PFNUMBER, ";
				asql = asql + " c.CHR_COUNTRYNAME,d.CHR_STATENAME,e.CHR_DISTRICT,f.CHR_CITYNAME  ";
				asql = asql + " FROM com_m_company a, com_m_country c, com_m_state d, com_m_district e, com_m_city f ";
				asql = asql + " WHERE a.INT_COUNTRYID= c.INT_COUNTRYID ";
				asql = asql + " AND a.INT_STATEID = d.INT_STATEID ";
				asql = asql + " AND a.INT_DISTRICTID = e.INT_DISTRICTID ";
				asql = asql + " AND a.INT_CITYID = f.INT_CITYID ";
				asql = asql + " AND a.INT_COMPANYID="+comid;
				
				File subReport1Dir = new File(Path + "/report/SmartPayroll/" + SubRptfilename1+".jrxml");
				
				String subReptSql="select if(a.CHR_PFNO=0,' ',a.CHR_PFNO),UPPER(a.CHR_STAFFNAME),UPPER(a.CHR_STAFFFNAME),DATE_FORMAT(a.DT_DOB,'%d-%b-%Y'),a.CHR_GENDER,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),a.CHR_EMPID,DATE_FORMAT(a.DAT_PFESIDATE,'%d-%b-%Y') from com_m_staff a,pay_t_salary b";
			  	subReptSql=subReptSql+ " where a.CHR_EMPID = b.CHR_EMPID AND b.CHR_ESI !='N' AND  b.CHR_PF!='N'  AND  month(a.DAT_PFESIDATE)="+mth+" ";  //a.CHR_EMPID = b.CHR_EMPID AND 
			  	if(!"Select".equals(comid))
					subReptSql=subReptSql+ " AND a.INT_COMPANYID = "+comid;
				if(!"0".equals(branchid))
					subReptSql=subReptSql+ " AND a.INT_BRANCHID = "+branchid;
				if(!"0".equals(officeid))
					subReptSql=subReptSql+ "  AND a.INT_OFFICEID = "+officeid;
				 
				subReptSql=subReptSql+ " and year(a.DAT_PFESIDATE)="+year+" group by a.CHR_EMPID order by a.CHR_PFNO";
				System.out.println("sub sql:"+subReptSql);

						
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