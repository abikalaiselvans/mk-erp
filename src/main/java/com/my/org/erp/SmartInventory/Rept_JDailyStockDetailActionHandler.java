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

public class Rept_JDailyStockDetailActionHandler extends AbstractActionHandler 
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
			
			if (action.equals("INVRept_JDailyStockDetail")) 
			{	
				String path=Path + "/report/Inventory/PaymentDetailReport/" + rptfilename+".jrxml";
				File reportDir = new File(Path + "/report/Inventory/PaymentDetailReport/" + rptfilename+".jrxml");
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
			
		    Double c=0.00;		
		   
		    	map.put("producttype","Item");
		    	sql = "SELECT   b.CHR_DIVICODE,if( a.CHR_TYPE ='I' ,'ITEM','PRODUCT' ),  if( a.CHR_TYPE ='I' ,(SELECT a1.CHR_ITEMNAME " +
		    			"FROM inv_m_item a1  WHERE  a1.CHR_ITEMID =a.CHR_ITEMID), (SELECT a2.CHR_PRODUCTCODE FROM inv_m_produtlist a2  " +
		    			"WHERE  a2.CHR_PRODUCTID =a.CHR_ITEMID) ) productcode,if( a.CHR_TYPE ='I' , (SELECT aa1.CHR_DES FROM inv_m_item aa1  " +
		    			"WHERE  aa1.CHR_ITEMID =a.CHR_ITEMID),(SELECT aa2.CHR_PRODUCTDESC FROM inv_m_produtlist aa2  WHERE  " +
		    			"aa2.CHR_PRODUCTID =a.CHR_ITEMID)) productdescription, COUNT(*) ,SUM(a.DOU_UNITPRICE) FROM inv_t_vendorgoodsreceived a ," +
		    			"inv_m_division b WHERE a.INT_DIVIID=b.INT_DIVIID AND a.CHR_FLAG='N' AND a.CHR_SERIALNO is not null GROUP BY a.CHR_ITEMID," +
		    			"a.CHR_TYPE ORDER BY a.INT_DIVIID ";
				
				System.out.println("sql1:"+sql);
				
				data1 = CommonFunctions.QueryExecute(sql);
				int columnCount=CommonFunctions.intGetColumnCount(sql);
				System.out.println("columnCount:"+columnCount);
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
						else if(j==6)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-1])));
							c+=Double.parseDouble(data1[i][j-1]);
						}
							else
							h3.put("d"+j,data1[i][j-1]);
					}
					}
					else
					{
						if(i==data1.length )
						{
						h3.put("d5", "Grand Total :");
						h3.put("d6", formatter.format(c));
						
						}
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
					  
					  String title[]={"S.No.","Division","Product Type","Product Code","Product Description","Product Count","Product Total Amount"};
					  int datawidth[]={35,110,50,110,170,50,90};
					  
					  Style list[]={detailstyle,detailstyle,detailstyle,detailstyle,detailstyle,detailstyle,amountstyle};
					 
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