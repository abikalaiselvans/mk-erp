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

public class Rept_JPurchaseInvoicePendingListActionHandler extends AbstractActionHandler 
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
		asql="SELECT d.CHR_BRANCHNAME, a.CHR_PURCHASEORDERNO,b.CHR_VENDORNAME,DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y')," +
				"if(a.CHR_PAYMENTSTATUS='Y','Closed','Pending')  , if(a.CHR_ACCOUNTFLAG='Y','Received','Not Received'), " +
				"a.DOU_TOTALAMOUNT FROM inv_t_directpurchase a ,  inv_m_vendorsinformation  b , com_m_branch d where  " +
				"a.INT_VENDORID = b.INT_VENDORID AND a.INT_BRANCHID =d.INT_BRANCHID AND a.CHR_ACCOUNTFLAG='N' AND " +
				"a.DAT_ORDERDATE<= date_format(now(),'%Y-%m-%d') order by a.DAT_ORDERDATE";
		return asql;
	}
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
				
			if (action.equals("INVRept_JPurchaseInvoicePendingList")) 
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