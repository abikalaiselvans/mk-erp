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

public class Rept_JuserBalanceLeaveStatusActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String officename="";
	String deptname="";
	String categoryname="";
	String hImageExpression="";
	String fImageExpression="";
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			String empid = request.getParameter("empid");
			String year = request.getParameter("year");
			
			String sql = "SELECT INT_LEAVEID,CHR_LEAVENAME,CHR_SYMBOL FROM att_m_leavetype ORDER BY INT_LEAVEID";
			String Leaves[][]=CommonFunctions.QueryExecute(sql);
			
			asql ="SELECT a.CHR_EMPID,b.CHR_STAFFNAME,";
			for(int u=0;u<Leaves.length;u++)
				asql = asql +" INT_NOD"+(u+1)+",INT_NOD"+(u+1) +"BALANCE , (INT_NOD"+(u+1)+" -INT_NOD"+(u+1) +"BALANCE ) ," ;
			asql = asql +"a.INT_YEAR FROM att_m_leave a, com_m_staff b ";
			asql = asql +" WHERE a.CHR_EMPID = b.CHR_EMPID ";
			asql = asql +" AND a.CHR_EMPID ='"+empid+"'";
			asql = asql +"  AND a.INT_YEAR= "+year ; 
			System.out.println(asql);
			String data[][] =CommonFunctions.QueryExecute(asql);
			
			HashMap<Object,Object> map = new HashMap<Object,Object>();
			if(Leaves.length>0)
			{
				map.put("empId",data[0][0]);	
				map.put("empName",data[0][1]);
				map.put("year",year);
				
				int x=2;
				for(int u=0; u<Leaves.length; u++)
				{
					map.put("leaveName"+(u+1),Leaves[u][1]);
					map.put("NOF"+(u+1), data[0][(x+2)]);//Grant
					map.put("LT"+(u+1), data[0][(x+3)]);//Taken
					map.put("B"+(u+1),data[0][(x+4)]);//Balance
					x=x+1;
				}
			}
			
	
			if (action.equals("ATTRept_JuserBalanceLeaveStatus")) 
			{
				System.out.println("inside ATTRept_JMonthwiseUserAttendance");
				File reportsDir = new File(Path + "/report/Attendance/" + rptfilename+".jrxml");
				
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				
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