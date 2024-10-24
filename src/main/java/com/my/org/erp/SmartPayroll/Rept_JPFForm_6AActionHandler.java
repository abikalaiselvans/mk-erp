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
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JPFForm_6AActionHandler extends AbstractActionHandler 
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
		System.out.println("Rept_JPFForm_6AActionHandler");
		try 
		{ 
			String action = request.getParameter("actionS");
			
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			if (action.equals("PAYRept_JPFForm_6A")) 
			{
				System.out.println("insite Rept_JPFForm_6A");
				
				File reportDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				

				String company =request.getParameter("company");
				String branch =request.getParameter("branch");
				String office =request.getParameter("Office");
				String year =request.getParameter("Year");
				String cpy  ="";
				String bid  ="";
				String off="";
				 
				
				String sql="";
				sql=" SELECT a.CHR_EMPID,a.CHR_EMPNAME,CONCAT(c.CHR_PFNUMBER,b.CHR_PFNO),ROUND(sum(a.DOU_BASIC)),ROUND(sum(a.DOU_PF)),ROUND(sum(a.DOU_CPYPF2)),ROUND(sum(a.DOU_CPYPF1))";
				sql = sql+",b.CHR_TYPE,b.CHR_HOLD	FROM pay_t_salary a, com_m_staff b,com_m_company c ";                               
				sql = sql+"	WHERE a.CHR_EMPID =b.CHR_EMPID  AND a.CHR_PF !='N'   AND  b.INT_COMPANYID=c.INT_COMPANYID  ";
				if(!"0".equals(company))
					sql = sql+"	AND b.INT_COMPANYID = "+company;
				
				if(!"0".equals(branch))
					sql = sql+"	AND b.INT_BRANCHID = "+branch;
				
				if(!"0".equals(office))
					sql = sql+"	AND b.INT_OFFICEID = "+office;
					
				sql = sql+"	"+cpy;
				sql = sql+"	"+bid;
				sql = sql+"	"+ off;
				sql = sql+" AND (((a.CHR_MONTH in('April','May','June','July','August','September','October','November','December')) AND";
				sql = sql+"  (a.INT_YEAR= "+(Integer.parseInt(year)-1)+")) or((a.CHR_MONTH in('January','February','March')) ";
				sql = sql+" AND (a.INT_YEAR= "+year+")  )) group BY CHR_PFNO  "; //ORDER BY replace(CHR_PFNO,'TN/50360/','')
				 
				
				String cdata[][] = CommonFunctions.QueryExecute("SELECT upper(CHR_COMPANYNAME) FROM com_m_company WHERE INT_COMPANYID ="+company);
				if(cdata[0][0].length()>0)
				map.put("cpy", cdata[0][0]);
				
				int iyr=Integer.parseInt(year);
			 	String yr=Integer.toString(iyr-1);
			 	String yrTitle="Year   : "+yr+"-"+year;
			 	map.put("year", yrTitle);
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, sql, con, Path,map);
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