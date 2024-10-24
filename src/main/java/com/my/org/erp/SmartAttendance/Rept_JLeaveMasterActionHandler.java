package com.my.org.erp.SmartAttendance;

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

public class Rept_JLeaveMasterActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String cmpyname="";
	String brname="";
	String officename="";
	String deptname="";
	String hImageExpression="";
	String fImageExpression="";
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			HashMap<Object,Object> map = new HashMap<Object,Object>();
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			String company = request.getParameter("company");
			String branch = request.getParameter("branch");
			String Office = request.getParameter("Office");
			String dept = request.getParameter("dept");
			String year = request.getParameter("year");
			String cpy="";
			String bid="";
			String off="";
		
			if(!"0".equals(company))
				cpy =" AND `com_m_staff`.`INT_COMPANYID` = "+company;
				
			if(!"0".equals(branch))
				bid =" AND `com_m_staff`.`INT_BRANCHID`="+branch;
				
			if(!"0".equals(Office))
				off =" AND `com_m_staff`.`INT_OFFICEID`="+Office;
			
			String sql = "SELECT CHR_LEAVENAME from att_m_leavetype ORDER BY INT_LEAVEID";
			String data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			int noofleave=data.length;
			for(int u=0;u<data.length;u++)
				map.put("leaveName"+(u+1), data[u][0]);
			
		sql=" SELECT `com_m_staff`.`CHR_EMPID`,`com_m_staff`.`CHR_STAFFNAME` , ";

		for(int y=1;y<=noofleave;y++)
		{
			sql=sql+" `att_m_leave`.`INT_NOD"+y+"`,";
			sql=sql+" `att_m_leave`.`INT_NOD"+y+"BALANCE`,";
			sql=sql+" (`att_m_leave`.`INT_NOD"+y+"`-`att_m_leave`.`INT_NOD"+y+"BALANCE`),";

		}
	sql =sql.substring(0,sql.length()-1);	
	sql=sql+" FROM  `smartcampus`.`com_m_staff`,  `smartcampus`.`com_m_depart`   ,  ";
	sql=sql+" `smartcampus`.`com_m_branch`, `smartcampus`.`com_m_company` ,`smartcampus`.`com_m_office` ";
	sql=sql+" ,`smartcampus`.`att_m_leave` ";
	sql=sql+" WHERE `com_m_staff`.`INT_DEPARTID`=`com_m_depart`.`INT_DEPARTID`  ";
	sql=sql+" AND `com_m_staff`.`INT_OFFICEID`=`com_m_office`.`INT_OFFICEID` ";
	sql=sql+" AND `com_m_staff`.`INT_COMPANYID` = `com_m_company`.`INT_COMPANYID` ";
	sql=sql+" AND `com_m_staff`.`INT_BRANCHID` = `com_m_branch`.`INT_BRANCHID` ";
	sql=sql+" AND `com_m_staff`.`CHR_EMPID` = `att_m_leave`.`CHR_EMPID` ";
	sql=sql+" AND `com_m_staff`.`CHR_TYPE` !='Y'  ";
	sql=sql+" AND `com_m_staff`.`CHR_HOLD`!='Y'   ";
	sql = sql+cpy;
	sql = sql+bid;
	sql = sql+off;
	sql=sql+" AND `att_m_leave`.`INT_YEAR`= "+year;
	sql=sql+" AND year(`com_m_staff`.`DT_DOJCOLLEGE`) <= "+year;
	sql=sql+" order BY  `com_m_staff`.`CHR_STAFFNAME` ";
	asql=sql;
	System.out.println("asql:"+asql);
	
			if(!"0".equals(company))
				cmpyname = CommonFunctions.QueryExecutecon(con,"SELECT CHR_COMPANYNAME FROM  com_m_company  WHERE INT_COMPANYID="+company)[0][0];
			else
				cmpyname="ALL";
			if(!"0".equals(branch))
			{
				brname = CommonFunctions.QueryExecutecon(con,"SELECT CHR_BRANCHNAME FROM  com_m_branch  WHERE INT_BRANCHID="+branch)[0][0];
				System.out.println("br name:"+brname);
			}
			else
				brname="ALL";
			
			if(!"0".equals(Office))
				officename = CommonFunctions.QueryExecutecon(con, "select CHR_OFFICENAME  FROM com_m_office WHERE INT_OFFICEID="+Office)[0][0];
			else
				officename = "ALL";
			if(!"0".equals(dept))
				deptname = CommonFunctions.QueryExecutecon(con, "select chr_departname FROM com_m_depart WHERE INT_DEPARTID="+dept)[0][0];
			else
				deptname = "ALL";
		
			
				
			if (action.equals("ATTRept_JLeaveMaster")) 
			{
				File reportsDir = new File(Path + "/report/Attendance/Leave/" + rptfilename+".jrxml");
			
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				map.put("year", year);
				map.put("dept", dept);
				map.put("office", officename);
				map.put("dept", deptname);
				map.put("company", cmpyname);
				map.put("branch", brname);
				
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportsDir, rptfilename, asql, con, Path,map);
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