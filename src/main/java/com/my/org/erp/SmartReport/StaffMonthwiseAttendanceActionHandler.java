package com.my.org.erp.SmartReport;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JasperPrint;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class StaffMonthwiseAttendanceActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	public String getSqlQuery(String countryId)
	{
		String sql =" SELECT b.CHR_COUNTRYNAME,a.CHR_STATENAME,a.CHR_STATEDES FROM com_m_state a ," +
				"com_m_country b WHERE a.INT_COUNTRYID = b.INT_COUNTRYID "; 
		if(!"0".equalsIgnoreCase(countryId))		
			sql=sql+" AND a.INT_COUNTRYID="+countryId;
		sql=sql+" ORDER BY a.CHR_STATENAME";
		
		return sql;
	}
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			String countryId = request.getParameter("countryId");
			HashMap<Object,Object> map = new HashMap<Object,Object>();
			if (action.equals("ATRStaffMonthwiseAttendance")) 
			{
				asql=getSqlQuery(countryId);
				File reportsDir = new File(Path + "/report/SmartCommon/" + rptfilename+".jrxml");
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportsDir, rptfilename, asql, con, Path,map);
				ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
				System.out.println("state generated");
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