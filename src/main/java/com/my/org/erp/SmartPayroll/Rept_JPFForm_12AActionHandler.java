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
import com.my.org.erp.SmartReport.SavePDFFunction;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JPFForm_12AActionHandler extends AbstractActionHandler 
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
		System.out.println("Rept_JPFForm_12AActionHandler");
		try 
		{ 
			String action = request.getParameter("actionS");
			
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			if (action.equals("PAYRept_JPFForm_12A")) 
			{
			System.out.println("insite Rept_JPFForm_12A");
			System.out.println("Path:"+Path);
				File reportDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");
				System.out.println("Path:"+Path);
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				System.out.println("before company:");
				String comid=request.getParameter("company");
				System.out.println("after company:");
				System.out.println("company:"+comid);
				String branchid=request.getParameter("branch");
				String officeid=request.getParameter("Office");
				String year=request.getParameter("Year");
				System.out.println("company:"+comid);
				System.out.println("branchid:"+branchid);
				System.out.println("officeid:"+officeid);
				System.out.println("year:"+year);
				String cpy  ="";
				String bid  ="";
				String off="";
				String yer="";
				String sql="";
				if(!"Select".equals(comid))
					cpy =" AND b.INT_COMPANYID = "+comid;
				
				if(!"0".equals(branchid))
					bid ="  AND b.INT_BRANCHID = "+branchid;
				
				if(!"0".equals(officeid))
					off ="  AND b.INT_OFFICEID = "+officeid;
				 
				int yr=Integer.parseInt(year);
				System.out.println("company:"+comid);
				System.out.println("branchid:"+branchid);
				System.out.println("officeid:"+officeid);
				System.out.println("year:"+year);
		sql = " SELECT a.CHR_COMPANYNAME,a.CHR_STREET,f.CHR_CITYNAME,a.INT_PINCODE,a.CHR_PFNUMBER, ";
			sql = sql + " c.CHR_COUNTRYNAME,d.CHR_STATENAME,e.CHR_DISTRICT,f.CHR_CITYNAME  ";
			sql = sql + " FROM com_m_company a, com_m_country c, com_m_state d, com_m_district e, com_m_city f ";
			sql = sql + " WHERE a.INT_COUNTRYID= c.INT_COUNTRYID ";
			sql = sql + " AND a.INT_STATEID = d.INT_STATEID ";
			sql = sql + " AND a.INT_DISTRICTID = e.INT_DISTRICTID ";
			sql = sql + " AND a.INT_CITYID = f.INT_CITYID ";
			sql = sql + " AND a.INT_COMPANYID="+comid;
			System.out.println(sql);
			String datac[][]=CommonFunctions.QueryExecute(sql);
			map.put("cpy","M/s."+datac[0][0]);
			map.put("st",datac[0][1]);
			map.put("city",datac[0][2] );
			map.put("pin",datac[0][3]);
			
			sql = " select ROUND(SUM(a.DOU_BASIC)),ROUND(SUM(a.DOU_PENBASIC)),ROUND(SUM(a.DOU_PF))";
			sql =sql +" ,ROUND(SUM(a.DOU_COMPANYPF)),ROUND(SUM(a.DOU_COMPANYPENSION)),ROUND(SUM(a.DOU_ADMINCHARGE)),ROUND(SUM(a.DOU_EDLI)),";
			sql =sql +" ROUND(SUM(a.DOU_ADMINCHARGE1)) from pay_t_salary a,com_m_staff b";
			sql =sql +" where ((a.CHR_MONTH in('May','June','July','August','Septemper','October','November','December') ";
			sql =sql +"  and a.INT_YEAR="+yr+") or (a.CHR_MONTH in('January','February','March') and a.INT_YEAR="+(yr+1)+")) ";
			sql =sql +cpy;
			sql =sql +bid;
			sql =sql +off;
			System.out.println(sql);
			String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			
			map.put("EPF_wages",data[0][0]+"0.00");
			map.put("EPF_empcontri",data[0][2]+"0.00");
			map.put("EPF_cpycontri", data[0][3]+"0.00");
			map.put("EPF_empshare",data[0][2]+"0.00");
			map.put("EPF_cpyshare",data[0][3]+"0.00" );
			map.put("admindue", data[0][5]+"0.00");
			map.put("adminremitted",data[0][5]+"0.00");
			map.put("pension_wages",data[0][1]+"0.00");
			map.put("pension_cpycontri",data[0][4]+"0.00");
			map.put("pension_cpyshare",data[0][4]+"0.00");
			map.put("EDLI_cpycontri", data[0][6]+"0.00");
			map.put("EDLI_cpyshare",data[0][6]+"0.00");
			map.put("EDLI_admindue",data[0][7]+"0.00");
			map.put("EDLI_adminremitted",data[0][7]+"0.00");
			map.put("yr",year );
			String ayr=Integer.toString(yr+1);
			System.out.println("ayr:"+ayr);
			map.put("ayr",ayr );
			
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, null, con, Path,map);
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