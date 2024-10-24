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
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JESIFormQActionHandler extends AbstractActionHandler 
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
			
			if(action.equals("PAYRept_JESIFormQ")) 
			{
					File reportDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");
					String company=request.getParameter("company");
					String branch=request.getParameter("branch");
					String office=request.getParameter("Office");
					String category=request.getParameter("category");
					String Month=request.getParameter("Month");
					String month = DateUtil.getMonth(Integer.parseInt(Month));
					String Year=request.getParameter("Year");
					String noofmonth=request.getParameter("noofmonth");
					int nootm = Integer.parseInt(noofmonth);
					String mor="";
					String eve="";
					int day=1;
					 
					asql = "SELECT b.CHR_EMPID,b.CHR_STAFFNAME,DATE_FORMAT(b.DT_DOB,'%d-%b-%Y'),";
					asql = asql +" floor(DATEDIFF(now(),b.DT_DOB)/365),c.CHR_DESIGNAME,";
					for(int u=1;u<=nootm;u++)
						asql = asql+"a.CHR_MORNING"+u +", a.CHR_EVENING"+u+ " , ";
					asql = asql +" a.CHR_MONTH,a.INT_YEAR FROM att_t_register a, com_m_staff b,com_m_desig c ";
					asql = asql +" WHERE a.CHR_MONTH='"+month+"' AND  a.INT_YEAR="+Integer.parseInt(Year);
					asql = asql +" AND b.CHR_EMPID =a.CHR_EMPID ";
					asql = asql +" AND c.INT_DESIGID = b.INT_DESIGID ";
					if(!"0".equals(company))
						asql = asql +" AND b.INT_COMPANYID = "+company;
					if(!"0".equals(branch))
						asql = asql +" AND b.INT_BRANCHID = "+branch;
					if(!"0".equals(office))
						asql = asql +" AND b.INT_OFFICEID = "+office;
					if(!"0".equals(category))
						asql = asql +" AND b.CHR_CATEGORY = "+category;
					System.out.println("FOR Q :"+asql); 
					String data[][]=  CommonFunctions.QueryExecute(asql);
					

					HashMap<Object,Object> map = new HashMap<Object,Object>();
					 
					for(int u=0;u<data.length;u++)
					{
						
						day=4;
						for(int i=1;i<=nootm;i++)
						{
							mor=data[u][i+day].trim();
							eve=data[u][i+day+1].trim();
							day=day+1;
							if(("SUN".equals(mor)) && ("SUN".equals(eve) ))
								map.put("d"+i, "S");
							else if(("HOL".equals(mor)) && ("HOL".equals(eve) ))
								map.put("d"+i, "H");
							else if(("LEA".equals(mor)) && ("LEA".equals(eve) ))
								map.put("d"+i, "L");
							else if(("NA".equals(mor)) && ("NA".equals(eve) ))
								map.put("d"+i, "-");
							else if(("ABS".equals(mor)) && ("ABS".equals(eve) ))
								map.put("d"+i, "-");
							else
								map.put("d"+i, "8");
					}	
				
				 }	
					
					 
					System.out.println(map);
					jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, asql, con, Path,map);
					ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
				
					
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
