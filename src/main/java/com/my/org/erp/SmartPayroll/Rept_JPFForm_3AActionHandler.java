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
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.SmartReport.ReportFunctions;
 
public class Rept_JPFForm_3AActionHandler extends AbstractActionHandler 
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
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			String SubRptfilename1 = request.getParameter("subRptfilename1");
			String SubRptfilename2 = request.getParameter("subRptfilename2");
			String SubRptfilename3 = request.getParameter("subRptfilename3");
			String SubRptfilename4 = request.getParameter("subRptfilename4");
			String SubRptfilename5 = request.getParameter("subRptfilename5");
			String SubRptfilename6 = request.getParameter("subRptfilename6");
			String SubRptfilename7 = request.getParameter("subRptfilename7");
			String SubRptfilename8 = request.getParameter("subRptfilename8");
			String SubRptfilename9 = request.getParameter("subRptfilename9");
			String SubRptfilename10 = request.getParameter("subRptfilename10");
			String SubRptfilename11 = request.getParameter("subRptfilename11");
			String SubRptfilename12 = request.getParameter("subRptfilename12");
			String SubRptfilename13 = request.getParameter("subRptfilename13");
			if (action.equals("PAYRept_JPFForm_3A")) 
			{
				File reportDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
		
				int byear=0;
				
				String staffid="";
				String branchid=request.getParameter("branch");
				String officeid=request.getParameter("office");
				String year=request.getParameter("Year");
				String staff[]=request.getParameterValues("ename");
				
				String empid="";
				for(int k=0;k<staff.length;k++)
					empid=empid+",'"+staff[k]+"'";
				staffid=empid.substring(1);
				map.put("employees", staffid);
				byear=(Integer.parseInt(year));
				String year1=Integer.toString(byear+1);
				map.put("year", year);
				map.put("year1", year1);
			
			asql = " SELECT b.CHR_EMPID, b.CHR_PFNO,a.CHR_EMPNAME,b.CHR_STAFFFNAME, ";
			asql = asql +" g.CHR_COMPANYNAME,g.CHR_STREET,f.CHR_CITYNAME,";
			asql = asql +" g.INT_PINCODE,g.CHR_PFNUMBER, c.CHR_COUNTRYNAME, ";
			asql = asql +" d.CHR_STATENAME,e.CHR_DISTRICT,f.CHR_CITYNAME";
			asql = asql +" FROM com_m_staff b,pay_t_salary a,com_m_company g, ";
			asql = asql +" com_m_country c, com_m_state d, com_m_district e, com_m_city f ";
			asql = asql +" WHERE b.CHR_TYPE!='T' AND b.CHR_HOLD!='Y' ";
			asql = asql +" AND b.INT_OFFICEID = 1 AND a.CHR_EMPID=b.CHR_EMPID  AND g.INT_COMPANYID=a.INT_COMPANYID " ;
			asql = asql +" AND g.INT_COUNTRYID= c.INT_COUNTRYID AND g.INT_STATEID = d.INT_STATEID AND g.INT_DISTRICTID = e.INT_DISTRICTID ";
			asql = asql +"   AND g.INT_CITYID = f.INT_CITYID  " ;
			if(!"0".equals(officeid))
				asql = asql+"	AND b.INT_OFFICEID = "+officeid;
			asql = asql+" AND a.CHR_EMPID=b.CHR_EMPID AND a.CHR_EMPID in("+staffid+") GROUP BY a.CHR_EMPID ORDER BY a.CHR_EMPNAME";
			System.out.println("sql1:"+asql);
						
			File subreportDir1 = new File(Path + "/report/SmartPayroll/" + SubRptfilename1+".jrxml");
			File subreportDir2 = new File(Path + "/report/SmartPayroll/" + SubRptfilename2+".jrxml");
			File subreportDir3 = new File(Path + "/report/SmartPayroll/" + SubRptfilename3+".jrxml");
			File subreportDir4 = new File(Path + "/report/SmartPayroll/" + SubRptfilename4+".jrxml");
			File subreportDir5 = new File(Path + "/report/SmartPayroll/" + SubRptfilename5+".jrxml");
			File subreportDir6 = new File(Path + "/report/SmartPayroll/" + SubRptfilename6+".jrxml");
			File subreportDir7 = new File(Path + "/report/SmartPayroll/" + SubRptfilename7+".jrxml");
			File subreportDir8 = new File(Path + "/report/SmartPayroll/" + SubRptfilename8+".jrxml");
			File subreportDir9 = new File(Path + "/report/SmartPayroll/" + SubRptfilename9+".jrxml");
			File subreportDir10 = new File(Path + "/report/SmartPayroll/" + SubRptfilename10+".jrxml");
			File subreportDir11 = new File(Path + "/report/SmartPayroll/" + SubRptfilename11+".jrxml");
			File subreportDir12 = new File(Path + "/report/SmartPayroll/" + SubRptfilename12+".jrxml");
			File subreportDir13 = new File(Path + "/report/SmartPayroll/" + SubRptfilename13+".jrxml");
			
			jasperPrint=ReportFunctions.createForm3APFReport(jasperPrint, request, response, reportDir, rptfilename, asql, 
					con, Path,map,subreportDir1,subreportDir2,subreportDir3,subreportDir4,subreportDir5,subreportDir6,
					subreportDir7,subreportDir8,subreportDir9,subreportDir10,subreportDir11,subreportDir12,subreportDir13);
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