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
 
import com.my.org.erp.Date.Day;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JStaffProductAssetActionHandler extends AbstractActionHandler 
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
			String  company  = request.getParameter("company");
			String  branch  = request.getParameter("branch");
	      	String  office  = request.getParameter("Office");
	      	String dept= request.getParameter("Dept");
	      	String fromdate= request.getParameter("fromdate");
	      	String todate= request.getParameter("todate");
	      	fromdate= DateUtil.FormateDateSQL(fromdate);
			todate= DateUtil.FormateDateSQL(todate);
			String fromdate1= DateUtil.FormateDateSys(fromdate);
			String todate1= DateUtil.FormateDateSys(todate);
	      	String materialStatus= request.getParameter("radiobutton");
			if (action.equals("INVRept_JStaffProductAsset")) 
			{
				File reportsDir = new File(Path + "/report/Inventory/PaymentDetailReport/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				
				asql=" SELECT if(a.CHR_STATUS='Y','Return',if(a.CHR_STATUS='F','Damage', 'Not Return')),b.CHR_EMPID,b.CHR_STAFFNAME,if(a.CHR_TYPE='I','Item','Product'),if(a.CHR_TYPE='I',(SELECT d.CHR_ITEMNAME FROM inv_m_item d " +
				"WHERE d.CHR_ITEMID=a.CHR_ITEMID),(SELECT e.CHR_PRODUCTCODE  FROM inv_m_produtlist  e WHERE e.CHR_PRODUCTID=a.CHR_ITEMID) ) productName," +
				"a.CHR_SERIALNO, DATE_FORMAT(a.DAT_CREATIONDATE,'%d-%b-%Y'), IF(a.CHR_STATUS ='Y','Return','Not Return') FROM inv_t_asset a," +
				"com_m_staff b,inv_t_vendorgoodsreceived c WHERE a.CHR_EMPID=b.CHR_EMPID AND a.CHR_ITEMID = c.CHR_ITEMID AND a.CHR_SERIALNO =c.CHR_SERIALNO ";
				asql = asql + " AND a.DAT_CREATIONDATE >='"+fromdate+"'";
				asql = asql + " AND a.DAT_CREATIONDATE <='"+todate+"'";
				if(!"0".equals(company))
			      	asql = asql + " AND b.INT_COMPANYID="+company;
			    if(!"0".equals(branch))
			    	asql = asql + " AND b.INT_BRANCHID="+branch;
		 	    if(!"0".equals(office))
		 	    	asql = asql + " AND b.INT_OFFICEID="+office;
		        if(!"0".equals(dept))
		        	asql = asql + " AND b.INT_DEPARTID= "+dept;
		        if(!"All".equals(materialStatus))
		        if("Return".equals(materialStatus))
			      	asql = asql + " AND a.CHR_STATUS='Y'";
		        else if("Not Return".equals(materialStatus))
		        	asql = asql + " AND a.CHR_STATUS='N'";
		      		asql = asql +	" ORDER BY b.CHR_STAFFNAME  ";
				System.out.println("asql:"+asql);
				
				String data[][] = CommonFunctions.QueryExecute(asql);
				
				if(data.length<=0)
					map.put("dataLength", "0");
				else
					map.put("dataLength", "1");
				
				if(!company.equals("0"))
				{String shipids[][] = CommonFunctions.QueryExecutecon(con,"SELECT CHR_COMPANYNAME FROM com_m_company  WHERE  INT_COMPANYID ="+company);
				map.put("company",shipids[0][0]);
				}
				else
					map.put("company", "All Companies");
				if(!branch.equals("0"))
				{String shipids[][] = CommonFunctions.QueryExecutecon(con,"SELECT CHR_BRANCHNAME FROM  com_m_branch WHERE INT_BRANCHID="+branch);
				map.put("branch", shipids[0][0]);
				}
				else
					map.put("branch", "All Branches");
				if(!office.equals("0"))
				{String shipids[][] = CommonFunctions.QueryExecutecon(con,"select CHR_OFFICENAME from com_m_office where INT_OFFICEID="+office);
				map.put("office", shipids[0][0]);
				}
				else
					map.put("office", "All Offices");
				if(!dept.equals("0"))
				{String shipids[][] = CommonFunctions.QueryExecutecon(con,"select CHR_DEPARTNAME from com_m_depart where INT_DEPARTID="+dept);
				map.put("dept",shipids[0][0]);
				}
				else
					map.put("dept", "All Departments");
				
				map.put("fromdate", fromdate1);
				map.put("todate", todate1);
				map.put("ms",materialStatus);
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