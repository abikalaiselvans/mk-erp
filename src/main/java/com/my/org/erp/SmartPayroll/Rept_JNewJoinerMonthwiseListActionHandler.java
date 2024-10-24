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
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JNewJoinerMonthwiseListActionHandler extends AbstractActionHandler 
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
		System.out.println("insite PAYRept_JAdvanceAll");
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			 String Office= request.getParameter("Office");
			 String Dept= request.getParameter("dept");
			 String Month= request.getParameter("Month");
			 String Day= request.getParameter("Day");
			 
			 String orderby= request.getParameter("orderby");
			 String Resign= request.getParameter("Resign");
			 
			
				
			if (action.equals("PAYRept_JNewJoinerMonthwiseList")) 
			{
			System.out.println("insite Rept_JNewJoinerMonthwiseList");
				
				File reportDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				

				String sql="";
				String allowancefield[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_ACODE,CHR_ANAME,CHR_FLAG FROM  pay_m_allowance ORDER BY INT_ALLOWANCEID");
				String sumgrossallowancefield="";
				String sumothersallowancefield="";
				String allowancefields="";
				if(allowancefield.length>0)
				{
					for(int u=0;u<allowancefield.length;u++)
					{
						if("Y".equals(allowancefield[u][2]))
						{
							sumgrossallowancefield =sumgrossallowancefield+ " o."+allowancefield[u][0]+"+";
						 	allowancefields =allowancefields+ " o."+allowancefield[u][0]+",";
						}
					}
				}

				String allData[]=	allowancefields.split(",");
				 
				asql =  " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,g.CHR_COMPANYNAME,f.CHR_BRANCHNAME,c.CHR_DEPARTNAME,i.CHR_DESIGNAME,b.CHR_OFFICENAME         ,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%m-%Y'),datediff(now(),a.DT_DOJCOLLEGE)  ,a.INT_SALARY,";
				asql = asql + allowancefields ;
				asql = asql + " ( " +sumgrossallowancefield +" 0 ) allowanceTotal, " ;
				asql = asql + " ( a.INT_SALARY +" +sumgrossallowancefield +" 0 ) grossPay" ; 
				asql = asql + " ,a.CHR_TYPE,p.CHR_CATEGORYNAME FROM com_m_staff a , com_m_office b ,com_m_depart c ,  ";
				asql = asql + " com_m_branch f , com_m_company g, ";
				asql = asql + " com_m_desig i, ";
				asql = asql + " pay_t_allowance o ,com_m_employeecategory p ";
				asql = asql + " WHERE a.INT_DEPARTID = c.INT_DEPARTID  ";
				asql = asql + " AND a.INT_OFFICEID= b.INT_OFFICEID  ";
				 
				asql = asql + " AND a.INT_BRANCHID =f.INT_BRANCHID  ";
				asql = asql + " AND a.INT_COMPANYID =g.INT_COMPANYID  ";
				asql = asql + " AND a.INT_DESIGID= i.INT_DESIGID  ";
				asql = asql + " AND a.CHR_EMPID =o.CHR_EMPID   AND a.CHR_CATEGORY=p.INT_EMPLOYEECATEGORYID";

				if(!"0".equals(Office))
					asql = asql + " AND a.INT_OFFICEID="+Office;
				if(!"0".equals(Dept))
					asql = asql + " AND a.INT_DEPARTID= "+Dept;
				if("Y".equals(Resign))
					asql = asql+" AND a.CHR_TYPE !='T' ";

				asql = asql+" AND MONTH(a.DT_DOJCOLLEGE ) = "+Month+" ";
				asql = asql+" AND DAY(a.DT_DOJCOLLEGE ) = "+Day+" ";

				asql = asql + " ORDER BY "+orderby ;
				String monthName=CommonFunctions.getMonthName(Integer.parseInt(Month));
				
				map.put("month",monthName);
				System.out.println("PAYRept_JNewJoinerMonthwiseList sql:"+asql); 

						
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, asql, con, Path,map);
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