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
 
 
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;

public class Rept_JESIForm_6_2ActionHandler extends AbstractActionHandler 
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
			 
			if (action.equals("PAYRept_JESIForm_6_2")) 
			{
			System.out.println("insite PAYRept_JESIForm_6_1");
			System.out.println("Path:"+Path);
				File reportDir = new File(Path + "/report/SmartPayroll/" + rptfilename+".jrxml");
				System.out.println("Path:"+Path);
				HashMap<Object,Object> map = new HashMap<Object,Object>();

				
			      String type=request.getParameter("type");
			      String company=request.getParameter("company");
				  String branch = request.getParameter("branch");
				  String Office = request.getParameter("Office");
			      
			     
			      int year=Integer.parseInt(request.getParameter("Year"));
			      String comname="", from="",to="";
			      String sql="",bra="",off="";
			      sql="select * from com_m_company where INT_COMPANYID="+company;
			      String datacom[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
			      if(datacom.length>0)
			      {
			      comname=datacom[0][1];
			       
			      }
			      
			     
			      if(type.equals("O"))
			      {
			    	  
			    	 
			          from="OCT-"+(year-1);
			    	  to="MAR-"+year;
			    	   
			      }
			      else
			      {
			    	  
		        	
			    	  
			    	  from="APRIL-"+year;
			    	  to="SEP-"+year;
			    	  
			      }
			     
				  if(!"0".equals(branch))
					bra = " AND b.INT_BRANCHID=  "+branch;
				if(!"0".equals(Office))
					off = " AND b.INT_OFFICEID=  "+Office;
			 
				 map.put("from",from);
	        	  map.put("to",to );
	        	  map.put("cpy",comname);
	        	  map.put("to",to );
	        	  
	        	  
	        		sql="select a.CHR_EMPNAME,sum(a.DOU_WORKDAYS),sum(a.DOU_BASIC),sum(a.DOU_ESI),b.CHR_ESINO,b.CHR_TYPE,b.CHR_HOLD," +
	        				"ROUND(sum(a.DOU_BASIC)/sum(a.DOU_WORKDAYS)) from pay_t_salary a,com_m_staff b " +
	        				"where ((a.CHR_MONTH in ('October','November','December') and a.INT_YEAR=(2011)) " +
	        				"or (a.CHR_MONTH in ('January','February','March') and a.INT_YEAR=(2012))) " +
	        				"and a.CHR_EMPID=b.CHR_EMPID and b.CHR_ESI<>'N' and b.INT_COMPANYID="+company+" ";
	        		sql = sql +bra;
	        		sql = sql +off+"  group by a.chr_empid order by a.CHR_EMPNAME";
	        		System.out.println(sql);
			
	        	
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportDir, rptfilename, sql, con, Path,map);
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