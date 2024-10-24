package com.my.org.erp.SmartPayroll;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRExporter; 
import net.sf.jasperreports.engine.JasperPrint;
  
 
import com.my.org.erp.SmartReport.OneSubReportFunctions;
import com.my.org.erp.SmartReport.ReportFunctions; 
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.common.CommonFunctions;
 

public class Rept_JESIForm_6_1ActionHandler extends AbstractActionHandler 
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
		System.out.println("Rept_JESIForm_6_1ActionHandler");
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			 
			if (action.equals("PAYRept_JESIForm_6_1")) 
			{
				
				File reportDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");
				System.out.println("Path:"+Path);
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				System.out.println("before company:");
				String type=request.getParameter("type");
		        String company=request.getParameter("company");
		        int start=0,end=0;
		        int year=Integer.parseInt(request.getParameter("Year"));
		         
		        String sql="";
		        asql = " select a.CHR_COMPANYNAME,a.CHR_STREET,b.CHR_CITYNAME,a.INT_PINCODE from com_m_company a,com_m_city b ";
		        asql = asql + " WHERE a.INT_CITYID = b.INT_CITYID   AND INT_COMPANYID="+company;
		        String datacom[][]=CommonFunctions.QueryExecute(asql);
		        if(datacom.length>0)
		        {
		        	 
		        	map.put("companyname", datacom[0][0]);
		        	map.put("street", datacom[0][1]);
		        	map.put("city", datacom[0][2]);
		        	map.put("pincode", datacom[0][3]);
		        }
		        String mon="";
		        map.put("yr",""+year );
		      	String byr=Integer.toString(year-1);
		      	String yr=Integer.toString(year);
				
		        if(type.equals("O"))
		        {
		        	map.put("byr",byr);
		        	map.put("monFrom","01-10-" );
		        	map.put("monTo","31-03-" );
		        	mon="October,November,December,January,February,March";
		            start=year-1;
		        	end=year;
		        }
		        else
		        {
		        	map.put("byr",yr);
		        	map.put("monFrom","01-04-" );
		        	map.put("monTo","30-09-" );
		        	mon="April,May,June,July,August,September";
		        	start=year;
		        	end=year;
		        }
		        String month[]=mon.split(",");
		        double cpf=0,spf=0,total=0;
		        double sesi=0,scpyesi=0;
		        System.out.println();
		        
		        //OCT - MARCH CALCULATION
		        if(type.equals("O"))
		        {	
			        for(int i=0;i<6;i++)
			        {
			        	spf =0;cpf=0;total=0;
			        	if(i<3)
			        		sql="SELECT  ROUND(DOU_BASIC,2),ROUND(DOU_ESI,2),ROUND(DOU_CPYESI,2),ROUND((DOU_ESI+DOU_CPYESI),2) FROM pay_t_salary WHERE CHR_MONTH='"+month[i]+"' and INT_YEAR="+start+" GROUP BY CHR_MONTH,INT_YEAR"; 
			        	else
			        		sql="SELECT  ROUND(DOU_BASIC,2),ROUND(DOU_ESI,2),ROUND(DOU_CPYESI,2),ROUND((DOU_ESI+DOU_CPYESI),2)  FROM pay_t_salary WHERE CHR_MONTH='"+month[i]+"' and INT_YEAR="+end+" GROUP BY CHR_MONTH,INT_YEAR";
			        	 
			        	String data[][]=CommonFunctions.QueryExecute(sql);
			        	if(data.length>0)
			        	{
			        		cpf=0;spf=0;
			        		if(!data[0][1].equals("") || !data[0][1].equals("-"))
			        			spf=Double.parseDouble(data[0][1]);
			        		if(!data[0][2].equals("") || !data[0][2].equals("-"))
			        			cpf=Double.parseDouble(data[0][2]);
			        		if(!data[0][3].equals("") || !data[0][3].equals("-"))
			        			total=Double.parseDouble(data[0][3]);
			        	}
			        	
			        	map.put("emp_contri_month"+(i+1),""+spf  );
			        	map.put("employer_contri_month"+(i+1),""+cpf );
			        	map.put("tot_contri_month"+(i+1), ""+total);
			        	
			        	sesi =sesi+spf;
			        	scpyesi =scpyesi+cpf;
			        }
			          
		        }
		        else
		        {	
		        	//APR - SEP CALCULATION
			        for(int i=0;i<6;i++)
			        {
			        	spf =0;cpf=0;total=0;
			        	sql="SELECT  ROUND(DOU_BASIC,2),ROUND(DOU_ESI,2),ROUND(DOU_CPYESI,2),ROUND((DOU_ESI+DOU_CPYESI),2)  FROM pay_t_salary WHERE CHR_MONTH='"+month[i]+"' and INT_YEAR="+end+" GROUP BY CHR_MONTH,INT_YEAR";
			        	 
			        	String data[][]=CommonFunctions.QueryExecute(sql);
			        	if(data.length>0)
			        	{
			        		cpf=0;spf=0;
			        		if(!data[0][1].equals("") || !data[0][1].equals("-"))
			        			spf=Double.parseDouble(data[0][1]);
			        		if(!data[0][2].equals("") || !data[0][2].equals("-"))
			        			cpf=Double.parseDouble(data[0][2]);
			        		if(!data[0][3].equals("") || !data[0][3].equals("-"))
			        			total=Double.parseDouble(data[0][3]);
			        	}
			        	
			        	map.put("emp_contri_month"+(i+1),""+spf  );
			        	map.put("employer_contri_month"+(i+1),""+cpf );
			        	map.put("tot_contri_month"+(i+1), ""+total);
			        	 
			        	 
			        	sesi =sesi+spf;
			        	scpyesi =scpyesi+cpf;
			        }
			        
		        }
		        
		        map.put("employer_share",""+Math.round(scpyesi) );
		        map.put("emp_share",""+Math.round(sesi ));
	        	map.put("tot", ""+Math.round((scpyesi+sesi)));
	        	map.put("tot_employer_contri",""+Math.round(scpyesi) );
		        map.put("tot_emp_contri",""+Math.round(sesi ));
		        map.put("tot_contri", ""+Math.round((scpyesi+sesi)));
	        
        	    
        	    
        	   	asql ="SELECT CHR_EMPID FROM com_m_staff where CHR_EMPID='ADMIN'";
        	   	jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, asql, con, Path,map);
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