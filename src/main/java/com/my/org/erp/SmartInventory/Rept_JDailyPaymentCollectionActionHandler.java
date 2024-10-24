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
import com.my.org.erp.common.CommonFunctions;

public class Rept_JDailyPaymentCollectionActionHandler extends AbstractActionHandler 
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
		asql="SELECT a.CHR_SALESORDERNO , FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),c.CHR_BANKGROUPNAME,a.CHR_PAYNO," +
				"date_format(a.DAT_PAYMENTDATE,'%d-%b-%Y'),a.DOU_PAIDAMOUNT,date_format(a.CHR_CHKDATE,'%d-%b-%Y')," +
				"date_format(d.DAT_SALESDATE,'%d-%b-%Y') ,a.CHR_REMARK,(SELECT e.CHR_STAFFNAME FROM com_m_staff e WHERE " +
				"e.CHR_EMPID=a.CHR_PAYEMENTCOLLECTEDBY),a.CHR_PAYEMENTCOLLECTEDBY,e.CHR_COMPANYNAME,f.CHR_BRANCHNAME," +
				"datediff(a.CHR_CHKDATE,d.DAT_SALESDATE),g.CHR_DIVICODE FROM inv_t_customersalespayment a,inv_m_customerinfo b," +
				"com_m_bankgroup c  ,inv_t_directsales d ,com_m_company e, com_m_branch f,inv_m_division g WHERE " +
				"a.INT_CUSTOMERID = b.INT_CUSTOMERID AND a.CHR_SALESORDERNO =d.CHR_SALESNO  AND d.CHR_CANCEL='N' " +
				"AND d.INT_BRANCHID = f.INT_BRANCHID AND f.INT_COMPANYID =e.INT_COMPANYID  AND a.CHR_BANKNAME = c.INT_BANKGROUPID " +
				"AND d.INT_DIVIID = g.INT_DIVIID   AND d.INT_DIVIID NOT IN(9) AND a.DAT_PAYMENTDATE<= date_format(now(),'%Y-%m-%d') " +
				"AND a.DAT_PAYMENTDATE>=  date_format(now(),'%Y-%m-%d') ORDER BY a.CHR_SALESORDERNO ";
		return asql;
	}
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
				
			if (action.equals("INVRept_JDailyPaymentCollection")) 
			{
				File reportsDir = new File(Path + "/report/Inventory/PaymentDetailReport/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				
				asql=getSqlQuery();
				String data[][] = CommonFunctions.QueryExecute(asql);
				
				if(data.length<=0)
					map.put("dataLength", "0");
				else
					map.put("dataLength", "1");
				
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