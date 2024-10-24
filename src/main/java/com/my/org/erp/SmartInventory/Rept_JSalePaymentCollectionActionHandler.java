package com.my.org.erp.SmartInventory;
import java.awt.Color;
import java.io.File;

import java.io.FileNotFoundException;
import java.io.IOException;

import java.util.ArrayList;
import java.util.HashMap;

import java.util.List;

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

import com.my.org.erp.SmartReport.ReportFunctions;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;

public class Rept_JSalePaymentCollectionActionHandler extends AbstractActionHandler 
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
			
			if (action.equals("INVRept_JSalePaymentCollection")) 
			{
				String path=Path + "/report/Inventory/SalePaymentReports/" + rptfilename+".jrxml";
				File reportDir = new File(Path + "/report/Inventory/SalePaymentReports/" + rptfilename+".jrxml");
				HashMap<Object,Object> map = new HashMap<Object,Object>();
				String fromdate = request.getParameter("fromdate");
				String todate = request.getParameter("todate");
				String bank = request.getParameter("Bank");
				String customer = request.getParameter("customer");
				String Branch = request.getParameter("Branch");
				String Chequedt=request.getParameter("Chequedt");
				String division=request.getParameter("division");
				String Direct=request.getParameter("payType");
				String ref = request.getParameter("ref");
				String refsql="";
				
				
				if(!"0".equals(ref))
					refsql=" AND a.CHR_PAYEMENTCOLLECTEDBY='"+ref+"' ";
					 		
				String divsql="";
				if(!"0".equals(division))
					divsql=" AND d.INT_DIVIID="+division+" ";
				String fdt=DateUtil.FormateDateSQL(fromdate);
				String tdt=DateUtil.FormateDateSQL(todate);
				String mode="";
				
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
				sql1 = sql1+" SELECT a.CHR_SALESORDERNO ,e.CHR_COMPANYNAME,f.CHR_BRANCHNAME,g.CHR_DIVICODE,date_format(d.DAT_SALESDATE,'%d-%b-%Y') ," +
						"FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),FIND_A_BANKNAME_NAME(a.CHR_BANKNAME),a.CHR_PAYNO,date_format(a.CHR_CHKDATE,'%d-%b-%Y') ," +
						"datediff(a.CHR_CHKDATE,d.DAT_SALESDATE), a.CHR_REMARK ,(SELECT e.CHR_STAFFNAME FROM com_m_staff e WHERE e.CHR_EMPID=a.CHR_PAYEMENTCOLLECTEDBY)," +
						"date_format(a.DAT_PAYMENTDATE,'%d-%b-%Y'),a.DOU_PAIDAMOUNT FROM inv_t_customersalespayment a,";
				sql1 = sql1+" inv_m_customerinfo b ,inv_t_directsales d ,com_m_company e, com_m_branch f,inv_m_division g WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID ";
				sql1 = sql1+"   AND a.CHR_SALESORDERNO =d.CHR_SALESNO AND d.INT_BRANCHID = f.INT_BRANCHID AND f.INT_COMPANYID =e.INT_COMPANYID           AND d.INT_DIVIID = g.INT_DIVIID ";
				 if(!"0".equals(Branch))
					sql1 = sql1+" AND a.INT_BRANCHID ="+Branch;
				sql1 = sql1 + divsql +refsql;
				//if(!"0".equals(bank))
					//sql1 = sql1+" AND a.CHR_BANKNAME='"+bank+"' ";
				//	,com_m_bank c   AND a.CHR_BANKNAME = c.INT_BANKID   
					 
					
				if(!"0".equals(customer))	
					sql1 = sql1+" AND a.INT_CUSTOMERID="+customer;
					//,e.CHR_COMPANYNAME,f.CHR_BRANCHNAME   ,com_m_company e, com_m_branch f  AND d.INT_BRANCHID = f.INT_BRANCHID AND f.INT_COMPANYID =e.INT_COMPANYID 
				//INT_COMPANYID,CHR_COMPANYNAME   com_m_company INT_BRANCHID , CHR_BRANCHNAME com_m_branch
				if("2".equals(Chequedt))
					sql1 = sql1+" AND a.DAT_PAYMENTDATE<='"+tdt+"' AND a.DAT_PAYMENTDATE>='"+fdt+"' ";
				else
					sql1 = sql1+" AND a.CHR_CHKDATE<='"+tdt+"' AND a.CHR_CHKDATE>='"+fdt+"' ";
						
				sql1 = sql1+" ORDER BY a.CHR_SALESORDERNO ";
				System.out.println("sql1:"+sql1);
				 				
				sql2 =  sql2+" SELECT a.CHR_SALESNO ,e.CHR_COMPANYNAME,f.CHR_BRANCHNAME,g.CHR_DIVICODE,date_format(d.DAT_SALESDATE,'%d-%b-%Y') ," +
						"FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),FIND_A_BANKNAME_NAME(c.INT_BANKID),a.CHR_REFNO,date_format(a.CHR_CHKDATE,'%d-%b-%Y') ," +
						"datediff(a.CHR_CHKDATE,d.DAT_SALESDATE), a.CHR_REMARK ,(SELECT e.CHR_STAFFNAME FROM com_m_staff e " +
						"WHERE e.CHR_EMPID=a.CHR_PAYEMENTCOLLECTEDBY),date_format(a.DAT_PAYMENTDATE,'%d-%b-%Y'),a.DOU_PAIDAMOUNT   FROM inv_t_directbillingpayment a,";
					sql2 = sql2+" inv_m_customerinfo b,com_m_bank c  ,inv_t_directbilling d ,com_m_company e, com_m_branch f,inv_m_division g  WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID ";
					sql2 = sql2+"   AND a.CHR_SALESNO =d.CHR_SALESNO AND a.INT_BANKID = c.INT_BANKID AND d.INT_BRANCHID = f.INT_BRANCHID AND f.INT_COMPANYID =e.INT_COMPANYID    AND d.INT_DIVIID = g.INT_DIVIID ";
					
					//,e.CHR_COMPANYNAME,f.CHR_BRANCHNAME   ,com_m_company e, com_m_branch f  AND d.INT_BRANCHID = f.INT_BRANCHID AND f.INT_COMPANYID =e.INT_COMPANYID 
					if(!"0".equals(Branch))
						sql2 = sql2+" AND a.INT_BRANCHID ="+Branch;
					sql2 = sql2 + divsql+refsql;
					if(!"0".equals(bank))
						sql2 = sql2+" AND a.INT_BANKID='"+bank+"' ";
					if(!"0".equals(customer))	
						sql2 = sql2+" AND a.INT_CUSTOMERID="+customer;
					
					if("2".equals(Chequedt))
						sql2 = sql2+" AND a.DAT_PAYMENTDATE<='"+tdt+"' AND a.DAT_PAYMENTDATE>='"+fdt+"' ";
					else
						sql2 = sql2+" AND a.CHR_CHKDATE<='"+tdt+"' AND a.CHR_CHKDATE>='"+fdt+"' ";
							
					sql2 = sql2+" ORDER BY a.CHR_SALESNO ";
					System.out.println("sql2:"+sql2);
		
					mode = "SERVICE BILLING";
					sql3 = sql3+" SELECT a.CHR_SALESNO ,e.CHR_COMPANYNAME,f.CHR_BRANCHNAME,g.CHR_DIVICODE,date_format(d.DAT_SALESDATE,'%d-%b-%Y') ," +
							"FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),FIND_A_BANKNAME_NAME(c.INT_BANKID),a.CHR_REFNO,date_format(a.CHR_CHKDATE,'%d-%b-%Y') ," +
							"datediff(a.CHR_CHKDATE,d.DAT_SALESDATE), a.CHR_REMARK ,(SELECT e.CHR_STAFFNAME " +
							"FROM com_m_staff e WHERE e.CHR_EMPID=a.CHR_PAYEMENTCOLLECTEDBY),date_format(a.DAT_PAYMENTDATE,'%d-%b-%Y')," +
							"a.DOU_PAIDAMOUNT   FROM inv_t_servicebillingpayment a,";
					sql3 = sql3+" inv_m_customerinfo b,com_m_bank c  ,inv_t_servicebilling d ,com_m_company e, com_m_branch f,inv_m_division g  WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID ";
					sql3 = sql3+"   AND a.CHR_SALESNO =d.CHR_SALESNO AND a.INT_BANKID = c.INT_BANKID AND d.INT_BRANCHID = f.INT_BRANCHID AND f.INT_COMPANYID =e.INT_COMPANYID    AND d.INT_DIVIID = g.INT_DIVIID ";
					 //,e.CHR_COMPANYNAME,f.CHR_BRANCHNAME   ,com_m_company e, com_m_branch f  AND d.INT_BRANCHID = f.INT_BRANCHID AND f.INT_COMPANYID =e.INT_COMPANYID 
					if(!"0".equals(Branch))
						sql3 = sql3+" AND a.INT_BRANCHID ="+Branch;
					
					
					sql3 = sql3 + divsql+refsql;
					if(!"0".equals(bank))
						sql3 = sql3+" AND a.INT_BANKID='"+bank+"' ";
					if(!"0".equals(customer))	
						sql3 = sql3+" AND a.INT_CUSTOMERID="+customer;
					
					if("2".equals(Chequedt))
						sql3 = sql3+" AND a.DAT_PAYMENTDATE<='"+tdt+"' AND a.DAT_PAYMENTDATE>='"+fdt+"' ";
					else
						sql3 = sql3+" AND a.CHR_CHKDATE<='"+tdt+"' AND a.CHR_CHKDATE>='"+fdt+"' ";
							
					sql3 = sql3+" ORDER BY a.CHR_SALESNO ";

			System.out.println("sql3:"+sql3);
			//int d4length=data1.length+data2.length+data3.length;
			List<HashMap> al=new ArrayList<HashMap>();
		
			if(Direct.equals("Direct"))
			{
				Double c=0.00;
				data1 = CommonFunctions.QueryExecute(sql1);
				 if(data1.length==0 )
						map.put("dataNotExist", "0");
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
						else
						h3.put("d"+j, data1[i][j-2]);
						if(j==15)
						{
							String payamount=data1[i][j-2];
							Double ipayamount=Double.parseDouble(payamount);
							c+=ipayamount;
						}
						
					}
					}
					else
					{
						h3.put("d14", "Grand Total :");
						h3.put("d15",c);
						
					}
					
					al.add(h3);
				}
				
			}
			
			if(Direct.equals("DirectBilling"))
			{
				Double a=0.00;
				data2 = CommonFunctions.QueryExecute(sql2);
				 if(data2.length==0 )
						map.put("dataNotExist", "0");
				 
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
						else
						{
							h3.put("d"+j, data2[i][j-2]);
						}
						
						if(j==15)
						{
							String payamount=data2[i][j-2];
							Double ipayamount=Double.parseDouble(payamount);
							a+=ipayamount;
						}
					}
					}
					else
					{
						h3.put("d14", "Grand Total :");
						h3.put("d15",a);
					}
					al.add(h3);
			}
				
			}
			
			if(Direct.equals("ServiceBilling"))
			{
				Double b=0.00;
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
						
						else
						h3.put("d"+j, data3[i][j-2]);
						
						if(j==15)
						{
							String payamount=data3[i][j-2];
							Double ipayamount=Double.parseDouble(payamount);
							b+=ipayamount;
						}
						
						}
					}
					else
					{
						h3.put("d14", "Grand Total :");
						h3.put("d15",b);
						
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
				if(!"0".equals(bank))
				{
					 data1 = CommonFunctions.QueryExecute("SELECT  CHR_BANKGROUPNAME FROM com_m_bankgroup WHERE  INT_BANKGROUPID="+bank);
					if(!data1[0][0].equals(""))
							map.put("bank",data1[0][0]);
				}
				else
					map.put("bank","All Banks");
				if(!"0".equals(customer))
				{
					 data1 = CommonFunctions.QueryExecute("SELECT f.CHR_NAME,a.CHR_CONTACTPERSON, e.CHR_CITYNAME,d.CHR_DISTRICT,c.CHR_STATENAME,  CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE),CONCAT('Phone :',a.CHR_PHONE),CONCAT('E-Mail :',a.CHR_EMAIL) FROM  inv_m_customerinfo a, com_m_country b,com_m_state c,com_m_district d,com_m_city e  ,inv_m_customergroup f   WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID   AND a.INT_COUNTRYID = b.INT_COUNTRYID    AND a.INT_STATEID =c.INT_STATEID    AND a.INT_DISTRICTID= d.INT_DISTRICTID   AND a.INT_CITYID =e.INT_CITYID AND   a.INT_ACTIVE =1 AND a.CHR_VERIFIED ='Y'  AND a.INT_CUSTOMERID="+customer);
					if(!data1[0][0].equals(""))
							map.put("customer",data1[0][0]);
				}
				else
					map.put("customer","All Customers");
				if(!"0".equals(ref))
				{
					 data1 = CommonFunctions.QueryExecute("SELECT CHR_STAFFNAME  FROM com_m_staff WHERE CHR_HOLD!='Y'  AND CHR_TYPE!='T' AND CHR_EMPID='"+ref+"'");
					if(!data1[0][0].equals(""))
							map.put("staff",data1[0][0]);
				}
				else
					map.put("staff","All Reference Employees");
				if(Chequedt.equals("1"))
					map.put("Chequedt","Cheque Date");
				else if(Chequedt.equals("2"))
					map.put("Chequedt", "Cheque Received Date");
								
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
		          
		          String title[]={"S.No.","Invoice Type","Invoice Number","Company","Branch","Division","Invoice Date","Customer Nmae","Bank Name",
		        		  "Payment(Cheque) No","Cheque Date","Day Difference(Sale Dt & Cheque dt)","Payment Description","Payment Collected By",
		        		  "Cheque Received Date","Payment Amount"};
		          int datawidth[]={40,70,100,150,100,100,50,170,100,80,50,50,100,100,50,70};
		          
		          Style list[]={detailstyle,detailstyle,detailstyle,detailstyle,detailstyle,detailstyle,numberstyle,detailstyle,detailstyle,detailstyle,
		        		  numberstyle,detailstyle,detailstyle, detailstyle,numberstyle,amountstyle};
		         
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
			}
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