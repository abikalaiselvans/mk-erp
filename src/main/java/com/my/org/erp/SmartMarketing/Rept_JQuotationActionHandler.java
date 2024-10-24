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
 public class Rept_JQuotationActionHandler extends AbstractActionHandler 
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
		 
			String action = request.getParameter("actionS");
			String rptfilename1 = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			if (action.equals("MKTRept_JQuotation")) 
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
				
				
				String quotationno=request.getParameter("quotationno"); 
				asql ="SELECT  CHR_QUOTATIONNO quotno,FIND_A_MKT_CUSTOMER_ADDRESS(INT_CUSTOMERID) customer,DATE_FORMAT(DAT_QUOTATIONDATE,'%d-%b-%Y') dt , ";
				asql = asql +" CHR_ATTENTION attention, CHR_SUBJECT subject, CHR_TERMS terms,FIND_A_INSTITUTION_NAME() companyname, DOU_TOTALAMOUNT from mkt_t_quotation where CHR_QUOTATIONNO='"+quotationno+"' ";
				System.out.println("asql:"+asql);
				String data[][] = CommonFunctions.QueryExecute(asql);
				map.put("quotno", data[0][0]);
				map.put("customer",data[0][1].toUpperCase());
				map.put("dt", data[0][2]);
				if(data[0][3].length()>5)
				{
					map.put("attentiontitle", "Kind Attention : ");
					map.put("attention", data[0][3]);
				}
				else
				{
					map.put("attentiontitle", null);
					map.put("attention", null);
				}
				map.put("subject",data[0][4]);
				map.put("terms", data[0][5]);
				map.put("companyname", data[0][6] );
				map.put("qtotal", data[0][7] );
				
				asql = " SELECT a.CHR_DESC de,a.INT_QUANTITY qty, "; 
				asql = asql + " IF(a.INT_WARRANTY=0,'NO WARRANTY',CONCAT(a.INT_WARRANTY,'-Yrs')) warranty, ";
				asql = asql + " ROUND(a.DOU_UNITPRICE,2) price, ROUND(a.DOU_TOTAL,2) total ";
				asql = asql + " from mkt_t_quotationitem a WHERE  CHR_QUOTATIONNO ='"+quotationno+"' "; 
					
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename1, asql, con, Path,map);
				ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, quotationno);
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