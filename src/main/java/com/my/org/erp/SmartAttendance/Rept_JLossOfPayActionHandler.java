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
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JLossOfPayActionHandler extends AbstractActionHandler 
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
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			String company= request.getParameter("company");
			String branch= request.getParameter("branch");
			String Office = request.getParameter("Office");
			String dept= request.getParameter("dept");
			String month= request.getParameter("month");
			String repmon = DateUtil.getMonth(Integer.parseInt( month));
			String year= request.getParameter("year");
			String cpy="";
			String bid="";
			String off="";
			String dep="";
			String sql="";
		
			if(!"-1".equals(company))
				cpy= " AND `com_m_staff`.`INT_COMPANYID`="+company;
				
			if(!"0".equals(branch))
				bid= " AND `com_m_staff`.`INT_BRANCHID`="+branch;	
				
			if(!"0".equals(Office))
				off=" AND `com_m_staff`.`INT_OFFICEID` ="+Office;
				
			if(!"0".equals(dept))
				dep=" AND `com_m_staff`.`INT_DEPARTID` ="+dept;
				
		
			 sql = " SELECT `att_t_register`.`CHR_EMPID`,`com_m_staff`.`CHR_STAFFNAME`,`att_t_register`.`DOU_ABSENT`, ";
			 sql = sql+" `att_t_register`.`INT_LATE`, `att_t_register`.`INT_PERMISSION`  ";
			 sql = sql+" FROM `smartcampus`.`att_t_register` ,`smartcampus`.`com_m_staff` ";
			 sql = sql+" WHERE `att_t_register`.`CHR_MONTH`='October'  ";
			 sql = sql+" AND  `att_t_register`.`INT_YEAR`=2007 ";
			 sql = sql+" AND  `att_t_register`.`DOU_ABSENT` >0  ";
			 sql = sql+" AND  `att_t_register`.`INT_LATE` >0 ";
			 sql = sql+" AND  `att_t_register`.`INT_PERMISSION` >0 ";

			 sql = sql+" AND  `att_t_register`.`CHR_EMPID` =`com_m_staff`.`CHR_EMPID` ";
			 sql = sql+cpy;
			 sql = sql+bid;
			 sql = sql+off;
			 sql = sql+dep;
			 sql = sql+" ORDER BY `com_m_staff`.`CHR_STAFFNAME` ";
			 
			 asql=sql;
			 System.out.println("asql:"+asql);
			 
			 if(!"0".equals(company))
					cmpyname = CommonFunctions.QueryExecutecon(con,"SELECT CHR_COMPANYNAME FROM  com_m_company  WHERE INT_COMPANYID="+company)[0][0];
				else
					cmpyname="ALL";
			 if(!"0".equals(branch))
					brname = CommonFunctions.QueryExecutecon(con,"SELECT CHR_BRANCHNAME FROM  com_m_branch  WHERE INT_BRANCHID="+branch)[0][0];
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
			
				
			if (action.equals("ATTRept_JLossOfPay")) 
			{
				File reportsDir = new File(Path + "/report/Attendance/Leave/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				map.put("year", year);
				map.put("month", repmon);
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