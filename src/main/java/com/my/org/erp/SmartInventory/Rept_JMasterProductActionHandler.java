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

public class Rept_JMasterProductActionHandler extends AbstractActionHandler 
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
			HashMap<Object,Object> map = new HashMap<Object,Object>();
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			asql="SELECT a.CHR_NAME,b.CHR_PRODUCTCODE,b.CHR_PRODUCTDESC,b.INT_ACTIVE ,b.CHR_PTYPE  FROM inv_m_productgroup  a , inv_m_produtlist b  WHERE a.INT_PRODUCTGROUPID =b.INT_PRODUCTGROUPID ORDER BY b.CHR_PRODUCTCODE ";
			String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(asql);
				
		if(data.length>0)
		{
			for(int u=0;u<data.length;u++)
			{
				
				if("1".equals(data[u][3]))
					map.put("activeStatus", "Active");
				else
					map.put("activeStatus", "In Active");
				
				if("F".equals(data[u][4]))
					map.put("productType", "Full Product");
				else if("S".equals(data[u][4]))
					map.put("productType", "Consumable Product");
				else
					map.put("productType", "Combination Product");
					
				
			}
		} 
				
			if (action.equals("INVRept_JMasterProduct")) 
			{
				File reportsDir = new File(Path + "/report/Inventory/Master/" + rptfilename+".jrxml");
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				
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