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
import com.my.org.erp.SmartReport.OneSubReportFunctions;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.SmartReport.SavePDFFunction;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JESIForm_6AActionHandler extends AbstractActionHandler 
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
		System.out.println("Rept_JPFForm_12AActionHandler");
		try 
		{ 
			String action = request.getParameter("actionS");
			
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			if (action.equals("PAYRept_JPFForm_12A")) 
			{
			System.out.println("insite Rept_JPFForm_12A");
			System.out.println("Path:"+Path);
				File reportDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");
				System.out.println("Path:"+Path);
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				System.out.println("before company:");
				  String type=request.getParameter("type");
				 String yr= request.getParameter("Year");
		          String company=request.getParameter("company");
		          int start=0,end=0;
		          int year=Integer.parseInt(request.getParameter("Year"));
		          String comname="",comst="",comcity="",compin="",from="",to="";
		          String sql="";
		          sql="select * from com_m_company where INT_COMPANYID="+company;
		          String datacom[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		          if(datacom.length>0)
		          {
		          comname=datacom[0][1];
		          comst=datacom[0][3];
		          comcity=datacom[0][4];
		          compin=datacom[0][6];
		          }
		          String mon="";
		          if(type.equals("O"))
		          {
		        	 mon="October,November,December,January,February,March";
		              from="OCT,"+(year-1);
		        	  to="MAR,"+year;
		        	  start=year-1;
		        	  end=year;
		          }
		          else
		          {
		        	  mon="April,May,June,July,August,September";
		        	  from="APRIL,"+year;
		        	  to="SEP,"+year;
		        	  start=year;
		        	  end=year;
		          }
		          String month[]=mon.split(",");
		          String basic="0",cpf="0",spf="0";
		          int tbasic=0,tcpf=0,tspf=0,ttotal=0;
		          for(int i=0;i<6;i++)
		          {basic="0";cpf="0";spf="0";
		        	if(i<3)
		        	  sql="select  sum(DOU_BASIC),sum(DOU_ESI),sum(DOU_CPYESI) from pay_t_salary where CHR_MONTH='"+month[i]+"' and INT_YEAR="+start;
		        	else
		        		sql="select  sum(DOU_BASIC),sum(DOU_ESI),sum(DOU_CPYESI) from pay_t_salary where CHR_MONTH='"+month[i]+"' and INT_YEAR="+end;
		        	////System.out.println(sql);
		        	String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		        	if(data.length>0)
		        	{basic="0";cpf="0";spf="0";
		        		if(!data[0][0].equals(""))
		        		basic=data[0][0].substring(0,data[0][0].length()-3);
		        		if(!data[0][2].equals(""))
		        		cpf=data[0][2].substring(0,data[0][2].length()-3);
		        		if(!data[0][1].equals(""))
		        		spf=data[0][1].substring(0,data[0][1].length()-3);
		        	}
		        	
		        	tcpf=tcpf+Integer.parseInt(cpf);
		        	tspf=tspf+Integer.parseInt(spf);
		        	ttotal=ttotal+(Integer.parseInt(cpf)+Integer.parseInt(spf));
		        	
		          }	map.put("yr",yr );
			String ayr=Integer.toString(year+1);
			System.out.println("ayr:"+ayr);
			map.put("ayr",ayr );
			
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, null, con, Path,map);
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