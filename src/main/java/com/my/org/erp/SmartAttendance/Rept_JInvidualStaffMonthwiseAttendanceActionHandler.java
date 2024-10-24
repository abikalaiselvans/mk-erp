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

public class Rept_JInvidualStaffMonthwiseAttendanceActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String officename="";
	String deptname="";
	String categoryname="";
	String hImageExpression="";
	String fImageExpression="";
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			System.out.println("Rept_JInvidualStaffMonthwiseAttendanceActionHandler");
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String rptfilename1 = request.getParameter("rptfilename1");
			String reporttype = request.getParameter("reportType");
			String empid = request.getParameter("ename");
			System.out.println("eid:"+empid);
			String month = request.getParameter("month");
			String year = request.getParameter("year");

			String Office = request.getParameter("office");
			String dept= request.getParameter("dept");
			String category= request.getParameter("Category");
			
			String monthname =  DateUtil.getMonth(Integer.parseInt(month));
			int tot = DateUtil.totalDays(Integer.parseInt(month), Integer.parseInt(year));
			HashMap<Object,Object> map = new HashMap<Object,Object>();
			
			asql ="SELECT a.CHR_EMPID,b.CHR_STAFFNAME,";
			for(int u=0;u<31;u++)
				asql = asql +" CHR_MORNING"+(u+1)+",CHR_EVENING"+(u+1) +"," ;
			asql = asql +"a.INT_RNO,a.CHR_MONTH,a.INT_YEAR FROM att_t_register a, com_m_staff b ";
			asql = asql +" WHERE a.CHR_EMPID = b.CHR_EMPID ";
			asql = asql +" AND a.CHR_EMPID='"+empid+"'  AND a.INT_YEAR="+year;
					
			if(!month.equals("0"))
					asql=asql+" AND  a.CHR_MONTH ='"+monthname+"' "; 
			
			String data[][] =CommonFunctions.QueryExecute(asql);
			
			System.out.println("sql1:"+asql);
			int r=2;
			double present=0.0;
			double absent=0.0;
			if(data.length>0)
			{
				map.put("empId",data[0][0]);	
				map.put("empName",data[0][1]);
				map.put("month",monthname);
				map.put("year",year);
				map.put("noofDays",tot);
				for(int u=1;u<=tot;u++)
				{
					map.put("sno"+u, ""+u);
					map.put("date"+u,(""+u+"-"+month+"-"+year));
					if("SUN".equals(data[0][r].trim()))
						map.put("date"+u+"M", "Sunday");
					else if("PRE".equals(data[0][r].trim()))
					{
						map.put("date"+u+"M", "Present");
						present=present+0.5;
					}
					else if("ABS".equals(data[0][r].trim()))
					{
						map.put("date"+u+"M", "Absent");
						absent=absent+0.5;
					}
					else if("PER".equals(data[0][r].trim()))
						map.put("date"+u+"M", "Permission");
					else if("LEA".equals(data[0][r].trim()))
						map.put("date"+u+"M", "Leave");
					else if("OND".equals(data[0][r].trim()))
						map.put("date"+u+"M", "Onduty");
					else if("LAT".equals(data[0][r].trim()))
						map.put("date"+u+"M", "Late");
					else if("HOL".equals(data[0][r].trim()))
						map.put("date"+u+"M", "Holiday");
					else	
						map.put("date"+u+"M", "-");
						 
					if("SUN".equals(data[0][r+1].trim()))
						map.put("date"+u+"E", "Sunday");
					else if("PRE".equals(data[0][r+1].trim()))
					{
						map.put("date"+u+"E", "Present");
						present=present+0.5;
					}
					else if("ABS".equals(data[0][r+1].trim()))
						map.put("date"+u+"E", "Absent");
					else if("PER".equals(data[0][r+1].trim()))
						map.put("date"+u+"E", "Permission");
					else if("LEA".equals(data[0][r+1].trim()))
						map.put("date"+u+"E", "Leave");
					else if("OND".equals(data[0][r+1].trim()))
						map.put("date"+u+"E", "Onduty");
					else if("LAT".equals(data[0][r+1].trim()))
						map.put("date"+u+"E", "Late");
					else if("HOL".equals(data[0][r+1].trim()))
						map.put("date"+u+"E", "Holiday");
					else	
						map.put("date"+u+"E", "-");
						 
					r = r+2;
					
					
					
				}
				
			}
			if (action.equals("ATTRept_JInvidualStaffMonthwiseAttendance")) 
			{
				
				File reportsDir = new File(Path + "/report/Attendance/" + rptfilename+".jrxml");
				File reportsDir1 = new File(Path + "/report/Attendance/" + rptfilename1+".jrxml");
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
				
				if(!"0".equals(Office))
					officename = CommonFunctions.QueryExecutecon(con, "select CHR_OFFICENAME  FROM com_m_office WHERE INT_OFFICEID="+Office)[0][0];
				else
					officename = "ALL";
				if(!"0".equals(dept))
					deptname = CommonFunctions.QueryExecutecon(con, "select chr_departname FROM com_m_depart WHERE INT_DEPARTID="+dept)[0][0];
				else
					deptname = "ALL";
				if(!"0".equals(category))
					categoryname = CommonFunctions.QueryExecutecon(con, "select chr_categoryname FROM com_m_employeecategory WHERE INT_EMPLOYEECATEGORYID="+category)[0][0];
				else
					categoryname = "ALL";
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				
				map.put("office",officename);
				map.put("dept",deptname);
				map.put("category",categoryname);
				
				map.put("month",monthname);
				map.put("year",year);
				 
				//map.put("present",present);
				//map.put("absent", absent);
				if(month.equals("0")){
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportsDir1, rptfilename1, asql, con, Path,map);
				ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename1);
				}
				else
				{
					jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportsDir, rptfilename, asql, con, Path,map);
					ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
					
				}
				
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