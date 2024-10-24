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
 
import com.my.org.erp.Date.Day;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JPaymentCommitmentDetailActionHandler extends AbstractActionHandler 
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
		asql=" SELECT a.CHR_SALESNO, FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) , FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF),  a.DOU_TOTALAMOUNT," +
				" FUN_GET_PAIDAMOUNT(a.CHR_SALESNO), (a.DOU_TOTALAMOUNT- FUN_GET_PAIDAMOUNT(a.CHR_SALESNO)) balance, " +
				"DATE_FORMAT(a.DAT_SALESDATE,'%e-%M-%Y'), FUN_GET_NOOFCOMMITMENT(a.CHR_SALESNO), DATE_FORMAT(b.DT_COMMITMENTDATE,'%e-%M-%Y') ," +
				"a.INT_PAYMENT_COMMITMENT_DAYS, datediff(now(),b.DT_COMMITMENTDATE), (DATE(NOW()) >= b.DT_COMMITMENTDATE) " +
				"FROM  inv_t_directsales a, inv_t_paymentcommitment b WHERE a.CHR_SALESNO = b.CHR_SALESNO AND b.CHR_INVOICETYPE = 'C'  " +
				"  AND a.CHR_CANCEL='N' AND b.CHR_PAYMENTFLAG ='N'    AND b.CHR_NEXTFLAG ='N' AND a.INT_SALESSTATUS=1 AND " +
				"b.DT_COMMITMENTDATE <= DATE_ADD(DATE(NOW()), INTERVAL 15 DAY) AND  (a.DOU_TOTALAMOUNT- FUN_GET_PAIDAMOUNT(a.CHR_SALESNO))  >0 " +
				"ORDER BY a.INT_SALESID  ";
		return asql;
	}
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			if (action.equals("INVRept_JPaymentCommitmentDetail")) 
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