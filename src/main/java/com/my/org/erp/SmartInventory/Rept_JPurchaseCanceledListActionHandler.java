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

public class Rept_JPurchaseCanceledListActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String cmpyname="";
	String officename="";
	String deptname="";
	String hImageExpression="";
	String fImageExpression="";
	String showRef="";
	
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String rptfilename1 = request.getParameter("rptfilename1");
			System.out.println("rptfilename1:"+rptfilename1);
			String reporttype = request.getParameter("reportType");
			
				
			if (action.equals("INVRept_JPurchaseCanceledList")) 
			{
				try 
				{ 
				System.out.println("Rept_JPurchaseCanceledList");
				
				File reportsDir = new File(Path + "/report/Inventory/Reports1/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
							
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				
						String sql="";
						String sql1="";
						sql = "SELECT b.CHR_BRANCHNAME,c.CHR_VENDORNAME,a.CHR_PURCHASEORDERNO,DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y') ,FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF),a.DOU_TOTALAMOUNT,if(a.CHR_CANCEL='Y','CANCELLED',''),a.CHR_CANCELDESC FROM  inv_t_directpurchase a ,   com_m_branch b, inv_m_vendorsinformation c WHERE    a.INT_BRANCHID =b.INT_BRANCHID AND a.INT_VENDORID =c.INT_VENDORID  AND a.CHR_CANCEL ='Y' ORDER BY a.DAT_ORDERDATE";		
					jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportsDir, rptfilename, sql, con, Path,map);
					ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
					
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
}

	