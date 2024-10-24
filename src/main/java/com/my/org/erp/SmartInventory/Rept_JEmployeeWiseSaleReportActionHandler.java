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
 
import com.my.org.erp.common.CommonFunctions;

public class Rept_JEmployeeWiseSaleReportActionHandler extends AbstractActionHandler 
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
		try 
				{ 
			System.out.println("INVRept_JSaleReport");
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
				
			if (action.equals("INVRept_JEmployeeWiseSaleReport")) 
			{
				System.out.println("INVRept_JEmployeeWiseSaleReport");
				File reportsDir = new File(Path + "/report/Inventory/Reports1/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
							
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				 
		   		String dt = ""+request.getParameter("saleDate");
				String dt2 = request.getParameter("saleDate2");
				dt=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(dt);
				dt2= com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(dt2);
				
				String ref = ""+request.getParameter("ref");
				showRef = CommonFunctions.QueryExecutecon(con,"SELECT CONCAT(CHR_EMPID,' / ',CHR_STAFFNAME)  FROM com_m_staff WHERE CHR_HOLD!='Y'  AND CHR_TYPE!='T' AND CHR_EMPID= '"+ref+"'")[0][0];
				
				map.put("fromDt", dt);
				map.put("toDt", dt2);
				map.put("ref", showRef);
			
					System.out.println("inside sale type 0");
					String rptfilename1 = request.getParameter("rptfilename1");
					File reportsDir1 = new File(Path + "/report/Inventory/Reports1/" + rptfilename1+".jrxml");
					
					String rptfilename2 = request.getParameter("rptfilename2");
					File reportsDir2 = new File(Path + "/report/Inventory/Reports1/" + rptfilename2+".jrxml");
					
					String rptfilename3 = request.getParameter("rptfilename3");
					File reportsDir3 = new File(Path + "/report/Inventory/Reports1/" + rptfilename3+".jrxml");
					
					String rptfilename4 = request.getParameter("rptfilename4");
					File reportsDir4 = new File(Path + "/report/Inventory/Reports1/" + rptfilename4+".jrxml");
					
					
					 asql =" SELECT a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),a.DOU_TOTALAMOUNT,c.CHR_DIVICODE,a.CHR_REF,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID), "; 
					asql = asql+ " a.CHR_OTHERREF ,d.DOU_PAMOUNT,d.DOU_SAMOUNT,d.DOU_CONTRIBUTION ,e.CHR_STAFFNAME ,a.DOU_AMOUNT";
					asql = asql+ " FROM inv_t_directsales a , inv_m_customerinfo b, inv_m_division c , inv_t_contribution d ,com_m_staff e";
					asql = asql+ " WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID AND e.CHR_EMPID  = a.CHR_REF";
					asql = asql+ " AND d.CHR_EMPID=a.CHR_REF AND a.INT_DIVIID = c.INT_DIVIID  ";
					asql = asql+ " AND a.CHR_SALESNO = d.CHR_SALESNO AND a.CHR_REF='"+ref+"' "; 
					asql = asql+ " AND a.DAT_SALESDATE >='"+dt+"'  AND a.DAT_SALESDATE <='"+dt2+"'";
					asql = asql+ " ORDER BY a.CHR_REF "; 
					
					System.out.println("asql:"+asql);
					
				 	String sql1 ="SELECT a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),a.DOU_NETAMOUNT,c.CHR_DIVICODE,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.CHR_REF, e.CHR_STAFFNAME  "; 
				  	sql1 = sql1+ " ,a.DOU_CONTRIBUTION ,a.DOU_AMOUNT FROM inv_t_directbilling a , inv_m_customerinfo b, inv_m_division c , com_m_staff e  ";
				  	sql1 = sql1+ " WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID ";
				  	sql1 = sql1+ " AND e.CHR_EMPID = a.CHR_REF    ";
				  	sql1 = sql1+ " AND a.INT_DIVIID =c.INT_DIVIID   "; 
				  	sql1 = sql1+ " AND a.CHR_REF='"+ref+"' ";
					sql1 = sql1+ " AND a.DAT_SALESDATE >='"+dt+"'  AND a.DAT_SALESDATE <='"+dt2+"' ";
					sql1 = sql1+ " ORDER BY a.CHR_REF ";
					
					System.out.println("sql1:"+sql1);
					
					
					String sql2 = " SELECT a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),a.DOU_NETAMOUNT,c.CHR_DIVICODE,a.CHR_REF,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),   "; 
					sql2 = sql2+ " a.CHR_OTHERREF, e.CHR_STAFFNAME ,a.DOU_AMOUNT  "; 
					sql2 = sql2+ " FROM inv_t_servicebilling a , inv_m_customerinfo b, inv_m_division c , com_m_staff e  ";  
					sql2 = sql2+ " WHERE a.INT_CUSTOMERID= b.INT_CUSTOMERID  "; 
					sql2 = sql2+ " AND e.CHR_EMPID = a.CHR_REF   "; 
					sql2 = sql2+ " AND a.INT_DIVIID = c.INT_DIVIID   "; 
					sql2 = sql2+ " AND a.CHR_REF='"+ref+"' "; 
					sql2 = sql2+ " AND a.DAT_SALESDATE >='"+dt+"'  AND a.DAT_SALESDATE <='"+dt2+"'";
					sql2 = sql2+ " ORDER BY a.CHR_REF "; 
					
					System.out.println("sql2:"+sql2);
					
					String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(asql);
					String data1[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql1);
					String data2[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql2);
					
					if(data.length<=0 )
						map.put("dataLength", "0");
					else
						map.put("dataLength", "1");
					if(data1.length<=0 )
						map.put("dataLength1", "0");
					else
						map.put("dataLength1", "1");
					if(data2.length<=0 )
						map.put("dataLength2", "0");
					else
						map.put("dataLength2", "1");
					
					
					jasperPrint=subReportCalling.employeeWiseSaleReport(jasperPrint, request, response, reportsDir,  null, con, Path,map,reportsDir1,reportsDir2,reportsDir3,reportsDir4,asql,sql1,sql2);
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