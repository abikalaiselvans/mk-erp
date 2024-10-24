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
import com.my.org.erp.common.CommonFunctions;

public class Rept_JLeaveListActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String cmpyname="";
	String brname="";
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
			
			String company = request.getParameter("company");
			String branch = request.getParameter("branch");
			String Office = request.getParameter("Office");
			String dept = request.getParameter("dept");
			String year = request.getParameter("year");
			String resigned = request.getParameter("resigned");

			
			if(!"0".equals(company))
				cmpyname = CommonFunctions.QueryExecutecon(con,"SELECT CHR_COMPANYNAME FROM  com_m_company  WHERE INT_COMPANYID="+company)[0][0];
			else
				cmpyname="ALL";
			if(!"0".equals(branch))
			{	brname = CommonFunctions.QueryExecutecon(con,"SELECT CHR_COMPANYNAME FROM  com_m_company  WHERE INT_COMPANYID="+company)[0][0];
			}
			else
				brname="ALL";
			
			if(!"0".equals(Office))
				officename = CommonFunctions.QueryExecutecon(con, "select CHR_OFFICENAME  FROM com_m_office WHERE INT_OFFICEID="+Office)[0][0];
			else
				officename = "ALL";
			if(!"0".equals(dept))
				deptname = CommonFunctions.QueryExecutecon(con, "select chr_departname FROM com_m_depart WHERE INT_DEPARTID="+dept)[0][0];
			else
				deptname = "ALL";
			
			String sql = "";

			sql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME, DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%m-%Y'),  n.CHR_OFFICENAME,o.CHR_DEPARTNAME, ( SELECT SUM(b.DOU_VALUE)  FROM att_t_leave b    WHERE  a.CHR_EMPID = b.CHR_EMPID AND YEAR(b.DT_LDATE) = 2013 AND MONTHNAME(b.DT_LDATE)='January' GROUP BY MONTHNAME(b.DT_LDATE)),( SELECT SUM(c.DOU_VALUE)  FROM att_t_leave c    WHERE  a.CHR_EMPID = c.CHR_EMPID AND YEAR(c.DT_LDATE) =  2013  AND MONTHNAME(c.DT_LDATE)='February' GROUP BY MONTHNAME(c.DT_LDATE)), ( SELECT SUM(d.DOU_VALUE)  FROM att_t_leave d    WHERE  a.CHR_EMPID = d.CHR_EMPID AND YEAR(d.DT_LDATE) =  2013 AND MONTHNAME(d.DT_LDATE)='March' GROUP BY MONTHNAME(d.DT_LDATE)),( SELECT SUM(e.DOU_VALUE)  FROM att_t_leave e    WHERE  a.CHR_EMPID = e.CHR_EMPID AND YEAR(e.DT_LDATE) =  2013  AND MONTHNAME(e.DT_LDATE)='April' GROUP BY MONTHNAME(e.DT_LDATE)), ( SELECT SUM(f.DOU_VALUE)  FROM att_t_leave f   WHERE  a.CHR_EMPID = f.CHR_EMPID AND YEAR(f.DT_LDATE) =  2013  AND MONTHNAME(f.DT_LDATE)='May' GROUP BY MONTHNAME(f.DT_LDATE)), ( SELECT SUM(g.DOU_VALUE)  FROM att_t_leave g    WHERE  a.CHR_EMPID = g.CHR_EMPID AND YEAR(g.DT_LDATE) =  2013  AND MONTHNAME(g.DT_LDATE)='June' GROUP BY MONTHNAME(g.DT_LDATE)), ( SELECT SUM(h.DOU_VALUE)  FROM att_t_leave h    WHERE  a.CHR_EMPID = h.CHR_EMPID AND YEAR(h.DT_LDATE) =  2013  AND MONTHNAME(h.DT_LDATE)='July' GROUP BY MONTHNAME(h.DT_LDATE)),( SELECT SUM(i.DOU_VALUE)  FROM att_t_leave i   WHERE  a.CHR_EMPID = i.CHR_EMPID AND YEAR(i.DT_LDATE) =  2013  AND MONTHNAME(i.DT_LDATE)='August' GROUP BY MONTHNAME(i.DT_LDATE)),( SELECT SUM(j.DOU_VALUE)  FROM att_t_leave j   WHERE  a.CHR_EMPID = j.CHR_EMPID AND YEAR(j.DT_LDATE) =  2013  AND MONTHNAME(j.DT_LDATE)='September' GROUP BY MONTHNAME(j.DT_LDATE)),( SELECT SUM(k.DOU_VALUE)  FROM att_t_leave k   WHERE  a.CHR_EMPID = k.CHR_EMPID AND YEAR(k.DT_LDATE) =  2013  AND MONTHNAME(k.DT_LDATE)='October' GROUP BY MONTHNAME(k.DT_LDATE)),( SELECT SUM(l.DOU_VALUE)  FROM att_t_leave l   WHERE  a.CHR_EMPID = l.CHR_EMPID AND YEAR(l.DT_LDATE) =  2013  AND MONTHNAME(l.DT_LDATE)='November' GROUP BY MONTHNAME(l.DT_LDATE)),( SELECT SUM(m.DOU_VALUE)  FROM att_t_leave m   WHERE  a.CHR_EMPID = m.CHR_EMPID AND YEAR(m.DT_LDATE) =  2013  AND MONTHNAME(m.DT_LDATE)='December' GROUP BY MONTHNAME(m.DT_LDATE))  , SUM(p.INT_NOD1+p.INT_NOD2+p.INT_NOD3+p.INT_NOD4+p.INT_NOD5+p.INT_NOD6+p.INT_NOD7+p.INT_NOD8+p.INT_NOD9) leaveGiven,( SELECT SUM(q.DOU_VALUE)  FROM att_t_leave q WHERE  a.CHR_EMPID = q.CHR_EMPID AND YEAR(q.DT_LDATE) = 2013  GROUP BY YEAR(q.DT_LDATE)) leaveTaken, (   ( SUM(p.INT_NOD1+p.INT_NOD2+p.INT_NOD3+p.INT_NOD4+p.INT_NOD5+p.INT_NOD6+p.INT_NOD7+p.INT_NOD8+p.INT_NOD9))- ( SELECT SUM(s.DOU_VALUE) FROM att_t_leave s  WHERE  a.CHR_EMPID = s.CHR_EMPID AND YEAR(s.DT_LDATE) = 2013  GROUP BY YEAR(s.DT_LDATE) ) ) bal  FROM com_m_staff a ,com_m_office   n ,com_m_depart o ,att_m_leave p WHERE a.INT_OFFICEID = n.INT_OFFICEID AND a.INT_DEPARTID = o.INT_DEPARTID AND a.CHR_EMPID=p.CHR_EMPID AND p.INT_YEAR=2013 GROUP BY p.CHR_EMPID ORDER BY a.CHR_STAFFNAME";
			//System.out.println("sql1:"+sql);
			if(!"-1".equals(company))
				sql = sql + " AND a.INT_COMPANYID  = "+company;
						
			if(!"-1".equals(branch))
				sql = sql + " AND a.INT_OFFICEID ="+branch;
				
			if(!"0".equals(Office))
				sql = sql + " AND a.INT_OFFICEID="+Office;
			if(!"Y".equals(resigned))
				 asql = asql +" AND  a.CHR_TYPE!='T' ";
			 asql=sql;
			// System.out.println("sql2:"+sql);
				
			if (action.equals("ATTRept_JLeaveList")) 
			{
				File reportsDir = new File(Path + "/report/Attendance/Leave/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				map.put("year", year);
				map.put("office", officename);
				map.put("dept", deptname);
				map.put("company", cmpyname);
				map.put("branch", brname);
				
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