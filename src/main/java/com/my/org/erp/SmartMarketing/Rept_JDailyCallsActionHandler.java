package com.my.org.erp.SmartMarketing;

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
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
 public class Rept_JDailyCallsActionHandler extends AbstractActionHandler 
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
		try 
		{ 
		System.out.println("inside handle");
			String action = request.getParameter("actionS");
			String rptfilename1 = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			if (action.equals("MKTRept_JDailyCalls")) 
			{
				
				File reportDir = new File(Path + "/report/SmartMarketing/" + rptfilename1+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				
			
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				
				
				String calltype=request.getParameter("calltype");
				String customer=request.getParameter("customer");
				String status=request.getParameter("status");
				String fmdate= request.getParameter("fromdate");
				String todate= request.getParameter("todate");
				
				map.put("fdate", fmdate);
				map.put("tdate", todate);
				
				fmdate=DateUtil.FormateDateSQL(fmdate);
				todate=DateUtil.FormateDateSQL(todate);			
				asql = " SELECT FIND_A_EMPLOYEE_ID_NAME(a.CHR_EMPID) ME, ";
				asql = asql + " FIND_A_MKT_CUSTOMER_NAME(a.INT_CUSTOMERID) customer, c.CHR_CALLTYPE, ";
				asql = asql + " DATE_FORMAT(a.DAT_START,'%d-%b-%Y') stdate, DATE_FORMAT(a.DAT_END,'%d-%b-%Y') eddate, ";
				asql = asql + " DATE_FORMAT(a.DAT_START,'%H:%i:%s %p') sttime, ";
				asql = asql + " DATE_FORMAT(a.DAT_END,'%H:%i:%s %p') edtime , TIME_FORMAT(TIMEDIFF(a.DAT_END,a.DAT_START),'%H:%i:%s') age, ";
				asql = asql + " a.CHR_DEPARTMENT dept,a.CHR_DESIGINATION desg,a.CHR_CONTACTPERSON ct, a.CHR_DESC deesc, if(a.CHR_NEXT='Y','Yes',''), ";
				asql = asql + " DATE_FORMAT(a.DAT_FOLLOWON,'%d-%b-%Y %H:%i:%s %p') followdt , IF(a.CHR_RESCHEDULE ='Y','Reschedule','') Reschedule , ";
				asql = asql + " IF(a.CHR_STATUS ='Y','Closed','Follows Up') status , FIND_A_MKT_CUSTOMER_ADDRESS(a.INT_CUSTOMERID) address ";
				asql = asql + " FROM mkt_t_daillycalls a, mkt_k_calltype c ";
				asql = asql + " WHERE a.CHR_CALLTYPE=c.INT_CALLTYPEID ";
				if(!"0".equals(calltype))
					asql=asql+" AND c.INT_CALLTYPEID="+calltype;
				if(!"0".equals(customer))
					asql=asql+" AND a.INT_CUSTOMERID="+customer;
				if(!"0".equals(status))
				{
					if("Y".equals(status))
						asql=asql+" AND a.CHR_STATUS='Y'";
					else
						asql=asql+" AND a.CHR_STATUS='N'";
				}
				asql = asql+" AND a.DAT_START >= '"+fmdate+"' ";
				asql = asql+" AND a.DAT_START <= '"+todate+"' ";
				asql = asql + " ORDER BY a.DAT_START ";
				System.out.println("asql:"+asql);
			
				String data[][] = CommonFunctions.QueryExecute(asql);
					
				if(!"0".equals(calltype))
				{
					String calltypeSelect[][] = CommonFunctions.QueryExecute("SELECT INT_CALLTYPEID,CHR_CALLTYPE FROM mkt_k_calltype WHERE INT_CALLTYPEID="+calltype);
					if(!calltypeSelect[0][1].equals(null))
							map.put("calltype",calltypeSelect[0][1]);
				}
				else
					map.put("calltype","All Call Types");
				if(!"0".equals(customer))
				{
					String customerSelect[][] = CommonFunctions.QueryExecute("SELECT a.INT_CUSTOMERID,b.CHR_NAME ,a.CHR_CONTACTPERSON  FROM mkt_m_customerinfo a, mkt_m_customername b  WHERE a.INT_CUSTOMERNAMEID =b.INT_CUSTOMERNAMEID  AND  a.CHR_VERIFY='Y' AND a.INT_CUSTOMERID="+customer);
					if(!customerSelect[0][0].equals(null))
					map.put("customer",customerSelect[0][1]+" / "+customerSelect[0][2]);
				}
				else
					map.put("customer","All Customers");
				if(!"0".equals(status))
				{
					if("Y".equals(status))
						map.put("status","Closed");
					else
						map.put("status","Pending");
				}
				else
					map.put("status","Both Status");
				if(data.length<=0)
					map.put("dataLength", "0");
				else
					map.put("dataLength", "1");
			
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename1, asql, con, Path,map);
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