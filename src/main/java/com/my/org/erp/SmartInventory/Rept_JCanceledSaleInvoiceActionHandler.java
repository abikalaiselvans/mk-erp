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
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JCanceledSaleInvoiceActionHandler extends AbstractActionHandler 
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
		System.out.println("inside Rept_JAppointmentOrder");
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			String SubRptfilename1 = request.getParameter("rptfilename1");
			String SubRptfilename2 = request.getParameter("rptfilename2");
			
			if (action.equals("INVRept_JCanceledSaleInvoice")) 
			{
			System.out.println("inside INVRept_JCanceledSaleInvoice");
				
				File reportDir = new File(Path + "/report/Inventory/Reports1/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				
				String branchid = request.getParameter("Branch");
				String division = request.getParameter("division");
				String ref = ""+request.getParameter("ref");
				String custid=request.getParameter("customer");
				String invoicetype=request.getParameter("invoice");
				String fromdate = request.getParameter("fromdate");
				String todate = request.getParameter("todate");
				
			
				String subReport1Sql=" SELECT a.CHR_SALESNO,c.CHR_BRANCHNAME,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') ," +
						"FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),a.DOU_TOTALAMOUNT,if(a.CHR_PAYMENTSTATUS='Y','Paid','Not Paid')" +
						" FROM  inv_t_directsales a , inv_t_paymentcommitment b,com_m_branch c WHERE   " +
						"a.CHR_SALESNO = b.CHR_SALESNO AND a.INT_BRANCHID  = c.INT_BRANCHID  AND b.CHR_STATUS='N'  AND a.CHR_CANCEL ='N' ";
				if(!"0".equals(branchid))
					subReport1Sql = subReport1Sql + " AND a.INT_BRANCHID = "+branchid;
				if(!"0".equals(division))
					subReport1Sql = subReport1Sql + " AND a.INT_DIVIID = "+division;
				if(!"0".equals(custid))
					subReport1Sql = subReport1Sql + "  AND a.INT_CUSTOMERID="+custid ;
				if(!"0".equals(ref))
					subReport1Sql = subReport1Sql + "  AND a.CHR_REF ='"+ref+"' ";
				
				subReport1Sql = subReport1Sql +" AND a.DAT_SALESDATE >='"+DateUtil.FormateDateSQL(fromdate)+"' AND a.DAT_SALESDATE <='"+DateUtil.FormateDateSQL(todate)+"'  ";
				subReport1Sql = subReport1Sql +" ORDER BY a.CHR_SALESNO";
				System.out.println("subReport1Sql:"+subReport1Sql);
				String data[][] = CommonFunctions.QueryExecute(subReport1Sql);
				if(data.length>0)
				map.put("sql1len",data.length-1 );
			
				File subReport1Dir = new File(Path + "/report/Inventory/Reports1/" + SubRptfilename1+".jrxml");
				File subReport2Dir = new File(Path + "/report/Inventory/Reports1/" + SubRptfilename2+".jrxml");
				String subReport2Sql=null;
				subReport2Sql="SELECT a.CHR_SALESNO,c.CHR_BRANCHNAME,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') ,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),a.DOU_NETAMOUNT,if(a.CHR_PAYMENTSTATUS='Y','Paid','Not Paid') FROM  inv_t_servicebilling a , inv_t_paymentcommitment b,com_m_branch c WHERE a.CHR_SALESNO = b.CHR_SALESNO AND a.INT_BRANCHID  = c.INT_BRANCHID  AND b.CHR_STATUS='N'   AND a.CHR_CANCEL ='N' ";
				if(!"0".equals(branchid))
					subReport2Sql = subReport2Sql + " AND a.INT_BRANCHID = "+branchid;
				if(!"0".equals(division))
					subReport2Sql = subReport2Sql + " AND a.INT_DIVIID = "+division;
				if(!"0".equals(custid))
					subReport2Sql = subReport2Sql + "  AND a.INT_CUSTOMERID="+custid ;
				if(!"0".equals(ref))
					subReport2Sql = subReport2Sql + "  AND a.CHR_REF ='"+ref+"' ";
				subReport2Sql = subReport2Sql +" AND a.DAT_SALESDATE >='"+DateUtil.FormateDateSQL(fromdate)+"' AND a.DAT_SALESDATE <='"+DateUtil.FormateDateSQL(todate)+"'  ";
				subReport2Sql = subReport2Sql +" ORDER BY a.CHR_SALESNO";
				System.out.println("subReport2Sql:"+subReport2Sql);
				String data1[][] = CommonFunctions.QueryExecute(subReport2Sql);
				
				if(data.length>data1.length)
					asql=subReport1Sql;
				else
					asql=subReport2Sql;
				int reportCount=1;
				if(data.length==0)
					map.put("reportCount", reportCount);
				else if(data.length>0)
					map.put("reportCount", reportCount+1);
				
					if(data.length==0 && data1.length==0 )
						map.put("dataLength", "0");
					else
						map.put("dataLength", "1");
				
				if("0".equals(invoicetype))
				{
					map.put("invoicetype", "0");
					map.put("type","All Invoice Types" );
				}
				else if("C".equals(invoicetype))
				{
					map.put("invoicetype", "C");
					map.put("type","Customer Sales" );
				}
				else if("S".equals(invoicetype))
				{
					map.put("invoicetype", "S");
					map.put("type","Service Billing" );
				}
				
				jasperPrint=CanceledSaleDtlSubReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, asql, subReport1Sql, con, Path,map,subReport1Dir,subReport2Dir,subReport2Sql);
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