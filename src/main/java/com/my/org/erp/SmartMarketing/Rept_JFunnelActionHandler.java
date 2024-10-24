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
 public class Rept_JFunnelActionHandler extends AbstractActionHandler 
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
		asql =  "    SELECT  FIND_A_EMPLOYEE_ID_NAME(a.CHR_EMPID) ME,   FIND_A_MKT_CUSTOMER_NAME(a.INT_CUSTOMERID) Clientname, ";
 		asql = asql + "    b.CHR_DESC, CONCAT(a.INT_PERCENTAGE,'%') stage,DATE_FORMAT(c.DAT_QUOTATIONDATE,'%d-%b-%Y') funneldate, ";
 		asql = asql + "    b.INT_QUANTITY, ROUND(b.DOU_UNITPRICE,2) , (b.DOU_TOTAL-b.DOU_TAX_AMOUNT),FIND_A_EMPLOYEE_REPORTING_TO(a.CHR_EMPID) Owner,MKT_FUN_GET_COLORCODE(a.INT_PERCENTAGE) ";
 		asql = asql + "    FROM mkt_t_daillycalls a ,mkt_t_quotationitem b, mkt_t_quotation c ";
 		asql = asql + "    WHERE  a.INT_CALLID >0  AND a.CHR_QUOTATION = b.CHR_QUOTATIONNO  AND b.CHR_QUOTATIONNO = c.CHR_QUOTATIONNO ";
 		asql = asql + "    AND  a.CHR_ADDEDTO_FUNNEL ='Y'  AND a.CHR_STATUS ='N' ";
 		asql = asql +"  ORDER BY c.INT_QUOTATIONID ";
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
			if (action.equals("MKTRept_JFunnel")) 
			{
				System.out.println("inside action");
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