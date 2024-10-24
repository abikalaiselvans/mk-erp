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

public class Rept_JAdminODMonthActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String cmpyname="";
	String officename="";
	String deptname="";
	String hImageExpression="";
	String fImageExpression="";
	public String getSqlQuery(String cmpy, String office, String dept, String fdate, String tdate,  String sorting, String ss)
	{
	String sql="SELECT  a.CHR_EMPID ,b.CHR_STAFFNAME,DATE_FORMAT(a.DT_ODDATE,'%d-%m-%Y'), ";
	sql=sql+"a.CHR_TYPE, a.CHR_PLACE,a.CHR_REASON  ";
	fdate=DateUtil.FormateDateSQL(fdate);
	tdate=DateUtil.FormateDateSQL(tdate);
	sql = sql+" From att_t_onduty a, com_m_staff b ";
	sql = sql+" WHERE  b.CHR_HOLD='N' and a.CHR_EMPID = b.CHR_EMPID ";
	if(!"0".equals(cmpy))
		sql = sql+" AND b.INT_COMPANYID= "+cmpy;
	if(!"0".equals(office))
		sql = sql+"  AND b.INT_OFFICEID= "+office;	
	if(!"0".equals(dept))
		sql = sql+"   AND b.INT_DEPARTID= "+dept;
			
	sql=sql+"   AND a.DT_ODDATE>='"+fdate+"'  AND a.DT_ODDATE<='"+tdate+"'";
	sql = sql+" and b.CHR_TYPE<>'T'  ORDER BY "+ sorting +" "+ss;
	
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
			String fdate=request.getParameter("fdate");
			String tdate=request.getParameter("tdate");
			String dept = request.getParameter("dept");
			String Office = request.getParameter("Office");
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
		
						
			if (action.equals("ATTRept_JAdminODMonth")) 
			{
				File reportsDir = new File(Path + "/report/Attendance/Admin/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				map.put("dept", dept);
				map.put("office", officename);
				map.put("dept", deptname);
				map.put("company", cmpyname);
				map.put("fdate", fdate);
				map.put("tdate", tdate);
								
				asql=getSqlQuery(cmpy,Office,dept,fdate,tdate,sorting,ss);
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