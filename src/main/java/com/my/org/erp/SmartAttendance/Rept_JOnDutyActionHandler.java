package com.my.org.erp.SmartAttendance;

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
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JOnDutyActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String cmpyname="";
	String officename="";
	String deptname="";
	String hImageExpression="";
	String fImageExpression="";
	public String getSqlQuery(String cmpy, String office, String dept, String umonth, String year,  String sorting, String ss)
	{
	String sql="SELECT  a.CHR_EMPID ,b.CHR_STAFFNAME,a.DOU_ONDUTY ";
		 sql = sql+" From att_t_register a, com_m_staff b ";
		 sql = sql+" WHERE a.CHR_EMPID = b.CHR_EMPID   AND a.INT_YEAR="+year+"";
		sql=sql+"   AND a.DOU_ONDUTY>0  ";
		if(!"0".equals(cmpy))
			sql=sql+" AND b.INT_COMPANYID= "+cmpy;
		
		if(!"0".equals(office))	
			sql=sql+"  AND b.INT_OFFICEID= "+office;
		
		if(!"0".equals(dept))
			sql=sql+"   AND b.INT_DEPARTID= "+dept;
		
		
		 sql = sql+" AND a.CHR_MONTH ='"+umonth+"' ORDER BY "+ sorting +" "+ss;
	
		return sql;
	}
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			String cmpy=request.getParameter("company");
			String Office = request.getParameter("Office");
			String dept = request.getParameter("dept");
			String month = request.getParameter("month");
			String year = request.getParameter("year");
			String umonth=DateUtil.getMonth(Integer.parseInt(month));
			String sorting = request.getParameter("sorting");
			String ss = request.getParameter("ss");
			
			if(!"0".equals(cmpy))
				cmpyname = CommonFunctions.QueryExecutecon(con,"SELECT CHR_COMPANYNAME FROM  com_m_company  WHERE INT_COMPANYID="+cmpy)[0][0];
			else
				cmpyname="ALL";
			
			if(!"0".equals(Office))
				officename = CommonFunctions.QueryExecutecon(con, "select CHR_OFFICENAME  FROM com_m_office WHERE INT_OFFICEID="+Office)[0][0];
			else
				officename = "ALL";
			if(!"0".equals(dept))
				deptname = CommonFunctions.QueryExecutecon(con, "select chr_departname FROM com_m_depart WHERE INT_DEPARTID="+dept)[0][0];
			else
				deptname = "ALL";
		
				
			if (action.equals("ATTRept_JOnDuty")) 
			{
				File reportsDir = new File(Path + "/report/Attendance/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				map.put("year", year);
				map.put("month", umonth);
				map.put("dept", dept);
				map.put("office", officename);
				map.put("dept", deptname);
				map.put("company", cmpyname);
				
							
				asql=getSqlQuery(cmpy,Office,dept,umonth,year,sorting,ss);
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