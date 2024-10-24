package com.my.org.erp.SmartCommon;

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
  
import com.my.org.erp.SmartReport.SavePDFFunction;
import com.my.org.erp.ServiceLogin.AbstractActionHandler; 

public class Rept_JIdCardActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String cmpyname="";
	String officename="";
	String deptname="";
	String id1Expression="";
	String id2Expression="";

	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		System.out.println("insite Rept_JIdCard");
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String staffid = request.getParameter("staffid");
			String reporttype = "pdf";
			System.out.println("action:"+action);
			System.out.println("rptfilename:"+rptfilename);
			System.out.println("action:"+action);
					
				
			if (action.equals("GENRept_JIdCard")) 
			{
							
				File reportDir = new File(Path + "/report/SmartCommon/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File idImage = new File(Path + "/images/id-card.jpg");
				
				
				id1Expression=(idImage.exists())?"../../images/id-card.jpg":null;
				
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("id1", id1Expression);
				
				asql = " SELECT a.CHR_EMPID,a.CHR_STAFFNAME,c.CHR_GROUPNAME,a.CHR_MOBILE," +
						"FUN_GET_ADDRESS(a.CHR_EMPID,'P','\n') empadd,'CARE ITSOLUTION PVT LIMITED'," +
						"'No 481 2nd Floor, Nandanam','Chennai-600030,Tamilnadu',b.IMG_IMAGE " +
						" FROM com_m_staff a,com_m_staffaddressproof b , com_m_bloodgroup c " +
						"WHERE a.CHR_EMPID =b.CHR_EMPID AND a.CHR_BG = c.INT_BLOODGROUPID " +
						"AND a.CHR_EMPID='"+staffid+"'";
				jasperPrint=SavePDFFunction.createReport(jasperPrint, request, response, reportDir, rptfilename, asql, con, Path,map);
				SavePDFFunction.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
				
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