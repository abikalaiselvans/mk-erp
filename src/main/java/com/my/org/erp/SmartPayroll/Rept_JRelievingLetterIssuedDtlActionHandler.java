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
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.SmartReport.SavePDFFunction;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil; 
import com.my.org.erp.common.CommonFunctions;

public class Rept_JRelievingLetterIssuedDtlActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String hImageExpression="";
	String fImageExpression="";
	String company,branch,office,dept,category;
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			
				
			if (action.equals("PAYRept_JRelievingLetterIssuedDtl")) 
			{
				company= request.getParameter("company");
				branch= request.getParameter("branch");
				office= request.getParameter("Office");
				dept= request.getParameter("dept");
				category= request.getParameter("Category");
				String fmdate= request.getParameter("fromdate");
				String todate= request.getParameter("todate");
				 
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
				fmdate=DateUtil.FormateDateSQL(fmdate);
				todate=DateUtil.FormateDateSQL(todate);			
				
				asql = "SELECT a.CHR_EMPID,b.CHR_STAFFNAME,date_format(b.DT_DOJCOLLEGE,'%d-%m-%Y') doj,date_format(b.DAT_RESIGNDATE,'%d-%m-%Y') dor, date_format(a.DAT_ISSUE,'%d-%m-%Y') doi ,b.CHR_REPTO,c.CHR_COMPANYNAME,d.CHR_BRANCHNAME,e.CHR_OFFICENAME,f.CHR_DEPARTNAME,g.CHR_CATEGORYNAME FROM pay_t_emp_ndc a,com_m_staff b,com_m_company c,com_m_branch d,com_m_office e,com_m_depart f,com_m_employeecategory g WHERE a.CHR_EMPID=b.CHR_EMPID AND b.INT_COMPANYID=c.INT_COMPANYID  AND b.INT_BRANCHID=d.INT_BRANCHID   AND b.INT_OFFICEID=e.INT_OFFICEID   AND b.INT_DEPARTID=f.INT_DEPARTID   AND b.CHR_CATEGORY=g.INT_EMPLOYEECATEGORYID AND a.CHR_ISSUE='Y'";	
				if(!"0".equals(company))
					asql = asql +"  AND b.INT_COMPANYID="+company;
				if(!"0".equals(branch))
					asql = asql +"  AND b.INT_BRANCHID="+branch;
				if(!"0".equals(office))
					asql = asql +"  AND b.INT_OFFICEID="+office;
				if(!"0".equals(dept))
					asql = asql +"  AND b.INT_DEPARTID="+dept;
				if(!"0".equals(category))
					asql = asql +"   AND b.CHR_CATEGORY='"+category +"' ";	
				asql = asql+" AND a.DAT_ISSUE >= '"+fmdate+"' ";
				asql = asql+" AND a.DAT_ISSUE <= '"+todate+"' "; 
			
				String data[][] = CommonFunctions.QueryExecute(asql);
				if(data.length<=0)
					map.put("dataLength", "0");
				else
					map.put("dataLength", "1");
				
				if(!"0".equals(company))
				{
					String shipids[][] = CommonFunctions.QueryExecute("SELECT CHR_COMPANYNAME FROM com_m_company  WHERE  INT_COMPANYID ="+company);
					map.put("company",shipids[0][0]);
				}
				else
					map.put("company", "All Companies");
				if(!branch.equals("0"))
				{
					String shipids[][] = CommonFunctions.QueryExecute("SELECT CHR_BRANCHNAME FROM  com_m_branch WHERE INT_BRANCHID="+branch);
					map.put("branch", shipids[0][0]);
				}
				else
					map.put("branch", "All Branches");
				if(!office.equals("0"))
				{
					String shipids[][] = CommonFunctions.QueryExecute("select CHR_OFFICENAME from com_m_office where INT_OFFICEID="+office);
					map.put("office", shipids[0][0]);
				}
				else
					map.put("office", "All Offices");
				if(!dept.equals("0"))
				{
					String shipids[][] = CommonFunctions.QueryExecute("select CHR_DEPARTNAME from com_m_depart where INT_DEPARTID="+dept);
					map.put("dept",shipids[0][0]);
				}
				else
					map.put("dept", "All Departments");
				
				if(!dept.equals("0"))
				{
					String shipids[][] = CommonFunctions.QueryExecute("select CHR_CATEGORYNAME from com_m_employeecategory where INT_EMPLOYEECATEGORYID="+category);
					map.put("category",shipids[0][0]);
				}
				else
					map.put("category", "All Categories");
				
				jasperPrint=SavePDFFunction.createReport(jasperPrint, request, response, reportDir, rptfilename, asql, con, Path,map);
				ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
				
			}
		
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response);
		}
	}
}