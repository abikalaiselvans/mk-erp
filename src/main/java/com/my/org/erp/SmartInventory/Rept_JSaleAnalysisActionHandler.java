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
import com.ibm.icu.text.NumberFormat;
import com.ibm.icu.text.DecimalFormat;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JSaleAnalysisActionHandler extends AbstractActionHandler 
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
			
			if (action.equals("INVRept_JSaleAnalysis")) 
			{
				String path=Path + "/report/Inventory/SalePaymentReports/" + rptfilename+".jrxml";
				File reportDir = new File(Path + "/report/Inventory/SalePaymentReports/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				String Branch=request.getParameter("Branch");
				String division=request.getParameter("divis");
				String payType=request.getParameter("payType");
				String month=request.getParameter("month");
				String year=request.getParameter("year");
				
				String mon=DateUtil.getMonth(Integer.parseInt(month));
				map.put("month", mon);
				map.put("year", year);
				String sql = "";
				String dd="";
				if(!"0".equals(division))
					dd="  AND a.INT_DIVIID="+division;

				
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
				
				String sql1= "",sql2="",sql3="";
				String data1[][]=null,data2[][]=null,data3[][]=null,data4[][]=null;
				sql1 = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM(a.DOU_TOTALAMOUNT), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)   ";
				sql1 = sql1 +" FROM inv_t_directsales a  ,inv_m_division b,com_m_branch c,com_m_company d  ";
				sql1 = sql1 +" where a.INT_DIVIID=b.INT_DIVIID   ";
				sql1 = sql1 +" AND a.INT_BRANCHID=c.INT_BRANCHID  ";
				sql1 = sql1 +" AND c.INT_COMPANYID=d.INT_COMPANYID AND a.CHR_CANCEL='N' ";
				if(!"0".equals(Branch))
					sql1 = sql1 +" AND a.INT_BRANCHID ="+Branch;
				sql1 = sql1+dd;
				sql1 = sql1 +" AND YEAR(a.DAT_SALESDATE) ="+year;	
				sql1 = sql1 +" AND MONTH(DAT_SALESDATE) = "+Integer.parseInt(month);	
				sql1 = sql1 +" GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  ";
				sql1 = sql1 +" order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)  ";
				System.out.println("sql1:"+sql1);
			
		sql2 = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM(a.DOU_NETAMOUNT), MONTHNAME(a.DAT_SALESDATE),YEAR(a.DAT_SALESDATE)   ";
		sql2 = sql2 +" FROM inv_t_directbilling a  ,inv_m_division b,com_m_branch c,com_m_company d  ";
		sql2 = sql2 +" where a.INT_DIVIID=b.INT_DIVIID   ";
		sql2 = sql2 +" AND a.INT_BRANCHID=c.INT_BRANCHID  ";
		sql2 = sql2 +" AND c.INT_COMPANYID=d.INT_COMPANYID  ";
		if(!"0".equals(Branch))
			sql2 = sql2 +" AND a.INT_BRANCHID ="+Branch;
		sql2 = sql2+dd;
		sql2 = sql2 +" AND YEAR(a.DAT_SALESDATE) ="+year;	
		sql2 = sql2 +" AND MONTH(DAT_SALESDATE) = "+Integer.parseInt(month);	
		sql2 = sql2 +" GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  ";
		sql2 = sql2 +" order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)  ";
		
		System.out.println("sql2:"+sql2);
		
		sql3 = " SELECT d.CHR_COMPANYNAME, c.CHR_BRANCHNAME, b.CHR_DIVICODE,COUNT(*),SUM(a.DOU_NETAMOUNT), MONTHNAME(a.DAT_SALESDATE)," +
				"YEAR(a.DAT_SALESDATE)   ";
		sql3 = sql3 +" FROM inv_t_servicebilling a  ,inv_m_division b,com_m_branch c,com_m_company d  ";
		sql3 = sql3 +" where a.INT_DIVIID=b.INT_DIVIID   ";
		sql3 = sql3 +" AND a.INT_BRANCHID=c.INT_BRANCHID  ";
		sql3 = sql3 +" AND c.INT_COMPANYID=d.INT_COMPANYID AND a.CHR_CANCEL='N' ";
		if(!"0".equals(Branch))
			sql3 = sql3 +" AND a.INT_BRANCHID ="+Branch;
		sql3 = sql3+dd;
		sql3 = sql3 +" AND YEAR(a.DAT_SALESDATE) ="+year;	
		sql3 = sql3 +" AND MONTH(DAT_SALESDATE) = "+Integer.parseInt(month);	
		sql3 = sql3 +" GROUP BY MONTH(a.DAT_SALESDATE),a.INT_BRANCHID ,a.INT_DIVIID  ";
		sql3 = sql3 +" order by a.INT_BRANCHID ,a.INT_DIVIID,MONTH(a.DAT_SALESDATE)  ";
		 
	
			System.out.println("sql3:"+sql3);
			List<HashMap> al=new ArrayList<HashMap>();
		
		    
		    NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("en", "IN"));
		    com.ibm.icu.text.DecimalFormatSymbols decimalFormatSymbols = ((DecimalFormat) formatter).getDecimalFormatSymbols();
		    decimalFormatSymbols.setCurrencySymbol("");
		    ((DecimalFormat) formatter).setDecimalFormatSymbols(decimalFormatSymbols);
			
		    Double c=0.00;		
			if("Direct".equals(payType) || "ALL".equals(payType))
			{
				
				data1 = CommonFunctions.QueryExecute(sql1);
				
				if(data1.length>0)
				for(int i=0;i<=data1.length;i++)
				{
					HashMap h3 = new HashMap();
					if(i!=data1.length)
					{
					for(int j=0;j<=8;j++)
					{
						if(j==0)
						{
							h3.put("d"+j,i+1);
						}
						else if(j==1)
						{
							h3.put("d"+j,"Customer Sale Payment");
						}
						else if(j==6)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data1[i][j-2])));
							c+=Double.parseDouble(data1[i][4]);
						}
						
						else
							h3.put("d"+j,data1[i][j-2]);
										
					}
					}
					else
					{
						if(i==data1.length && "Direct".equals(payType))
						{
						h3.put("d5", "Customer Sale Payment Total :");
						h3.put("d6", formatter.format(c));
						}
					}
					
					al.add(h3);
				}
				
			}
			Double a=0.00;
			if("DirectBilling".equals(payType)|| "ALL".equals(payType))
			{
				
				data2 = CommonFunctions.QueryExecute(sql2);
								 
				if(data2.length>0)
				for(int i=0;i<=data2.length;i++)
				{
					HashMap h3 = new HashMap();
					if(i!=data2.length)
					{
					for(int j=0;j<=8;j++)
					{
						if(j==0)
						{
							h3.put("d"+j,i+1);
						}
						else if(j==1)
						{
							h3.put("d"+j,"Direct Billing");
						}
						else if(j==6)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data2[i][j-2])));
							a+=Double.parseDouble(data2[i][4]);
						}
						
						else
							h3.put("d"+j,data2[i][j-2]);
					
												
					}
					}
					else
					{
						if(i==data2.length && "DirectBilling".equals(payType))
						{
						h3.put("d5", "Direct Billing Total :");
						h3.put("d6", formatter.format(a));
						}
					}
			
						al.add(h3);
				}
			}
			Double b=0.00;
			if("ServiceBilling".equals(payType)|| "ALL".equals(payType))
			{
				
				data3 = CommonFunctions.QueryExecute(sql3);
				
				if(data3.length>0)
				for(int i=0;i<=data3.length;i++)
				{
					HashMap h3 = new HashMap();
					if(i!=data3.length )
					{
					for(int j=0;j<=8;j++)
					{
						if(j==0)
						{
							h3.put("d"+j,i+1);
						}
						else if(j==1)
						{
							h3.put("d"+j,"Service Billing");
						}
						else if(j==6)
						{
							h3.put("d"+j,formatter.format(Double.parseDouble(data3[i][j-2])));
							b+=Double.parseDouble(data3[i][4]);
						}
						else
							h3.put("d"+j,data3[i][j-2]);
					}
					}
					else
					{
						if(i==data3.length && "ServiceBilling".equals(payType))
						{
						h3.put("d5", "Service Billing Total :");
						h3.put("d6", formatter.format(b));
						}
					}	
							al.add(h3);
				}
			}
			if(("ALL".equals(payType)) &&(data1.length>0 || data2.length>0 || data3.length>0))
			{
				HashMap htot1 = new HashMap();
				htot1.put("d5", "Customer Sale Payment Total :");
				htot1.put("d6", formatter.format(c));
				
				HashMap htot2 = new HashMap();
				htot2.put("d5", "Direct Billing Total :");
				htot2.put("d6", formatter.format(a));
				
				HashMap htot3 = new HashMap();
				htot3.put("d5", "Service Billing Total :");
				htot3.put("d6", formatter.format(b));

			HashMap htot = new HashMap();
			Double grandTotal=c+a+b;
			htot.put("d5", "Grand Total :");
			htot.put("d6", formatter.format(grandTotal));
			al.add(htot1);
			al.add(htot2);
			al.add(htot3);
			al.add(htot);
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
				
				
				if("Direct".equals(payType))
					map.put("saletype", "Customer Sales");
				else if("DirectBilling".equals(payType))
					map.put("saletype", "Direct Billing");
				else if("ServiceBilling".equals(payType))
					map.put("saletype", "Service Billing");
				else if("ALL".equals(payType))
						map.put("saletype", "All Payment Types");
				
				
				
								
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
		          
		          String title[]={"S.No.","Invoice Type","Company","Branch","Division","Invoice total Count","Total Amount","Sale Month","Sale Year"};
		          int datawidth[]={40,70,110,70,60,50,50,50,50};
		          
		          Style list[]={detailstyle,detailstyle,detailstyle,detailstyle,detailstyle,detailstyle,amountstyle,detailstyle,detailstyle};
		         
		          for(int u=0;u<=8;u++)
		          {
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
		          al=null;
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