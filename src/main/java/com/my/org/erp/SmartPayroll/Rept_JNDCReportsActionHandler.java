package com.my.org.erp.SmartPayroll;

import java.io.File;
import java.io.FileNotFoundException;
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

public class Rept_JNDCReportsActionHandler extends AbstractActionHandler 
{

	
	JasperPrint jasperPrint;
	JRExporter exporter;
	public String getSqlQuery()
	{
		asql =" SELECT a.CHR_EMPID,a.CHR_STAFFNAME, b.CHR_TER_TYPE,DATE_FORMAT(b.DT_TERM_DATE,'%d-%b-%Y'),datediff(now(),b.DT_TERM_DATE)," +
				"if(d.CHR_FINAL = 'Y','','Need NDC Tracking'),if(d.CHR_STORE='Y' , 'Closed' , 'Pending'),if(d.CHR_HR='Y' , 'Closed' , 'Pending')," +
				"if(d.CHR_ACCOUNTS='Y' , 'Closed' , 'Pending'), if(d.CHR_GENERAL='Y' , 'Closed' , 'Pending')," +
				"if(d.CHR_FINAL='Y' , 'Closed' , 'Pending') FROM com_m_staff a ,pay_m_emp_termination b , pay_t_exitinterview c ," +
				"pay_t_emp_ndc d WHERE a.CHR_EMPID = b.CHR_EMPID AND a.CHR_EMPID = c.CHR_EMPID AND a.CHR_EMPID = d.CHR_EMPID " +
				"AND CHR_TER_TYPE !='Abscond' AND b.DT_TERM_DATE >= '2013-05-01' AND ( c.CHR_STATUS != 'Y' OR  d.CHR_FINAL != 'Y'  ) " +
				"AND d.CHR_FINAL != 'Y' ORDER BY a.CHR_STAFFNAME ";
		System.out.println("asql:"+asql);
		return asql;
	}
	public String getSqlQuery1()
	{
		asql =" SELECT a.CHR_EMPID,a.CHR_STAFFNAME,b.CHR_COMPANYNAME,c.CHR_BRANCHNAME,d.CHR_OFFICENAME, e.CHR_CATEGORYNAME ," +
				"DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),DATE_FORMAT(a.DAT_RIVISION,'%d-%b-%Y'),DATEDIFF(now(),a.DAT_RIVISION) FROM com_m_staff a ,com_m_company b, " +
				"com_m_branch c, com_m_office d, com_m_employeecategory e WHERE a.INT_COMPANYID = b.INT_COMPANYID AND " +
				"a.INT_BRANCHID = c.INT_BRANCHID AND a.INT_OFFICEID = d.INT_OFFICEID AND a.CHR_CATEGORY = e.INT_EMPLOYEECATEGORYID " +
				"AND a.CHR_TYPE != 'T' AND a.DAT_RIVISION is not null AND (  ( MONTH(a.DAT_RIVISION)=MONTH(NOW()) AND " +
				"YEAR(a.DAT_RIVISION) = YEAR(NOW()) ) OR ( a.DAT_RIVISION <=DATE(NOW()) ) )  ";
		System.out.println("asql:"+asql);
		return asql;
	}
	public String getSqlQuery2()
	{
		asql =" SELECT a.CHR_EMPID,a.CHR_STAFFNAME,c.CHR_OFFICENAME,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'), DATE_FORMAT(b.DT_TERM_DATE,'%d-%b-%Y'),datediff(b.DT_TERM_DATE,a.DT_DOJCOLLEGE) FROM com_m_staff a , pay_m_emp_termination b,com_m_office c WHERE a.CHR_EMPID =b.CHR_EMPID AND a.CHR_TYPE ='T' AND a.INT_OFFICEID = c.INT_OFFICEID AND a.DT_DOJCOLLEGE >= DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 60 DAY),'%Y-%m-%d') AND a.DT_DOJCOLLEGE <=date(now()) AND datediff(b.DT_TERM_DATE,a.DT_DOJCOLLEGE) <= 60 ORDER BY  a.CHR_STAFFNAME ";
		System.out.println("asql:"+asql);
		return asql;
	}
	public String getSqlQuery3()
	{
		asql =" SELECT a.CHR_EMPID,a.CHR_STAFFNAME,c.CHR_BRANCHNAME, DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'), DATE_FORMAT(b.DAT_CREATION_DATE,'%d-%b-%Y'), DATEDIFF(NOW(),b.DAT_CREATION_DATE)  FROM com_m_staff a, pay_t_emp_ndc b, com_m_branch c WHERE a.CHR_EMPID = b.CHR_EMPID AND a.INT_BRANCHID = c.INT_BRANCHID AND b.CHR_STORE='Y' AND b.CHR_ACCOUNTS='Y'	AND b.CHR_HR='Y' AND b.CHR_GENERAL='Y' AND b.CHR_FINAL !='Y' ORDER BY a.CHR_STAFFNAME";
		System.out.println("asql:"+asql);
		return asql;
	}

	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String rptfilename1 = request.getParameter("rptfilename1");
			String rptfilename2 = request.getParameter("rptfilename2");
			String rptfilename3 = request.getParameter("rptfilename3");
			String reporttype = request.getParameter("reportType");
			String hLinkName = request.getParameter("hLinkName");
			System.out.println("hLinkName:"+hLinkName);
			HashMap<Object,Object> map = new HashMap<Object,Object>();
			
			if (action.equals("PAYRept_JNDCReports")) 
			{
				System.out.println("PAYRept_JNDCReports:");
				
				File reportDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");
				File reportDir1 = new File(Path + "/report/SmartPayroll/" + rptfilename1+".jrxml");
				File reportDir2 = new File(Path + "/report/SmartPayroll/" + rptfilename2+".jrxml");
				File reportDir3 = new File(Path + "/report/SmartPayroll/" + rptfilename3+".jrxml");
				/*if (!reportDir.exists()) 
				{
				    throw new FileNotFoundException(String.valueOf(reportDir));
				}*/
				
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				String hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				String fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				if(hLinkName.equals("NDC"))
				asql=getSqlQuery();
				else if(hLinkName.equals("revisionList"))
				asql=getSqlQuery1();
				else if(hLinkName.equals("abortCase"))
				asql=getSqlQuery2();
				else if(hLinkName.equals("needFinalClose"))
				asql=getSqlQuery3();
				String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(asql);
				
				if(data.length<=0 )
					map.put("dataLength", "0");
				else
					map.put("dataLength", "1");
				
				if(hLinkName.equals("NDC"))
				{
					jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, asql, con, Path,map);
					ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
				}
					
					else if(hLinkName.equals("revisionList"))
					{
						jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir1, rptfilename1, asql, con, Path,map);
						ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename1);
					}
					
					else if(hLinkName.equals("abortCase"))
					{
						jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir2, rptfilename2, asql, con, Path,map);
						ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename2);
					}
					
					else if(hLinkName.equals("needFinalClose"))
					{
						jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir3, rptfilename3, asql, con, Path,map);
						ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename3);
					}
					
				
				
			}
		
		} catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response);
		}
	}
}
