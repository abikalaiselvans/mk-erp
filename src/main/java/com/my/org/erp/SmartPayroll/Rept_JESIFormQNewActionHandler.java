 package com.my.org.erp.SmartPayroll;


import java.io.File;

import java.io.IOException;
import java.util.HashMap;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JasperPrint;

import com.my.org.erp.JasperReport.ReportTemplate;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JESIFormQNewActionHandler extends AbstractActionHandler 
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
		System.out.println("inside Rept_JESIFormQActionHandler handle");
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			rptfilename = rptfilename+".jrxml";
			if(action.equals("PAYRept_JESIFormQ")) 
			{
					String company=request.getParameter("company");
					String branch=request.getParameter("branch");
					String office=request.getParameter("Office");
					String category=request.getParameter("category");
					String Month=request.getParameter("Month");
					String month = DateUtil.getMonth(Integer.parseInt(Month));
					String Year=request.getParameter("Year");
					String department=request.getParameter("department");
					 
					
					asql = " ";
					asql = asql +" SELECT  b.CHR_EMPID,b.CHR_STAFFNAME,DATE_FORMAT(b.DT_DOB,'%d-%b-%Y'),";
					asql = asql +"  CONCAT(   ";
					asql = asql +"  		FLOOR(PERIOD_DIFF(DATE_FORMAT(NOW(),'%y%m') , DATE_FORMAT(b.DT_DOJCOLLEGE,'%y%m'))/12 ), '-Yrs / ' ,   ";
					//asql = asql +"  		MOD(PERIOD_DIFF(DATE_FORMAT(NOW(),'%y%m') , DATE_FORMAT(b.DT_DOJCOLLEGE,'%y%m') ), 12) , '-Mths / ' ,  ";
					asql = asql +"  		DATE_FORMAT(b.DT_DOJCOLLEGE,'%d-%b-%Y')   ";
					asql = asql +"  		)  doj,  ";
					asql = asql +"  c.CHR_DESIGNAME, a.CHR_MONTH,a.INT_YEAR,  ";
					asql = asql +"  FUN_PAY_FORM_Q(CHR_MORNING1,CHR_EVENING1) d1, FUN_PAY_FORM_Q(CHR_MORNING2,CHR_EVENING2) d2, ";
					asql = asql +"  FUN_PAY_FORM_Q(CHR_MORNING3,CHR_EVENING3) d3, FUN_PAY_FORM_Q(CHR_MORNING4,CHR_EVENING4) d4, ";
					asql = asql +"  FUN_PAY_FORM_Q(CHR_MORNING5,CHR_EVENING5) d5, FUN_PAY_FORM_Q(CHR_MORNING6,CHR_EVENING6) d6, ";
					asql = asql +"  FUN_PAY_FORM_Q(CHR_MORNING7,CHR_EVENING8) d7, FUN_PAY_FORM_Q(CHR_MORNING8,CHR_EVENING9) d8, ";
					asql = asql +"  FUN_PAY_FORM_Q(CHR_MORNING9,CHR_EVENING9) d9, FUN_PAY_FORM_Q(CHR_MORNING10,CHR_EVENING10) d10, ";
					asql = asql +"  FUN_PAY_FORM_Q(CHR_MORNING11,CHR_EVENING11) d11, FUN_PAY_FORM_Q(CHR_MORNING12,CHR_EVENING12) d12, ";
					asql = asql +"  FUN_PAY_FORM_Q(CHR_MORNING13,CHR_EVENING13) d13, FUN_PAY_FORM_Q(CHR_MORNING14,CHR_EVENING14) d14, ";
					asql = asql +"  FUN_PAY_FORM_Q(CHR_MORNING15,CHR_EVENING15) d15, FUN_PAY_FORM_Q(CHR_MORNING16,CHR_EVENING16) d16, ";
					asql = asql +"  FUN_PAY_FORM_Q(CHR_MORNING17,CHR_EVENING17) d17, FUN_PAY_FORM_Q(CHR_MORNING18,CHR_EVENING18) d18, ";
					asql = asql +"  FUN_PAY_FORM_Q(CHR_MORNING19,CHR_EVENING19) d19, FUN_PAY_FORM_Q(CHR_MORNING20,CHR_EVENING20) d20, ";
					asql = asql +"  FUN_PAY_FORM_Q(CHR_MORNING21,CHR_EVENING21) d21, FUN_PAY_FORM_Q(CHR_MORNING22,CHR_EVENING22) d22, ";
					asql = asql +"  FUN_PAY_FORM_Q(CHR_MORNING23,CHR_EVENING23) d23, FUN_PAY_FORM_Q(CHR_MORNING24,CHR_EVENING24) d24, ";
					asql = asql +"  FUN_PAY_FORM_Q(CHR_MORNING25,CHR_EVENING25) d25, FUN_PAY_FORM_Q(CHR_MORNING26,CHR_EVENING26) d26, ";
					asql = asql +"  FUN_PAY_FORM_Q(CHR_MORNING27,CHR_EVENING27) d27, FUN_PAY_FORM_Q(CHR_MORNING28,CHR_EVENING28) d28, ";
					asql = asql +"  FUN_PAY_FORM_Q(CHR_MORNING29,CHR_EVENING29) d29, FUN_PAY_FORM_Q(CHR_MORNING30,CHR_EVENING30) d30, ";
					asql = asql +"  FUN_PAY_FORM_Q(CHR_MORNING31,CHR_EVENING31) d31 ";
					asql = asql +" FROM att_t_register a, com_m_staff b,com_m_desig c   ";
					asql = asql +" WHERE b.CHR_EMPID =a.CHR_EMPID    ";
					asql = asql +" AND c.INT_DESIGID = b.INT_DESIGID  "; 
					asql = asql +" AND a.CHR_MONTH='"+month+"' AND  a.INT_YEAR="+Year;
					if(!"0".equals(company))
						asql = asql +" AND b.INT_COMPANYID = "+company;
					if(!"0".equals(branch))
						asql = asql +" AND b.INT_BRANCHID = "+branch;
					if(!"0".equals(office))
						asql = asql +" AND b.INT_OFFICEID = "+office;
					if(!"0".equals(department))
						asql = asql +" AND b.INT_DEPARTID = "+department;
					if(!"0".equals(category))
						asql = asql +" AND b.CHR_CATEGORY = "+category;
					System.out.println();
					System.out.println();
					System.out.println();
					System.out.println(asql); 
					String fileName="Rept_JESIFormQ_New.jrxml";
					String path = Path + "report/SmartPayroll";
					System.out.println(fileName+"   "+path+"  ");
					String fName=fileName.substring(0,fileName.indexOf("."));
					response.setContentType("application/octet-stream");
					try
					{
						ReportTemplate rtemplate=new ReportTemplate();
						byte[] output=rtemplate.generate(path, fileName, reporttype,asql);
						response.setHeader("Content-Disposition", "attachment; filename=\"" + fName+"."+reporttype + "\"");
						System.out.println(path+"\\"+fName+"."+reporttype);
						ServletOutputStream out = response.getOutputStream();
						out.write(output);
						out.close();
					
					}
					catch(Exception e)
					{
						System.out.println(e.getMessage());
					}
					
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
