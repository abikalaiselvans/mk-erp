package com.my.org.erp.SmartInventory;

import com.my.org.erp.SmartMailtemplates.Mail;
import com.my.org.erp.SmartMailtemplates.StyleSheet;
import com.my.org.erp.SmartMailtemplates.Template2;
import com.my.org.erp.common.CommonFunctions;

public class PaymentMail 
{
	public static String sql =""; 
	//Sales Paymnet
	public static void sendSalesPaymentAddMail(String branchid,String division , String salesnumber,String Path)
	{
		try
		{
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
			{
				sql = "SELECT  b.CHR_EMAILID,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID)  FROM inv_t_directsales a , com_m_staff b WHERE a.CHR_REF = b.CHR_EMPID AND a.CHR_SALESNO ='"+salesnumber+"'";
				String meemaildata[][]= CommonFunctions.QueryExecute(sql) ;
				String meemail= meemaildata[0][0];
				if(meemail.length()>12)
					meemail =meemail+",";
				else 
					meemail="";
				String to = CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+division)[0][0];
				String approvalmail = CommonFunctions.QueryExecute("SELECT CHR_PAYMENTMAIL  FROM m_inventorysetting WHERE INT_ROWID=1")[0][0];
				String content = PaymentAddMailContent(branchid,salesnumber);
				String subject = " Payment Received from "+meemaildata[0][1];//+ " INVOICE -"+salesnumber ;
				String recipients[] =(meemail+to+","+approvalmail).split(",") ;
				String[] attachments = Template2.paymentUpdatedImageFile(Path);
				Mail.sendEmailWithAttachments(recipients, subject, content, attachments);
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	
	public static void sendCPaymentDeleteMail(String branchid,String salesnumber,String Path)
	{
		try
		{
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
			{
				String approvalmail = CommonFunctions.QueryExecute("SELECT CHR_INWARDMAIL  FROM   m_inventorysetting WHERE INT_ROWID=1")[0][0];
				String content = PaymentDeleteMailContent(branchid,salesnumber);
				String subject = " Payment deleted "+salesnumber;
				String recipients[] =(approvalmail).split(",") ;
				String[] attachments = Template2.paymentUpdatedImageFile(Path);
				Mail.sendEmailWithAttachments(recipients, subject, content, attachments);
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	
	//Service Billing payment
	public static void sendServiceBillingPaymentAddMail(String branchid,String division , String salesnumber,String Path)
	{
		try
		{
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
			{
				String to = CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+division)[0][0];
				String approvalmail = CommonFunctions.QueryExecute("SELECT CHR_PAYMENTMAIL  FROM m_inventorysetting WHERE INT_ROWID=1")[0][0];
				String content = ServiceBillingPaymentAddMailContent(branchid,salesnumber);
				String subject = " Service bill Payment Received "+salesnumber;
				String recipients[] =(to+","+approvalmail).split(",") ;
				String[] attachments = Template2.paymentUpdatedImageFile(Path);
				Mail.sendEmailWithAttachments(recipients, subject, content, attachments);
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	
	public static String  PaymentAddMailContent(String branchid, String salesnumber )
    {
    	String content="";
    	try
    	{ 	
    		//stylesheet
			content = content + StyleSheet.styleSheet();
			//top content
			content = content + Template2.topContent("Customer payment Received ");
			
			sql = "SELECT CHR_SALESORDERNO,FIND_A_CUSTOMER_NAME(INT_CUSTOMERID) customer,FIND_A_PAYMENT_TERM(INT_PAYMENTTERMID) payment,";
			sql = sql + " IF(FIND_A_PAYMENT_TERM(INT_PAYMENTTERMID)='CASH' ,'',FIND_A_BANKGROUP_NAME(CHR_BANKNAME)) bank,";
			sql = sql + " CHR_PAYNO,DATE_FORMAT(DAT_PAYMENTDATE,'%d-%b-%Y'),DOU_PAIDAMOUNT,";//DOU_OPENDEBIT ,
			sql = sql + " CHR_REMARK,FIND_A_EMPLOYEE_ID_NAME(CHR_PAYEMENTCOLLECTEDBY),FIND_A_PAYMENT_CREDITEDTO(INT_DEPOSITID)  FROM    inv_t_customersalespayment  ";
			sql = sql + " WHERE CHR_SALESORDERNO = '"+salesnumber+"' ";
			sql = sql + "  ORDER BY INT_PAYMENTID DESC  limit 0,1 ";
			String data[][]=CommonFunctions.QueryExecute(sql);
			if(data.length>0)
			{
				content = content + "<table width='100%' border='0' align='center' cellpadding='2' cellspacing='2'> ";
				
				content = content + "<tr bgcolor='#FF9900'> ";
				content = content + "<td width='192' align='left' valign='top' class='boldEleven'><b>Invoice No</td> ";
				content = content + "<td width='226' align='left' valign='top' class='boldEleven'>"+data[0][0]+"</td> ";
				content = content + "<td align='left' valign='top' class='boldEleven'><b>Customer</td> ";
				content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][1]+"</td> ";
				content = content + "</tr> ";
				
				content = content + "<tr> ";
				content = content + "<td width='192' align='left' valign='top' class='boldEleven'><b>Payment Mode</td> ";
				content = content + "<td width='226' align='left' valign='top' class='boldEleven'>"+data[0][2]+"</td> ";
				content = content + "<td align='left' valign='top' class='boldEleven'><b>Bank</td> ";
				content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][3]+"</td> ";
				content = content + "</tr> ";
				
				content = content + "<tr bgcolor='#FF9900'> ";
				content = content + "<td width='192' align='left' valign='top' class='boldEleven'><b>Reference no</td> ";
				content = content + "<td width='226' align='left' valign='top' class='boldEleven'>"+data[0][4]+"</td> ";
				content = content + "<td align='left' valign='top' class='boldEleven'><b>Payment Date</td> ";
				content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][5]+"</td> ";
				content = content + "</tr> ";
				
				content = content + "<tr> ";
				content = content + "<td width='192' align='left' valign='top' class='boldEleven'><b>Paid Amount</td> ";
				content = content + "<td width='226' align='left' valign='top' class='boldEleven'>"+data[0][6]+"</td> ";
				content = content + "<td align='left' valign='top' class='boldEleven'><b>Description</td> ";
				content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][7]+"</td> ";
				content = content + "</tr> ";
				
				content = content + "<tr bgcolor='#FF9900'> ";
				content = content + "<td width='192' align='left' valign='top' class='boldEleven'><b>Payment Collected By</td> ";
				content = content + "<td width='226' align='left' valign='top' class='boldEleven'>"+data[0][8]+"</td> ";
				content = content + "<td align='left' valign='top' class='boldEleven'><b>Payment Credited to</td> ";
				content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][9]+"</td> ";
				content = content + "</tr> ";
				
				content = content + "</table>";
			}
			//bottom content
			content = content + Template2.bottomContent(branchid);
			
			return content;
    		
    	}
    	catch(Exception e)
    	{
    		 
    		System.out.println(e.getMessage());
    	}
    	return content;
    }
	
	public static String  PaymentDeleteMailContent(String branchid, String salesnumber )
    {
    	String content="";
    	try
    	{ 	
    		//stylesheet
			content = content + StyleSheet.styleSheet();
			//top content
			content = content + Template2.topContent("Customer payment deleted ");
			
			  	 
			//bottom content
			content = content + Template2.bottomContent(branchid);
			
			return content;
    		
    	}
    	catch(Exception e)
    	{
    		 
    		System.out.println(e.getMessage());
    	}
    	return content;
    }
	
	public static String  ServiceBillingPaymentAddMailContent(String branchid, String salesnumber )
    {
    	String content="";
    	try
    	{ 	
    		//stylesheet
			content = content + StyleSheet.styleSheet();
			//top content
			content = content + Template2.topContent("Service bill payment Received ");
			sql = " SELECT CHR_SALESNO,FIND_A_CUSTOMER_NAME(INT_CUSTOMERID) customer,FIND_A_PAYMENT_TERM(INT_PAYMENTTERMID) payment,"; 
			sql = sql + "  IF(FIND_A_PAYMENT_TERM(INT_PAYMENTTERMID)='CASH' ,'',FIND_A_BANKGROUP_NAME(INT_BANKID)) bank,"; 
			sql = sql + " CHR_REFNO,DATE_FORMAT(DAT_PAYMENTDATE,'%d-%b-%Y'),DOU_PAIDAMOUNT, ";
			sql = sql + "  CHR_REMARK,FIND_A_EMPLOYEE_ID_NAME(CHR_PAYEMENTCOLLECTEDBY),FIND_A_PAYMENT_CREDITEDTO(INT_DEPOSITID)";
			sql = sql + " FROM    inv_t_servicebillingpayment  ";
			sql = sql + " WHERE CHR_SALESNO = '"+salesnumber+"'";
			System.out.println(sql);
			String data[][]=CommonFunctions.QueryExecute(sql);
			if(data.length>0)
			{
				content = content + "<table width='100%' border='0' align='center' cellpadding='2' cellspacing='2'> ";
				
				content = content + "<tr bgcolor='#FF9900'> ";
				content = content + "<td width='192' align='left' valign='top' class='boldEleven'><b>Invoice No</td> ";
				content = content + "<td width='226' align='left' valign='top' class='boldEleven'>"+data[0][0]+"</td> ";
				content = content + "<td align='left' valign='top' class='boldEleven'><b>Customer</td> ";
				content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][1]+"</td> ";
				content = content + "</tr> ";
				
				content = content + "<tr> ";
				content = content + "<td width='192' align='left' valign='top' class='boldEleven'><b>Payment Mode</td> ";
				content = content + "<td width='226' align='left' valign='top' class='boldEleven'>"+data[0][2]+"</td> ";
				content = content + "<td align='left' valign='top' class='boldEleven'><b>Bank</td> ";
				content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][3]+"</td> ";
				content = content + "</tr> ";
				
				content = content + "<tr bgcolor='#FF9900'> ";
				content = content + "<td width='192' align='left' valign='top' class='boldEleven'><b>Reference no</td> ";
				content = content + "<td width='226' align='left' valign='top' class='boldEleven'>"+data[0][4]+"</td> ";
				content = content + "<td align='left' valign='top' class='boldEleven'><b>Payment Date</td> ";
				content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][5]+"</td> ";
				content = content + "</tr> ";
				
				content = content + "<tr> ";
				content = content + "<td width='192' align='left' valign='top' class='boldEleven'><b>Paid Amount</td> ";
				content = content + "<td width='226' align='left' valign='top' class='boldEleven'>"+data[0][6]+"</td> ";
				content = content + "<td align='left' valign='top' class='boldEleven'><b>Description</td> ";
				content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][7]+"</td> ";
				content = content + "</tr> ";
				
				content = content + "<tr bgcolor='#FF9900'> ";
				content = content + "<td width='192' align='left' valign='top' class='boldEleven'><b>Payment Collected By</td> ";
				content = content + "<td width='226' align='left' valign='top' class='boldEleven'>"+data[0][8]+"</td> ";
				content = content + "<td align='left' valign='top' class='boldEleven'><b>Payment Credited to</td> ";
				content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][9]+"</td> ";
				content = content + "</tr> ";
				
				content = content + "</table>";
			}
			//bottom content
			content = content + Template2.bottomContent(branchid);
			
			return content;
    		
    	}
    	catch(Exception e)
    	{
    		 
    		System.out.println(e.getMessage());
    	}
    	return content;
    }
	
}
