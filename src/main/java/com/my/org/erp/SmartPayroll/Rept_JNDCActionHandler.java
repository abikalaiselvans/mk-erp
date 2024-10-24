package com.my.org.erp.SmartPayroll;

import java.io.File;
import java.io.IOException;
import java.util.Date;
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
import com.my.org.erp.ServiceLogin.*; 
import com.my.org.erp.common.CommonFunctions;

public class Rept_JNDCActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String cmpyname="";
	String officename="";
	String deptname="";
	String hImageExpression="";
	String fImageExpression="";
	String exitInterview="";
	Double workingDays=0.0;
	Double salary=0.00;
	Double advance=0.00;
	Double loan=0.00;
	Double total=0.00;
	Double settlement=0.00;

	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		System.out.println("Rept_JNDC");
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");

			if (action.equals("PAYRept_JNDC")) 
			{
				System.out.println("insite PAYRept_JNDC");

				String rowid = request.getParameter("rowid");	
				String edate = request.getParameter("edate");	
				edate=DateUtil.FormateDateSQL(edate);
				Date entryDt=DateUtil.getDate(edate);
				int eyr=entryDt.getYear();
				
				File reportDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");

				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;

				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);

				
				String data1[][] = CommonFunctions.QueryExecute("select INT_LEAVEID from att_m_leavetype");
				String leaveBal="";
				for(int i=0;i<data1.length;i++)
					if(i==data1.length-1)
						leaveBal=leaveBal+"(select a.INT_NOD"+(i+1)+"BALANCE FROM att_m_leave a,pay_t_emp_ndc b where a.INT_NOD"+(i+1)+"BALANCE<1  AND a.CHR_EMPID=b.CHR_EMPID AND a.INT_YEAR="+eyr+" AND b.INT_NDCID = "+rowid+")";
					else
						leaveBal=leaveBal+"( select a.INT_NOD"+(i+1)+"BALANCE FROM att_m_leave a,pay_t_emp_ndc b where a.INT_NOD"+(i+1)+"BALANCE<1  AND a.CHR_EMPID=b.CHR_EMPID AND a.INT_YEAR="+eyr+" AND b.INT_NDCID = "+rowid+")+";

				asql = asql +" SELECT a.INT_NDCID,a.CHR_EMPID,b.CHR_STAFFNAME, ";
				asql = asql +" c.CHR_OFFICENAME,d.CHR_DEPARTNAME,e.CHR_CATEGORYNAME,DATE_FORMAT(DAT_RESIGNDATE,'%d-%b-%Y'),  ";
				asql = asql +" if(a.CHR_STORE='Y','Closed','Pending'), ";
				asql = asql +" a.CHR_STORE_DESC,FIND_A_EMPLOYEE_ID_NAME(a.CHR_STORE_EMPID),DATE_FORMAT(a.DAT_STORE_DATE,'%d-%b-%Y'),  ";
				asql = asql +" a.DOU_STORE,if(a.CHR_ACCOUNTS='Y','Closed','Pending'),a.CHR_ACCOUNTS_DESC,FIND_A_EMPLOYEE_ID_NAME(a.CHR_ACCOUNTS_EMPID), ";
				asql = asql +" DATE_FORMAT(a.DAT_ACCOUNTS_DATE,'%d-%b-%Y'), a.DOU_ACCOUNTS, if(a.CHR_HR='Y','Closed','Pending'), ";
				asql = asql +" a.CHR_HR_DESC,FIND_A_EMPLOYEE_ID_NAME(a.CHR_HR_EMPID),DATE_FORMAT(a.DAT_HR_DATE,'%d-%b-%Y'), ";
				asql = asql +" DOU_HR, if(a.CHR_GENERAL='Y','Closed','Pending') ,a.CHR_GENERAL_DESC,FIND_A_EMPLOYEE_ID_NAME(a.CHR_GENERAL_EMPID), ";
				asql = asql +" DATE_FORMAT(a.DAT_GENERAL_DATE,'%d-%b-%Y'), a.DOU_GENERAL, if(a.CHR_FINAL='Y','Closed','Pending') , ";
				asql = asql +" a.CHR_FINAL_DESC,FIND_A_EMPLOYEE_ID_NAME(a.CHR_FINAL_EMPID),DATE_FORMAT(a.DAT_FINAL_DATE,'%d-%b-%Y'), ";
				asql = asql +" a.DOU_FINAL, a.CHR_USRNAME,a.DT_UPDATEDATE,a.CHR_UPDATESTATUS," +
						"a.DOU_STORE+a.DOU_ACCOUNTS+DOU_HR+a.DOU_GENERAL+a.DOU_FINAL total," +
						"if(a.CHR_HR_IDCARD='Y','Id card returned','Id card not returned')," +
						"if(a.CHR_HR_ACCESSCARD='Y','Access card returned','Access card not returned') ac," +
						"if(a.CHR_HR_EMAILDELETION='Y','Email Id deleted','Email Id not deleted') em," +
						"if(a.CHR_OUTSOURCE_EMPLOYEE='Y','outsource employee','Not an outsource employee')," +
						"if(a.CHR_OUTSOURCE_EMPLOYEE='Y',if(a.CHR_OUTSOURCE='Y','Outsource claimed','Outsource not claimed'),'')," +
						"(a.DOU_STORE+a.DOU_ACCOUNTS+DOU_HR+a.DOU_GENERAL+a.DOU_FINAL) ,(";

				asql=asql+leaveBal;
				asql = asql+") leaveBal FROM pay_t_emp_ndc a , com_m_staff b, com_m_office c, com_m_depart d, com_m_employeecategory e ";
				asql = asql +" WHERE a.CHR_EMPID =b.CHR_EMPID ";
				asql = asql +" AND b.INT_OFFICEID =c.INT_OFFICEID AND a.CHR_FINAL='Y' ";
				asql = asql +" AND b.INT_DEPARTID = d.INT_DEPARTID ";
				asql = asql +" AND b.CHR_CATEGORY =e.INT_EMPLOYEECATEGORYID ";
				asql = asql +" AND a.INT_NDCID = "+rowid;

				System.out.println("asql:"+asql);
				String exitInterviewSql="SELECT IF(a.CHR_UPDATESTATUS='Y','Completed','Not Completed') FROM   pay_t_exitinterview a,pay_t_emp_ndc b WHERE a.CHR_EMPID =b.CHR_EMPID AND b.INT_NDCID ="+rowid;
				String exitInterview=CommonFunctions.QueryExecute(exitInterviewSql)[0][0];

				map.put("exitInterview",exitInterview);
				map.put("workingDays",""+workingDays);
				map.put("salary",""+salary);
				map.put("advance",""+advance);
				map.put("loan",""+loan);
				map.put("total",""+total);
				map.put("settlement",""+settlement);

				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, asql, con, Path,map);
				ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);

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