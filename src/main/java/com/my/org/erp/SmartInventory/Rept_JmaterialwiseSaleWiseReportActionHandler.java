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

public class Rept_JmaterialwiseSaleWiseReportActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	JRExporter exporter;
	String cmpyname="";
	String officename="";
	String deptname="";
	String hImageExpression="";
	String fImageExpression="";
	String showRef="";
	
	
	
	@SuppressWarnings({ "unused", "rawtypes" })
	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
				
			if (action.equals("INVRept_JmaterialwiseSaleWiseReport")) 
			{
				try 
				{ 
				System.out.println("INVRept_JmaterialwiseSaleWiseReport");
				
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
						String division = request.getParameter("division");
						String itype = request.getParameter("itype");
						String pgroup = request.getParameter("pgroup");
						String item = request.getParameter("item");
						String fromdate = request.getParameter("fromdate");
						String todate = request.getParameter("todate");
						String stockType="";
						String itemname="";
						
						String sql="";
						if("1".equals(itype))
						{
							map.put("mtype", "Item");
							sql = "";
							sql = " SELECT  f.CHR_GROUPNAME mgroup,c.CHR_ITEMNAME mmodel,c.CHR_DES mdesc,d.CHR_DIVICODE,a.CHR_SALESNO,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID), b.INT_QUANTITY, DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'), ";
							sql = sql +" b.DOU_UNITPRICE,b.DOU_TOTAL,a.DOU_AMOUNT,a.DOU_TAXAMOUNT,a.DOU_TOTALAMOUNT ";
							sql = sql +" from inv_t_directsales a,inv_t_swapsalesitem b,inv_m_item c,inv_m_division d,inv_m_customerinfo e,inv_m_itemgroup f ";
							sql = sql +" WHERE a.CHR_SALESNO = b.CHR_SALESNO  AND b.CHR_TYPE ='I'  AND a.INT_SALESSTATUS=1 ";
							sql = sql +" AND b.CHR_ITEMID =c.CHR_ITEMID   "; 
							sql = sql +" AND a.INT_DIVIID= d.INT_DIVIID  ";
							sql = sql +" AND a.INT_CUSTOMERID = e.INT_CUSTOMERID ";
							sql = sql +" AND c.INT_ITEMGROUPID = f.INT_ITEMGROUPID ";
							if(!"0".equals(item))
								sql = sql +" AND b.CHR_ITEMID=   '"+item+"' ";
							if(!"0".equals(division))
								sql = sql +" AND a.INT_DIVIID= "+division ;	
							sql = sql +" AND a.INT_BRANCHID=   "+Branch;
							sql = sql +" AND a.DAT_SALESDATE >='"+DateUtil.FormateDateSQL(fromdate)+"' AND a.DAT_SALESDATE <='"+DateUtil.FormateDateSQL(todate)+"'  ";
							sql = sql +" ORDER BY b.CHR_ITEMID  ";
							
						}
						else
						{
							map.put("mtype", "Product");
							sql = " SELECT  f.CHR_NAME mgroup,c.CHR_PRODUCTCODE mmodel,c.CHR_PRODUCTDESC mdesc,d.CHR_DIVICODE,a.CHR_SALESNO,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID), b.INT_QUANTITY, DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'), ";
							sql = sql +" b.DOU_UNITPRICE,b.DOU_TOTAL,a.DOU_AMOUNT,a.DOU_TAXAMOUNT,a.DOU_TOTALAMOUNT ";
							sql = sql +" from inv_t_directsales a,inv_t_swapsalesitem b,inv_m_produtlist c,inv_m_division d,inv_m_customerinfo e,inv_m_productgroup f ";
							sql = sql +" WHERE a.CHR_SALESNO = b.CHR_SALESNO  AND b.CHR_TYPE ='P' AND a.INT_SALESSTATUS=1  ";
							sql = sql +" AND b.CHR_ITEMID =c.CHR_PRODUCTID  ";
							sql = sql +" AND a.INT_DIVIID= d.INT_DIVIID  ";
							sql = sql +" AND a.INT_CUSTOMERID = e.INT_CUSTOMERID ";
							sql = sql +" AND c.INT_PRODUCTGROUPID = f.INT_PRODUCTGROUPID ";
							if(!"0".equals(item))
								sql = sql +" AND b.CHR_ITEMID=   '"+item+"' ";
							sql = sql +" AND a.INT_BRANCHID=   "+Branch;
							if(!"0".equals(division))
								sql = sql +" AND a.INT_DIVIID= "+division ;	
							sql = sql +" AND a.DAT_SALESDATE >='"+DateUtil.FormateDateSQL(fromdate)+"' AND a.DAT_SALESDATE <='"+DateUtil.FormateDateSQL(todate)+"'  ";
							sql = sql +" ORDER BY b.CHR_ITEMID  ";
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

	