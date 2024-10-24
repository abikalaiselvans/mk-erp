package com.my.org.erp.SmartInventory;

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

public class Rept_JMasterCustomerInfoActionHandler extends AbstractActionHandler 
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
		asql="SELECT b.CHR_NAME, FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),a.CHR_CONTACTPERSON,a.CHR_ADDRESS1," +
				"a.CHR_ADDRESS2,a.CHR_ADDRESS3,c.CHR_COUNTRYNAME,d.CHR_STATENAME,e.CHR_DISTRICT,f.CHR_CITYNAME," +
				"a.INT_PINCODE,a.CHR_AREACODE,a.CHR_PHONE,a.CHR_MOBILE,a.CHR_FAX,a.CHR_EMAIL,a.CHR_WEBSITE," +
				"if(a.INT_ACTIVE =1 ,'Active','Inactive'),a.CHR_TIN,a.CHR_CST FROM inv_m_customerinfo a," +
				"inv_m_customergroup b, com_m_country c, com_m_state d, com_m_district e, com_m_city f" +
				" WHERE a.INT_CUSTOMERGROUPID = b.INT_CUSTOMERGROUPID AND a.INT_COUNTRYID= c.INT_COUNTRYID" +
				" AND a.INT_STATEID = d.INT_STATEID AND a.INT_DISTRICTID = e.INT_DISTRICTID AND" +
				" a.INT_CITYID = f.INT_CITYID "; 
		return asql;
	}
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
				
			if (action.equals("INVRept_JMasterCustomerInfo")) 
			{
				File reportsDir = new File(Path + "/report/Inventory/Master/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				
				asql=getSqlQuery();
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