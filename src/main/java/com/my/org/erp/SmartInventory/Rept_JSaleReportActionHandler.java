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

public class Rept_JSaleReportActionHandler extends AbstractActionHandler 
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
	String showRef="";
	String selectedCustomer="";
	String saleType="";
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
				{ 
			System.out.println("INVRept_JSaleReport");
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
				
			if (action.equals("INVRept_JSaleReport")) 
			{
				System.out.println("INVRept_JSaleReport");
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
				String sql = ""+request.getParameter("sql");
				System.out.println("sql:"+sql);
				String division = ""+request.getParameter("division");
				String ref = ""+request.getParameter("ref");
				
				String custid=request.getParameter("customer");
				String type=request.getParameter("type");
				String Branch=request.getParameter("Branch");
				
				if(!Branch.equals("0"))
				{String shipids[][] = CommonFunctions.QueryExecutecon(con,"Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID and a.INT_BRANCHID="+Branch);
				map.put("cpy", shipids[0][2]+"@"+shipids[0][1]);
				}
				else
					map.put("cpy", "All Companies");
				//String division1[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE");
				if(!division.equals("0"))
					divName= CommonFunctions.QueryExecutecon(con,"Select INT_DIVIID,CHR_DIVICODE from inv_m_division  WHERE INT_DIVIID >0 AND INT_DIVIID= "+division)[0][1];
				else
					divName="All Divisions";
				if(!custid.equals("0"))
					selectedCustomer = CommonFunctions.QueryExecutecon(con,"SELECT CONCAT(a.CHR_CONTACTPERSON,',',f.CHR_NAME,',',e.CHR_CITYNAME) FROM  inv_m_customerinfo a,com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID AND a.INT_CITYID =e.INT_CITYID AND   a.INT_ACTIVE =1 AND a.CHR_VERIFIED ='Y' AND  a.INT_CUSTOMERID= "+custid)[0][0];
				else
					selectedCustomer="All Customers";
				if(!ref.equals("0"))
					showRef = CommonFunctions.QueryExecutecon(con,"SELECT CONCAT(CHR_EMPID,' / ',CHR_STAFFNAME)  FROM com_m_staff WHERE CHR_HOLD!='Y'  AND CHR_TYPE!='T' AND CHR_EMPID= '"+ref+"'")[0][0];
				else
					showRef="All Sale references";
				if(type.equals("0"))
					saleType="All Sale Types";
				else if(type.equals("1"))
					saleType="Direct Sales";
				else if(type.equals("2"))
					saleType="Direct Billing";
				else if(type.equals("3"))
					saleType="Service Billing";
				
				map.put("fromDt", dt);
				map.put("toDt", dt2);
				map.put("division", divName);
				map.put("customer", selectedCustomer);
				map.put("ref", showRef);
				map.put("saleType", saleType);
					
				if ("0".equals(type))
				{
					System.out.println("inside sale type 0");
					String rptfilename1 = request.getParameter("rptfilename4");
					File reportsDir1 = new File(Path + "/report/Inventory/Reports1/" + rptfilename1+".jrxml");
					
					String rptfilename2 = request.getParameter("rptfilename5");
					File reportsDir2 = new File(Path + "/report/Inventory/Reports1/" + rptfilename2+".jrxml");
					
					String rptfilename3 = request.getParameter("rptfilename6");
					File reportsDir3 = new File(Path + "/report/Inventory/Reports1/" + rptfilename3+".jrxml");
					
					String rptfilename4 = request.getParameter("rptfilename7");
					File reportsDir4 = new File(Path + "/report/Inventory/Reports1/" + rptfilename4+".jrxml");
					
					String rptfilename5 = request.getParameter("rptfilename8");
					File reportsDir5 = new File(Path + "/report/Inventory/Reports1/" + rptfilename5+".jrxml");
					
					sql = " SELECT a.CHR_SALESNO,ROUND(a.DOU_TOTALAMOUNT,2),DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.INT_PAYMENTTERMID,a.CHR_PAYMENTSTATUS,";
					sql = sql + " c.CHR_STAFFNAME,ROUND(a.DOU_AMOUNT,2),e.CHR_COMPANYNAME,d.CHR_BRANCHNAME,f.CHR_DIVICODE FROM inv_t_directsales  a ,inv_m_customerinfo b ,com_m_staff c  ,com_m_branch d ,com_m_company e, inv_m_division f";
					sql = sql + "  WHERE a.INT_BRANCHID = d.INT_BRANCHID AND d.INT_COMPANYID=e.INT_COMPANYID AND a.INT_DIVIID=f.INT_DIVIID AND a.DAT_SALESDATE >= '"+dt+"' ";
					sql = sql + " AND a.DAT_SALESDATE<='"+dt2+"' ";
					if(!"0".equals(division))
						sql = sql + " AND a.INT_DIVIID="+division ;
					if(!"0".equals(custid))
						sql = sql + "  AND a.INT_CUSTOMERID="+custid ;
					if(!"0".equals(ref))
						sql = sql + "  AND a.CHR_REF ='"+ref+"' ";
					if(!"0".equals(Branch))
						sql = sql + "  AND a.INT_BRANCHID="+Branch ;
					sql = sql + "  AND a.INT_SALESSTATUS=1 AND a.INT_CUSTOMERID = b.INT_CUSTOMERID  ";
					sql = sql + " AND c.CHR_EMPID =a.CHR_REF  ORDER BY a.CHR_SALESNO";
					
					String sql1 = " SELECT a.CHR_SALESNO,a.DOU_NETAMOUNT,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID), a.CHR_PAYMENTSTATUS,";
					sql1 = sql1 + " c.CHR_STAFFNAME,a.DOU_AMOUNT,e.CHR_COMPANYNAME,d.CHR_BRANCHNAME ,f.CHR_DIVICODE FROM inv_t_directbilling  a ,inv_m_customerinfo b ,com_m_staff c   ";
					sql1 = sql1 + " ,com_m_branch d ,com_m_company e,inv_m_division f  WHERE a.INT_BRANCHID = d.INT_BRANCHID  AND a.INT_DIVIID=f.INT_DIVIID AND d.INT_COMPANYID=e.INT_COMPANYID AND a.DAT_SALESDATE >= '"+dt+"' ";
					sql1 = sql1 + " AND a.DAT_SALESDATE<='"+dt2+"' ";
					
					if(!"0".equals(division))
						sql1 = sql1 + " AND a.INT_DIVIID="+division ;
					if(!"0".equals(custid))
						sql1 = sql1 + "  AND a.INT_CUSTOMERID="+custid ;
					if(!"0".equals(ref))
						sql1 = sql1 + "  AND a.CHR_REF ='"+ref+"' ";
					if(!"0".equals(Branch))
						sql1 = sql1 + "  AND a.INT_BRANCHID="+Branch ;
					
					
					sql1 = sql1 + " AND a.INT_CUSTOMERID = b.INT_CUSTOMERID  ";
					sql1 = sql1 + " AND c.CHR_EMPID =a.CHR_REF  ORDER BY a.CHR_SALESNO";
					
					String sql2 = " SELECT a.CHR_SALESNO,a.DOU_NETAMOUNT,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID), a.CHR_PAYMENTSTATUS,";
					sql2 = sql2 + " c.CHR_STAFFNAME,a.DOU_AMOUNT,e.CHR_COMPANYNAME,d.CHR_BRANCHNAME,f.CHR_DIVICODE FROM inv_t_servicebilling  a ,inv_m_customerinfo b ,com_m_staff c,com_m_branch d ,com_m_company e ,inv_m_division f ";
					sql2 = sql2 + "WHERE a.INT_BRANCHID = d.INT_BRANCHID AND d.INT_COMPANYID=e.INT_COMPANYID AND a.INT_DIVIID=f.INT_DIVIID  AND a.DAT_SALESDATE >='"+dt+"' ";
					sql2 = sql2 + " AND a.DAT_SALESDATE<='"+dt2+"' " ;
					if(!"0".equals(division))
						sql2 = sql2 + " AND a.INT_DIVIID="+division ;
					if(!"0".equals(custid))
						sql2 = sql2 + "  AND a.INT_CUSTOMERID="+custid ;
					if(!"0".equals(ref))
						sql2 = sql2 + "  AND a.CHR_REF ='"+ref+"' ";
					if(!"0".equals(Branch))
						sql2 = sql2 + "  AND a.INT_BRANCHID="+Branch ;
					
					sql2 = sql2 + "  AND a.INT_CUSTOMERID = b.INT_CUSTOMERID  ";
					sql2 = sql2 + " AND c.CHR_EMPID =a.CHR_REF  ORDER BY a.CHR_SALESNO";
					
					String data[][] =  CommonFunctions.QueryExecute(sql);
					String data1[][] =  CommonFunctions.QueryExecute(sql1);
					String data2[][] = CommonFunctions.QueryExecute(sql2);
					
					if(data.length<=0 && data1.length<=0 && data2.length<=0)
						map.put("dataLength", "0");
					else
						map.put("dataLength", "1");
					
					
					jasperPrint=subReportCalling.createReport(jasperPrint, request, response, reportsDir1, rptfilename1, null, con, Path,map,reportsDir2,reportsDir3,reportsDir4,reportsDir5,sql,sql1,sql2);
					ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename1);
				}
				else
				{
					System.out.println("outside sale type 0");
				if(("1".equals(type)) )
				{
					System.out.println("first sale type");
						
					sql = " SELECT a.CHR_SALESNO,ROUND(a.DOU_TOTALAMOUNT,2),DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.INT_PAYMENTTERMID,a.CHR_PAYMENTSTATUS,";
					sql = sql + " c.CHR_STAFFNAME,ROUND(a.DOU_AMOUNT,2),e.CHR_COMPANYNAME,d.CHR_BRANCHNAME,f.CHR_DIVICODE FROM inv_t_directsales  a ,inv_m_customerinfo b ,com_m_staff c  ,com_m_branch d ,com_m_company e, inv_m_division f";
					sql = sql + "  WHERE a.INT_BRANCHID = d.INT_BRANCHID AND d.INT_COMPANYID=e.INT_COMPANYID AND a.INT_DIVIID=f.INT_DIVIID AND a.DAT_SALESDATE >= '"+dt+"' ";
					sql = sql + " AND a.DAT_SALESDATE<='"+dt2+"' ";
					if(!"0".equals(division))
						sql = sql + " AND a.INT_DIVIID="+division ;
					if(!"0".equals(custid))
						sql = sql + "  AND a.INT_CUSTOMERID="+custid ;
					if(!"0".equals(ref))
						sql = sql + "  AND a.CHR_REF ='"+ref+"' ";
					if(!"0".equals(Branch))
						sql = sql + "  AND a.INT_BRANCHID="+Branch ;
					sql = sql + "  AND a.INT_SALESSTATUS=1 AND a.INT_CUSTOMERID = b.INT_CUSTOMERID  ";
					sql = sql + " AND c.CHR_EMPID =a.CHR_REF  ORDER BY a.CHR_SALESNO";
					System.out.println("direct sale sql==="+sql);
					
			}
				//Direct Billing
				if(("2".equals(type)))
				{
					rptfilename = request.getParameter("rptfilename2");
					reportsDir = new File(Path + "/report/Inventory/Reports1/" + rptfilename+".jrxml");
							
					sql = " SELECT a.CHR_SALESNO,a.DOU_NETAMOUNT,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID), a.CHR_PAYMENTSTATUS,";
					sql = sql + " c.CHR_STAFFNAME,a.DOU_AMOUNT,e.CHR_COMPANYNAME,d.CHR_BRANCHNAME ,f.CHR_DIVICODE FROM inv_t_directbilling  a ,inv_m_customerinfo b ,com_m_staff c   ";
					sql = sql + " ,com_m_branch d ,com_m_company e,inv_m_division f  WHERE a.INT_BRANCHID = d.INT_BRANCHID  AND a.INT_DIVIID=f.INT_DIVIID AND d.INT_COMPANYID=e.INT_COMPANYID AND a.DAT_SALESDATE >= '"+dt+"' ";
					sql = sql + " AND a.DAT_SALESDATE<='"+dt2+"' ";
					
					if(!"0".equals(division))
						sql = sql + " AND a.INT_DIVIID="+division ;
					if(!"0".equals(custid))
						sql = sql + "  AND a.INT_CUSTOMERID="+custid ;
					if(!"0".equals(ref))
						sql = sql + "  AND a.CHR_REF ='"+ref+"' ";
					if(!"0".equals(Branch))
						sql = sql + "  AND a.INT_BRANCHID="+Branch ;
					
					
					sql = sql + " AND a.INT_CUSTOMERID = b.INT_CUSTOMERID  ";
					sql = sql + " AND c.CHR_EMPID =a.CHR_REF  ORDER BY a.CHR_SALESNO";
					//AND a.INT_BRANCHID="+branchid+"  
					System.out.println("sql2==="+sql);
				}
				
				//Service Billing
				if(("3".equals(type) ))
				{
					rptfilename = request.getParameter("rptfilename3");
					reportsDir = new File(Path + "/report/Inventory/Reports1/" + rptfilename+".jrxml");
					 		
					sql = " SELECT a.CHR_SALESNO,a.DOU_NETAMOUNT,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID), a.CHR_PAYMENTSTATUS,";
					sql = sql + " c.CHR_STAFFNAME,a.DOU_AMOUNT,e.CHR_COMPANYNAME,d.CHR_BRANCHNAME,f.CHR_DIVICODE FROM inv_t_servicebilling  a ,inv_m_customerinfo b ,com_m_staff c,com_m_branch d ,com_m_company e ,inv_m_division f ";
					sql = sql + "WHERE a.INT_BRANCHID = d.INT_BRANCHID AND d.INT_COMPANYID=e.INT_COMPANYID AND a.INT_DIVIID=f.INT_DIVIID  AND a.DAT_SALESDATE >='"+dt+"' ";
					sql = sql + " AND a.DAT_SALESDATE<='"+dt2+"' " ;
					if(!"0".equals(division))
						sql = sql + " AND a.INT_DIVIID="+division ;
					if(!"0".equals(custid))
						sql = sql + "  AND a.INT_CUSTOMERID="+custid ;
					if(!"0".equals(ref))
						sql = sql + "  AND a.CHR_REF ='"+ref+"' ";
					if(!"0".equals(Branch))
						sql = sql + "  AND a.INT_BRANCHID="+Branch ;
					
					 
					sql = sql + "  AND a.INT_CUSTOMERID = b.INT_CUSTOMERID  ";
					sql = sql + " AND c.CHR_EMPID =a.CHR_REF  ORDER BY a.CHR_SALESNO";
					//AND a.INT_BRANCHID="+branchid+"   
					System.out.println("sql3==="+sql);
				}
					System.out.println("sql:"+sql);
					
					
				
				String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				
			
				
				if(data.length>0)
					map.put("dataLength", "1");
				else
					map.put("dataLength", "0");
				
				jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportsDir, rptfilename, sql, con, Path,map);
				ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
				
				}
				
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