package com.my.org.erp.JasperReport.ResignLetter;
 
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.common.CommonFunctions;

import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.util.SimpleFileResolver;

 
@WebServlet("/letter")
public class ReportController extends HttpServlet 
{

	private static final long serialVersionUID = 1L;
	JasperPrint jasperPrint;
	JRExporter exporter;
	String hImageExpression="";
	String fImageExpression="";
	String sql="";
	public void service(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String rptfilename=request.getParameter("file");
			String Path = request.getRealPath("/");
			String reporttype=request.getParameter("export");
			String empid=request.getParameter("empid");
			
			File reportsDir = new File(Path + "jasper_report_files/" + rptfilename+".jrxml"); 
			
			System.out.println(""+reportsDir.exists());
			System.out.println(reportsDir.getPath());
			sql =" SELECT DATE_FORMAT(NOW(),'%d-%b-%Y'),CONCAT(FIND_A_SHORT_NAME(),'/REL/',YEAR(NOW()),if(month(now())<10,'0','')  , " +
			" MONTH(DATE(NOW())),'/',RIGHT(CONCAT('000000',c.INT_RESIGNID),6) )  refno ," +
			" TIMESTAMPDIFF(MONTH, a.DT_DOJCOLLEGE, c.DT_TERM_DATE)," +
			" a.CHR_EMPID,a.CHR_STAFFNAME,CONCAT(if(a.CHR_GENDER='Male','Mr. '," +
			" (if(a.CHR_MARITALSTATUS ='M','Mrs.' ,'Ms.'))),' ',a.CHR_STAFFNAME) salute," +
			" d.CHR_OFFICENAME,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),DATE_FORMAT(c.DT_TERM_DATE,'%d-%b-%Y')," +
			" b.CHR_DESIGNAME,if(a.CHR_GENDER= 'Male' ,'Mr.' , (if(a.CHR_MARITALSTATUS ='M', 'Mrs.' ,'Ms.' )) )," +
			" if(a.CHR_GENDER= 'Male' ,'his' ,'her') , if(a.CHR_GENDER= 'Male' ,'he' ,'she')," +
			" if(a.CHR_GENDER= 'Male' ,'He' ,'She') firstCaps FROM com_m_staff a, com_m_desig b, pay_m_emp_termination c ," +
			" com_m_office d WHERE a.CHR_EMPID =c.CHR_EMPID AND a.INT_DESIGID = b.INT_DESIGID " +
			"AND a.INT_OFFICEID = d.INT_OFFICEID AND a.CHR_EMPID = '"+empid+"'";
			System.out.println("cessation sql "+sql);
			
			HashMap<Object,Object> map = new HashMap<Object,Object>();
			File headerImage = new File(Path + "/images/hImage.jpg");
			File footerImage = new File(Path + "/images/fImage.jpg");
			hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
			fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
			 
			map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
			map.put("hImageExpression", hImageExpression);
			map.put("fImageExpression", fImageExpression);
			map.put("empid", empid);
			map.put("shortname", CommonFunctions.QueryExecute("SELECT  FIND_A_SHORT_NAME()")[0][0]);
			map.put("Organization", "FOR "+CommonFunctions.QueryExecute("SELECT FIND_A_INSTITUTION_NAME()")[0][0]);
			
			Connection con=com.my.org.erp.JasperReport.JdbcUtil.getJdbcConnection();
			jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportsDir, rptfilename, sql, con, Path,map);
			ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
			 
			 
 
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
		} 
		
	
	}

	
}
