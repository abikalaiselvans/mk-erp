package com.my.org.erp.SmartInventory;
import java.awt.Color;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.text.DecimalFormatSymbols;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.List;
import java.util.Locale;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRParameter;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.data.JRMapCollectionDataSource;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.util.SimpleFileResolver;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
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

import com.ibm.icu.text.DateFormatSymbols;
import com.ibm.icu.text.NumberFormat;
import com.ibm.icu.text.DecimalFormat;
import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.SmartReport.ReportFunctions2;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JPaymentPendingActionHandler extends AbstractActionHandler 
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
			
			if (action.equals("INVRept_JPaymentPending")) 
			{
				String path=Path + "/report/Inventory/SalePaymentReports/" + rptfilename+".jrxml";
				File reportDir = new File(Path + "/report/Inventory/SalePaymentReports/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				String Branch=request.getParameter("Branch");
				String division=request.getParameter("divis");
				String payType=request.getParameter("payType");
				String ref=request.getParameter("ref");
				String From=request.getParameter("From");
				String To=request.getParameter("To");
				String Chequedt=request.getParameter("Chequedt");
				String order = request.getParameter("order");
				
				String sql = "";
				String dd="";
				String me="";
				if(!"0".equals(division))
					dd="  AND a.INT_DIVIID="+division;
				
				if(!"0".equals(ref))	
					me = " AND a.CHR_REF='"+ref+"'";	

				
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
				sql1 =" SELECT a.CHR_SALESNO,f.CHR_COMPANYNAME,e.CHR_BRANCHNAME,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y')," +
						"( SELECT DATE_FORMAT(max(h.DT_COMMITMENTDATE ),'%d-%b-%Y') FROM inv_t_paymentcommitment h   " +
						"WHERE a.CHR_SALESNO = h.CHR_SALESNO ) ,DATEDIFF(( SELECT max(h.DT_COMMITMENTDATE ) " +
						"FROM inv_t_paymentcommitment h WHERE a.CHR_SALESNO = h.CHR_SALESNO ),a.DAT_SALESDATE)," +
						"FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),FIND_A_CUSTOMER_ADDRESS(b.INT_CUSTOMERID),a.CHR_PAYMENTSTATUS," +
						"a.DOU_TOTALAMOUNT,  datediff(now(),a.DAT_SALESDATE),c.CHR_STAFFNAME, d.CHR_DIVICODE,a.CHR_OTHERREF " +
						"from inv_t_directsales a ,inv_m_customerinfo b ,com_m_staff c ,inv_m_division d, com_m_branch e,com_m_company f," +
						"inv_t_paymentcommitment g WHERE a.CHR_PAYMENTSTATUS !='Y'   AND a.CHR_SALESNO = g.CHR_SALESNO AND g.CHR_INVOICETYPE='C'" +
						" AND a.INT_SALESSTATUS=1 AND a.CHR_CANCEL='N' ";
				sql1 = sql1+" AND a.CHR_PAYMENTSTATUS !='S'  AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND a.CHR_REF = c.CHR_EMPID";
				sql1 = sql1+" AND a.INT_DIVIID=d.INT_DIVIID  AND a.INT_BRANCHID = e.INT_BRANCHID  AND e.INT_COMPANYID = f.INT_COMPANYID" ;
				
				if(!"0".equals(Branch))	
					sql1 = sql1+" AND a.INT_BRANCHID="+Branch;	
				
				sql1 = sql1+dd;
				sql1 = sql1+" AND datediff(now(),a.DAT_SALESDATE)>="+From;
				sql1 = sql1+" AND datediff(now(),a.DAT_SALESDATE)<="+To;
				sql1 = sql1+" "+me+" ";
				sql1 = sql1+" GROUP BY a.CHR_SALESNO ORDER BY "+order;
				System.out.println("sql:"+sql1);
				 				
				sql2 ="  SELECT a.CHR_SALESNO,f.CHR_COMPANYNAME,e.CHR_BRANCHNAME,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y')," +
						"( SELECT DATE_FORMAT(max(h.DT_COMMITMENTDATE ),'%d-%b-%Y') FROM inv_t_paymentcommitment h   WHERE " +
						"a.CHR_SALESNO = h.CHR_SALESNO ) ,DATEDIFF(( SELECT max(h.DT_COMMITMENTDATE ) FROM inv_t_paymentcommitment h " +
						"WHERE a.CHR_SALESNO = h.CHR_SALESNO ),a.DAT_SALESDATE),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID)," +
						"FIND_A_CUSTOMER_ADDRESS(b.INT_CUSTOMERID),a.CHR_PAYMENTSTATUS,a.DOU_AMOUNT,  datediff(now(),a.DAT_SALESDATE)," +
						"c.CHR_STAFFNAME, d.CHR_DIVICODE,a.CHR_DES from inv_t_directbilling a , inv_m_customerinfo b ,";
				
				sql2 = sql2 + "com_m_staff c ,inv_m_division d ,com_m_branch e,com_m_company f,inv_t_paymentcommitment g WHERE a.CHR_PAYMENTSTATUS !='Y' ";
				sql2 = sql2+"  AND a.CHR_SALESNO = g.CHR_SALESNO AND g.CHR_INVOICETYPE='D'  AND a.CHR_PAYMENTSTATUS !='S'  AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND a.CHR_REF = c.CHR_EMPID";
				sql2 = sql2+" AND a.INT_DIVIID=d.INT_DIVIID AND a.INT_BRANCHID = e.INT_BRANCHID  AND e.INT_COMPANYID = f.INT_COMPANYID  " ;
				
				
				if(!"0".equals(Branch))	
					sql2 = sql2+" AND a.INT_BRANCHID="+Branch;	
				
				sql2 = sql2+dd;
				sql2 = sql2+" AND datediff(now(),a.DAT_SALESDATE)>="+From;
				sql2 = sql2+" AND datediff(now(),a.DAT_SALESDATE)<="+To;
				sql2 = sql2+" "+me+" ";
				sql2 = sql2+" GROUP BY a.CHR_SALESNO ORDER BY  "+order;
				
		System.out.println("sql2:"+sql2);
		
		sql3 ="  SELECT a.CHR_SALESNO,f.CHR_COMPANYNAME,e.CHR_BRANCHNAME,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),( SELECT DATE_FORMAT(" +
				"max(h.DT_COMMITMENTDATE ),'%d-%b-%Y') FROM inv_t_paymentcommitment h   WHERE a.CHR_SALESNO = h.CHR_SALESNO ) ," +
				"DATEDIFF(( SELECT max(h.DT_COMMITMENTDATE ) FROM inv_t_paymentcommitment h WHERE a.CHR_SALESNO = h.CHR_SALESNO )," +
				"a.DAT_SALESDATE),FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),FIND_A_CUSTOMER_ADDRESS(b.INT_CUSTOMERID),a.CHR_PAYMENTSTATUS," +
				"a.DOU_NETAMOUNT,  datediff(now(),a.DAT_SALESDATE),c.CHR_STAFFNAME, d.CHR_DIVICODE,a.CHR_DES  from inv_t_servicebilling a , " +
				"inv_m_customerinfo b ,com_m_staff c ,inv_m_division d,com_m_branch e,com_m_company f,inv_t_paymentcommitment g " +
				" WHERE a.CHR_PAYMENTSTATUS !='Y' AND a.CHR_CANCEL='N' ";
		sql3 = sql3+" AND a.CHR_PAYMENTSTATUS !='S'   AND a.CHR_SALESNO = g.CHR_SALESNO AND g.CHR_INVOICETYPE='S' AND a.INT_CUSTOMERID = b.INT_CUSTOMERID AND a.CHR_REF = c.CHR_EMPID";
		sql3 = sql3+" AND a.INT_DIVIID=d.INT_DIVIID AND a.INT_BRANCHID = e.INT_BRANCHID  AND e.INT_COMPANYID = f.INT_COMPANYID";
		
		if(!"0".equals(Branch))	
			sql3 = sql3+" AND a.INT_BRANCHID="+Branch;	
		
		sql3 = sql3+dd;
		sql3 = sql3+" AND datediff(now(),a.DAT_SALESDATE)>="+From;
		sql3 = sql3+" AND datediff(now(),a.DAT_SALESDATE)<="+To;
		sql3 = sql3+" "+me+" ";
		sql3 = sql3+" GROUP BY a.CHR_SALESNO ORDER BY  "+order;			
			System.out.println("sql3:"+sql3);
			List<HashMap> al=new ArrayList<HashMap>();
		
		    
		    NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("en", "IN"));
		    com.ibm.icu.text.DecimalFormatSymbols decimalFormatSymbols = ((DecimalFormat) formatter).getDecimalFormatSymbols();
		    decimalFormatSymbols.setCurrencySymbol("");
		    ((DecimalFormat) formatter).setDecimalFormatSymbols(decimalFormatSymbols);
			
		    Double c=0.00,c1=0.00;		
			if("Direct".equals(payType) || "ALL".equals(payType))
			{
				
				data1 = CommonFunctions.QueryExecute(sql1);
				
				if(data1.length>0)
				for(int i=0;i<=data1.length;i++)
				{
					HashMap h3 = new HashMap();
					if(i!=data1.length)
					{
					for(int j=0;j<=15;j++)
					{
						if(j==0)
						{
							h3.put("d"+j,i+1);
						}
						else if(j==1)
						{
							h3.put("d"+j,"Customer Sale Payment");
						}
						
						else if(j==10)
						{
						if("P".equals(data1[i][8]))
						{
							System.out.println("inside p");
							
							sql="SELECT COUNT(*) FROM inv_t_customersalespayment WHERE CHR_SALESORDERNO='"+data1[i][0]+"'";
							boolean f= CommonFunction.RecordExist(sql);
							if(f)
							{
								System.out.println("inside boolean f");
							  sql="SELECT SUM(DOU_PAIDAMOUNT) FROM inv_t_customersalespayment WHERE CHR_SALESORDERNO='"+data1[i][0]+"'";
							  String pdata[][] =CommonFunctions.QueryExecute(sql);	
							  System.out.println("pdata[0][0]:"+pdata[0][0]);
							  if(pdata.length>0)
								 c= Double.parseDouble(pdata[0][0]);
							  else
								c=0.00;
							}
							
							
							h3.put("d"+j,"Partialy Paid("+formatter.format(Double.parseDouble(data1[i][9]))+"-"+formatter.format(c)+" )" );
							c1+=Double.parseDouble(data1[i][9])-c;
							
							h3.put("d"+(j+1),formatter.format(Double.parseDouble(data1[i][9])-c));
								j++;
						
						}	
						else
						{
							h3.put("d"+j,"");
							h3.put("d"+(j+1),formatter.format(Double.parseDouble(data1[i][9])));
							c1+=Double.parseDouble(data1[i][9]);
							 j++;
						}
						}
						else
							h3.put("d"+j,data1[i][j-2]);
												
					}
					}
					else if(i==data1.length && "Direct".equals(payType))
					{
						h3.put("d10", "Customer Sale Payment Total :");
						h3.put("d11", formatter.format(c1));
					}
					
					al.add(h3);
				}
				
			}
			Double a=0.00,a1=0.00;
			if("DirectBilling".equals(payType)|| "ALL".equals(payType))
			{
				
				data2 = CommonFunctions.QueryExecute(sql2);
								 
				if(data2.length>0)
				for(int i=0;i<=data2.length;i++)
				{
					HashMap h3 = new HashMap();
					if(i!=data2.length)
					{
				
						for(int j=0;j<=15;j++)
						{
							if(j==0)
							{
								h3.put("d"+j,i+1);
							}
							else if(j==1)
							{
								h3.put("d"+j,"Direct Billing");
							}
							
							else if(j==10)
							{
							if("P".equals(data2[i][8]))
							{
								System.out.println("inside p");
								
								sql="SELECT COUNT(*) FROM inv_t_customersalespayment WHERE CHR_SALESORDERNO='"+data2[i][0]+"'";
								boolean f= CommonFunction.RecordExist(sql);
								if(f)
								{
									System.out.println("inside boolean f");
								  sql="SELECT SUM(DOU_PAIDAMOUNT) FROM inv_t_customersalespayment WHERE CHR_SALESORDERNO='"+data2[i][0]+"'";
								  String pdata[][] =CommonFunctions.QueryExecute(sql);	
								  System.out.println("pdata[0][0]:"+pdata[0][0]);
								  if(pdata.length>0)
									 a= Double.parseDouble(pdata[0][0]);
								  else
									a=0.00;
								}
								
								
								h3.put("d"+j,"Partialy Paid("+formatter.format(Double.parseDouble(data2[i][9]))+"-"+formatter.format(a)+" )" );
								a1+=Double.parseDouble(data2[i][9])-a;
								
								h3.put("d"+(j+1),formatter.format(Double.parseDouble(data2[i][9])-a));
									j++;
									
							}	
							else
							{
								h3.put("d"+j,"");
								h3.put("d"+(j+1),formatter.format(Double.parseDouble(data2[i][9])));
								a1+=Double.parseDouble(data2[i][9]);
								 j++;
							}
							}
							else
								h3.put("d"+j,data2[i][j-2]);
													
						}
						}
					else if(i==data2.length && "DirectBilling".equals(payType))
					{
						h3.put("d10", "Direct Billing Total :");
						h3.put("d11", formatter.format(a1));
						
					}
						al.add(h3);
				}
			}
			Double b=0.00,b1=0.00;
			if("ServiceBilling".equals(payType)|| "ALL".equals(payType))
			{
				
				data3 = CommonFunctions.QueryExecute(sql3);
				
				if(data3.length>0)
				for(int i=0;i<=data3.length;i++)
				{
					HashMap h3 = new HashMap();
					if(i!=data3.length )
					{
						for(int j=0;j<=15;j++)
						{
							if(j==0)
							{
								h3.put("d"+j,i+1);
							}
							else if(j==1)
							{
								h3.put("d"+j,"Service Billing");
							}
							
							else if(j==10)
							{
							if("P".equals(data3[i][8]))
							{
								System.out.println("inside p");
								
								sql="SELECT COUNT(*) FROM inv_t_customersalespayment WHERE CHR_SALESORDERNO='"+data3[i][0]+"'";
								boolean f= CommonFunction.RecordExist(sql);
								if(f)
								{
									System.out.println("inside boolean f");
								  sql="SELECT SUM(DOU_PAIDAMOUNT) FROM inv_t_customersalespayment WHERE CHR_SALESORDERNO='"+data3[i][0]+"'";
								  String pdata[][] =CommonFunctions.QueryExecute(sql);	
								  System.out.println("pdata[0][0]:"+pdata[0][0]);
								  if(pdata.length>0)
									 b= Double.parseDouble(pdata[0][0]);
								  else
									b=0.00;
								}
								
								h3.put("d"+j,"Partialy Paid("+formatter.format(Double.parseDouble(data3[i][9]))+"-"+formatter.format(b)+" )" );
								b1+=Double.parseDouble(data3[i][9])-b;
								h3.put("d"+(j+1),formatter.format(Double.parseDouble(data3[i][9])-b));
									j++;
									
							}	
							else 
							{
								h3.put("d"+j,"");
								h3.put("d"+(j+1),formatter.format(Double.parseDouble(data3[i][9])));
								b1+=Double.parseDouble(data3[i][9]);
								 j++;
							}
							}
							else
								h3.put("d"+j,data3[i][j-2]);
													
						}
						}
					else if(i==data3.length && "ServiceBilling".equals(payType))
					{
						h3.put("d10", "Service Billing Total :");
						h3.put("d11", formatter.format(b1));
					}
						al.add(h3);
				}
			}
			
			if(("ALL".equals(payType)) &&(data1.length>0 || data2.length>0 || data3.length>0))
			{
				HashMap htot1 = new HashMap();
				htot1.put("d10", "Customer Sale Payment Total :");
				htot1.put("d11", formatter.format(c1));
				
				HashMap htot2 = new HashMap();
				htot2.put("d10", "Direct Billing Total :");
				htot2.put("d11", formatter.format(a1));
				
				HashMap htot3 = new HashMap();
				htot3.put("d10", "Service Billing Total :");
				htot3.put("d11", formatter.format(b1));

			HashMap htot = new HashMap();
			Double grandTotal=c1+a1+b1;
			htot.put("d10", "Grand Total :");
			htot.put("d11", formatter.format(grandTotal));
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
				
				if(!"0".equals(ref))
				{
					data1 = CommonFunctions.QueryExecute("SELECT CHR_STAFFNAME  FROM com_m_staff WHERE CHR_HOLD!='Y'  AND CHR_TYPE!='T' AND CHR_EMPID='"+ref+"'");
					if(!data1[0][0].equals(""))
							map.put("ref",data1[0][0]);
				}
				else
					map.put("ref","All Marketing Employees");
				if(order.equals("a.DAT_SALESDATE"))
					map.put("orderby","Invoice Date");
				else if(order.equals("FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID)"))
					map.put("orderby", "Customer Name");
				
				map.put("daysLeftFrom", From);
				map.put("daysLeftTo", To);
								
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
		          
		          String title[]={"S.No.","Invoice Type","Invoice Number","Company","Branch","Invoice Date","Commitment Date","Day Difference",
		        		  "Customer Name","Customer Address","Payment Status", "Payable Amount","No of Days","Marketing Employee Name","Division","Other Reference"};
		          int datawidth[]={40,70,100,110,70,50,50,50,140,150,70,70,50,100,100,60,150};
		          
		          Style list[]={detailstyle,detailstyle,detailstyle,detailstyle,detailstyle,numberstyle,numberstyle,detailstyle,detailstyle,
		        		  detailstyle,detailstyle,amountstyle,detailstyle,detailstyle,detailstyle,detailstyle};
		         
		          for(int u=0;u<=15;u++)
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