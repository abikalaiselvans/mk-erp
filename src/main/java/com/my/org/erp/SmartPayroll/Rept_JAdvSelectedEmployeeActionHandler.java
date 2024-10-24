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
import com.my.org.erp.SmartReport.TwoSubReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

import com.my.org.erp.common.CommonFunctions;

public class Rept_JAdvSelectedEmployeeActionHandler extends AbstractActionHandler 
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
		System.out.println("insite Rept_JAdvSelectedEmployeeActionHandler");
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String SubRptfilename1 = request.getParameter("subRptfilename1");
			String SubRptfilename2 = request.getParameter("subRptfilename2");
			String reporttype = request.getParameter("reportType");
			
			String staffid = request.getParameter("ename");
			
				System.out.println("Staff id:"+staffid);
			if (action.equals("PAYRept_JAdvSelectedEmployee")) 
			{
				System.out.println("insite PAYRept_JAdvanceAll");
				
				File reportDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				
				
				
				String EmpName = CommonFunctions.QueryExecutecon(con,"SELECT CHR_STAFFNAME FROM  com_m_staff  WHERE CHR_EMPID='"+staffid+"'")[0][0];
				
				String sql="select FIND_A_EMPLOYEE_ADVANCE('"+staffid+"'),FIND_A_EMPLOYEE_DUE('"+staffid+"')," +
						"(FIND_A_EMPLOYEE_ADVANCE('"+staffid+"')-FIND_A_EMPLOYEE_DUE('"+staffid+"'))";
				String  data[][] = com.my.org.erp.common.CommonFunction.RecordSetArray(sql);
				
				 
				if(data.length>0)
				{
					map.put("advtot",data[0][0]);
					map.put("duetot",data[0][1]);
					map.put("baldue",data[0][2]);
					map.put("empname",EmpName);
					map.put("empid",staffid);
					
				}
				File subReport1Dir = new File(Path + "/report/SmartPayroll/" + SubRptfilename1+".jrxml");
				File subReport2Dir = new File(Path + "/report/SmartPayroll/" + SubRptfilename2+".jrxml");
				
				String subReport1Sql="SELECT a.CHR_STAFFNAME,b.INT_ADVAMT,b.CHR_MONTH adMonth,b.INT_YEAR adYear FROM com_m_staff a,pay_m_advance b WHERE a.CHR_EMPID=b.CHR_EMPID AND a.CHR_EMPID='"+staffid+"'";
				String subReport2Sql="SELECT  INT_DUEAMT,CHR_MONTH,INT_YEAR,INT_ID,if(CHR_TYPE='Y','Salary Deduction','Cash Return')  FROM  pay_t_advance  WHERE CHR_EMPID='"+staffid+"'";
						
				jasperPrint=TwoSubReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, subReport1Sql, con, Path,map,subReport1Dir,subReport2Dir,subReport2Sql);
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