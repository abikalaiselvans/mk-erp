package com.my.org.erp.SmartMarketing;

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
import com.my.org.erp.common.CommonFunctions;
 
public class Rept_JMobileContactActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String cmpyname="";
	String officename="";
	String deptname="";
	String hImageExpression="";
	String fImageExpression="";
	public String getSqlQuery()
	{
		asql = "   SELECT  b.CHR_GROUPNAME,a.CHR_CUSTOMERNAME,a.INT_MOBILENO,a.INT_AGE,a.CHR_CITY,c.CHR_STAFFNAME,a.CHR_EMAIL   "; 
		asql = asql + "   FROM  mkt_m_mobilecontacts a  , mkt_m_mobile_group b ,com_m_staff c   "; 
		asql = asql + "   WHERE a.INT_GROUPID= b.INT_GROUPID AND UPPER(RIGHT(c.CHR_EMPID,6)) = UPPER(a.CHR_USRNAME)   "; 
		asql = asql + "   ORDER BY 	a.CHR_CUSTOMERNAME  "; 
		System.out.println(asql);
		return asql;
	}
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename1 = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			if (action.equals("MKTRept_JMobileContact")) 
			{
				File reportsDir1 = new File(Path + "/report/SmartMarketing/" + rptfilename1+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
							
				asql=getSqlQuery();
				String data[][] = CommonFunctions.QueryExecute(asql);
				System.out.println("asql:"+asql);
				if(data.length<=0)
					map.put("dataLength", "0");
				else
					map.put("dataLength", "1");
			
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportsDir1, rptfilename1, asql, con, Path,map);
				ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename1);
				
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