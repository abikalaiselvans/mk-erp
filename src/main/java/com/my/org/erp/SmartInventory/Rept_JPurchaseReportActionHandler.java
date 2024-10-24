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
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JPurchaseReportActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String cmpyname="";
	String officename="";
	String deptname="";
	String hImageExpression="";
	String fImageExpression="";
	String comAndBrName="";
	String divName="";
	String venName="";
	String accFlag="";
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
				
			if (action.equals("INVRept_JPurchaseReport")) 
			{
				System.out.println("INVRept_JPurchaseReport");
				File reportsDir = new File(Path + "/report/Inventory/Reports1/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				
				 
		   		System.out.println("branchid:");
				 
				String frmdate = ""+request.getParameter("frmdate");
				String todate = request.getParameter("todate");
				frmdate= DateUtil.FormateDateSQL(frmdate);
				todate= DateUtil.FormateDateSQL(todate);
				
				String sql = "" ;
				String division = ""+request.getParameter("division");
				String vendor=request.getParameter("vendor");
				String Branch=request.getParameter("Branch");
				String account=request.getParameter("account");
					
				sql = " SELECT a.CHR_PURCHASEORDERNO,b.CHR_VENDORNAME,c.CHR_NAME vendorGroup,d.CHR_COMPANYNAME,e.CHR_BRANCHNAME,  ";
				sql = sql + " f.CHR_DIVICODE,DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y'),g.CHR_PAYMENTNAME,a.CHR_ACCOUNTFLAG,  ";
				sql = sql + " a.DOU_AMOUNT,h.CHR_TAXNAME,a.DOU_TAXAMOUNT,a.DOU_TOTALAMOUNT,a.CHR_VENDORPO  ";
				sql = sql + " FROM inv_t_directpurchase a, inv_m_vendorsinformation  b,inv_m_vendorsgroup c,com_m_company d, com_m_branch e,  ";
				sql = sql + " inv_m_division f,inv_m_paymentterms g,inv_m_tax h  ";
				sql = sql + " WHERE a.INT_VENDORID=b.INT_VENDORID  ";
				sql = sql + " AND b.INT_GROUPID = c.INT_GROUPID  ";
				sql = sql + " AND d.INT_COMPANYID =e.INT_COMPANYID  ";
				sql = sql + " AND a.INT_BRANCHID = e.INT_BRANCHID  ";
				sql = sql + " AND a.INT_DIVIID = f.INT_DIVIID   ";
				sql = sql + " AND a.INT_PAYMENTTERMID = g.INT_PAYMENTTERMID   ";
				sql = sql + " AND a.INT_TAXID = h.INT_TAXID  ";
				sql = sql + " AND a.DAT_ORDERDATE >='"+frmdate+"'";
				sql = sql + " AND a.DAT_ORDERDATE <='"+todate+"'";
				if(!"0".equals(Branch))
					sql = sql + " AND a.INT_BRANCHID <= "+Branch ;
				if(!"0".equals(division))
					sql = sql + " AND a.INT_DIVIID <= "+division ;
				if(!"0".equals(vendor))
					sql = sql + " AND a.INT_VENDORID = "+vendor ;
				if(!"0".equals(account))
					sql = sql + " AND a.CHR_ACCOUNTFLAG = '"+account+"' " ;
					
				sql = sql + " ORDER BY a.DAT_ORDERDATE  ";
				 
				System.out.println(sql);
				
				String data[][] =  CommonFunctions.QueryExecute(sql);
				
				if(!Branch.equals("0"))
				{String shipids[][] = CommonFunctions.QueryExecutecon(con,"Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID and a.INT_BRANCHID="+Branch);
				map.put("cpy", shipids[0][2]+"@"+shipids[0][1]);
				}
				else
					map.put("cpy", "All Companies");
				if(!division.equals("0"))
					divName= CommonFunctions.QueryExecutecon(con,"Select INT_DIVIID,CHR_DIVICODE from inv_m_division  WHERE INT_DIVIID >0 AND INT_DIVIID= "+division)[0][1];
				else
					divName="All Divisions";
				if(!vendor.equals("0"))
					venName = CommonFunctions.QueryExecutecon(con,"Select INT_VENDORID,CHR_VENDORNAME from  inv_m_vendorsinformation WHERE INT_VENDORID = "+vendor)[0][1];
				else
					venName="All Vendors";
				if(account.equals("0"))
					accFlag="Both";
				else if(account.equals("Y"))
					accFlag="Received";
				else 
					accFlag="Not Received";
				
				if(data.length>0)
					map.put("dataLength", "1");
				else
					map.put("dataLength", "0");
				
				map.put("fromDt", frmdate);
				map.put("toDt", todate);
				map.put("division", divName);
				map.put("vendor", venName);
				map.put("accountFlag", accFlag);
				
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportsDir, rptfilename, sql, con, Path,map);
				
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