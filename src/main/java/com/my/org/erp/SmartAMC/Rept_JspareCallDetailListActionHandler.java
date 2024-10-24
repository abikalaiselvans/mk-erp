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

public class Rept_JspareCallDetailListActionHandler extends AbstractActionHandler 
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
			
			if(action.equals("AMCRept_JspareCallDetailList")) 
			{
				System.out.println("inside AMCRept_JindividualItemFullDetail");
				String fromdate=request.getParameter("fromdate");
				String todate=request.getParameter("todate");
				String servicecenter=request.getParameter("servicecenter");
				String customerid=request.getParameter("customerid");
				String Customergroup=request.getParameter("Customergroup");
				String sparecall=request.getParameter("sparecall");
				String callstatus=request.getParameter("callstatus");


				
				
				asql="SELECT g.CHR_GROUPNAME,c.CHR_CUSTOMERNAME,d.CHR_CENTERNAME,f.CHR_SERVICEITEMNAME,a.CHR_SERVICECALLNO, a.CHR_EMPID," +
						"a.CHR_SERIALNO,DATE_FORMAT(a.DT_ASSIGNDATE,'%d-%b-%Y'),DATE_FORMAT(a.DT_ATTENDATE,'%d-%b-%Y')," +
						"DATE_FORMAT(a.DT_CLOSEDATE,'%d-%b-%Y'),a.CHR_CALLSTATUS,if(a.CHR_SPARE='Y','Spare','Not Spare')," +
						"a.CHR_SPAREDESC,a.CHR_CONTACTPERSON,a.CHR_CONTACTMOBILE,a.CHR_CONTACTADDRESS,a.CHR_CONTACTEMAIL,h.CHR_STAFFNAME " +
						"FROM inv_t_servicecallbookingtrack a,inv_t_servicecallbooking b,inv_m_servicecustomerinfo c,inv_m_servicecenter d," +
						"inv_m_serviceamc e,inv_m_serviceitems f,inv_m_servicecustomergroup g ,com_m_staff h WHERE a.CHR_SERVICECALLNO = " +
						"b.CHR_SERVICECALLNO AND b.INT_CUSTOMERID = c.INT_CUSTOMERID AND c.INT_SERVICECENTERID = d.INT_SERVICECENTERID AND " +
						"a.CHR_SERIALNO=e.CHR_SERIALNO AND c.INT_CUSTOMERID = e.INT_CUSTOMERID AND e.INT_SERVICEITEMID = f.INT_SERVICEITEMID " +
						"AND c.INT_GROUPID = g.INT_GROUPID  AND a.CHR_EMPID =h.CHR_EMPID ";
				if(!"0".equals(servicecenter))
					asql = asql + " AND d.INT_SERVICECENTERID="+servicecenter;
					if(!"0".equals(Customergroup))
					asql = asql + " AND g.INT_GROUPID="+Customergroup;
					if(!"0".equals(customerid))
					asql = asql + " AND c.INT_CUSTOMERID="+customerid;
					if(!"0".equals(callstatus))
					asql = asql + " AND a.CHR_CALLSTATUS="+callstatus;	
					if(!"0".equals(sparecall))
					asql = asql + " AND a.CHR_SPARE='"+sparecall+"' ";	
					asql = asql + " AND date(a.DT_ASSIGNDATE) >='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(fromdate)+"' ";
					asql = asql + " AND date(a.DT_ASSIGNDATE) <='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(todate)+"' ";
					asql = asql + " ORDER BY g.CHR_GROUPNAME,c.CHR_CUSTOMERNAME";
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
