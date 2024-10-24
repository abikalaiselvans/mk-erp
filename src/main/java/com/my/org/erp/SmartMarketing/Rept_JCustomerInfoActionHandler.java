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
 public class Rept_JCustomerInfoActionHandler extends AbstractActionHandler 
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
		asql = " SELECT a.CHR_CONTACTPERSON,i.CHR_NAME,b.CHR_GROUPNAME,a.CHR_ADDRESS1,a.CHR_ADDRESS2,a.CHR_ADDRESS3,h.CHR_CITYNAME, ";
		asql = asql + " CONCAT(g.CHR_DISTRICT,' - District '),f.CHR_STATENAME,e.CHR_COUNTRYNAME,a.INT_PINCODE,a.INT_PHONE1,a.INT_EXTN1, ";
		asql = asql + " a.INT_PHONE2,a.INT_EXTN2, a.INT_MOBILE1,a.INT_MOBILE2,a.CHR_FAX,a.CHR_EMAIL,a.CHR_WEBSITE,a.CHR_ACTIVE ";
		asql = asql + " FROM  mkt_m_customerinfo a, mkt_m_customergroup b , ";
		asql = asql + " com_m_country e,com_m_state f,com_m_district g,com_m_city h ,mkt_m_customername i ";
		asql = asql + " WHERE a.INT_GROUPID= b.INT_GROUPID ";
		asql = asql + " AND a.INT_COUNTRYID =e.INT_COUNTRYID ";
		asql = asql + " AND a.INT_STATEID =f.INT_STATEID ";
		asql = asql + " AND a.INT_DISTRICTID  = g.INT_DISTRICTID ";
		asql = asql + " AND a.INT_CITYID  = h.INT_CITYID AND a.INT_CUSTOMERNAMEID =i.INT_CUSTOMERNAMEID ";
		asql = asql + " ORDER BY i.CHR_NAME ";
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
			
			if (action.equals("MKTRept_JCustomerInfo")) 
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