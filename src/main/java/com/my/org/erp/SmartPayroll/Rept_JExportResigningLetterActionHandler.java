package com.my.org.erp.SmartPayroll;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JasperPrint;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JExportResigningLetterActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String cmpyname="";
	String officename="";
	String deptname="";
	String hImageExpression="";
	String fImageExpression="";
	public String getSqlQuery(String empid, String shortname)
	{
		asql =" SELECT DATE_FORMAT(NOW(),'%d-%b-%Y'),CONCAT('"+shortname+"/REL/',YEAR(NOW()),if(month(now())<10,'0','')  , " +
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
	
		System.out.println("cessation sql "+asql);
		return asql;
	}
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename1 = request.getParameter("rptfilename1");
			String rptfilename2 = request.getParameter("rptfilename2");
			String reporttype = request.getParameter("reportType");
			String empid =request.getParameter("empid");
			String company = CommonFunctions.QueryExecute("SELECT UPPER(CHR_NAME) FROM m_company WHERE INT_CPYID =1")[0][0];
			String shortname = CommonFunctions.QueryExecute("SELECT UPPER(CHR_SHORTNAME) FROM m_institution WHERE INT_ID =1")[0][0];
			 
			if (action.equals("PAYRept_JExportResigningLetter")) 
			{
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				map.clear();
				map.put("dc", "\"");
				map.put("shortname", "shortname");
				map.put("company", "For <b>"+company+"</b>");
				asql=getSqlQuery(empid,shortname);
				String empExpMonCt=CommonFunctions.QueryExecute(asql)[0][2];
				int expMonthCt=Integer.parseInt(empExpMonCt);
				
				//Check Lesser than 6months or greater than six
				File report = null;
				if(expMonthCt<=6)
					report = new File(Path + "/report/SmartPayroll/" + rptfilename1+".jrxml");
				else
					report = new File(Path + "/report/SmartPayroll/" + rptfilename2+".jrxml");
				System.out.println("cessation report file :: "+report);
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, report, rptfilename1, asql, con, Path,map);
				ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename1);
				map.clear();
				
			}
		} 
		catch (Exception e) 
		{
			 
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
			RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response);
		}
	}
}