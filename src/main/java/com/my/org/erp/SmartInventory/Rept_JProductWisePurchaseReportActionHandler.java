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

public class Rept_JProductWisePurchaseReportActionHandler extends AbstractActionHandler 
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
	String stockType;
	String paymentStatus;
	String icode;
	
	
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String rptfilename1 = request.getParameter("rptfilename1");
			String reporttype = request.getParameter("reportType");
				
			if (action.equals("INVRept_JProductWisePurchaseReport")) 
			{
				System.out.println("Rept_JProductWisePurchaseReport");
				File reportsDir = new File(Path + "/report/Inventory/Reports1/" + rptfilename+".jrxml");
				File reportsDir1 = new File(Path + "/report/Inventory/Reports1/" + rptfilename1+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				String hyperlinkPath=Path + "/report/Inventory/ViewDirectPurchase.jsp";
				map.put("hyperlinkPath", hyperlinkPath);
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				
				String branchid = request.getParameter("Branch");
				String division = request.getParameter("division");
				String vendor = request.getParameter("vendor");
				String payment = request.getParameter("payment");
				String account = request.getParameter("account");
				String itype = request.getParameter("itype");
				String item = request.getParameter("item");
				System.out.println("item:"+item);
				
				String fromdate = request.getParameter("fromdate");
				String todate = request.getParameter("todate");
				fromdate= DateUtil.FormateDateSQL(fromdate);
				todate=  DateUtil.FormateDateSQL(todate);
				String sql ="";
				  
				
				if(!branchid.equals("0"))
				{String shipids[][] = CommonFunctions.QueryExecutecon(con,"Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID and a.INT_BRANCHID="+branchid);
				map.put("cpy", shipids[0][2]+"@"+shipids[0][1]);
				}
				else
					map.put("cpy", "All Companies");
				//String division1[][] = com.mythra.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE");
				if(!division.equals("0"))
					divName= CommonFunctions.QueryExecutecon(con,"Select INT_DIVIID,CHR_DIVICODE from inv_m_division  WHERE INT_DIVIID >0 AND INT_DIVIID= "+division)[0][1];
				else
					divName="All Divisions";
				if(!vendor.equals("0"))
					venName = CommonFunctions.QueryExecutecon(con,"Select INT_VENDORID,CHR_VENDORNAME from  inv_m_vendorsinformation WHERE INT_VENDORID = "+vendor)[0][1];
				else
					venName="All Vendors";
				
				
				if(payment.equals("0"))
					paymentStatus="All Payment Status";
				else if(payment.equals("Y"))
					paymentStatus="Completed";
				else if(payment.equals("N"))
					paymentStatus="Partially Completed";
				else if(payment.equals("P"))
					paymentStatus="Pending";
				
				if(account.equals("0"))
					accFlag="Both";
				else if(account.equals("Y"))
					accFlag="Received";
				else 
					accFlag="Not Received";
				
				
				 if(itype.equals("1"))
					stockType="Item";
				else 
					stockType="Product";
				 
				 if(!item.equals("0"))
						icode=item;
				
				 else if(item.equals("0")&& itype.equals("1"))
						icode="All Items";
				 else if(item.equals("0")&& itype.equals("2"))
						icode="All Products";
				
				
				map.put("division", divName);
				map.put("vendor", venName);
				map.put("paymentStatus", paymentStatus);
				map.put("accountFlag", accFlag);
				map.put("stockType", stockType);
				
				map.put("fromDt", fromdate);
				map.put("toDt", todate);
				
				

				if("1".equals(itype))
				{
					sql = "";
					sql = "SELECT FUN_GET_BRANCH_WITH_COMPANY_NAME(c.INT_BRANCHID),a.CHR_ITEMNAME,b.CHR_GROUPNAME,a.CHR_DES,c.CHR_PURCHASEORDERNO,DATE_FORMAT(c.DAT_ORDERDATE,'%d-%b-%Y'),d.CHR_DIVICODE,e.CHR_VENDORNAME,"; 
					sql = sql +" f.INT_QUANTITY,f.DOU_UNITPRICE, f.DOU_TOTAL,c.DOU_AMOUNT,c.DOU_TAXAMOUNT,c.DOU_TOTALAMOUNT,c.CHR_PAYMENTSTATUS,c.CHR_ACCOUNTFLAG   "; 
					sql = sql +" FROM inv_m_item a ,inv_m_itemgroup b,inv_t_directpurchase c,inv_m_division d, inv_m_vendorsinformation  e,inv_t_directpurchaseitem f   "; 
					sql = sql +" WHERE a.INT_ITEMGROUPID=b.INT_ITEMGROUPID    "; 
					sql = sql +" AND c.INT_DIVIID = d.INT_DIVIID   "; 
					sql = sql +" AND c.INT_VENDORID = e.INT_VENDORID   "; 
					sql = sql +" AND c.CHR_PURCHASEORDERNO =f.CHR_PURCHASEORDERNO   "; 
					sql = sql +" AND a.CHR_ITEMID = f.CHR_ITEMID    "; 
					sql = sql +" AND f.CHR_TYPE='I'   "; 
					if(!"0".equals(division))
						sql = sql +" AND c.INT_DIVIID= "+division ;	
						
					if(!"0".equals(vendor))
						sql = sql +" AND c.INT_VENDORID= "+vendor ;		
						
					if(!"0".equals(branchid))
						sql = sql + " AND c.INT_BRANCHID = "+branchid ;
					if(!"0".equals(account))
						sql = sql + " AND c.CHR_ACCOUNTFLAG = '"+account+"' " ;
					
					if(!"0".equals(payment))
						sql = sql + " AND c.CHR_PAYMENTSTATUS = '"+payment+"' " ;
						
					if(!"0".equals(item))
						sql = sql + " AND a.CHR_ITEMID = '"+item+"' " ;	
						
					sql = sql +" AND c.DAT_ORDERDATE >='"+fromdate+"' AND c.DAT_ORDERDATE <='"+todate+"'  ";
					sql = sql +" ORDER BY a.CHR_ITEMNAME  ";
					System.out.println("sql1:"+sql);
					
					String data[][] =  CommonFunctions.QueryExecute(sql);
					if(data.length>0){
						map.put("dataLength", "1");
						
					}
					else
						map.put("dataLength", "0");
					String itemNameSql="Select UPPER(CHR_ITEMNAME) from inv_m_item   WHERE CHR_ITEMID="+item;
					String data1[][] =  CommonFunctions.QueryExecute(itemNameSql);	
					if(data1.length>0)
						map.put("icode", data1[0][0]);	
					else
						map.put("icode", "All "+stockType+"s");	
					
					System.out.println("rptfilename:"+rptfilename);
					
					jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportsDir, rptfilename, sql, con, Path,map);
					ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
				}
				if("2".equals(itype))
				{
					sql = " SELECT FUN_GET_BRANCH_WITH_COMPANY_NAME(c.INT_BRANCHID),a.CHR_PRODUCTCODE,b.CHR_NAME,a.CHR_PRODUCTDESC ,c.CHR_PURCHASEORDERNO, DATE_FORMAT(c.DAT_ORDERDATE,'%d-%b-%Y'),d.CHR_DIVICODE,e.CHR_VENDORNAME, ";
					sql = sql +" f.INT_QUANTITY,f.DOU_UNITPRICE, f.DOU_TOTAL,c.DOU_AMOUNT,c.DOU_TAXAMOUNT,c.DOU_TOTALAMOUNT,c.CHR_PAYMENTSTATUS,c.CHR_ACCOUNTFLAG ";
					sql = sql +" FROM  inv_m_produtlist a ,inv_m_productgroup b,inv_t_directpurchase c,inv_m_division d, inv_m_vendorsinformation  e,inv_t_directpurchaseitem f ";
					sql = sql +" WHERE a.INT_PRODUCTGROUPID=b.INT_PRODUCTGROUPID  ";
					sql = sql +" AND c.INT_DIVIID = d.INT_DIVIID ";
					sql = sql +" AND c.INT_VENDORID = e.INT_VENDORID ";
					sql = sql +" AND c.CHR_PURCHASEORDERNO =f.CHR_PURCHASEORDERNO ";
					sql = sql +" AND a.CHR_PRODUCTID = f.CHR_ITEMID  ";
					sql = sql +" AND f.CHR_TYPE='P' ";
					if(!"0".equals(division))
						sql = sql +" AND c.INT_DIVIID= "+division ;	
					if(!"0".equals(vendor))
						sql = sql +" AND c.INT_VENDORID= "+vendor ;	
					if(!"0".equals(branchid))
						sql = sql + " AND c.INT_BRANCHID = "+branchid ;
					if(!"0".equals(account))
						sql = sql + " AND c.CHR_ACCOUNTFLAG = '"+account+"' " ;
					
					if(!"0".equals(payment))
						sql = sql + " AND c.CHR_PAYMENTSTATUS = '"+payment+"' " ;
					
					if(!"0".equals(item))
						sql = sql + " AND a.CHR_PRODUCTID = '"+item+"' " ;	
						
					sql = sql +" AND c.DAT_ORDERDATE >='"+fromdate+"' AND c.DAT_ORDERDATE <='"+todate+"'  ";
					sql = sql +" ORDER BY a.CHR_PRODUCTCODE  ";
					System.out.println("sql2:"+sql);
					
					String data[][] =  CommonFunctions.QueryExecute(sql);
					if(data.length>0)
						map.put("dataLength", "1");
					else
						map.put("dataLength", "0");
					
					String productNameSql="select UPPER(CHR_PRODUCTCODE) from inv_m_produtlist  WHERE CHR_PRODUCTID="+item;
					String data1[][] = CommonFunctions.QueryExecute(productNameSql);
					if(data1.length>0)
						map.put("icode", data1[0][0]);	
					else
						map.put("icode", "All "+stockType+"s");	
				
					
					System.out.println("rptfilename1:"+rptfilename1);
					
					jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportsDir1, rptfilename1, sql, con, Path,map);
					ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename1);
				
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