package com.my.org.erp.SmartInventory;
import java.awt.Color;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
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

import com.my.org.erp.SmartReport.ReportFunctions;
import com.my.org.erp.SmartReport.ReportFunctions2;
import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JPaymentCommitmentDatewiseActionHandler extends AbstractActionHandler 
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
			
			if (action.equals("INVRept_JPaymentCommitmentDatewise")) 
			{
				String path=Path + "/report/Inventory/SalePaymentReports/" + rptfilename+".jrxml";
				File reportDir = new File(Path + "/report/Inventory/SalePaymentReports/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				String branchid = request.getParameter("Branch");
				String division = request.getParameter("division");
				String salestype = ""+request.getParameter("salestype");
				String status = ""+request.getParameter("status");
				String fromdate = request.getParameter("fromdate");
				String todate = request.getParameter("todate");
				
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
				map.put("fdate", fromdate);
				map.put("tdate", todate);
				String sql1= "",sql2="",sql3="";
				String data1[][]=null,data2[][]=null,data3[][]=null,data4[][]=null;
				sql1 = " SELECT a.INT_PAYMENTCOMMITMENTID,FUN_GET_BRANCH_WITH_COMPANY_NAME(b.INT_BRANCHID),'CUSTOMER SALES'," +
						" a.CHR_SALESNO,FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID ),d.CHR_DIVICODE,DATE_FORMAT(b.DAT_SALESDATE,'%d-%b-%Y')," +
						"DATE_FORMAT(a.DT_COMMITMENTDATE,'%d-%b-%Y'),DATEDIFF(a.DT_COMMITMENTDATE,b.DAT_SALESDATE),b.DOU_TOTALAMOUNT," +
						" a.DOU_COMMITMENTAMOUNT,a.DT_RECIEVEDDATE,a.DOU_RECEIVEDAMOUNT,a.CHR_DESCRIPTION, (b.DOU_TOTALAMOUNT -a.DOU_RECEIVEDAMOUNT )," +
						"if(a.CHR_STATUS='Y','Commitment Assigned','commitment not assigned'),if(a.CHR_PAYMENTFLAG='Y', 'Payment Received','Payment Not Received')," +
						"if( a.CHR_NEXTFLAG ='Y','Yes','No') FROM inv_t_paymentcommitment a,inv_t_directsales b,inv_m_customerinfo c,inv_m_division d " +
						"WHERE a.CHR_SALESNO=b.CHR_SALESNO  " +
						"AND b.INT_CUSTOMERID =c.INT_CUSTOMERID AND b.INT_DIVIID= d.INT_DIVIID AND a.CHR_INVOICETYPE='C' ";
						//" AND  b.CHR_CANCEL='N'  ";	
				if(!"0".equals(branchid))
					sql1 = sql1 + " AND b.INT_BRANCHID = "+branchid;
				if(!"0".equals(division))
					sql1 = sql1 + " AND b.INT_DIVIID = "+division;
					sql1 = sql1 + "  AND a.CHR_PAYMENTFLAG ='"+status+"' AND a.CHR_INVOICETYPE='C' ";
					sql1 = sql1+" AND  DT_COMMITMENTDATE  >= '"+DateUtil.FormateDateSQL(fromdate)+"'";	
					sql1 = sql1+" AND  DT_COMMITMENTDATE  <= '"+DateUtil.FormateDateSQL(todate)+"'";	
				sql1 = sql1 +" ORDER BY a.CHR_SALESNO,a.DT_COMMITMENTDATE ";
				System.out.println("sql1:"+sql1);
				 				
				sql2 = " SELECT a.INT_PAYMENTCOMMITMENTID,FUN_GET_BRANCH_WITH_COMPANY_NAME(b.INT_BRANCHID),'DIRECT BILLING'," +
						" a.CHR_SALESNO,FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID ),d.CHR_DIVICODE,DATE_FORMAT(b.DAT_SALESDATE,'%d-%b-%Y')," +
						"DATE_FORMAT(a.DT_COMMITMENTDATE,'%d-%b-%Y'),DATEDIFF(a.DT_COMMITMENTDATE,b.DAT_SALESDATE),b.DOU_NETAMOUNT, " +
						"a.DOU_COMMITMENTAMOUNT,a.DT_RECIEVEDDATE,a.DOU_RECEIVEDAMOUNT,a.CHR_DESCRIPTION, (b.DOU_NETAMOUNT -a.DOU_RECEIVEDAMOUNT )," +
						"if(a.CHR_STATUS='Y','Commitment Assigned','commitment not assigned'),if(a.CHR_PAYMENTFLAG='Y'," +
						" 'Payment Received','Payment Not Received'),if( a.CHR_NEXTFLAG ='Y','Yes','No') FROM inv_t_paymentcommitment a," +
						"inv_t_directbilling b,inv_m_customerinfo c,inv_m_division d  WHERE a.CHR_SALESNO=b.CHR_SALESNO  " +
						"AND b.INT_CUSTOMERID =c.INT_CUSTOMERID AND b.INT_DIVIID= d.INT_DIVIID AND a.CHR_INVOICETYPE='D' " ;
						
		if(!"0".equals(branchid))
			sql2 = sql2+ " AND b.INT_BRANCHID = "+branchid;
		if(!"0".equals(division))
			sql2 = sql2 + " AND b.INT_DIVIID = "+division;
			sql2 = sql2 + "  AND a.CHR_PAYMENTFLAG ='"+status+"' AND a.CHR_INVOICETYPE='D' ";
			sql2 = sql2+" AND  DT_COMMITMENTDATE  >= '"+DateUtil.FormateDateSQL(fromdate)+"'";	
			sql2 = sql2+" AND  DT_COMMITMENTDATE  <= '"+DateUtil.FormateDateSQL(todate)+"'";	
		sql2 = sql2 +" ORDER BY a.CHR_SALESNO,a.DT_COMMITMENTDATE  ";
		System.out.println("sql2:"+sql2);
		
		sql3 = " SELECT a.INT_PAYMENTCOMMITMENTID,FUN_GET_BRANCH_WITH_COMPANY_NAME(b.INT_BRANCHID),'SERVICE BILLING', " +
				"a.CHR_SALESNO,FIND_A_CUSTOMER_NAME(c.INT_CUSTOMERID ),d.CHR_DIVICODE,DATE_FORMAT(b.DAT_SALESDATE,'%d-%b-%Y')," +
				"DATE_FORMAT(a.DT_COMMITMENTDATE,'%d-%b-%Y'),DATEDIFF(a.DT_COMMITMENTDATE,b.DAT_SALESDATE)," +
				"b.DOU_NETAMOUNT, a.DOU_COMMITMENTAMOUNT,a.DT_RECIEVEDDATE,a.DOU_RECEIVEDAMOUNT,a.CHR_DESCRIPTION, " +
				"(b.DOU_NETAMOUNT -a.DOU_RECEIVEDAMOUNT ),if(a.CHR_STATUS='Y','Commitment Assigned','commitment not assigned')," +
				"if(a.CHR_PAYMENTFLAG='Y', 'Payment Received','Payment Not Received'),if( a.CHR_NEXTFLAG ='Y','Yes','No')" +
				" FROM inv_t_paymentcommitment a,inv_t_servicebilling b,inv_m_customerinfo c,inv_m_division d  WHERE a.CHR_SALESNO=b.CHR_SALESNO  " +
				"AND b.INT_CUSTOMERID =c.INT_CUSTOMERID AND b.INT_DIVIID= d.INT_DIVIID AND a.CHR_INVOICETYPE='S'  " ;
				//"AND  b.CHR_CANCEL='N'";	
		if(!"0".equals(branchid))
			sql3 = sql3 + " AND b.INT_BRANCHID = "+branchid;
		if(!"0".equals(division))
			sql3 = sql3 + " AND b.INT_DIVIID = "+division;
			sql3 = sql3 + " AND a.CHR_PAYMENTFLAG ='"+status+"' AND a.CHR_INVOICETYPE='S' ";
			sql3 = sql3+" AND  DT_COMMITMENTDATE  >= '"+DateUtil.FormateDateSQL(fromdate)+"'";	
			sql3 = sql3+" AND  DT_COMMITMENTDATE  <= '"+DateUtil.FormateDateSQL(todate)+"'";	
			sql3 = sql3 +" ORDER BY a.CHR_SALESNO,a.DT_COMMITMENTDATE ";
			
			System.out.println("sql3:"+sql3);
			//int d4length=data1.length+data2.length+data3.length;
			List<HashMap> al=new ArrayList<HashMap>();
		
			if(salestype.equals("C"))
			{
				Double c=0.00,c1=0.00,c2=0.00,c3=0.00;
				map.put("saletype", "Customer Sales");
				data1 = CommonFunctions.QueryExecute(sql1);
				 if(data1.length==0 )
						map.put("dataNotExist", "0");
				if(data1.length>0)
				for(int i=0;i<=data1.length;i++)
				{
					HashMap h3 = new HashMap();
					if(i!=data1.length)
					{
					for(int j=0;j<=17;j++)
					{
						if(j==0)
						{
							h3.put("d"+j,i+1);
						}
						else
						h3.put("d"+j, data1[i][j]);
						if(j==9)
						{
							String payamount=data1[i][j];
							Double ipayamount=Double.parseDouble(payamount);
							c+=ipayamount;
						}
						if(j==10)
						{
							String payamount=data1[i][j];
							Double ipayamount=Double.parseDouble(payamount);
							c1+=ipayamount;
						}
						if(j==12)
						{
							String payamount=data1[i][j];
							Double ipayamount=Double.parseDouble(payamount);
							c2+=ipayamount;
						}
						if(j==14)
						{
							String payamount=data1[i][j];
							Double ipayamount=Double.parseDouble(payamount);
							c3+=ipayamount;
						}
					}
					}
					else
					{
						h3.put("d8", "Grand Total :");
						h3.put("d9",c);
						h3.put("d10",c1);
						h3.put("d12",c2);
						h3.put("d14",c3);
					}
					
					al.add(h3);
				}
				
			}
			
			if(salestype.equals("D"))
			{
				Double a=0.00,a1=0.00,a2=0.00,a3=0.00;
				map.put("saletype", "Direct Billing");
				data2 = CommonFunctions.QueryExecute(sql2);
				 if(data2.length==0 )
						map.put("dataNotExist", "0");
				 
				if(data2.length>0)
				for(int i=0;i<=data2.length;i++)
				{
					HashMap h3 = new HashMap();
					if(i!=data2.length)
					{
				
					for(int j=0;j<=17;j++)
					{
						if(j==0)
						{
							h3.put("d"+j,i+1);
						}
						else
							h3.put("d"+j, data2[i][j]);
						if(j==9)
						{
							String payamount=data2[i][j];
							Double ipayamount=Double.parseDouble(payamount);
							a+=ipayamount;
						}
						if(j==10)
						{
							String payamount=data2[i][j];
							Double ipayamount=Double.parseDouble(payamount);
							a1+=ipayamount;
						}
						if(j==12)
						{
							String payamount=data2[i][j];
							Double ipayamount=Double.parseDouble(payamount);
							a2+=ipayamount;
						}
						if(j==14)
						{
							String payamount=data2[i][j];
							Double ipayamount=Double.parseDouble(payamount);
							a3+=ipayamount;
						}
					}
					}
					else
					{
						h3.put("d8", "Grand Total :");
						h3.put("d9",a);
						h3.put("d10",a1);
						h3.put("d12",a2);
						h3.put("d14",a3);					}
						al.add(h3);
				}
			}
			
			if(salestype.equals("S"))
			{
				Double b=0.00,b1=0.00,b2=0.00,b3=0.00;
				map.put("saletype", "Service Billing");
				data3 = CommonFunctions.QueryExecute(sql3);
				 if(data3.length==0 )
						map.put("dataNotExist", "0");
					/*else
						map.put("dataLength", "1");*/
				if(data3.length>0)
				for(int i=0;i<=data3.length;i++)
				{
					HashMap h3 = new HashMap();
					if(i!=data3.length)
					{
					for(int j=0;j<=17;j++)
					{
						if(j==0)
						{
							h3.put("d"+j,i+1);
						}
						else
						h3.put("d"+j, data3[i][j]);
						if(j==9)
						{
							String payamount=data3[i][j];
							Double ipayamount=Double.parseDouble(payamount);
							b+=ipayamount;
						}
						if(j==10)
						{
							String payamount=data3[i][j];
							Double ipayamount=Double.parseDouble(payamount);
							b1+=ipayamount;
						}
						if(j==12)
						{
							String payamount=data3[i][j];
							Double ipayamount=Double.parseDouble(payamount);
							b2+=ipayamount;
						}
						if(j==14)
						{
							String payamount=data3[i][j];
							Double ipayamount=Double.parseDouble(payamount);
							b3+=ipayamount;
						}
					}
					}
					else
					{
						h3.put("d8", "Grand Total :");
						h3.put("d9",b);
						h3.put("d10",b1);
						h3.put("d12",b2);
						h3.put("d14",b3);
					}
					al.add(h3);
				}
			}
			
			if(salestype.equals("A"))
			{
				Double c=0.00,c1=0.00,c2=0.00,c3=0.00;
				Double a=0.00,a1=0.00,a2=0.00,a3=0.00;
				Double b=0.00,b1=0.00,b2=0.00,b3=0.00;
				data1 = CommonFunctions.QueryExecute(sql1);
				data2 = CommonFunctions.QueryExecute(sql2);
				data3 = CommonFunctions.QueryExecute(sql3);
				 data4=new String[data1.length+data2.length+data3.length][18];
				 if(data4.length==0 )
						map.put("dataNotExist", "0");
					else
						map.put("dataNotExist", "1");
				map.put("saletype", "All Sale Types");
				if(data1.length>0)
				for(int i=0;i<data1.length;i++)
				{
					for(int j=1;j<=17;j++)
					{
						data4[i][j]= data1[i][j];
						if(j==9)
						{
							String payamount=data1[i][j];
							Double ipayamount=Double.parseDouble(payamount);
							c+=ipayamount;
						}
						if(j==10)
						{
							String payamount=data1[i][j];
							Double ipayamount=Double.parseDouble(payamount);
							c1+=ipayamount;
						}
						if(j==12)
						{
							String payamount=data1[i][j];
							Double ipayamount=Double.parseDouble(payamount);
							c2+=ipayamount;
						}
						if(j==14)
						{
							String payamount=data1[i][j];
							Double ipayamount=Double.parseDouble(payamount);
							c3+=ipayamount;
						}
					
					}
				}
				if(data2.length>0)
				{int k=0;
				for(int i=data1.length;i<data1.length+data2.length;i++)
				{
					
					for(int j=1;j<=17;j++)
					{
						data4[i][j]= data2[k][j];
						if(j==9)
						{
							String payamount=data2[k][j];
							Double ipayamount=Double.parseDouble(payamount);
							a+=ipayamount;
						}
						if(j==10)
						{
							String payamount=data2[k][j];
							Double ipayamount=Double.parseDouble(payamount);
							a1+=ipayamount;
						}
						if(j==12)
						{
							String payamount=data2[k][j];
							Double ipayamount=Double.parseDouble(payamount);
							a2+=ipayamount;
						}
						if(j==14)
						{
							String payamount=data2[k][j];
							Double ipayamount=Double.parseDouble(payamount);
							a3+=ipayamount;
						}
					}
					k++;
				}
				}
				if(data3.length>0)
				{
					int k=0;
				for(int i=data1.length+data2.length;i<data1.length+data2.length+data3.length;i++)
				{
					for(int j=1;j<=17;j++)
					{
						data4[i][j]= data3[k][j];
						if(j==9)
						{
							String payamount=data3[k][j];
							Double ipayamount=Double.parseDouble(payamount);
							b+=ipayamount;
						}
						if(j==10)
						{
							String payamount=data3[k][j];
							Double ipayamount=Double.parseDouble(payamount);
							b1+=ipayamount;
						}
						if(j==12)
						{
							String payamount=data3[k][j];
							Double ipayamount=Double.parseDouble(payamount);
							b2+=ipayamount;
						}
						if(j==14)
						{
							String payamount=data3[k][j];
							Double ipayamount=Double.parseDouble(payamount);
							b3+=ipayamount;
						}
					}
					k++;
				}
				}
				Double d=a+b+c;
				Double d1=a1+b1+c1;
				Double d2=a2+b2+c2;
				Double d3=a3+b3+c3;
				if(data4.length>0)
				for(int i=0;i<=data4.length;i++)
				{
					HashMap h3 = new HashMap();
					if(i!=data4.length)					
					for(int j=0;j<=17;j++)
					{
						if(j==0)
						{
							h3.put("d"+j,i+1);
						}
						else
							h3.put("d"+j, data4[i][j]);
					}
					else
					{
						h3.put("d8", "Grand Total :");
						h3.put("d9",d);
						h3.put("d10",d1);
						h3.put("d12",d2);
						h3.put("d14",d3);
					}
					al.add(h3);
				}
			}				
				if(!"0".equals(branchid))
				{
					data1 = CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID ="+branchid);
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
				if(status.equals("Y"))
					map.put("paymentStatus","Payment Received");
				else if(status.equals("N"))
					map.put("paymentStatus", "Payment Not Received");
								
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
		          
		          String title[]={"S.No.","Company","Invoice Type","Invoice Number","Customer Name","Division","Invoice Date","Commitment Date",
		        		  "Day Difference","Invoice Amount","Commitment Amount","Received Date","Received Amount","Description",
		        		  "Balance Amount","Commitment Status","Payment Status","Postpone Status"};
		          int datawidth[]={40,150,70,80,170,100,50,50,40,70,70,50,70,150,70,70,70,50};
		          
		          Style list[]={detailstyle,detailstyle,detailstyle,detailstyle,detailstyle,detailstyle,numberstyle,numberstyle,detailstyle,amountstyle,
		        		  amountstyle,numberstyle,amountstyle, detailstyle,amountstyle,detailstyle,detailstyle,detailstyle};
		         
		          for(int u=0;u<=17;u++)
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