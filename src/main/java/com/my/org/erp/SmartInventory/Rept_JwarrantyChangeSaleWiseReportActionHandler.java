package com.my.org.erp.SmartInventory;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List; 
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

public class Rept_JwarrantyChangeSaleWiseReportActionHandler extends AbstractActionHandler 
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
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
		 		
			if (action.equals("INVRept_JwarrantyChangeSaleWiseReport")) 
			{
				try 
				{ 
				System.out.println("INVRept_JwarrantyChangeSaleWiseReport");
				
				File reportsDir = new File(Path + "/report/Inventory/Reports1/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				List<Hashtable> al=new ArrayList<Hashtable>();
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
							
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportsDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
						//String company= request.getParameter("company");
						String Branch = request.getParameter("Branch");
						String itype = request.getParameter("itype");
						String pgroup = request.getParameter("pgroup");
						String item = request.getParameter("item");
						String fromdate = request.getParameter("fromdate");
						String todate = request.getParameter("todate");
						 
						
						String sql="";
						if("1".equals(itype))
						{
							sql = "";
							sql = sql + " SELECT g.CHR_COMPANYNAME,h.CHR_BRANCHNAME,if(a.CHR_TYPE='I','Item','Product'),a.CHR_ITEMID,f.CHR_GROUPNAME mgroup,e.CHR_ITEMNAME mmodel,a.CHR_SERIALNO,a.CHR_SALESNO, " ;
							sql = sql + " a.DOU_UNITPRICE,a.CHR_QUALITY,a.CHR_PURCHASE_WARRANTY ,a.CHR_WARRANTY, " ;
							sql = sql + " b.DAT_SALESDATE,b.DOU_TOTALAMOUNT,FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID),d.CHR_DIVICODE " ;
							sql = sql + " FROM inv_t_vendorgoodsreceived a,inv_t_directsales b,inv_m_customerinfo c,inv_m_division d,inv_m_item e,inv_m_itemgroup f,com_m_company g,com_m_branch h " ;
							sql = sql + " WHERE a.CHR_SALESNO =b.CHR_SALESNO AND b.INT_CUSTOMERID =c.INT_CUSTOMERID AND b.INT_DIVIID = d.INT_DIVIID AND a.CHR_TYPE='I' " ;
							sql = sql + " AND a.CHR_ITEMID=e.CHR_ITEMID AND e.INT_ITEMGROUPID= f.INT_ITEMGROUPID  AND g.INT_COMPANYID = h.INT_COMPANYID AND a.INT_BRANCHID = h.INT_BRANCHID " ;
							sql = sql + " AND b.DAT_SALESDATE <='"+DateUtil.FormateDateSQL(todate)+"' ";
							sql = sql + " AND b.DAT_SALESDATE >='"+DateUtil.FormateDateSQL(fromdate)+"' ";
							if(!"0".equals(Branch))
								sql = sql + " AND a.INT_BRANCHID ="+Branch;
							if(!"0".equals(pgroup))
								sql = sql + " AND f.INT_ITEMGROUPID ="+pgroup;
							if(!"0".equals(item))
								sql = sql + " AND a.CHR_ITEMID ="+item;
							sql = sql + " AND a.CHR_WARRANTY != a.CHR_PURCHASE_WARRANTY ORDER BY a.DAT_RECIVEDDATE,a.CHR_TYPE,a.CHR_ITEMID" ;
							 
						}
						else
						{
							sql = "";
							sql = sql + " SELECT g.CHR_COMPANYNAME,h.CHR_BRANCHNAME,if(a.CHR_TYPE='I','Item','Product'),a.CHR_ITEMID,f.CHR_NAME mgroup,e.CHR_PRODUCTCODE mmodel,a.CHR_SERIALNO, " ;
							sql = sql + " a.CHR_SALESNO,a.DOU_UNITPRICE,a.CHR_QUALITY,a.CHR_PURCHASE_WARRANTY,a.CHR_WARRANTY , " ;
							sql = sql + "b.DAT_SALESDATE,b.DOU_TOTALAMOUNT,FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID),d.CHR_DIVICODE FROM inv_t_vendorgoodsreceived a , " ;
							sql = sql + "inv_t_directsales b  , inv_m_customerinfo c,inv_m_division d,inv_m_produtlist e,inv_m_productgroup f,com_m_company g ,com_m_branch h  " ;
							sql = sql + "WHERE a.CHR_SALESNO =b.CHR_SALESNO " ;
							sql = sql + " AND b.INT_CUSTOMERID =c.INT_CUSTOMERID  AND b.INT_DIVIID = d.INT_DIVIID AND a.CHR_TYPE='p' 	AND a.CHR_ITEMID=e.CHR_PRODUCTID " ;
							sql = sql + "AND e.INT_PRODUCTGROUPID= f.INT_PRODUCTGROUPID AND g.INT_COMPANYID = h.INT_COMPANYID AND a.INT_BRANCHID = h.INT_BRANCHID  " ;
							sql = sql + " AND b.DAT_SALESDATE <='"+DateUtil.FormateDateSQL(todate)+"'  ";
							sql = sql + " AND b.DAT_SALESDATE >='"+DateUtil.FormateDateSQL(fromdate)+"'  " ;
							if(!"0".equals(Branch))
								sql = sql + " AND a.INT_BRANCHID ="+Branch;
							if(!"0".equals(pgroup))
								sql = sql + " AND f.INT_PRODUCTGROUPID ="+pgroup;
							if(!"0".equals(item))
								sql = sql + " AND a.CHR_ITEMID ="+item;
								sql = sql + " AND a.CHR_WARRANTY != a.CHR_PURCHASE_WARRANTY ORDER BY a.DAT_RECIVEDDATE,a.CHR_TYPE,a.CHR_ITEMID " ;
							 
						}			
						String data1[][]=CommonFunctions.QueryExecute(sql);
						System.out.println("Sql:"+sql);
						if(data1.length<=0)
							map.put("dataLength", "0");
						else
							map.put("dataLength", "1");
						
						if(!"0".equals(Branch))
						{
							String data[][] = CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID ="+Branch);
							System.out.println("Sql:"+sql);
							if(!data[0][0].equals(null))
									map.put("company",data[0][2]+" @ "+data[0][1]);
						}
						else
							map.put("company","All Companies");
						if(itype.equals("1"))
							map.put("stockType", "Item");
						else 
							map.put("stockType", "Product");
						if("1".equals(itype))
						{
							if(!"0".equals(pgroup))
							{
							String data[][] = CommonFunctions.QueryExecute("Select INT_ITEMGROUPID,replace(UPPER(CHR_GROUPNAME),'&','AND') from inv_m_itemgroup   WHERE INT_ITEMGROUPID="+pgroup);
							
							if(!data[0][0].equals(null))
									map.put("pgroup",data[0][1]);
							}
							else
									map.put("pgroup","All Item Groups");
							if(!"0".equals(item))
							{
								String data[][] = CommonFunctions.QueryExecute("SELECT CHR_ITEMID,replace(UPPER(CHR_ITEMNAME),'&','AND') FROM inv_m_item   WHERE CHR_ITEMID='"+item+"'");
								
								if(!data[0][0].equals(null))
										map.put("item",data[0][1]);
							}
							else
								map.put("item","All Items");
						}
						else
							{
							if(!"0".equals(pgroup))
							{
							String data[][] = CommonFunctions.QueryExecute("select INT_PRODUCTGROUPID,replace(UPPER(CHR_NAME),'&','AND')from inv_m_productgroup   WHERE INT_PRODUCTGROUPID="+pgroup);
							
							if(!data[0][0].equals(null))
									map.put("pgroup",data[0][1]);
							}
							else
								map.put("pgroup","All Product Groups");
							if(!"0".equals(item))
							{
								String data[][] = CommonFunctions.QueryExecute("SELECT CHR_PRODUCTID,replace(UPPER(CHR_PRODUCTCODE),'&','AND')FROM inv_m_produtlist  WHERE  CHR_PRODUCTID='"+item+"'");
								
								if(!data[0][0].equals(null))
										map.put("item",data[0][1]);
							}
							else
								map.put("item","All Products");
							}
						
					
						map.put("fdate", fromdate);
						map.put("tdate", todate);
					jasperPrint=ReportFunctions.createReport(jasperPrint, request, response, reportsDir, rptfilename, sql, con, Path,map);
					ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
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
}

	