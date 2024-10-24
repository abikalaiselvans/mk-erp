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
 
import com.my.org.erp.Date.Day;
import com.my.org.erp.SmartReport.OneSubReportFunctions;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JPFForm_10ActionHandler extends AbstractActionHandler 
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
		System.out.println("insite Rept_JPFForm_5");
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			String SubRptfilename1 = request.getParameter("subRptfilename1");
			
			if (action.equals("PAYRept_JPFForm_10")) 
			{
			System.out.println("insite Rept_JPFForm_10");
				
				File reportDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
		
		   		String mth=""+request.getParameter("Month");
  				String year=""+request.getParameter("Year");
  				String comid=""+request.getParameter("company");
				String branchid=""+request.getParameter("branch");
				String officeid=""+request.getParameter("Office");
				asql = " SELECT a.CHR_COMPANYNAME,a.CHR_STREET,f.CHR_CITYNAME,a.INT_PINCODE,a.CHR_PFNUMBER, ";
				asql = asql + " c.CHR_COUNTRYNAME,d.CHR_STATENAME,e.CHR_DISTRICT,f.CHR_CITYNAME  ";
				asql = asql + " FROM com_m_company a, com_m_country c, com_m_state d, com_m_district e, com_m_city f ";
				asql = asql + " WHERE a.INT_COUNTRYID= c.INT_COUNTRYID ";
				asql = asql + " AND a.INT_STATEID = d.INT_STATEID ";
				asql = asql + " AND a.INT_DISTRICTID = e.INT_DISTRICTID ";
				asql = asql + " AND a.INT_CITYID = f.INT_CITYID ";
				asql = asql + " AND a.INT_COMPANYID="+comid;
				
				String mont = DateUtil.getMonth(Integer.parseInt(mth));
				map.put("month", mont);
				map.put("year", year);
				String pfnumber = CommonFunctions.QueryExecute("SELECT CHR_PFNUMBER FROM com_m_company  WHERE INT_COMPANYID="+comid)[0][0];
				map.put("compfno", pfnumber);
				
				File subReport1Dir = new File(Path + "/report/SmartPayroll/" + SubRptfilename1+".jrxml");
				
				String sql="select a.CHR_EMPID,b.CHR_STAFFNAME,DATE_FORMAT(b.DAT_RESIGNDATE,'%d-%b-%Y'),a.CHR_TER_TYPE,b.CHR_STAFFFNAME,CONCAT(c.CHR_PFNUMBER,b.CHR_PFNO),DATE_FORMAT(b.DAT_RESIGNDATE,'%d-%m-%Y') from pay_m_emp_termination a,com_m_staff b ,com_m_company c";
				sql=sql+ " where  b.CHR_ESI ='C' AND  b.CHR_PF='C'  AND  a.CHR_EMPID=b.CHR_EMPID AND b.INT_COMPANYID=c.INT_COMPANYID ";
				if(!"Select".equals(comid))
					sql=sql+ " AND b.INT_COMPANYID = "+comid;
				if(!"0".equals(branchid))
					sql=sql+ " AND b.INT_BRANCHID = "+branchid;
				if(!"0".equals(officeid))
					sql=sql+ " AND b.INT_OFFICEID = "+officeid;
				sql=sql+" and month(b.DAT_RESIGNDATE)="+mth+" and year(b.DAT_RESIGNDATE)="+year+" order by a.CHR_EMPID";
			 	String subReptSql=sql;

						
				jasperPrint=OneSubReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, asql, con, Path,map,subReport1Dir,subReptSql);
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