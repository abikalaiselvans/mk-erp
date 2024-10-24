package com.my.org.erp.SmartInventory;
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

public class Rept_JBlockedSaleInvoiceActionHandler extends AbstractActionHandler 
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
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			if (action.equals("INVRept_JBlockedSaleInvoice")) 
			{
				File reportDir = new File(Path + "/report/Inventory/Reports1/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				
				String sql = "";
				sql = " SELECT a.CHR_SALESNO,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID), DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y') ," +
						" a.DOU_TOTALAMOUNT, (SELECT f.CHR_STAFFNAME FROM com_m_staff  f WHERE f.CHR_USERID= a.CHR_USRNAME), " +
						" if(a.CHR_INVOICEBLOCK='Y','Blocked','Not Blocked') FROM inv_t_directsales  a  WHERE a.CHR_INVOICEBLOCK ='Y' " +
						" ORDER BY a.CHR_SALESNO  ";	
			
				System.out.println("INVRept_JBlockedSaleInvoice sql:"+sql);
				 
				String data[][] = CommonFunctions.QueryExecute(sql);
				if(data.length<=0 )
					map.put("dataLength", "0");
				else
					map.put("dataLength", "1");
				
					
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, sql, con, Path,map);
				ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
				
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