package com.my.org.erp.SmartInventory;
import java.awt.Color;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRMapCollectionDataSource;
import net.sf.jasperreports.engine.util.SimpleFileResolver;
import ar.com.fdvs.dj.core.DynamicJasperHelper;
import ar.com.fdvs.dj.core.layout.ClassicLayoutManager;
import ar.com.fdvs.dj.domain.DynamicReport;
import ar.com.fdvs.dj.domain.Style;
import ar.com.fdvs.dj.domain.builders.ColumnBuilder;
import ar.com.fdvs.dj.domain.builders.DynamicReportBuilder;
import ar.com.fdvs.dj.domain.constants.Border;
import ar.com.fdvs.dj.domain.constants.Font;
import ar.com.fdvs.dj.domain.constants.HorizontalAlign;
import ar.com.fdvs.dj.domain.constants.VerticalAlign;
import ar.com.fdvs.dj.domain.entities.columns.AbstractColumn;
import com.ibm.icu.text.DecimalFormatSymbols;
import com.ibm.icu.text.NumberFormat;
import com.ibm.icu.text.DecimalFormat;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JProductwiseDetailSaleReportActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	protected JasperReport jr;
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
			
			if (action.equals("INVRept_JProductwiseDetailSaleReport")) 
			{	
				String path=Path + "/report/Inventory/SalePaymentReports/" + rptfilename+".jrxml";
				File reportDir = new File(Path + "/report/Inventory/SalePaymentReports/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				String Branch = request.getParameter("Branch");
				String division = request.getParameter("division");
				String itype = request.getParameter("itype");
				String item = request.getParameter("item");
				String month = request.getParameter("month");
				String year = request.getParameter("year");
				int columnCount=0;
								
				if (!reportDir.exists()) 
				{
				    throw new FileNotFoundException(String.valueOf(reportDir));
				}
				
				File headerImage = new File(Path + "/images/hImage.jpg");
				File footerImage = new File(Path + "/images/fImage.jpg");
				
				hImageExpression=(headerImage.exists())?"../../images/hImage.jpg":null;
				fImageExpression=(footerImage.exists())?"../../images/fImage.jpg":null;
								
				map.put(JRParameter.REPORT_FILE_RESOLVER, new SimpleFileResolver(reportDir));
				map.put("hImageExpression", hImageExpression);
				map.put("fImageExpression", fImageExpression);
				if(!"0".equals(month))
					map.put("month", DateUtil.getMonth(Integer.parseInt(month)));
				else
					map.put("month","All Months");
				if(!"0".equals(year))
					map.put("year", year);
				else
					map.put("year", "All Years");
				
				String sql= "";
				String data1[][]=null,data2[][]=null;
				List<HashMap<String,String>> al=new ArrayList<HashMap<String,String>>();
		
		    NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("en", "IN"));
		    DecimalFormatSymbols decimalFormatSymbols = ((DecimalFormat) formatter).getDecimalFormatSymbols();
		    decimalFormatSymbols.setCurrencySymbol("");
		    ((DecimalFormat) formatter).setDecimalFormatSymbols(decimalFormatSymbols);
			
		    Double c=0.00,c1=0.00,c2=0.00,c3=0.00,c4=0.00,c5=0.00;		
		    if("1".equals(itype))
			{
		    	map.put("producttype","Item");
		    	sql = "  SELECT a.CHR_TYPE,FUN_GET_BRANCH_NAME(d.INT_BRANCHID),FUN_INV_DIVISION(d.INT_DIVIID),a.CHR_SALESNO,FIND_A_CUSTOMER_NAME(d.INT_CUSTOMERID),c.CHR_GROUPNAME,b.CHR_ITEMNAME,a.CHR_DESC,'Full Product' ," +
		    			" DATE_FORMAT(d.DAT_SALESDATE,'%d-%b-%Y'),  a.INT_QUANTITY,a.DOU_UNITPRICE, a.DOU_DISCOUNT,a.DOU_UNITDISCOUNT," +
		    			"a.DOU_TAX_PERCENTAGE,  a.DOU_TAX_AMOUNT,a.DOU_TOTAL,a.CHR_SWAP ";
		    	sql = sql +" FROM  ";
				sql = sql +" inv_t_swapsalesitem a,inv_m_item b , inv_m_itemgroup c, inv_t_directsales d,inv_m_customerinfo e ";
				sql = sql +" WHERE a.CHR_ITEMID = b.CHR_ITEMID AND a.CHR_TYPE='I' AND d.INT_SALESSTATUS =1  AND d.CHR_CANCEL='N' ";
				sql = sql +" AND b.INT_ITEMGROUPID = c.INT_ITEMGROUPID ";
				sql = sql +" AND a.CHR_SALESNO = d.CHR_SALESNO ";
				sql = sql +" AND d.INT_CUSTOMERID = e.INT_CUSTOMERID ";
				if(!"0".equals(item))
					sql = sql +" AND  a.CHR_ITEMID ='"+item+"' ";
				if(!"0".equals(division))
					sql = sql+" AND d.INT_DIVIID="+division;	
				if(!"0".equals(Branch))
					sql = sql+ "  AND  d.INT_BRANCHID = "+Branch;	
				if(!"0".equals(month))
					sql = sql+ "  AND  MONTH(d.DAT_SALESDATE) = "+month;	
				if(!"0".equals(year))
					sql = sql+ "  AND  YEAR(d.DAT_SALESDATE) = "+year;		
				sql = sql+ "  ORDER BY b.CHR_ITEMID    ";
				System.out.println("sql1:"+sql);
				columnCount=CommonFunctions.intGetColumnCount(sql);
				System.out.println("columnCount:"+columnCount);
				data1 = CommonFunctions.QueryExecute(sql);
				
				if(data1.length>0)
				for(int i=0;i<=data1.length;i++)
				{
					HashMap<String,String> h3 = new HashMap<String,String>();
					if(i!=data1.length)
					{
					for(int j=0;j<=columnCount;j++)
					{
						if(j==0)
						{
							h3.put("d"+j,Integer.toString(i+1));
						}
						else if(j==1)
						{
							h3.put("d"+j,"Item");
						}
						
						else if(j==12)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
							c+=Double.parseDouble(data1[i][11]);
						}
						else if(j==13)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
							c1+=Double.parseDouble(data1[i][12]);
						}
						else if(j==14)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
							c2+=Double.parseDouble(data1[i][13]);
						}
						else if(j==15)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
							c3+=Double.parseDouble(data1[i][14]);
						}
						else if(j==16)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
							c4+=Double.parseDouble(data1[i][15]);
						}
						else if(j==17)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
							c5+=Double.parseDouble(data1[i][16]);
						}
						else if(j==18)
						{							
						if("Y".equals(data1[i][j-1]))
							h3.put("d"+j,"Swap");
						else
							h3.put("d"+j,"");
						}
						else
							h3.put("d"+j,data1[i][j-1]);
										
					}
					}
					else
					{
						if(i==data1.length )
						{
						h3.put("d11", "Grand Total :");
						h3.put("d12", formatter.format(c));
						h3.put("d13", formatter.format(c1));
						h3.put("d14", formatter.format(c2));
						h3.put("d15", formatter.format(c3));
						h3.put("d16", formatter.format(c4));
						h3.put("d17", formatter.format(c5));
						}
					}
					al.add(h3);
				}
				
			}
			if("2".equals(itype))
			{
				map.put("producttype","Product");
				sql = "  SELECT a.CHR_TYPE,FUN_GET_BRANCH_NAME(d.INT_BRANCHID),FUN_INV_DIVISION(d.INT_DIVIID),a.CHR_SALESNO,FIND_A_CUSTOMER_NAME(d.INT_CUSTOMERID),c.CHR_NAME,b.CHR_PRODUCTCODE,a.CHR_DESC,b.CHR_PTYPE," +
						" DATE_FORMAT(d.DAT_SALESDATE,'%d-%b-%Y'),  a.INT_QUANTITY,a.DOU_UNITPRICE, a.DOU_DISCOUNT,a.DOU_UNITDISCOUNT," +
						"a.DOU_TAX_PERCENTAGE,  a.DOU_TAX_AMOUNT,a.DOU_TOTAL,a.CHR_SWAP ";
				sql = sql+ "  FROM     ";
				sql = sql+ "  inv_t_swapsalesitem a,inv_m_produtlist b , inv_m_productgroup c, inv_t_directsales d,inv_m_customerinfo e ";
				sql = sql+ "  WHERE a.CHR_ITEMID = b.CHR_PRODUCTID AND a.CHR_TYPE='P' AND d.INT_SALESSTATUS =1 AND d.CHR_CANCEL='N' ";
				sql = sql+ "  AND b.INT_PRODUCTGROUPID = c.INT_PRODUCTGROUPID    ";
				sql = sql+ "  AND a.CHR_SALESNO = d.CHR_SALESNO ";
				sql = sql+ "  AND d.INT_CUSTOMERID = e.INT_CUSTOMERID ";
				if(!"0".equals(item))
					sql = sql +" AND  a.CHR_ITEMID ='"+item+"' ";
				if(!"0".equals(division))
					sql = sql+" AND d.INT_DIVIID="+division;	
				if(!"0".equals(Branch))
					sql = sql+ "  AND  d.INT_BRANCHID = "+Branch;	
				if(!"0".equals(month))
					sql = sql+ "  AND  MONTH(d.DAT_SALESDATE) = "+month;	
				if(!"0".equals(year))
					sql = sql+ "  AND  YEAR(d.DAT_SALESDATE) = "+year;		
				sql = sql+ "  ORDER BY b.CHR_PRODUCTID    ";
				
				System.out.println("sql2:"+sql);
				columnCount=CommonFunctions.intGetColumnCount(sql);
				System.out.println("columnCount:"+columnCount);
				data2 = CommonFunctions.QueryExecute(sql);
								 
				if(data2.length>0)
				for(int i=0;i<=data2.length;i++)
				{
					HashMap<String,String> h3 = new HashMap<String,String>();
					if(i!=data2.length)
					{
					for(int j=0;j<=columnCount;j++)
					{
						if(j==0)
						{
							h3.put("d"+j,Integer.toString(i+1));
						}
						else if(j==1)
						{
							h3.put("d"+j,"Product");
						}
						else if(j==9)
						{							
						if("S".equals(data2[i][j-1]))
							h3.put("d"+j,"Consumables");
						else if("F".equals(data2[i][j-1]))
							h3.put("d"+j,"Full Product");
						else
							h3.put("d"+j,"Combination");
						}
						else if(j==12)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data2[i][j-1])));
							c+=Double.parseDouble(data2[i][11]);
						}
						else if(j==13)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data2[i][j-1])));
							c1+=Double.parseDouble(data2[i][12]);
						}
						else if(j==14)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data2[i][j-1])));
							c2+=Double.parseDouble(data2[i][13]);
						}
						else if(j==15)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data2[i][j-1])));
							c3+=Double.parseDouble(data2[i][14]);
						}
						else if(j==16)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data2[i][j-1])));
							c4+=Double.parseDouble(data2[i][15]);
						}
						else if(j==17)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data2[i][j-1])));
							c5+=Double.parseDouble(data2[i][16]);
						}
						else if(j==18)
						{							
						if("Y".equals(data2[i][j-1]))
							h3.put("d"+j,"Swap");
						else
							h3.put("d"+j,"");
						}
						else
							h3.put("d"+j,data2[i][j-1]);
										
					}
					}
					else
					{
						if(i==data2.length )
						{
						h3.put("d11", "Grand Total :");
						h3.put("d12", formatter.format(c));
						h3.put("d13", formatter.format(c1));
						h3.put("d14", formatter.format(c2));
						h3.put("d15", formatter.format(c3));
						h3.put("d16", formatter.format(c4));
						h3.put("d17", formatter.format(c5));
						}
					}
					al.add(h3);
				}
			
			}	
			if(!"0".equals(Branch))
				{
					data1 = CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID ="+Branch);
					if(!data1[0][0].equals(""))
							map.put("company",data1[0][2]+" @ "+data1[0][1]);
				}
				else
					map.put("company","All Companies");
				if(!"0".equals(division))
				{
					 data1 = CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND INT_DIVIID="+division);
					if(!data1[0][0].equals(""))
							map.put("division",data1[0][1]);
				}
				else
					map.put("division","All Divisions");
				if (itype.equals("1"))
				if(!"0".equals(item))
				{
					System.out.println("item:"+item);
					data1 = CommonFunctions.QueryExecute("Select replace(UPPER(CHR_ITEMNAME),'&','AND') from inv_m_item   WHERE INT_ACTIVE=1  AND CHR_ITEMID='"+item+"'");
					if(!data1[0][0].equals(""))
							map.put("productcode",data1[0][0]);
				}
				else
					map.put("productcode","All Product Codes");
				if (itype.equals("2"))
					if(!"0".equals(item))
					{
						System.out.println("Product:"+item);
						data1 = CommonFunctions.QueryExecute("select replace(UPPER(CHR_PRODUCTCODE),'&','AND')from inv_m_produtlist  WHERE INT_ACTIVE=1 AND CHR_PRODUCTID='"+item+"'");
						if(!data1[0][0].equals(""))
								map.put("productcode",data1[0][0]);
					}
					else
						map.put("productcode","All Product Codes");
				
							
				  try {
					  DynamicReportBuilder drb = new DynamicReportBuilder();
					  Font font = new Font(8,"Times New Roman",true);
					  Style headerStyle = new Style();
					  headerStyle.setFont(font);
					  headerStyle.setHorizontalAlign(HorizontalAlign.CENTER);
					  headerStyle.setVerticalAlign(VerticalAlign.MIDDLE);
					  headerStyle.setBorder(Border.PEN_1_POINT);
					  Color veryLightGrey = new Color(230, 230, 230);
					  headerStyle.setBackgroundColor(veryLightGrey);
					  font = new Font(7,"Verdana",false);
					  Style detailstyle = new Style();
					  detailstyle.setFont(font);
					  detailstyle.setHorizontalAlign(HorizontalAlign.LEFT);
					  detailstyle.setVerticalAlign(VerticalAlign.MIDDLE);
					  detailstyle.setBorder(Border.THIN);
					  detailstyle.setBackgroundColor(Color.cyan);
					  
					  Style amountstyle = new Style();
					  amountstyle.setFont(font);
					  amountstyle.setHorizontalAlign(HorizontalAlign.RIGHT);
					  amountstyle.setVerticalAlign(VerticalAlign.MIDDLE);
					  amountstyle.setBorder(Border.THIN);
					  
					  Style numberstyle = new Style();
					  numberstyle.setFont(font);
					  numberstyle.setHorizontalAlign(HorizontalAlign.CENTER);
					  numberstyle.setVerticalAlign(VerticalAlign.MIDDLE);
					  numberstyle.setBorder(Border.THIN);
					  
					  String title[]={"S.No.","Product Type","Branch","Division","Sale No","Customer","Product Group","Product Code","Product Description","Category",
							  "Sale Date","Quantity","Unit Price","Discount","Unit Discount","Tax(%)","Tax Amount","Total","Swap"};
					  int datawidth[]={35,30,70,70,100,120,70,70,120,60,50,30,60,50,50,50,50,70,20};
					  
					  Style list[]={detailstyle,detailstyle,detailstyle,detailstyle,detailstyle,detailstyle,detailstyle,detailstyle,detailstyle,detailstyle,numberstyle,detailstyle,
							  amountstyle,amountstyle,amountstyle,amountstyle,amountstyle,amountstyle,detailstyle};
					 
					  for(int u=0;u<=columnCount;u++)
					  {
						  @SuppressWarnings("deprecation")
						  AbstractColumn AllowanceCol = ColumnBuilder.getInstance()
						  .setColumnProperty("d"+u, String.class.getName())
					      .setTitle(title[u]).setWidth(datawidth[u])
					      .setStyle(list[u]).setHeaderStyle(headerStyle).build();
					      drb.addColumn(AllowanceCol);
					  }
					  		
					  drb.setUseFullPageWidth(true);
					  drb.setTemplateFile(path);
					  DynamicReport dr = drb.build();
					  jr = DynamicJasperHelper.generateJasperReport(dr, new ClassicLayoutManager(),map);
					  
					  JRMapCollectionDataSource mc = new JRMapCollectionDataSource(al); 
					  jasperPrint = JasperFillManager.fillReport(jr, map, mc); 
					  ReportFunctions.generateAllReport(exporter, jasperPrint, request, response, reporttype, Path, rptfilename);
					  
				} catch (Exception e) {
					e.printStackTrace();
					System.out.println(e.getMessage());
					request.setAttribute("error", e.getMessage() );
					RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
		    		dispatchers.forward(request, response);
				}
				finally
				{
		          al=null;
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