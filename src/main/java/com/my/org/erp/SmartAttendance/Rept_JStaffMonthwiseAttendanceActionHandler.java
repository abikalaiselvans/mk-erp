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
 
import com.my.org.erp.Date.Day;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JStaffMonthwiseAttendanceActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String officename="";
	String deptname="";
	String categoryname="";
	String hImageExpression="";
	String fImageExpression="";
	public String getSqlQuery(String Category, String office, String dept, String month, String year, String umonth, String sorting, String ss)
	{
		String sql ="  SELECT a.CHR_EMPID,b.CHR_STAFFNAME,";
		for(int d=1;d<=31;d++)
			sql = sql+" FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING"+d +") , "+" FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING"+d +"), ";
		sql = sql+" a.DOU_PRESENT,a.DOU_ONDUTY,	a.DOU_SUNDAY,a.DOU_HOLIDAY,";
		sql = sql+" a.DOU_LEAVE,a.DOU_ABSENT,a.INT_LATE,a.INT_PERMISSION,";
		sql = sql+" a.DOU_EXTRADAYS,a.DOU_EXTRAHOURS,a.DOU_TOTALDAYS ";
		sql = sql+" FROM att_t_register a, com_m_staff b";
		sql = sql+" WHERE a.CHR_EMPID =b.CHR_EMPID ";
		sql = sql+" AND a.CHR_MONTH='"+month+"'";
		sql = sql+" AND a.INT_YEAR ="+year;
		if(!"0".equals(office))
			sql = sql + "  AND b.INT_OFFICEID="+office;
		if(!"0".equals(dept))
			sql = sql + " AND b.INT_DEPARTID="+dept;
		if(!"0".equals(Category))
			sql = sql + "  AND b.CHR_CATEGORY='"+Category +"' ";
		sql = sql+" ORDER BY b.CHR_STAFFNAME ";
		
		return sql;
	}
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			String Office = request.getParameter("Office");
			String dept = request.getParameter("dept");
			String Category=request.getParameter("Category");
			String month = request.getParameter("month");
			String year = request.getParameter("year");
			String umonth=DateUtil.getMonth(Integer.parseInt(month));
			String sorting = request.getParameter("sorting");
			String ss = request.getParameter("ss");
			
			if(!"0".equals(Office))
				officename = CommonFunctions.QueryExecutecon(con, "select CHR_OFFICENAME  FROM com_m_office WHERE INT_OFFICEID="+Office)[0][0];
			else
				officename = " ALL";
			if(!"0".equals(dept))
				deptname = CommonFunctions.QueryExecutecon(con, "select chr_departname FROM com_m_depart WHERE INT_DEPARTID="+dept)[0][0];
			else
				deptname = " ALL";
			if(!"0".equals(dept))
				categoryname = CommonFunctions.QueryExecutecon(con, "select CHR_CATEGORYNAME FROM com_m_employeecategory where INT_EMPLOYEECATEGORYID="+Category)[0][0];
			else
				categoryname = " ALL";
			int intYear=Integer.parseInt(year);
			int intMonth=Integer.parseInt(month);
			int daysinaMonth = Day.getDaysInMonth((intMonth-1) ,intYear);
			
			for(int d=1;d<=31;d++)
				if(d <=Day.getDaysInMonth((intMonth-1),intYear))
					System.out.println(d+"--"+Day.displayDayname(d,(intMonth-1),intYear,"2"));
				else
					System.out.println(d+"--"+ " ");
				
			if (action.equals("ATTRept_StaffMonthwiseAttendance")) 
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
				map.put("category", categoryname);
				
				for(int d=1;d<=31;d++)
					if(d <=daysinaMonth)
						map.put(("day"+d), Day.displayDayname(d,(intMonth-1),intYear,"2"));
					else
						map.put(("day"+d),"" );
				
							
				asql=getSqlQuery(Category,Office,dept,umonth,year,month,sorting,ss);
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