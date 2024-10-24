package com.my.org.erp.SmartInventory;

import java.math.BigDecimal;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.mail.Mail;
import com.my.org.erp.setting.CommonData;

public class InventoryFunctions 
{	
	public static String csql="";
	public static String today ="";
	public static void dailyCollectionReport() 
	 {
		try 
	 	{
	 		  csql="";
			  csql =" SELECT TIME_format(now(),'%H') ";
			  String timeData[][] = CommonFunctions.QueryExecute(" SELECT TIME_format(now(),'%H') ");
			  int currenttime = Integer.parseInt(timeData[0][0]);
			   
			  csql =" SELECT CHR_DAILY_COLLECTION_MAIL,INT_DAILY_COLLECTION_MAIL_TIME   FROM m_inventorysetting  WHERE INT_ROWID=1 ";
			  String settingData[][] = CommonFunctions.QueryExecute(csql);
			  boolean f = false;
			  if("Y".equals(settingData[0][0] ))
				  f = true;
			  
			  int settingtime = Integer.parseInt(settingData[0][1]);
			  today =CommonFunctions.QueryExecute(" SELECT date_format(now(),'%d-%m-%Y')")[0][0];
			 
			  if(f)
				  if(currenttime >=settingtime)
				  {
				  	csql =" select count(*) from  sendmail_to_t_payment_collection  WHERE CHR_DATE = date_format(now(),'%Y-%m-%d') ";
					if(!CommonFunctions.QueryExecute(csql)[0][0].equals("1")) 
					{
						csql = "";
						csql = csql + " INSERT INTO sendmail_to_t_payment_collection (CHR_DATE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS) ";
						csql = csql + " VALUES(date_format(now(),'%Y-%m-%d') ,'ADMIN' ,date_format(now(),'%Y-%m-%d') ,'Y') ";
						CommonFunctions.Execute(csql);
						dailyStockReport();
						
						Thread.sleep(2000);
						dailyCollectionReports();
						
						Thread.sleep(2000);
						dailyAdvanceReport();
						
						Thread.sleep(2000);
						dailyPendingpurchaseInvoice();
						
						Thread.sleep(2000);
						dailyDeliveryReport();
						
						Thread.sleep(2000);
						dailyInstallationReport() ;
						
						Thread.sleep(2000);
						dailySalesPaymentPending() ;
						
						Thread.sleep(2000);
						dailySalesPaymentCommitments();
						
						Thread.sleep(2000);
						todayPaymentCollections();
						
						Thread.sleep(2000);
						todaySales();
						
						Thread.sleep(2000);
						SFAScheduleEmployeewise();
						
						Thread.sleep(2000);
						SFAScheduleDivisionwise();
						
						  
						
						
						csql = "DELETE FROM sendmail_to_t_payment_collection  WHERE  CHR_DATE < date_format(now(),'%Y-%m-%d')  ";
						CommonFunctions.Execute(csql);
					}
				  }
				  
			
	 	}
	 	catch (Exception e) 
	 	{
	 		System.out.println(e.getMessage()); 
	 	}
	 	 
	 }
	
	
	public static  void  dailyCollectionReports() 
	 {
		String content="";
		content = content +" <style type='text/css'> ";
		content = content +" .boldred { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #FF0000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .boldgreen { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #006600; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .boldEleven { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .MRow1 { ";
		content = content +" BACKGROUND-COLOR: #fdfae7; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } ";
		content = content +" .MRow2 { ";
		content = content +" BACKGROUND-COLOR: #f2f2f2; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } "; 
		content = content +" </style> ";
		try 
	 	{
			csql="";
			csql = " SELECT a.CHR_SALESORDERNO , FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),c.CHR_BANKGROUPNAME,a.CHR_PAYNO,   ";
			csql = csql + " date_format(a.DAT_PAYMENTDATE,'%d-%b-%Y'),a.DOU_PAIDAMOUNT,date_format(a.CHR_CHKDATE,'%d-%b-%Y')";
			csql = csql + " ,date_format(d.DAT_SALESDATE,'%d-%b-%Y') ,a.CHR_REMARK     ";
			csql = csql + " ,(SELECT e.CHR_STAFFNAME FROM com_m_staff e WHERE e.CHR_EMPID=a.CHR_PAYEMENTCOLLECTEDBY),   ";
			csql = csql + " a.CHR_PAYEMENTCOLLECTEDBY     ";
			csql = csql + " ,e.CHR_COMPANYNAME,f.CHR_BRANCHNAME,datediff(a.CHR_CHKDATE,d.DAT_SALESDATE),g.CHR_DIVICODE    ";
			csql = csql + " FROM inv_t_customersalespayment a,   ";
			csql = csql + " inv_m_customerinfo b,com_m_bankgroup c  ,inv_t_directsales d ,com_m_company e, com_m_branch f,  ";
			csql = csql + " inv_m_division g WHERE a.INT_CUSTOMERID = b.INT_CUSTOMERID   ";
			csql = csql + " AND a.CHR_SALESORDERNO =d.CHR_SALESNO  AND d.CHR_CANCEL='N' AND d.INT_BRANCHID = f.INT_BRANCHID   ";
			csql = csql + " AND f.INT_COMPANYID =e.INT_COMPANYID  AND a.CHR_BANKNAME = c.INT_BANKGROUPID    ";
			csql = csql + " AND d.INT_DIVIID = g.INT_DIVIID   AND d.INT_DIVIID NOT IN(9) ";
			csql = csql + " AND a.DAT_PAYMENTDATE<= date_format(now(),'%Y-%m-%d') ";
			csql = csql + " AND a.DAT_PAYMENTDATE>=  date_format(now(),'%Y-%m-%d') ";
			csql = csql + " ORDER BY a.CHR_SALESORDERNO  ";
			String data[][] =CommonFunctions.QueryExecute(csql);
			 
			if(data.length>0)
			{
				content = content +" <table border='0'  width='95%' cellpadding=2 cellspacing=2  bgcolor='#000000' >" ;
				content = content +" <tr class='MRow1'>" ;
				content = content +" <td colspan='16'><b>PAYMENT COLLECTIONS</b></td>" ;
				content = content +" </tr>" ;
				content = content +" <tr  class='MRow2'>" ;
				content = content +" <td ><b>S.No</b></td>" ;
				content = content +" <td ><b>Invoice Type</b></td>" ;
				content = content +" <td ><b>Invoice Number</b></td>" ;
				content = content +" <td ><b>Company</b></td>" ;
				content = content +" <td ><b>Branch</b></td>" ;
				content = content +" <td ><b>Division</b></td>" ;
				content = content +" <td ><b>Invoice Date</b></td>" ;
				content = content +" <td ><b>Customer Name</b></td>" ;
				content = content +" <td ><b>Bank Name</b></td>" ;
				content = content +" <td ><b>Payment details</b></td>" ;
				content = content +" <td ><b>Cheque Date</b></td>" ;
				content = content +" <td ><b>Day Difference</b></td>" ;
				content = content +" <td ><b>Payment Description</b></td>" ;
				content = content +" <td ><b>Payment Collected BY</b></td>" ;
				content = content +" <td ><b>Payment Colleted Date</b></td>" ;
				content = content +" <td ><b>Paid Amount</b></td>" ;
				content = content +" </tr>" ;
				double sum=0.0;
				for(int u=0;u<data.length;u++)
				{
						if(u%2==0)
							content = content +" <tr class='MRow1' >" ;
						else
							content = content +" <tr  class='MRow2'  >" ;
						content = content +" <td >"+(u+1)+"</td>" ;
						content = content +" <td >DIRECT SALES</td>" ;
						content = content +" <td >"+data[u][0]+"</td>" ;
						content = content +" <td >"+data[u][11]+"</td>" ;
						content = content +" <td >"+data[u][12]+"</td>" ;
						content = content +" <td >"+data[u][14]+"</td>" ;
						content = content +" <td >"+data[u][7]+"</td>" ;
						content = content +" <td >"+data[u][1]+"</td>" ;
						content = content +" <td >"+data[u][2]+"</td>" ;
						content = content +" <td >"+data[u][3]+"</td>" ;
						content = content +" <td >"+data[u][6]+"</td>" ;
						content = content +" <td >"+data[u][13]+"</td>" ;
						content = content +" <td >"+data[u][8]+"</td>" ;
						content = content +" <td >"+data[u][9]+" / "+data[u][10]+"</td>" ;
						content = content +" <td >"+data[u][4]+"</td>" ;
						content = content +" <td  align='right'>"+data[u][5]+"</td>" ;
						content = content +" </tr>" ;
						sum = sum+Double.parseDouble(data[u][5]);
					
					 
				}
				content = content +" <tr class='MRow1' >" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >Total</td>" ;
				content = content +" <td align='right' >"+Math.round(sum)+"</td>" ;
				content = content +" </tr>" ;
				content = content +" </table>";		
				
				csql =" SELECT CHR_DAILY_COLLECTION_MAIL_IDS ";
				csql = csql + " FROM m_inventorysetting  WHERE INT_ROWID=1 ";
				String  settingmailids =  CommonFunctions.QueryExecute(csql)[0][0] ;
			    
				String a[] =(settingmailids+","+CommonData.mailid).split(",") ;
				Mail.SimpleHTMLMail(a,today +" Payment collection.. ", content);
				
			}
			 
	 	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		 
	}
	
	
	
	
	public static void  dailyAdvanceReport() 
	 {
		String content="";
		content = content +" <style type='text/css'> ";
		content = content +" .boldred { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #FF0000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .boldgreen { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #006600; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .boldEleven { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .MRow1 { ";
		content = content +" BACKGROUND-COLOR: #fdfae7; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } ";
		content = content +" .MRow2 { ";
		content = content +" BACKGROUND-COLOR: #f2f2f2; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } "; 
		content = content +" </style> ";
		try 
	 	{
			csql = "";
			csql = csql + " SELECT a.CHR_ADVANCEID,b.CHR_BRANCHNAME,c.CHR_DIVICODE,FIND_A_CUSTOMER_NAME(d.INT_CUSTOMERID),e.CHR_PAYMENTNAME, ";
			csql = csql + " f.CHR_BANKGROUPNAME,a.CHR_PAYNO,DATE_FORMAT(a.DAT_PAYMENTDATE,'%d-%b-%Y'), ";
			csql = csql + " DATE_FORMAT(a.DAT_COLLECTEDDATE,'%d-%b-%Y'),a.DOU_ADVANCEAMOUNT,FIND_A_EMPLOYEE_ID_NAME(a.CHR_COLLECTEDBY) ";
			csql = csql + " FROM inv_t_advancepayment a, com_m_branch b, inv_m_division c, inv_m_customerinfo d, ";
			csql = csql + " inv_m_paymentterms e,com_m_bankgroup f ";
			csql = csql + " WHERE a.INT_BRANCHID = b.INT_BRANCHID ";
			csql = csql + " AND a.INT_DIVIID =c.INT_DIVIID ";
			csql = csql + " AND a.INT_CUSTOMERID = d.INT_CUSTOMERID ";
			csql = csql + " AND a.INT_PAYMENTTERMID =e.INT_PAYMENTTERMID ";
			csql = csql + " AND a.INT_BANKID = f.INT_BANKGROUPID ";
			csql = csql + " AND a.DAT_PAYMENTDATE<= date_format(now(),'%Y-%m-%d')  ";
			csql = csql + " AND a.DAT_PAYMENTDATE>=  date_format(now(),'%Y-%m-%d') "; 
			csql = csql + " ORDER BY a.INT_ADVANCEID ";
			String Adata[][] =CommonFunctions.QueryExecute(csql);
			
			if(Adata.length>0)
			{
				content = content +" ";
				content = content +" <table  border='0' width='95%' cellpadding=2 cellspacing=2  bgcolor='#000000' >" ;
				content = content +" <tr class='MRow1'>" ;
				content = content +" <td colspan='12'><b><br><br><center><font color='red'>ADVANCE AMOUNT</font></center><br><br></b></td>" ;
				content = content +" </tr>" ;
				content = content +" <tr class='MRow2' >" ;
				content = content +" <td ><b>S.No</b></td>" ;
				content = content +" <td ><b>Advance No</b></td>" ;
				content = content +" <td ><b>Branch</b></td>" ;
				content = content +" <td ><b>Division</b></td>" ;
				content = content +" <td ><b>Customer Name</b></td>" ;
				content = content +" <td ><b>Payment Terms</b></td>" ;
				content = content +" <td ><b>Bank Name</b></td>" ;
				content = content +" <td ><b>Payment details</b></td>" ;
				content = content +" <td ><b>Cheque Date</b></td>" ;
				content = content +" <td ><b>Colleted Date</b></td>" ;
				content = content +" <td ><b>Advance Amount</b></td>" ;
				content = content +" <td ><b>Collected BY</b></td>" ;
				content = content +" </tr>" ;
				double sum=0.0;
				for(int u=0;u<Adata.length;u++)
				{
						if(u%2==0)
							content = content +" <tr class='MRow1' >" ;
						else
							content = content +" <tr  class='MRow2'  >" ;
	
						content = content +" <td >"+(u+1)+"</td>" ;
						content = content +" <td >"+Adata[u][0]+"</td>" ;
						content = content +" <td >"+Adata[u][1]+"</td>" ;
						content = content +" <td >"+Adata[u][2]+"</td>" ;
						content = content +" <td >"+Adata[u][3]+"</td>" ;
						content = content +" <td >"+Adata[u][4]+"</td>" ;
						content = content +" <td >"+Adata[u][5]+"</td>" ;
						content = content +" <td >"+Adata[u][6]+"</td>" ;
						content = content +" <td >"+Adata[u][7]+"</td>" ;
						content = content +" <td  align='right'>"+Adata[u][8]+"</td>" ;
						content = content +" <td >"+Adata[u][9]+"</td>" ;
						content = content +" <td >"+Adata[u][10]+"</td>" ;
						content = content +" </tr>" ;
						sum = sum+Double.parseDouble(Adata[u][8]);
				}
				content = content +" <tr class='MRow1'>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td ><B>Total : </B></td>" ;
				content = content +" <td  align='right'>"+Math.round(sum)+"</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" </tr>" ;
				content = content +" </table>";	
				
				csql =" SELECT CHR_DAILY_COLLECTION_MAIL_IDS ";
				csql = csql + " FROM m_inventorysetting  WHERE INT_ROWID=1 ";
				String  settingmailids =  CommonFunctions.QueryExecute(csql)[0][0] ;
			    
				String a[] =(settingmailids+","+CommonData.mailid).split(",") ;
				Mail.SimpleHTMLMail(a,today +" Advance collection.. ", content);
				 
				
			}
			
			
			
	 	}
		catch(Exception e)
		{
				System.out.println(e.getMessage());
		}
		 
	}
	
	
	
	
	public static void  dailyPendingpurchaseInvoice() 
	 {
		String content="";
		content = content +" <style type='text/css'> ";
		content = content +" .boldred { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #FF0000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .boldgreen { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #006600; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .boldEleven { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .MRow1 { ";
		content = content +" BACKGROUND-COLOR: #fdfae7; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } ";
		content = content +" .MRow2 { ";
		content = content +" BACKGROUND-COLOR: #f2f2f2; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } "; 
		content = content +" </style> ";
		try 
	 	{
			csql = "";
			csql = csql + " SELECT d.CHR_BRANCHNAME, a.CHR_PURCHASEORDERNO,b.CHR_VENDORNAME,DATE_FORMAT(a.DAT_ORDERDATE,'%d-%b-%Y'), "; 
			csql = csql + " if(a.CHR_PAYMENTSTATUS='Y','Closed','Pending')  , ";
			csql = csql + " if(a.CHR_ACCOUNTFLAG='Y','Received','Not Received'), a.DOU_TOTALAMOUNT "; 
			csql = csql + " FROM inv_t_directpurchase a ,  inv_m_vendorsinformation  b , com_m_branch d ";
			csql = csql + " where  a.INT_VENDORID = b.INT_VENDORID AND a.INT_BRANCHID =d.INT_BRANCHID AND a.CHR_ACCOUNTFLAG='N' "; 
			csql = csql + " AND a.DAT_ORDERDATE<= date_format(now(),'%Y-%m-%d')  ";
			csql = csql + " order by a.DAT_ORDERDATE   ";
			String Adata[][] =CommonFunctions.QueryExecute(csql);
			if(Adata.length>0)
			{
				 
				content = content +" <table  border='0' width='95%' cellpadding=2 cellspacing=2  bgcolor='#000000' >" ;
				content = content +" <tr class='MRow1'>" ;
				content = content +" <td colspan='7'><b><br><br><center><font color='red'>PENDING PURCHASE INVOICE</font></center><br><br></b></td>" ;
				content = content +" </tr>" ;
				content = content +" <tr  class='MRow2'>" ;
				content = content +" <td ><b>S.No</b></td>" ;
				content = content +" <td ><b>P.O</b></td>" ;
				content = content +" <td ><b>Vendor Name</b></td>" ;
				content = content +" <td ><b>Order Date</b></td>" ;
				content = content +" <td ><b>Payment</b></td>" ;
				content = content +" <td ><b>P.O Status</b></td>" ;
				content = content +" <td ><b>P.O Amount </b></td>" ;
				content = content +" </tr>" ;
				double sum=0.0;
				for(int u=0;u<Adata.length;u++)
				{

						if(u%2==0)
							content = content +" <tr class='MRow1' >" ;
						else
							content = content +" <tr  class='MRow2'  >" ;
						content = content +" <td >"+(u+1)+"</td>" ;
						content = content +" <td >"+Adata[u][1]+"</td>" ;
						content = content +" <td >"+Adata[u][2]+"</td>" ;
						content = content +" <td >"+Adata[u][3]+"</td>" ;
						content = content +" <td >"+Adata[u][4]+"</td>" ;
						content = content +" <td >"+Adata[u][5]+"</td>" ;
						content = content +" <td align='right' >"+Adata[u][6]+"</td>" ;
						sum = sum+Double.parseDouble(Adata[u][6]);
				}
				content = content +" <tr class='MRow1' >" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td >&nbsp;</td>" ;
				content = content +" <td ><B>Total : </B></td>" ;
				content = content +" <td  align='right'>"+Math.round(sum)+"</td>" ;
				content = content +" </tr>" ;
				content = content +" </table>";	
				
				csql =" SELECT CHR_DAILY_COLLECTION_MAIL_IDS ";
				csql = csql + " FROM m_inventorysetting  WHERE INT_ROWID=1 ";
				String  settingmailids =  CommonFunctions.QueryExecute(csql)[0][0] ;
			    
				String a[] =(settingmailids+","+CommonData.mailid).split(",") ;
				Mail.SimpleHTMLMail(a,today +" Purchase Bills are not received", content);
			}
			
			
			 
	 	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		 
	}
	
	
	
	

	public static void  dailyDeliveryReport() 
	 {
		String content="";
		content = content +" <style type='text/css'> ";
		content = content +" .boldred { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #FF0000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .boldgreen { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #006600; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .boldEleven { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		content = content +" .MRow1 { ";
		content = content +" BACKGROUND-COLOR: #fdfae7; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } ";
		content = content +" .MRow2 { ";
		content = content +" BACKGROUND-COLOR: #f2f2f2; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } "; 
		content = content +" </style> ";
		try 
	 	{
			csql = "";
			csql = csql + " SELECT b.CHR_BRANCHNAME,c.CHR_DIVICODE,a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'), ";
			csql = csql + " FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID ), ";
			csql = csql + " FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF),a.DOU_TOTALAMOUNT , ";
			csql = csql + " if(a.CHR_DELIVERY='P','PROGRESS',if(a.CHR_DELIVERY='Y','DELIVERED',if(a.CHR_DELIVERY='R','REJECT','PENDING'))) ";
			csql = csql + " FROM inv_t_directsales a, com_m_branch b, inv_m_division c ";
			csql = csql + " WHERE a.INT_BRANCHID =b.INT_BRANCHID AND a.CHR_DELIVERY !='Y'   AND a.CHR_CANCEL='N' ";  
			csql = csql + " AND a.INT_SALESSTATUS='1' AND a.INT_DIVIID = c.INT_DIVIID ";
			csql = csql + " AND a.DAT_SALESDATE >=  DATE_SUB(NOW(), INTERVAL 1 MONTH) "; 
			csql = csql + " ORDER BY a.DAT_SALESDATE,a.CHR_SALESNO ";
			String Adata[][] =CommonFunctions.QueryExecute(csql);
			
			if(Adata.length>0)
			{
				content = content +" <table  border='0' width='95%' cellpadding=2 cellspacing=2  bgcolor='#000000' >" ;
				content = content +" <tr class='MRow1'>" ;
				content = content +" <td colspan='9'><b> <br><br><center><font color='red'>DELIVERY PENDING</font></center><br><br></b></td>" ;
				content = content +" </tr>" ;
				content = content +" <tr  class='MRow2'>" ;
				content = content +" <td ><b>S.No</b></td>" ;
				content = content +" <td ><b>Branch</b></td>" ;
				content = content +" <td ><b>Division</b></td>" ;
				content = content +" <td ><b>Invoice Number</b></td>" ;
				content = content +" <td ><b>Invoice Date</b></td>" ;
				content = content +" <td ><b>Customer Name </b></td>" ;
				content = content +" <td ><b>BY</b></td>" ;
				content = content +" <td ><b>Invoice Amount</b></td>" ;
				content = content +" <td ><b>Delivery</b></td>" ;
				content = content +" </tr>" ;
			
				for(int u=0;u<Adata.length;u++)
				{
					if(u%2==0)
						content = content +" <tr class='MRow1' >" ;
					else
						content = content +" <tr  class='MRow2'  >" ;

					content = content +" <td >"+(u+1)+"</td>" ;
					content = content +" <td >"+Adata[u][0]+"</td>" ;
					content = content +" <td >"+Adata[u][1]+"</td>" ;
					content = content +" <td >"+Adata[u][2]+"</td>" ;
					content = content +" <td >"+Adata[u][3]+"</td>" ;
					content = content +" <td >"+Adata[u][4]+"</td>" ;
					content = content +" <td >"+Adata[u][5]+"</td>" ;
					content = content +" <td >"+Adata[u][6]+"</td>" ;
					content = content +" <td >"+Adata[u][7]+"</td>" ;
					content = content +" </tr>" ;
				}
				content = content +" </table>";	
				
				csql =" SELECT CHR_DAILY_COLLECTION_MAIL_IDS ";
				csql = csql + " FROM m_inventorysetting  WHERE INT_ROWID=1 ";
				String  settingmailids =  CommonFunctions.QueryExecute(csql)[0][0] ;
			    
				String a[] =(settingmailids+","+CommonData.mailid).split(",") ;
				Mail.SimpleHTMLMail(a,today +" Delivery status pending  ", content);
			}
			
			
	 	}
		catch(Exception e)
		{
				System.out.println(e.getMessage());
		}
		 
	}

	
	


	public static void  dailyInstallationReport() 
	 {
		String content="";
		content = content +" <style type='text/css'> ";
		content = content +" .boldred { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #FF0000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		
		content = content +" .boldgreen { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #006600; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		

		content = content +" .boldEleven { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		
		content = content +" .MRow1 { ";
		content = content +" BACKGROUND-COLOR: #fdfae7; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } ";
		 

		content = content +" .MRow2 { ";
		content = content +" BACKGROUND-COLOR: #f2f2f2; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } "; 

		content = content +" </style> ";
		try 
	 	{
			csql = "";
			csql = csql + " SELECT b.CHR_BRANCHNAME,c.CHR_DIVICODE,a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'), "; 
			csql = csql + " FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID ),  ";
			csql = csql + " FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF),a.DOU_TOTALAMOUNT ,  ";
			csql = csql + " if(a.CHR_DELIVERY='P','PROGRESS',if(a.CHR_DELIVERY='Y','DELIVERED',if(a.CHR_DELIVERY='R','REJECT','PENDING'))) , ";
			csql = csql + " if(a.CHR_INSTALLATION_STATUS='Y','Engineer Assigned','Engineer Not Assigned') ";
			csql = csql + " FROM inv_t_directsales a, com_m_branch b, inv_m_division c ";
			csql = csql + " WHERE a.INT_BRANCHID =b.INT_BRANCHID    AND a.CHR_CANCEL='N' ";
			csql = csql + " AND a.CHR_DELIVERY ='Y'  AND a.CHR_INSTALLATION='Y' ";
			csql = csql + " AND a.INT_SALESSTATUS='1'  ";
			csql = csql + " AND a.INT_DIVIID = c.INT_DIVIID  ";
			csql = csql + " AND a.DAT_SALESDATE >=  '2013-07-01'  ";
			csql = csql + " ORDER BY a.DAT_SALESDATE,a.CHR_SALESNO "; 
			 
			String Adata[][] =CommonFunctions.QueryExecute(csql);
			
			if(Adata.length>0)
			{
				
				content = content +" <table  border='0' width='95%' cellpadding=2 cellspacing=2  bgcolor='#000000' >" ;
				
				content = content +" <tr class='MRow1'>" ;
				content = content +" <td colspan='10'><b><br><br><center><font color='red'>INSTALLATION PENDING</font></center><br><br></b></td>" ;
				content = content +" </tr>" ;
				
				content = content +" <tr  class='MRow2'>" ;
				content = content +" <td ><b>S.No</b></td>" ;
				content = content +" <td ><b>Branch</b></td>" ;
				content = content +" <td ><b>Division</b></td>" ;
				content = content +" <td ><b>Invoice Number</b></td>" ;
				content = content +" <td ><b>Invoice Date</b></td>" ;
				content = content +" <td ><b>Customer Name </b></td>" ;
				content = content +" <td ><b>BY</b></td>" ;
				content = content +" <td ><b>Invoice Amount</b></td>" ;
				content = content +" <td ><b>Delivery</b></td>" ;
				content = content +" <td ><b>Installation</b></td>" ;
				content = content +" </tr>" ;
			
				for(int u=0;u<Adata.length;u++)
				{
					if(u%2==0)
						content = content +" <tr class='MRow1' >" ;
					else
						content = content +" <tr  class='MRow2'  >" ;

					
						content = content +" <td >"+(u+1)+"</td>" ;
						content = content +" <td >"+Adata[u][0]+"</td>" ;
						content = content +" <td >"+Adata[u][1]+"</td>" ;
						content = content +" <td >"+Adata[u][2]+"</td>" ;
						content = content +" <td >"+Adata[u][3]+"</td>" ;
						content = content +" <td >"+Adata[u][4]+"</td>" ;
						content = content +" <td >"+Adata[u][5]+"</td>" ;
						content = content +" <td >"+Adata[u][6]+"</td>" ;
						content = content +" <td >"+Adata[u][7]+"</td>" ;
						content = content +" <td >"+Adata[u][8]+"</td>" ;
						content = content +" </tr>" ;
				}
				content = content +" </table>";	
				csql =" SELECT CHR_DAILY_COLLECTION_MAIL_IDS ";
				csql = csql + " FROM m_inventorysetting  WHERE INT_ROWID=1 ";
				String  settingmailids =  CommonFunctions.QueryExecute(csql)[0][0] ;
			    
				String a[] =(settingmailids+","+CommonData.mailid).split(",") ;
				Mail.SimpleHTMLMail(a,today +"  Installation status pending ", content);
			}
			
			
	 	}
		catch(Exception e)
		{
				System.out.println(e.getMessage());
		}
		 
	}
	
	
	


	public static void  dailySalesPaymentPending() 
	 {
		String content="";
		content = content +" <style type='text/css'> ";
		content = content +" .boldred { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #FF0000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		
		content = content +" .boldgreen { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #006600; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		

		content = content +" .boldEleven { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		
		content = content +" .MRow1 { ";
		content = content +" BACKGROUND-COLOR: #fdfae7; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } ";
		 

		content = content +" .MRow2 { ";
		content = content +" BACKGROUND-COLOR: #f2f2f2; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } "; 

		content = content +" </style> ";
		try 
	 	{
			csql = "";
			csql = csql + " SELECT ";
			csql = csql + " d.CHR_DIVICODE, ";
			csql = csql + " FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID) , c.CHR_STAFFNAME, ";
			csql = csql + " a.CHR_SALESNO, ";
			csql = csql + " a.DOU_TOTALAMOUNT, ";
			csql = csql + " FUN_GET_PAIDAMOUNT(a.CHR_SALESNO), "; 
			csql = csql + " (a.DOU_TOTALAMOUNT- FUN_GET_PAIDAMOUNT(a.CHR_SALESNO)) balance, ";
			csql = csql + "  DATE_FORMAT(a.DAT_SALESDATE,'%e-%M-%Y'), ";
			csql = csql + " ( SELECT DATE_FORMAT(max(h.DT_COMMITMENTDATE ),'%e-%M-%Y') FROM inv_t_paymentcommitment h WHERE a.CHR_SALESNO = h.CHR_SALESNO ) ,  ";
			csql = csql + " DATEDIFF(( SELECT max(h.DT_COMMITMENTDATE ) FROM inv_t_paymentcommitment h WHERE a.CHR_SALESNO = h.CHR_SALESNO ),a.DAT_SALESDATE) , ";
			csql = csql + " DATEDIFF(DATE(NOW()),( SELECT max(h.DT_COMMITMENTDATE ) FROM inv_t_paymentcommitment h WHERE a.CHR_SALESNO = h.CHR_SALESNO )) "; 
			csql = csql + " from inv_t_directsales a ,inv_m_customerinfo b ,com_m_staff c ,inv_m_division d, "; 
			csql = csql + " inv_t_paymentcommitment g   ";
			csql = csql + " WHERE a.CHR_PAYMENTSTATUS !='Y'    AND a.CHR_CANCEL='N' ";
			csql = csql + " AND a.CHR_SALESNO = g.CHR_SALESNO ";  
			csql = csql + " AND g.CHR_INVOICETYPE='C'  ";
			csql = csql + " AND a.INT_SALESSTATUS=1  ";
			csql = csql + " AND a.CHR_PAYMENTSTATUS !='S'  ";
			csql = csql + " AND a.INT_CUSTOMERID = b.INT_CUSTOMERID ";
			csql = csql + " AND a.CHR_REF = c.CHR_EMPID  ";
			csql = csql + " AND a.INT_DIVIID=d.INT_DIVIID "; 
			csql = csql + " AND datediff(now(),a.DAT_SALESDATE)>=25  ";
			csql = csql + " GROUP BY a.CHR_SALESNO ORDER BY  a.DAT_SALESDATE "; 
		 	
			String Adata[][] =CommonFunctions.QueryExecute(csql);
			if(Adata.length>0)
			{
				content = content +" ";
				content = content +" <table  border='0' width='95%' cellpadding=2 cellspacing=2  bgcolor='#000000' >" ;
				
				content = content +" <tr class='MRow1'>" ;
				content = content +" <td colspan='12'><b><br><br><center><font color='red'>SALES PAYMENT PENDING</font></center><br><br></b></td>" ;
				content = content +" </tr>" ;

				
				content = content +" <tr class='MRow2'>" ;
				content = content +" <td ><b>S.No</b></td>" ;
				content = content +" <td ><b>Division</b></td>" ;
				content = content +" <td ><b>Customer</b></td>" ;
				content = content +" <td ><b>M.E Name</b></td>" ;
				content = content +" <td ><b>Sales Number</b></td>" ;
				content = content +" <td ><b>Net Amount</b></td>" ;
				content = content +" <td ><b>Paid Amount</b></td>" ;
				content = content +" <td ><b>Balance</b></td>" ;
				content = content +" <td ><b>Sale Date</b></td>" ;
				content = content +" <td ><b>Last Commitment Date</b></td>" ;
				content = content +" <td ><b>Given Days</b></td>" ;
				content = content +" <td ><b>Over due</b></td>" ;
				content = content +" </tr>" ;
			
				for(int u=0;u<Adata.length;u++)
				{
						if(u%2==0)
							content = content +" <tr class='MRow1' >" ;
						else
							content = content +" <tr  class='MRow2'  >" ;

						content = content +" <td>"+(u+1)+"</td>" ;
						content = content +" <td>"+Adata[u][0]+"</td>" ;
						content = content +" <td>"+Adata[u][1]+"</td>" ;
						content = content +" <td>"+Adata[u][2]+"</td>" ;
						content = content +" <td>"+Adata[u][3]+"</td>" ;
						content = content +" <td align='right'>"+Adata[u][4]+"</td>" ;
						content = content +" <td align='right'>"+Adata[u][5]+"</td>" ;
						content = content +" <td align='right'>"+Adata[u][6]+"</td>" ;
						content = content +" <td>"+Adata[u][7]+"</td>" ;
						content = content +" <td>"+Adata[u][8]+"</td>" ;
						content = content +" <td align='right'>"+Adata[u][9]+"</td>" ;
						content = content +" <td align='right'>"+Adata[u][10]+"</td>" ;
						content = content +" </tr>" ;
				}
				content = content +" </table>";	
				csql =" SELECT CHR_DAILY_COLLECTION_MAIL_IDS ";
				csql = csql + " FROM m_inventorysetting  WHERE INT_ROWID=1 ";
				String  settingmailids =  CommonFunctions.QueryExecute(csql)[0][0] ;
				
			    String a[] =(settingmailids+","+CommonData.mailid).split(",") ;
				Mail.SimpleHTMLMail(a,today +" Payment pending   ", content);
			}
			
			
	 	}
		catch(Exception e)
		{
				System.out.println(e.getMessage());
		}
		 
	}
	
	
	

	public static void  dailySalesPaymentCommitments() 
	 {
		String content="";
		content = content +" <style type='text/css'> ";
		content = content +" .boldred { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #FF0000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		
		content = content +" .boldgreen { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #006600; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		

		content = content +" .boldEleven { ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
		content = content +" TEXT-DECORATION: none ";
		content = content +" } ";
		
		content = content +" .MRow1 { ";
		content = content +" BACKGROUND-COLOR: #fdfae7; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } ";
		 

		content = content +" .MRow2 { ";
		content = content +" BACKGROUND-COLOR: #f2f2f2; ";
		content = content +" FONT-WEIGHT: normal; ";
		content = content +" FONT-SIZE: 10px; ";
		content = content +" COLOR: #000000; ";
		content = content +" LINE-HEIGHT: 15px; ";
		content = content +" FONT-FAMILY: Verdana; ";
		content = content +" TEXT-DECORATION: none; ";
		content = content +" } "; 

		 
 

		
		content = content +" </style> ";
		try 
	 	{
			csql = "";
			csql = csql + " SELECT a.CHR_SALESNO,  ";
			csql = csql + " FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ,  ";
			csql = csql + " FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF),  a.DOU_TOTALAMOUNT, FUN_GET_PAIDAMOUNT(a.CHR_SALESNO), "; 
			csql = csql + " (a.DOU_TOTALAMOUNT- FUN_GET_PAIDAMOUNT(a.CHR_SALESNO)) balance, ";
			csql = csql + " DATE_FORMAT(a.DAT_SALESDATE,'%e-%M-%Y'),  "; 
			csql = csql + " FUN_GET_NOOFCOMMITMENT(a.CHR_SALESNO), ";
			csql = csql + " DATE_FORMAT(b.DT_COMMITMENTDATE,'%e-%M-%Y') , ";
			csql = csql + " a.INT_PAYMENT_COMMITMENT_DAYS, ";
			csql = csql + " datediff(now(),b.DT_COMMITMENTDATE),   ";
			csql = csql + " (DATE(NOW()) >= b.DT_COMMITMENTDATE)  ";
			csql = csql + " FROM  inv_t_directsales a, inv_t_paymentcommitment b "; 
			csql = csql + " WHERE a.CHR_SALESNO = b.CHR_SALESNO   ";
			csql = csql + " AND b.CHR_INVOICETYPE = 'C'    AND a.CHR_CANCEL='N' ";
			csql = csql + " AND b.CHR_PAYMENTFLAG ='N'    AND b.CHR_NEXTFLAG ='N' "; 
			csql = csql + " AND a.INT_SALESSTATUS=1    ";
			csql = csql + " AND b.DT_COMMITMENTDATE <= DATE_ADD(DATE(NOW()), INTERVAL 15 DAY) "; 
			csql = csql + " AND  (a.DOU_TOTALAMOUNT- FUN_GET_PAIDAMOUNT(a.CHR_SALESNO))  >0 "; 
			csql = csql + " ORDER BY a.INT_SALESID ";
			 
			String Adata[][] =CommonFunctions.QueryExecute(csql);
			if(Adata.length>0)
			{
				content = content +" <table  border='0' width='95%' cellpadding=2 cellspacing=2  bgcolor='#000000' >" ;
				content = content +" <tr class='MRow1'>" ;
				content = content +" <td colspan='12'><b><br><br><center><font color='red'>PAYMENT COMMITMENT PENDING</font></center><br><br></b></td>" ;
				content = content +" </tr>" ;
				content = content +" <tr class='MRow2'>" ;
				content = content +" <td ><b>S.No</b></td>" ;
				content = content +" <td ><b>Sales Number</b></td>" ;
				content = content +" <td ><b>Customer</b></td>" ;
				content = content +" <td ><b>M.E Name</b></td>" ;
				content = content +" <td ><b>Net Amount</b></td>" ;
				content = content +" <td ><b>Paid Amount</b></td>" ;
				content = content +" <td ><b>Balance</b></td>" ;
				content = content +" <td ><b>Sale Date</b></td>" ;
				content = content +" <td ><b>No of Commitment</b></td>" ;
				content = content +" <td ><b>Commitment Date</b></td>" ;
				content = content +" <td ><b>Commitment Given</b></td>" ;
				content = content +" <td ><b>Over Due</b></td>" ;
				content = content +" </tr>" ;
			
				for(int u=0;u<Adata.length;u++)
				{
						
						if(u%2==0)
							content = content +" <tr class='MRow1' >" ;
						else
							content = content +" <tr  class='MRow2'  >" ;
						
						if("1".equals(Adata[u][11]))
						{
							
							content = content +" <td class='boldred'>"+(u+1)+"</td>" ;
							content = content +" <td class='boldred'>"+Adata[u][0]+"</td>" ;
							content = content +" <td class='boldred'>"+Adata[u][1]+"</td>" ;
							content = content +" <td class='boldred'>"+Adata[u][2]+"</td>" ;
							content = content +" <td class='boldred' align='right'>"+Adata[u][3]+"</td>" ;
							content = content +" <td class='boldred'>"+Adata[u][4]+"</td>" ;
							content = content +" <td class='boldred'>"+Adata[u][5]+"</td>" ;
							content = content +" <td class='boldred' align='right'>"+Adata[u][6]+"</td>" ;
							content = content +" <td class='boldred'>"+Adata[u][7]+"</td>" ;
							content = content +" <td class='boldred'>"+Adata[u][8]+"</td>" ;
							content = content +" <td class='boldred'>"+Adata[u][9]+"</td>" ;
							content = content +" <td class='boldred'>"+Adata[u][10]+"</td>" ;
							content = content +" </tr>" ;
						}	
						else
						{
							
							content = content +" <td class='boldgreen'>"+(u+1)+"</td>" ;
							content = content +" <td class='boldgreen'>"+Adata[u][0]+"</td>" ;
							content = content +" <td class='boldgreen'>"+Adata[u][1]+"</td>" ;
							content = content +" <td class='boldgreen'>"+Adata[u][2]+"</td>" ;
							content = content +" <td class='boldgreen' align='right'>"+Adata[u][3]+"</td>" ;
							content = content +" <td class='boldgreen'>"+Adata[u][4]+"</td>" ;
							content = content +" <td class='boldgreen'>"+Adata[u][5]+"</td>" ;
							content = content +" <td class='boldgreen' align='right'>"+Adata[u][6]+"</td>" ;
							content = content +" <td class='boldgreen'>"+Adata[u][7]+"</td>" ;
							content = content +" <td class='boldgreen'>"+Adata[u][8]+"</td>" ;
							content = content +" <td class='boldgreen'>"+Adata[u][9]+"</td>" ;
							content = content +" <td class='boldgreen'>"+Adata[u][10]+"</td>" ;
							content = content +" </tr>" ;
						}	
						
				}
				content = content +" </table>";	
				csql =" SELECT CHR_DAILY_COLLECTION_MAIL_IDS ";
				csql = csql + " FROM m_inventorysetting  WHERE INT_ROWID=1 ";
				String  settingmailids =  CommonFunctions.QueryExecute(csql)[0][0] ;
				
			    String a[] =(settingmailids+","+CommonData.mailid).split(",") ;
				Mail.SimpleHTMLMail(a,today +" Commitment   ", content);
			}
			
			
	 	}
		catch(Exception e)
		{
				System.out.println(e.getMessage());
		}
		
		
		
	 }
		
	 
		public static void  dailyStockReport() 
		 {
			String content="";
			content = content +" <style type='text/css'> ";
			content = content +" .boldred { ";
			content = content +" FONT-WEIGHT: normal; ";
			content = content +" FONT-SIZE: 10px; ";
			content = content +" COLOR: #FF0000; ";
			content = content +" LINE-HEIGHT: 15px; ";
			content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
			content = content +" TEXT-DECORATION: none ";
			content = content +" } ";
			
			content = content +" .boldgreen { ";
			content = content +" FONT-WEIGHT: normal; ";
			content = content +" FONT-SIZE: 10px; ";
			content = content +" COLOR: #006600; ";
			content = content +" LINE-HEIGHT: 15px; ";
			content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
			content = content +" TEXT-DECORATION: none ";
			content = content +" } ";
			
			content = content +" .boldEleven { ";
			content = content +" FONT-WEIGHT: normal; ";
			content = content +" FONT-SIZE: 10px; ";
			content = content +" COLOR: #000000; ";
			content = content +" LINE-HEIGHT: 15px; ";
			content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
			content = content +" TEXT-DECORATION: none ";
			content = content +" } ";
			
			content = content +" .MRow1 { ";
			content = content +" BACKGROUND-COLOR: #fdfae7; ";
			content = content +" FONT-WEIGHT: normal; ";
			content = content +" FONT-SIZE: 10px; ";
			content = content +" COLOR: #000000; ";
			content = content +" LINE-HEIGHT: 15px; ";
			content = content +" FONT-FAMILY: Verdana; ";
			content = content +" TEXT-DECORATION: none; ";
			content = content +" } ";
			 
			content = content +" .MRow2 { ";
			content = content +" BACKGROUND-COLOR: #f2f2f2; ";
			content = content +" FONT-WEIGHT: normal; ";
			content = content +" FONT-SIZE: 10px; ";
			content = content +" COLOR: #000000; ";
			content = content +" LINE-HEIGHT: 15px; ";
			content = content +" FONT-FAMILY: Verdana; ";
			content = content +" TEXT-DECORATION: none; ";
			content = content +" } "; 
			content = content +" </style> ";
			try 
		 	{
				csql =" SELECT CHR_DAILY_COLLECTION_MAIL_IDS ";
				csql = csql + " FROM m_inventorysetting  WHERE INT_ROWID=1 ";
				String  settingmailids =  CommonFunctions.QueryExecute(csql)[0][0] ;
				String divisionmailid="";
				String stockbranch=CommonFunctions.QueryExecute("SELECT CHR_STOCKMAIL_ALERT_BRANCH FROM m_inventorysetting WHERE INT_ROWID=1")[0][0];
				
				
				csql = "";
				csql = "SELECT INT_DIVIID,CHR_DIVICODE ,CHR_EMAILID FROM inv_m_division ORDER BY CHR_DIVICODE";
				String ddata[][] =CommonFunctions.QueryExecute(csql);
				
				if(ddata.length>0)
				{
					for(int u=0;u<ddata.length;u++)
					{
						String message="";
						
						if(!"-".equals(ddata[u][2]))
							divisionmailid=ddata[u][2];
						else
							divisionmailid="";
						
						csql = "SELECT   b.CHR_DIVICODE, ";  
						csql = csql + " if( a.CHR_TYPE ='I' ,'ITEM','PRODUCT' ), ";
						csql = csql + "   if( a.CHR_TYPE ='I' , ";
						csql = csql + " (SELECT a1.CHR_ITEMNAME FROM inv_m_item a1  WHERE  a1.CHR_ITEMID =a.CHR_ITEMID), ";
						csql = csql + " (SELECT a2.CHR_PRODUCTCODE FROM inv_m_produtlist a2  WHERE  a2.CHR_PRODUCTID =a.CHR_ITEMID) "; 
						csql = csql + " ) productcode, ";
						csql = csql + "  if( a.CHR_TYPE ='I' , ";
						csql = csql + " (SELECT aa1.CHR_DES FROM inv_m_item aa1  WHERE  aa1.CHR_ITEMID =a.CHR_ITEMID), ";
						csql = csql + " (SELECT aa2.CHR_PRODUCTDESC FROM inv_m_produtlist aa2  WHERE  aa2.CHR_PRODUCTID =a.CHR_ITEMID) "; 
						csql = csql + " ) productdescription, ";
						csql = csql + " COUNT(*) ,SUM(a.DOU_UNITPRICE) ";
						csql = csql + " FROM inv_t_vendorgoodsreceived a ,inv_m_division b ";  
						csql = csql + " WHERE a.INT_DIVIID=b.INT_DIVIID   ";
						csql = csql + " AND a.CHR_FLAG='N' ";
						csql = csql + " AND a.INT_DIVIID ="+ddata[u][0];
						csql = csql + " AND a.CHR_SERIALNO is not null ";  
						csql = csql + " AND a.INT_BRANCHID IN ( "+stockbranch+" 0 )";
						csql = csql + " GROUP BY a.CHR_ITEMID,a.CHR_TYPE ";
						csql = csql + " ORDER BY a.INT_DIVIID ";
						
						String Adata[][] =CommonFunctions.QueryExecute(csql);
						if(Adata.length>0)
						{
							message = message +" <table  border='0' width='95%' cellpadding=2 cellspacing=2  bgcolor='#000000' >" ;
							message = message +" <tr class='MRow1'>" ;
							message = message +" <td colspan='7'><b><br><br><center><font color='red'>STOCK FOR "+ddata[u][1]+" DIVISION</font></center><br><br></b></td>" ;
							message = message +" </tr>" ;
							message = message +" <tr class='MRow2'>" ;
							message = message +" <td class='boldEleven'><b>S.No</b></td>" ;
							message = message +" <td class='boldEleven'><b>Division</b></td>" ;
							message = message +" <td class='boldEleven'><b>Type</b></td>" ;
							message = message +" <td class='boldEleven'><b>Item / Product code</b></td>" ;
							message = message +" <td class='boldEleven'><b>Description</b></td>" ;
							message = message +" <td class='boldEleven'><b>Quantity</b></td>" ;
							message = message +" <td class='boldEleven'><b>Amount</b></td>" ;
							message = message +" </tr>" ;
							double sum=0;
							for(int v=0;v<Adata.length;v++)
							{
								if(u%2==0)
									message = message +" <tr class='MRow1' >" ;
								else
									message = message +" <tr  class='MRow2'  >" ;
									
								message = message +" <td class='boldEleven'>"+(v+1)+"</td>" ;
								message = message +" <td class='boldEleven'>"+Adata[v][0]+"</td>" ;
								message = message +" <td class='boldEleven'>"+Adata[v][1]+"</td>" ;
								message = message +" <td class='boldEleven'>"+Adata[v][2]+"</td>" ;
								message = message +" <td class='boldEleven'>"+Adata[v][3]+"</td>" ;
								message = message +" <td class='boldEleven' align='right'>"+Adata[v][4]+"</td>" ;
								message = message +" <td class='boldEleven' align='right'>"+Adata[v][5]+"</td>" ;
								sum = sum+Double.parseDouble(Adata[v][5]);
								message = message +" </tr>";
							}
							message = message +" <tr class='MRow1' >" ;
							message = message +" <td class='boldred' align='right' colspan='6'>Total</td>" ;
							message = message +" <td class='boldred'>"+BigDecimal.valueOf(sum).toPlainString()  +"</td>" ;
							message = message +" </tr>";
							message = content+ message +" </table>";
							String a[] =(settingmailids+","+divisionmailid+","+CommonData.mailid).split(",") ;
							Mail.SimpleHTMLMail(a,today +"  STOCK FOR "+ddata[u][1]+" DIVISION  ", message);
						}
						
					}
				}
				
				 
				
		 	}
			catch(Exception e)
			{
					System.out.println(e.getMessage());
			}
		 }
		
		
		
		
		public static void  todaySales() 
		 {
			String content="";
			content = content +" <style type='text/css'> ";
			content = content +" .boldred { ";
			content = content +" FONT-WEIGHT: normal; ";
			content = content +" FONT-SIZE: 10px; ";
			content = content +" COLOR: #FF0000; ";
			content = content +" LINE-HEIGHT: 15px; ";
			content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
			content = content +" TEXT-DECORATION: none ";
			content = content +" } ";
			content = content +" .boldgreen { ";
			content = content +" FONT-WEIGHT: normal; ";
			content = content +" FONT-SIZE: 10px; ";
			content = content +" COLOR: #006600; ";
			content = content +" LINE-HEIGHT: 15px; ";
			content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
			content = content +" TEXT-DECORATION: none ";
			content = content +" } ";
			content = content +" .boldEleven { ";
			content = content +" FONT-WEIGHT: normal; ";
			content = content +" FONT-SIZE: 10px; ";
			content = content +" COLOR: #000000; ";
			content = content +" LINE-HEIGHT: 15px; ";
			content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
			content = content +" TEXT-DECORATION: none ";
			content = content +" } ";
			content = content +" .MRow1 { ";
			content = content +" BACKGROUND-COLOR: #fdfae7; ";
			content = content +" FONT-WEIGHT: normal; ";
			content = content +" FONT-SIZE: 10px; ";
			content = content +" COLOR: #000000; ";
			content = content +" LINE-HEIGHT: 15px; ";
			content = content +" FONT-FAMILY: Verdana; ";
			content = content +" TEXT-DECORATION: none; ";
			content = content +" } ";
			content = content +" .MRow2 { ";
			content = content +" BACKGROUND-COLOR: #f2f2f2; ";
			content = content +" FONT-WEIGHT: normal; ";
			content = content +" FONT-SIZE: 10px; ";
			content = content +" COLOR: #000000; ";
			content = content +" LINE-HEIGHT: 15px; ";
			content = content +" FONT-FAMILY: Verdana; ";
			content = content +" TEXT-DECORATION: none; ";
			content = content +" } "; 
			content = content +" </style> ";
			try 
		 	{
				csql = "";
				csql = csql + " SELECT FUN_GET_BRANCH_NAME(a.INT_BRANCHID),c.CHR_DIVICODE, ";
				csql = csql + " if(a.CHR_TYPE='I','Item','Product'), ";
				csql = csql + " if( a.CHR_TYPE ='I' , ";
				csql = csql + " (SELECT a1.CHR_ITEMNAME FROM inv_m_item a1  WHERE  a1.CHR_ITEMID =a.CHR_ITEMID), ";
				csql = csql + " (SELECT a2.CHR_PRODUCTCODE FROM inv_m_produtlist a2  WHERE  a2.CHR_PRODUCTID =a.CHR_ITEMID) "; 
				csql = csql + " ) productcode,  ";
				csql = csql + " if( a.CHR_TYPE ='I' , ";
				csql = csql + " (SELECT aa1.CHR_DES FROM inv_m_item aa1  WHERE  aa1.CHR_ITEMID =a.CHR_ITEMID), ";
				csql = csql + " (SELECT sa2.CHR_PRODUCTDESC FROM inv_m_produtlist sa2  WHERE  sa2.CHR_PRODUCTID =a.CHR_ITEMID) "; 
				csql = csql + " ) productdescription, ";
				csql = csql + " a.CHR_SERIALNO,a.DOU_UNITPRICE, ";
				csql = csql + " DATE_FORMAT(a.DAT_PURCHASE_WARRANTY_START,'%d-%b-%Y'), ";
				csql = csql + " DATE_FORMAT(a.DAT_PURCHASE_WARRANTY_END,'%d-%b-%Y') , ";
				csql = csql + " a.CHR_SALESNO, DATE_FORMAT(a.DT_SALEDATE,'%d-%b-%Y'), "; 
				csql = csql + " FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID), ";
				csql = csql + " a.DOU_SALEUNITPRICE  , ";
				csql = csql + "  DATE_FORMAT(a.DAT_SALES_WARRANTY_START,'%d-%b-%Y'), ";
				csql = csql + "  DATE_FORMAT(a.DAT_SALES_WARRANTY_END,'%d-%b-%Y') "; 
				csql = csql + " FROM inv_t_vendorgoodsreceived a, inv_t_directsales b, inv_m_division c ";
				csql = csql + " WHERE a.CHR_SALESNO =b.CHR_SALESNO AND a.CHR_FLAG ='Y' AND a.INT_DIVIID = c.INT_DIVIID ";
				csql = csql + " AND a.DT_SALEDATE = DATE(NOW())";
				String Adata[][] =CommonFunctions.QueryExecute(csql);
				
				if(Adata.length>0)
				{
					content = content +" ";
					content = content +" <table  border='0' width='95%' cellpadding=2 cellspacing=2  bgcolor='#000000' >" ;
					content = content +" <tr class='MRow1'>" ;
					content = content +" <td colspan='12'><b><br><br><center><font color='red'>SALES REPORT</font></center><br><br></b></td>" ;
					content = content +" </tr>" ;
					content = content +" <tr class='MRow2' >" ;
					content = content +" <td ><b>S.No</b></td>" ;
					content = content +" <td ><b>Branch</b></td>" ;
					content = content +" <td ><b>Division</b></td>" ;
					content = content +" <td ><b>Type</b></td>" ;
					content = content +" <td ><b>Code</b></td>" ;
					content = content +" <td ><b>Description</b></td>" ;
					content = content +" <td ><b>Serial Number</b></td>" ;
					content = content +" <td ><b>Unit Price</b></td>" ;
					content = content +" <td ><b>Purchase Warranty Start</b></td>" ;
					content = content +" <td ><b>Purchase Warranty End</b></td>" ;
					content = content +" <td ><b>Sales No</b></td>" ;
					content = content +" <td ><b>Sale Date</b></td>" ;
					content = content +" <td ><b>Customer</b></td>" ;
					content = content +" <td ><b>Sales Price</b></td>" ;
					content = content +" <td ><b>Sales Warranty Start</b></td>" ;
					content = content +" <td ><b>Sales Warranty End</b></td>" ;
					content = content +" </tr>" ;
					for(int u=0;u<Adata.length;u++)
					{
							if(u%2==0)
								content = content +" <tr class='MRow1' >" ;
							else
								content = content +" <tr  class='MRow2'  >" ;
		
							content = content +" <td >"+(u+1)+"</td>" ;
							content = content +" <td >"+Adata[u][0]+"</td>" ;
							content = content +" <td >"+Adata[u][1]+"</td>" ;
							content = content +" <td >"+Adata[u][2]+"</td>" ;
							content = content +" <td >"+Adata[u][3]+"</td>" ;
							content = content +" <td >"+Adata[u][4]+"</td>" ;
							content = content +" <td >"+Adata[u][5]+"</td>" ;
							content = content +" <td >"+Adata[u][6]+"</td>" ;
							content = content +" <td >"+Adata[u][7]+"</td>" ;
							content = content +" <td>"+Adata[u][8]+"</td>" ;
							content = content +" <td >"+Adata[u][9]+"</td>" ;
							content = content +" <td >"+Adata[u][10]+"</td>" ;
							content = content +" <td >"+Adata[u][11]+"</td>" ;
							content = content +" <td >"+Adata[u][12]+"</td>" ;
							content = content +" <td >"+Adata[u][13]+"</td>" ;
							content = content +" <td >"+Adata[u][14]+"</td>" ;
							content = content +" <td >"+Adata[u][15]+"</td>" ;
							content = content +" </tr>" ;
							 
					}
					csql =" SELECT CHR_DAILY_COLLECTION_MAIL_IDS ";
					csql = csql + " FROM m_inventorysetting  WHERE INT_ROWID=1 ";
					//String  settingmailids =  CommonFunctions.QueryExecute(csql)[0][0] ;
				    String a[] =(""+CommonData.mailid+",").split(",") ;
					Mail.SimpleHTMLMail(a,today +" Sales Report ", content);
					 
						
				}
				
				
		 	}
			catch(Exception e)
			{
					System.out.println(e.getMessage());
			}
			 
		}
		
		
		public static void  todayPaymentCollections() 
		 {
			String content="";
			content = content +" <style type='text/css'> ";
			content = content +" .boldred { ";
			content = content +" FONT-WEIGHT: normal; ";
			content = content +" FONT-SIZE: 10px; ";
			content = content +" COLOR: #FF0000; ";
			content = content +" LINE-HEIGHT: 15px; ";
			content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
			content = content +" TEXT-DECORATION: none ";
			content = content +" } ";
			content = content +" .boldgreen { ";
			content = content +" FONT-WEIGHT: normal; ";
			content = content +" FONT-SIZE: 10px; ";
			content = content +" COLOR: #006600; ";
			content = content +" LINE-HEIGHT: 15px; ";
			content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
			content = content +" TEXT-DECORATION: none ";
			content = content +" } ";
			content = content +" .boldEleven { ";
			content = content +" FONT-WEIGHT: normal; ";
			content = content +" FONT-SIZE: 10px; ";
			content = content +" COLOR: #000000; ";
			content = content +" LINE-HEIGHT: 15px; ";
			content = content +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
			content = content +" TEXT-DECORATION: none ";
			content = content +" } ";
			content = content +" .MRow1 { ";
			content = content +" BACKGROUND-COLOR: #fdfae7; ";
			content = content +" FONT-WEIGHT: normal; ";
			content = content +" FONT-SIZE: 10px; ";
			content = content +" COLOR: #000000; ";
			content = content +" LINE-HEIGHT: 15px; ";
			content = content +" FONT-FAMILY: Verdana; ";
			content = content +" TEXT-DECORATION: none; ";
			content = content +" } ";
			content = content +" .MRow2 { ";
			content = content +" BACKGROUND-COLOR: #f2f2f2; ";
			content = content +" FONT-WEIGHT: normal; ";
			content = content +" FONT-SIZE: 10px; ";
			content = content +" COLOR: #000000; ";
			content = content +" LINE-HEIGHT: 15px; ";
			content = content +" FONT-FAMILY: Verdana; ";
			content = content +" TEXT-DECORATION: none; ";
			content = content +" } "; 
			content = content +" </style> ";
			try 
		 	{
				csql = "";
				csql = csql + " ( ";
				csql = csql + " SELECT CHR_SALESORDERNO,FIND_A_CUSTOMER_NAME(INT_CUSTOMERID) customer,FIND_A_PAYMENT_TERM(INT_PAYMENTTERMID) payment, "; 
				csql = csql + " IF(FIND_A_PAYMENT_TERM(INT_PAYMENTTERMID)='CASH' ,'',FIND_A_BANKGROUP_NAME(CHR_BANKNAME)) bank, "; 
				csql = csql + " CHR_PAYNO,DATE_FORMAT(DAT_PAYMENTDATE,'%d-%b-%Y'),DOU_PAIDAMOUNT,  ";
				csql = csql + " CHR_REMARK,FIND_A_EMPLOYEE_ID_NAME(CHR_PAYEMENTCOLLECTEDBY),FIND_A_PAYMENT_CREDITEDTO(INT_DEPOSITID)  FROM    inv_t_customersalespayment ";   
				csql = csql + " WHERE DAT_PAYMENTDATE = NOW() ";
				csql = csql + " )  ";
				csql = csql + " UNION "; 
				csql = csql + " ( ";
				csql = csql + " SELECT CHR_SALESNO,FIND_A_CUSTOMER_NAME(INT_CUSTOMERID) customer,FIND_A_PAYMENT_TERM(INT_PAYMENTTERMID) payment, "; 
				csql = csql + "  IF(FIND_A_PAYMENT_TERM(INT_PAYMENTTERMID)='CASH' ,'',FIND_A_BANKGROUP_NAME(INT_BANKID)) bank, "; 
				csql = csql + " CHR_REFNO,DATE_FORMAT(DAT_PAYMENTDATE,'%d-%b-%Y'),DOU_PAIDAMOUNT,   ";
				csql = csql + " CHR_REMARK,FIND_A_EMPLOYEE_ID_NAME(CHR_PAYEMENTCOLLECTEDBY),FIND_A_PAYMENT_CREDITEDTO(INT_DEPOSITID) "; 
				csql = csql + " FROM    inv_t_servicebillingpayment   ";
				csql = csql + "  WHERE DAT_PAYMENTDATE = NOW()	 ";		
				csql = csql + "  ) ";
						 
				String Adata[][] =CommonFunctions.QueryExecute(csql);
				
				if(Adata.length>0)
				{
					content = content +" ";
					content = content +" <table  border='0' width='95%' cellpadding=2 cellspacing=2  bgcolor='#000000' >" ;
					content = content +" <tr class='MRow1'>" ;
					content = content +" <td colspan='11'><b><br><br><center><font color='red'>TODAY PAYMENT COLLECTIONS</font></center><br><br></b></td>" ;
					content = content +" </tr>" ;
					content = content +" <tr class='MRow2' >" ;
					content = content +" <td ><b>S.No</b></td>" ;
					content = content +" <td ><b>Invoice</b></td>" ;
					content = content +" <td ><b>Customer</b></td>" ;
					content = content +" <td ><b>Payment</b></td>" ;
					content = content +" <td ><b>Bank</b></td>" ;
					content = content +" <td ><b>Ref number</b></td>" ;
					content = content +" <td ><b>Payment Date</b></td>" ;
					content = content +" <td ><b>Paid Amount</b></td>" ;
					content = content +" <td ><b>Description</b></td>" ;
					content = content +" <td ><b>Collected By</b></td>" ;
					content = content +" <td ><b>Credited to</b></td>" ;
					content = content +" </tr>" ;
					for(int u=0;u<Adata.length;u++)
					{
							if(u%2==0)
								content = content +" <tr class='MRow1' >" ;
							else
								content = content +" <tr  class='MRow2'  >" ;
		
							content = content +" <td >"+(u+1)+".</td>" ;
							content = content +" <td >"+Adata[u][0]+"</td>" ;
							content = content +" <td >"+Adata[u][1]+"</td>" ;
							content = content +" <td >"+Adata[u][2]+"</td>" ;
							content = content +" <td >"+Adata[u][3]+"</td>" ;
							content = content +" <td >"+Adata[u][4]+"</td>" ;
							content = content +" <td >"+Adata[u][5]+"</td>" ;
							content = content +" <td align='right'>"+Adata[u][6]+"</td>" ;
							content = content +" <td >"+Adata[u][7]+"</td>" ;
							content = content +" <td>"+Adata[u][8]+"</td>" ;
							content = content +" <td >"+Adata[u][9]+"</td>" ; 
							content = content +" </tr>" ;
							 
					}
					
					csql =" SELECT CHR_PAYMENTMAIL ";
					csql = csql + " FROM m_inventorysetting  WHERE INT_ROWID=1 ";
					String  settingmailids =  CommonFunctions.QueryExecute(csql)[0][0] ;
				    String a[] =settingmailids.split(",") ;
					Mail.SimpleHTMLMail(a,today +" Today Payment Collections ", content);
					 	
				}
				
				
				
		 	}
			catch(Exception e)
			{
					System.out.println(e.getMessage());
			}
			 
		}
		
		
		
		
		public static void  SFAScheduleEmployeewise() 
		 {
			String content="";
			String content1="";
			content1 = content1 +" <style type='text/css'> ";
			content1 = content1 +" .boldred { ";
			content1 = content1 +" FONT-WEIGHT: normal; ";
			content1 = content1 +" FONT-SIZE: 10px; ";
			content1 = content1 +" COLOR: #FF0000; ";
			content1 = content1 +" LINE-HEIGHT: 15px; ";
			content1 = content1 +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
			content1 = content1 +" TEXT-DECORATION: none ";
			content1 = content1 +" } ";
			content1 = content1 +" .boldgreen { ";
			content1 = content1 +" FONT-WEIGHT: normal; ";
			content1 = content1 +" FONT-SIZE: 10px; ";
			content1 = content1 +" COLOR: #006600; ";
			content1 = content1 +" LINE-HEIGHT: 15px; ";
			content1 = content1 +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
			content1 = content1 +" TEXT-DECORATION: none ";
			content1 = content1 +" } ";
			content1 = content1 +" .boldEleven { ";
			content1 = content1 +" FONT-WEIGHT: normal; ";
			content1 = content1 +" FONT-SIZE: 10px; ";
			content1 = content1 +" COLOR: #000000; ";
			content1 = content1 +" LINE-HEIGHT: 15px; ";
			content1 = content1 +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
			content1 = content1 +" TEXT-DECORATION: none ";
			content1 = content1 +" } ";
			content1 = content1 +" .MRow1 { ";
			content1 = content1 +" BACKGROUND-COLOR: #fdfae7; ";
			content1 = content1 +" FONT-WEIGHT: normal; ";
			content1 = content1 +" FONT-SIZE: 10px; ";
			content1 = content1 +" COLOR: #000000; ";
			content1 = content1 +" LINE-HEIGHT: 15px; ";
			content1 = content1 +" FONT-FAMILY: Verdana; ";
			content1 = content1 +" TEXT-DECORATION: none; ";
			content1 = content1 +" } ";
			content1 = content1 +" .MRow2 { ";
			content1 = content1 +" BACKGROUND-COLOR: #f2f2f2; ";
			content1 = content1 +" FONT-WEIGHT: normal; ";
			content1 = content1 +" FONT-SIZE: 10px; ";
			content1 = content1 +" COLOR: #000000; ";
			content1 = content1 +" LINE-HEIGHT: 15px; ";
			content1 = content1 +" FONT-FAMILY: Verdana; ";
			content1 = content1 +" TEXT-DECORATION: none; ";
			content1 = content1 +" } "; 
			content1 = content1 +" </style> ";
			String ids;
			try 
		 	{
				csql = "";
				csql = csql + "SELECT   "; 
				csql = csql + " a.CHR_EMPID,b.CHR_EMAILID,b.CHR_STAFFNAME  ";
				csql = csql + " FROM mkt_t_daillycalls a, com_m_staff b  ";
				csql = csql + " WHERE  a.INT_CALLID >0  AND  a.CHR_EMPID =  b.CHR_EMPID  ";
				csql = csql + "AND a.DAT_START <= (SELECT DATE_FORMAT(DATE_ADD(NOW(), INTERVAL 4 DAY),'%Y-%m-%d') )  ";
				csql = csql + "AND a.DAT_START >= (SELECT DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 2 DAY),'%Y-%m-%d') )  ";
				csql = csql + "AND a.CHR_STATUS = 'N'  ";
				csql = csql + "GROUP BY  a.CHR_EMPID  ";
				csql = csql + "ORDER BY 	FIND_A_EMPLOYEE_NAME(a.CHR_EMPID)  ";
				String Edata[][] =CommonFunctions.QueryExecute(csql);
				if(Edata.length>0)
				{
					for(int y=0;y<Edata.length;y++)
					{
						
						csql = "SELECT FIND_A_REPORTING_EMPID_LIST('"+Edata[y][0]+"')";
						String Idata[][] =CommonFunctions.QueryExecute(csql);
						ids = "";
						if(Idata.length>0)
						{
							String d[] = Idata[0][0].split(",");
							for(int x=0;x<d.length;x++)
								ids = ids +"'"+d[0]+"' , ";
						}
						ids = ids +"'"+Edata[y][0]+"'";
						
						
						csql = "";
						csql = csql + " SELECT  d.CHR_NAME,c.CHR_CALLTYPE,    ";  
						csql = csql + " DATE_FORMAT(a.DAT_START,'%d-%b-%Y %h:%m %p') scheduletime,     ";
						csql = csql + " a.CHR_EMPID,FIND_A_EMPLOYEE_NAME(a.CHR_EMPID) entryby,   "; 
						csql = csql + " IF(a.CHR_ADDEDTO_FUNNEL='Y','Funnel','') funnel  ";
						csql = csql + " FROM mkt_t_daillycalls a,mkt_m_customerinfo b,mkt_k_calltype c, mkt_m_customername d    ";
						csql = csql + " WHERE  a.INT_CALLID >0 AND a.INT_CUSTOMERID=b.INT_CUSTOMERID AND a.CHR_CALLTYPE=c.INT_CALLTYPEID  ";  
						csql = csql + " AND  b.INT_CUSTOMERNAMEID =d.INT_CUSTOMERNAMEID    ";
						csql = csql + " AND a.DAT_START <= (SELECT DATE_FORMAT(DATE_ADD(NOW(), INTERVAL 4 DAY),'%Y-%m-%d') )  ";
						csql = csql + " AND a.DAT_START >= (SELECT DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 2 DAY),'%Y-%m-%d') )  ";
						csql = csql + " AND a.CHR_STATUS = 'N'  ";
						csql = csql + " AND a.CHR_EMPID IN("+ids+") ";
						csql = csql + " ORDER BY 	FIND_A_EMPLOYEE_NAME(a.CHR_EMPID),a.DAT_START  ";
						System.out.println(csql);
						String Adata[][] =CommonFunctions.QueryExecute(csql);
						if(Adata.length>0)
						{
							content = " ";
							content = content +" <table  border='0' width='95%' cellpadding=2 cellspacing=2  bgcolor='#000000' >" ;
							content = content +" <tr class='MRow1'>" ;
							content = content +" <td colspan='4'><b><br><br><center><font color='red'>Next Schedule </font></center><br><br></b></td>" ;
							content = content +" </tr>" ;
							content = content +" <tr class='MRow2' >" ;
							content = content +" <td ><b>S.No</b></td>" ;
							content = content +" <td ><b>Customer Name</b></td>" ;
							content = content +" <td ><b>Call Type</b></td>" ;
							content = content +" <td ><b>Appoinment </b></td>" ;
							content = content +" <td ><b>M.E. Id / Name </b></td>" ;
							content = content +" </tr>" ;
							for(int u=0;u<Adata.length;u++)
							{
									if(u%2==0)
										content = content +" <tr class='MRow1' >" ;
									else
										content = content +" <tr  class='MRow2'  >" ;
				
									content = content +" <td >"+(u+1)+"</td>" ;
									content = content +" <td >"+Adata[u][0]+"</td>" ;
									content = content +" <td >"+Adata[u][1]+"</td>" ;
									content = content +" <td >"+Adata[u][2]+"</td>" ;
									content = content +" <td >"+Adata[u][3]+" / "+Adata[u][4]+"</td>" ;
									content = content +" </tr>" ;
									 
							}
							content = content +" </table>";
							String a[] =(""+CommonData.mailid+","+Edata[y][1]).split(",") ;
							Mail.SimpleHTMLMail(a, " Next 2days appointment Report ", content1+content);
							 
								
						}
					
					
					}
				}
		 	}
			catch(Exception e)
			{
					System.out.println(e.getMessage());
			}
			 
		}
		
		
		public static void  SFAScheduleDivisionwise() 
		 {
			String content="";
			String content1="";
			content1 = content1 +" <style type='text/css'> ";
			content1 = content1 +" .boldred { ";
			content1 = content1 +" FONT-WEIGHT: normal; ";
			content1 = content1 +" FONT-SIZE: 10px; ";
			content1 = content1 +" COLOR: #FF0000; ";
			content1 = content1 +" LINE-HEIGHT: 15px; ";
			content1 = content1 +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
			content1 = content1 +" TEXT-DECORATION: none ";
			content1 = content1 +" } ";
			content1 = content1 +" .boldgreen { ";
			content1 = content1 +" FONT-WEIGHT: normal; ";
			content1 = content1 +" FONT-SIZE: 10px; ";
			content1 = content1 +" COLOR: #006600; ";
			content1 = content1 +" LINE-HEIGHT: 15px; ";
			content1 = content1 +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
			content1 = content1 +" TEXT-DECORATION: none ";
			content1 = content1 +" } ";
			content1 = content1 +" .boldEleven { ";
			content1 = content1 +" FONT-WEIGHT: normal; ";
			content1 = content1 +" FONT-SIZE: 10px; ";
			content1 = content1 +" COLOR: #000000; ";
			content1 = content1 +" LINE-HEIGHT: 15px; ";
			content1 = content1 +" FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
			content1 = content1 +" TEXT-DECORATION: none ";
			content1 = content1 +" } ";
			content1 = content1 +" .MRow1 { ";
			content1 = content1 +" BACKGROUND-COLOR: #fdfae7; ";
			content1 = content1 +" FONT-WEIGHT: normal; ";
			content1 = content1 +" FONT-SIZE: 10px; ";
			content1 = content1 +" COLOR: #000000; ";
			content1 = content1 +" LINE-HEIGHT: 15px; ";
			content1 = content1 +" FONT-FAMILY: Verdana; ";
			content1 = content1 +" TEXT-DECORATION: none; ";
			content1 = content1 +" } ";
			content1 = content1 +" .MRow2 { ";
			content1 = content1 +" BACKGROUND-COLOR: #f2f2f2; ";
			content1 = content1 +" FONT-WEIGHT: normal; ";
			content1 = content1 +" FONT-SIZE: 10px; ";
			content1 = content1 +" COLOR: #000000; ";
			content1 = content1 +" LINE-HEIGHT: 15px; ";
			content1 = content1 +" FONT-FAMILY: Verdana; ";
			content1 = content1 +" TEXT-DECORATION: none; ";
			content1 = content1 +" } "; 
			content1 = content1 +" </style> ";
			String ids;
			try 
		 	{
				csql = "";
				csql = csql + "SELECT a.CHR_EMPID,b.CHR_EMAILID  FROM inv_m_division a , com_m_staff b WHERE a.CHR_EMPID=b.CHR_EMPID GROUP BY a.CHR_EMPID   "; 
				String Edata[][] =CommonFunctions.QueryExecute(csql);
				if(Edata.length>0)
				{
					for(int y=0;y<Edata.length;y++)
					{
						csql = "SELECT FIND_A_REPORTING_EMPID_LIST('"+Edata[y][0]+"')";
						String Idata[][] =CommonFunctions.QueryExecute(csql);
						ids = "";
						if(Idata.length>0)
						{
							String d[] = Idata[0][0].split(",");
							for(int x=0;x<d.length;x++)
								ids = ids +"'"+d[0]+"' , ";
						}
						ids = ids +"'"+Edata[y][0]+"'";
						
						
						csql = "";
						csql = csql + " SELECT  d.CHR_NAME,c.CHR_CALLTYPE,    ";  
						csql = csql + " DATE_FORMAT(a.DAT_START,'%d-%b-%Y %h:%m %p') scheduletime,     ";
						csql = csql + " a.CHR_EMPID,FIND_A_EMPLOYEE_NAME(a.CHR_EMPID) entryby,   "; 
						csql = csql + " IF(a.CHR_ADDEDTO_FUNNEL='Y','Funnel','') funnel  ";
						csql = csql + " FROM mkt_t_daillycalls a,mkt_m_customerinfo b,mkt_k_calltype c, mkt_m_customername d    ";
						csql = csql + " WHERE  a.INT_CALLID >0 AND a.INT_CUSTOMERID=b.INT_CUSTOMERID AND a.CHR_CALLTYPE=c.INT_CALLTYPEID  ";  
						csql = csql + " AND  b.INT_CUSTOMERNAMEID =d.INT_CUSTOMERNAMEID    ";
						csql = csql + " AND a.DAT_START <= (SELECT DATE_FORMAT(DATE_ADD(NOW(), INTERVAL 4 DAY),'%Y-%m-%d') )  ";
						csql = csql + " AND a.DAT_START >= (SELECT DATE_FORMAT(DATE_SUB(NOW(), INTERVAL 2 DAY),'%Y-%m-%d') )  ";
						csql = csql + " AND a.CHR_STATUS = 'N'  ";
						csql = csql + " AND a.CHR_EMPID IN("+ids+") ";
						csql = csql + " ORDER BY 	FIND_A_EMPLOYEE_NAME(a.CHR_EMPID),a.DAT_START  ";
						System.out.println(csql);
						String Adata[][] =CommonFunctions.QueryExecute(csql);
						if(Adata.length>0)
						{
							content = " ";
							content = content +" <table  border='0' width='95%' cellpadding=2 cellspacing=2  bgcolor='#000000' >" ;
							content = content +" <tr class='MRow1'>" ;
							content = content +" <td colspan='4'><b><br><br><center><font color='red'>Next Schedule </font></center><br><br></b></td>" ;
							content = content +" </tr>" ;
							content = content +" <tr class='MRow2' >" ;
							content = content +" <td ><b>S.No</b></td>" ;
							content = content +" <td ><b>Customer Name</b></td>" ;
							content = content +" <td ><b>Call Type</b></td>" ;
							content = content +" <td ><b>Appoinment </b></td>" ;
							content = content +" <td ><b>M.E. Id / Name </b></td>" ;
							content = content +" </tr>" ;
							for(int u=0;u<Adata.length;u++)
							{
									if(u%2==0)
										content = content +" <tr class='MRow1' >" ;
									else
										content = content +" <tr  class='MRow2'  >" ;
				
									content = content +" <td >"+(u+1)+"</td>" ;
									content = content +" <td >"+Adata[u][0]+"</td>" ;
									content = content +" <td >"+Adata[u][1]+"</td>" ;
									content = content +" <td >"+Adata[u][2]+"</td>" ;
									content = content +" <td >"+Adata[u][3]+" / "+Adata[u][4]+"</td>" ;
									content = content +" </tr>" ;
									 
							}
							content = content +" </table>";
							String a[] =(""+CommonData.mailid+","+Edata[y][1]).split(",") ;
							Mail.SimpleHTMLMail(a, " Next 2days appointment Report ", content1+content);
							 
								
						}
					
					
					}
				}
		 	}
			catch(Exception e)
			{
					System.out.println(e.getMessage());
			}
			 
		}
}
