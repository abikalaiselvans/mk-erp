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


public class Rept_JspareBookingDetailListActionHandler extends AbstractActionHandler 
{
	  
	JasperPrint jasperPrint;
	JRExporter exporter;
	String hImageExpression="";
	String fImageExpression="";
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		System.out.println("inside Rept_JspareCallDetailList handle");
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			 HashMap<Object,Object> map = new HashMap<Object,Object>();
			
			if(action.equals("AMCRept_JspareBookingDetailList")) 
			{
				System.out.println("inside AMCRept_JindividualItemFullDetail");
				String fromdate=request.getParameter("fromdate");
				String todate=request.getParameter("todate");
				String servicecenter=request.getParameter("servicecenter");
				String customerid=request.getParameter("customerid");
				String callstatus=request.getParameter("callstatus");


				
				
				asql="SELECT a.INT_SERVICEID,a.CHR_SERVICECALLNO, c.CHR_GROUPNAME,b.CHR_CUSTOMERNAME,d.CHR_CENTERNAME, a.CHR_SERIALNO," +
						"DATE_FORMAT(a.DT_BOOKINGDATE,'%d-%M-%Y %H:%i:%s'),DATE_FORMAT(a.DT_ASSIGNDATE,'%d-%M-%Y %H:%i:%s')," +
						"DATE_FORMAT(a.DT_CLOSINGDATE,'%d-%M-%Y %H:%i:%s'),a.CHR_SERVICEDESC, if(a.CHR_BOOKINGTYPE ='P','Phone'," +
						"if(a.CHR_BOOKINGTYPE ='D','Direct','Others')) ,if(a.CHR_BOOKINGUNDER ='W','Warranty'," +
						"if(a.CHR_BOOKINGUNDER ='A','AMC','On Call')) ,if(a.CHR_STATUS ='C','Completed',if(a.CHR_STATUS ='N','New Call'," +
						"if(a.CHR_STATUS ='P','Pending','Cancelled / Rejected'))) callStatus,if(a.CHR_ENGGSTATUS ='N','Not Assign'," +
						"if(a.CHR_ENGGSTATUS ='Y','Assigned','Re-Assign')) ,a.CHR_BOOKINGEMPID,e.CHR_STAFFNAME,a.CHR_CONTACTPERSON," +
						"a.CHR_CONTACTADDRESS,a.CHR_CONTACTMOBILE, a.CHR_CONTACTEMAIL FROM inv_t_servicecallbooking a ,inv_m_servicecustomerinfo b," +
						"inv_m_servicecustomergroup c,inv_m_servicecenter d,com_m_staff e WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID " +
						"AND b.INT_GROUPID=c.INT_GROUPID AND b.INT_SERVICECENTERID=d.INT_SERVICECENTERID AND a.CHR_BOOKINGEMPID=e.CHR_EMPID ";
				if(!"0".equals(servicecenter))
					asql = asql + " AND d.INT_SERVICECENTERID="+servicecenter;
					if(!"0".equals(customerid))
					asql = asql + " AND b.INT_CUSTOMERID="+customerid;
					if(!"0".equals(callstatus))
					asql = asql + " AND a.CHR_STATUS='"+callstatus+"'";	
					asql = asql + " AND date(a.DT_ASSIGNDATE) >='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate)+"' ";
					asql = asql + " AND date(a.DT_ASSIGNDATE) <='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate)+"' ";
					asql = asql + " ORDER BY b.CHR_CUSTOMERNAME";
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
