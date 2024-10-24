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

public class Rept_JPaymentBalanceListActionHandler extends AbstractActionHandler 
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
		asql="SELECT  d.CHR_DIVICODE, FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) , c.CHR_STAFFNAME,a.CHR_SALESNO,a.DOU_TOTALAMOUNT," +
				"FUN_GET_PAIDAMOUNT(a.CHR_SALESNO),(a.DOU_TOTALAMOUNT- FUN_GET_PAIDAMOUNT(a.CHR_SALESNO)) balance, " +
				"DATE_FORMAT(a.DAT_SALESDATE,'%e-%M-%Y'),( SELECT DATE_FORMAT(max(h.DT_COMMITMENTDATE ),'%e-%M-%Y') " +
				"FROM inv_t_paymentcommitment h WHERE a.CHR_SALESNO = h.CHR_SALESNO ) commitmentDt ,DATEDIFF(( SELECT max(h.DT_COMMITMENTDATE ) " +
				"FROM inv_t_paymentcommitment h WHERE a.CHR_SALESNO = h.CHR_SALESNO ),a.DAT_SALESDATE) saleDtDiff ,DATEDIFF(DATE(NOW())," +
				"( SELECT max(h.DT_COMMITMENTDATE ) FROM inv_t_paymentcommitment h WHERE a.CHR_SALESNO = h.CHR_SALESNO )) currDtDiff " +
				"from inv_t_directsales a ,inv_m_customerinfo b ,com_m_staff c ,inv_m_division d,inv_t_paymentcommitment g " +
				"WHERE a.CHR_PAYMENTSTATUS !='Y'    AND a.CHR_CANCEL='N' AND a.CHR_SALESNO = g.CHR_SALESNO AND g.CHR_INVOICETYPE='C' " +
				"AND a.INT_SALESSTATUS=1 AND a.CHR_PAYMENTSTATUS !='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND a.CHR_REF = c.CHR_EMPID " +
				"AND a.INT_DIVIID=d.INT_DIVIID AND datediff(now(),a.DAT_SALESDATE)>=25 GROUP BY a.CHR_SALESNO ORDER BY  a.DAT_SALESDATE";
		return asql;
	}
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
				
			if (action.equals("INVRept_JPaymentBalanceList")) 
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