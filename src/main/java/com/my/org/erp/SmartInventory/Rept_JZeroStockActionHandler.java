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
import com.my.org.erp.common.CommonFunctions;

public class Rept_JZeroStockActionHandler extends AbstractActionHandler 
{
	JasperPrint jasperPrint;
	protected JasperReport jr;
	JRExporter exporter;
	String hImageExpression="";
	String fImageExpression="";

	public void handle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try 
		{ 
			String action = request.getParameter("actionS");
			String rptfilename = request.getParameter("rptfilename");
			String reporttype = request.getParameter("reportType");
			
			if (action.equals("INVRept_JZeroStock")) 
			{	
				String path=Path + "/report/Inventory/Reports1/" + rptfilename+".jrxml";
				File reportDir = new File(Path + "/report/Inventory/Reports1/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
								
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
				
				String sql= "";
				String data1[][]=null,data2[][]=null;
				List<HashMap<String,String>> al=new ArrayList<HashMap<String,String>>();
		
			    NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("en", "IN"));
			    DecimalFormatSymbols decimalFormatSymbols = ((DecimalFormat) formatter).getDecimalFormatSymbols();
			    decimalFormatSymbols.setCurrencySymbol("");
			    ((DecimalFormat) formatter).setDecimalFormatSymbols(decimalFormatSymbols);
			
		    	sql = "  SELECT 'Item',b.CHR_GROUPNAME, a.CHR_ITEMNAME, a.CHR_DES  FROM inv_m_item  a ," +
		    			"inv_m_itemgroup b WHERE a.INT_ITEMGROUPID =b.INT_ITEMGROUPID AND FUN_INV_ITEM_STOCK(a.CHR_ITEMID) <1 " +
		    			"ORDER BY b.CHR_GROUPNAME,a.CHR_ITEMNAME ";
				System.out.println("sql1:"+sql);
				data1 = CommonFunctions.QueryExecute(sql);
				
				sql = "  SELECT 'Product',b.CHR_NAME,a.CHR_PRODUCTCODE, a.CHR_PRODUCTDESC  FROM inv_m_produtlist  a," +
						" inv_m_productgroup b WHERE a.INT_PRODUCTGROUPID = b.INT_PRODUCTGROUPID AND a.CHR_PTYPE !='S' " +
						"AND FUN_INV_PRODUCT_STOCK(a.CHR_PRODUCTID) <1 ORDER BY b.CHR_NAME,a.CHR_PRODUCTCODE ";
				System.out.println("sql2:"+sql);
				data2 = CommonFunctions.QueryExecute(sql);
				int columnCount=CommonFunctions.intGetColumnCount(sql);
				System.out.println("columnCount:"+columnCount);
				if(data1.length>0)
				for(int i=0;i<data1.length;i++)
				{
					HashMap<String,String> h3 = new HashMap<String,String>();
					for(int j=0;j<=columnCount;j++)
					{
						if(j==0)
						{
							h3.put("d"+j,Integer.toString(i+1));
						}
							else
							h3.put("d"+j,data1[i][j-1]);
					}
					al.add(h3);
				}
				if(data2.length>0)
					for(int i=0;i<data2.length;i++)
					{
						HashMap<String,String> h3 = new HashMap<String,String>();
						
						for(int j=0;j<=columnCount;j++)
						{
							if(j==0)
							{
								h3.put("d"+j,Integer.toString(data1.length+i+1));
							}
								else
								h3.put("d"+j,data2[i][j-1]);
						}
						al.add(h3);
					}	
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
					  
					  String title[]={"S.No.","Stock Type","Stock Group","Stock Model","Stock Description"};
					  int datawidth[]={35,30,100,100,200};
					  
					  Style list[]={detailstyle,detailstyle,detailstyle,detailstyle,detailstyle};
					 
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