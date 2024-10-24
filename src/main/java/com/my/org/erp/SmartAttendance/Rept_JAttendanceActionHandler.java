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

public class Rept_JAttendanceActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String cmpyname="";
	String officename="";
	String deptname="";
	String hImageExpression="";
	String fImageExpression="";
	public String getSqlQuery(String cmpy, String office, String dept, String umonth, String year, String sorting, String ss)
	{ 
	String sql=" SELECT a.CHR_EMPID,b.CHR_STAFFNAME, FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING1) , " +
			" FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING1),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING2) ," +
			"  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING2),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING3) ," +
			"  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING3),   FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING4) ," +
			"  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING4),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING5) ," +
			"    FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING5),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING6) ," +
			"  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING6),     FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING7) , " +
			" FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING7),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING8) ," +
			"      FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING8),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING9) ," +
			"  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING9),       FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING10) ," +
			"  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING10),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING11) ," +
			"        FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING11),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING12) ," +
			"  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING12),         FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING13) ," +
			"  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING13),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING14) , " +
			"         FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING14),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING15) ," +
			"  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING15),           FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING16)," +
			"  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING16),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING17) ," +
			"            FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING17),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING18)," +
			"FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING18),              FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING19) ," +
			"  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING19),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING20) ," +
			"FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING20),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING21) ," +
			"FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING21),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING22) ," +
			"FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING22),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING23) ," +
			"FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING23),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING24) , " +
			"                FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING24),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING25) ," +
			"                 FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING25),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING26) ," +
			"                 FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING26),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING27) , " +
			"                FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING27),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING28) , " +
			"                 FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING28),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING29) , " +
			"                  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING29),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING30) ," +
			"                    FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING30),  FIND_A_EMPLOYEE_ATTENREGISTER(CHR_MORNING31) , " +
			"                   FIND_A_EMPLOYEE_ATTENREGISTER(CHR_EVENING31) FROM att_t_register a, com_m_staff b " ;
			
			sql = sql+" WHERE a.INT_YEAR="+year+" AND a.CHR_EMPID = b.CHR_EMPID AND a.CHR_MONTH ='"+umonth+"'";
			if(!"0".equals(cmpy))
				sql=sql+" AND B.INT_COMPANYID= "+cmpy;
			
			if(!"0".equals(office))	
				sql=sql+" AND B.INT_OFFICEID= "+office;
			
			if(!"0".equals(dept))
				sql=sql+" AND B.INT_DEPARTID= "+dept;
			
			sql=sql+" ORDER BY b.CHR_STAFFNAME";	 
		
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
		
			int intYear=Integer.parseInt(year);
			int intMonth=Integer.parseInt(month);
			int daysinaMonth = Day.getDaysInMonth((intMonth-1) ,intYear);
			
			
			if (action.equals("ATTRept_JAttendance")) 
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
				
				for(int d=1;d<=31;d++)
					if(d <=daysinaMonth)
						map.put(("day"+d), Day.displayDayname(d,(intMonth-1),intYear,"2"));
					else
						map.put(("day"+d),"" );
							
				System.out.println(map);
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