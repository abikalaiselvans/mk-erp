package com.my.org.erp.SmartHRM;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
 
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.util.SimpleFileResolver;

 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.SmartReport.ReportFunctions;
 
 
public class JRept_ApplicantActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	static String hImageExpression;
	static String fImageExpression;
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{
			String action = request.getParameter("actionS");
			HttpSession session = request.getSession();
			String user  = (String) session.getAttribute("USRID");
			 
			if (action.equals("HRMJRept_Applicant")) 
			{
				String location = request.getParameter("location");
				String grade = request.getParameter("grade");
				String title = request.getParameter("title");
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				String rptfilename = request.getParameter("rptfilename");
				String reporttype = request.getParameter("export");
				System.out.println();
				System.out.println();
				System.out.println();
				System.out.println();
				asql+="SELECT  (@c:=@c+1)  SNO,app.CHR_APPCODE,app.CHR_APPNAME,app.CHR_APPFATHER, ";
				asql+=" app.DT_APPLICATIONDATE,app.CHR_JOBGRADE,jd.CHR_JOBCODE,jd.CHR_JOBTITLE,app.CHR_GENDER,";
				asql+=" app.DT_DOB, bg.CHR_GROUPNAME, app.CHR_MARITALSTATUS,app.DT_WEDDATE,qual.CHR_QUALIFICATIONNAME, ";
				asql+=" app.CHR_EMAILID,app.CHR_MOBILE, app.CHR_PASSPORT, app.CHR_PAN,app.CHR_BIKESTATUS, ";
				asql+=" app.CHR_DRIVINGLIC,CONCAT(CONCAT(CONCAT(app.CHR_PADD1,app.CHR_PADD2) ,";
				asql+=" city.CHR_CITYNAME), state.CHR_STATENAME) pAddress, CONCAT(CONCAT(CONCAT(app.CHR_CADD1,app.CHR_CADD2) , ";
				asql+=" app.INT_CCITY), app.INT_CSTATE) cAddress FROM hrm_m_application app, hrm_m_jobdesign jd, COM_M_city city,";
				asql+="  COM_M_STATE state,(SELECT @c:=0) t, com_m_office office, com_m_bloodgroup bg,com_m_qualification qual  ";
				asql+=" WHERE  app.INT_JOBID=jd.INT_JOBID AND  app.CHR_QUALIFICATION  =qual.INT_QUALIFICATIONID  ";
				asql+=" AND app.CHR_BG =bg.INT_BLOODGROUPID ";
				asql+=" AND app.INT_PCITY=city.INT_CITYID AND app.INT_OFFICEID=office.INT_OFFICEID ";
				asql+=" AND app.INT_PSTATE=state.INT_STATEID  AND app.INT_CCITY=city.INT_CITYID AND ";
				asql+=" state.INT_STATEID=app.INT_CSTATE";
				asql+=" AND app.INT_YEAR= "+year;
				if(!"0".equals(month))
					asql+=" AND app.CHR_MONTH ='"+DateUtil.getMonth(Integer.parseInt(month))+"'";
				if(!"0".equals(location))
					asql+=" AND app.INT_OFFICEID = "+location;
				if(!"0".equals(title))
					asql+=" AND app.INT_JOBID = "+title;
				if(!"0".equals(grade))
					asql+=" AND app.CHR_JOBGRADE = '"+grade+"' ";
				
				System.out.println(asql);
				 
				File reportsDir = new File(Path + "jasper_report_files/hrm/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				map.put("location", location);
				map.put("grade", grade);
				map.put("title", title);
				map.put("month", month);
				map.put("year", year);
				 
				
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportsDir, rptfilename, asql, con, Path,map);
				ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
				 
			}
			 
			
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
			
		}
	}

}
