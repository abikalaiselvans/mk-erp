package com.my.org.erp.SmartPayroll;

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

public class Rept_JExitInterviewActionHandler extends AbstractActionHandler 
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
				
			if (action.equals("PAYRept_JExitInterview")) 
			{
				File reportDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				
				String staffid = request.getParameter("staffid");
				
				asql="SELECT a.CHR_EMPID,b.CHR_STAFFNAME,date_format(DAT_INTERVIEWDATE,'%d-%b-%Y'),CHR_REASON1,CHR_REASON2," +
						"if(CHR_REASON3='Y','Yes','No'),CHR_REASON4,if(CHR_REASON5='Y','Yes','No'),if(CHR_REASON6='Y','Yes','No')," +
						"if(CHR_REASON7='Y','Yes','No'),if(CHR_REASON8='Y','Yes','No'),if(CHR_REASON9='Y','Yes','No')," +
						"CHR_REASON10,CHR_REASON11,CHR_REASON12,CHR_REASON13,CHR_REASON14,if(CHR_REASON15='Y','Yes','No')," +
						"if(CHR_REASON16='Y','Yes','No'),CHR_REASON17,CHR_REASON18,CHR_REASON19,CHR_REASON20 FROM " +
						"pay_t_exitinterview a,com_m_staff b WHERE a.CHR_EMPID=b.CHR_EMPID AND INT_EXITID="+staffid;
						
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, asql, con, Path,map);
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