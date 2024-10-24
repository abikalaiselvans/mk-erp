package com.my.org.erp.SmartAMC;

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
 
public class Rept_JdatewiseItemWarrantyDetailListActionHandler extends AbstractActionHandler 
{
	  
	JasperPrint jasperPrint;
	JRExporter exporter;
	String hImageExpression="";
	String fImageExpression="";
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		System.out.println("inside Rept_JdatewiseItemWarrantyDetailList");
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			HashMap<Object,Object> map = new HashMap<Object,Object>();
			if(action.equals("AMCRept_JdatewiseItemWarrantyDetailList")) 
			{
				System.out.println("inside AMCRept_JdatewiseItemWarrantyDetailList");
				String fromdate=request.getParameter("fromdate");
				String todate=request.getParameter("todate");
				String servicecenter=request.getParameter("servicecenter");
				String customerid=request.getParameter("customerid");
				String Customergroup=request.getParameter("Customergroup");
				
				asql="SELECT c.CHR_GROUPNAME,b.CHR_CUSTOMERNAME,b.CHR_STREET,a.CHR_SERIALNO,d.CHR_SERVICEITEMNAME," +
						"DATE_FORMAT(a.DT_STARTDATE,'%d-%m-%Y %H:%m:%s'),DATE_FORMAT(a.DT_ENDDATE,'%d-%m-%Y %H:%m:%s'),a.INT_NOOFYEAR " +
						"FROM inv_m_serviceamc a ,inv_m_servicecustomerinfo b,inv_m_servicecustomergroup c,inv_m_serviceitems d " +
						"WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND a.INT_SERVICEITEMID=d.INT_SERVICEITEMID AND b.INT_GROUPID= c.INT_GROUPID ";
				if(!"0".equals(servicecenter))
					asql = asql + " AND b.INT_SERVICECENTERID="+servicecenter;
				if(!"0".equals(Customergroup))
					asql = asql + " AND b.INT_GROUPID="+Customergroup;
				if(!"0".equals(customerid))
					asql = asql + " AND a.INT_CUSTOMERID="+customerid;
					
				asql = asql + " AND date(a.DT_STARTDATE) >='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate)+"' ";
				asql = asql + " AND date(a.DT_STARTDATE) <='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate)+"' ";
				asql = asql + " ORDER BY c.CHR_GROUPNAME,b.CHR_CUSTOMERNAME";

				System.out.println("asql:"+asql);
				
				
			
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;

				File reportDir = new File(Path + "/report/CRM/" + rptfilename+".jrxml");
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				
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
