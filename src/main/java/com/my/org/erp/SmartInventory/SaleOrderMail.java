package com.my.org.erp.SmartInventory;

 
import java.io.File;

import javax.servlet.http.HttpServletRequest;

import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.SmartMailtemplates.*;
public class SaleOrderMail 
{

	public static String sql =""; 
	
	//CPO Attached
	public static void sendCPOAttachedMail(String branchid,String cponumber, String division,String Path)
	{
		try
		{
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
			{
				String to = CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+division)[0][0];
				sql =" SELECT  b.CHR_EMAILID,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID)  FROM inv_t_customersalesorder a , com_m_staff b WHERE a.CHR_REF = b.CHR_EMPID AND a.CHR_SALESORDERNO ='"+cponumber+"' ";
				String meemaildata[][]= CommonFunctions.QueryExecute(sql) ;
				String meemail= meemaildata[0][0];
				if(meemail.length()>12)
					meemail =meemail+",";
				else 
					meemail="";
				String approvalmail = CommonFunctions.QueryExecute("SELECT CHR_INWARDMAIL  FROM   m_inventorysetting WHERE INT_ROWID=1")[0][0];
				String content = CPOAttachedMailContent(branchid,cponumber);
				String subject = " CPO Received from "+meemaildata[0][1] +" [ Waiting for billing team acknowledgement ]";
				String recipients[] =(meemail+to+","+approvalmail).split(",") ;
				String[] attachments = Template2.cpoattachedImageFile(Path);
				Mail.sendEmailWithAttachments(recipients, subject, content, attachments);
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	//CPO billing team Verification
	public static void sendCPOVerificationMail(HttpServletRequest request,String branchid,String cponumber, String division,String Path)
	{
		try
		{
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
			{
				String Qnumber = CommonFunctions.QueryExecute("SELECT CHR_QUOTATIONNO FROM inv_t_customersalesorder WHERE CHR_SALESORDERNO='"+cponumber+"' ")[0][0];
				sql =" SELECT  b.CHR_EMAILID,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID)  FROM inv_t_customersalesorder a , com_m_staff b WHERE a.CHR_REF = b.CHR_EMPID AND a.CHR_SALESORDERNO ='"+cponumber+"' ";
				String meemaildata[][]= CommonFunctions.QueryExecute(sql) ;
				String meemail= meemaildata[0][0];
				if(meemail.length()>12)
					meemail =meemail+",";
				else 
					meemail="";
				String to = CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+division)[0][0];
				String approvalmail = CommonFunctions.QueryExecute("SELECT CHR_INWARDMAIL  FROM   m_inventorysetting WHERE INT_ROWID=1")[0][0];
				String content = CPOVerificationMailContent(branchid,cponumber,Qnumber,Path);
				String subject = " CPO [ "+cponumber+" ]  Ack. by billing team [ Awaiting B.H  Approval ]";
				String recipients[] =(meemail+to+","+approvalmail).split(",") ;
				String[] attachments = Template3.attachImageFile(request,Path,Qnumber);
				Mail.sendEmailWithAttachments(recipients, subject, content, attachments);
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	
	//BusinessHead Closed
	public static void sendCPOClosedBusinessHeadMail(HttpServletRequest request,String branchid,String cponumber, String division,String Path)
	{
		try
		{
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
			{
				String Qnumber = CommonFunctions.QueryExecute("SELECT CHR_QUOTATIONNO FROM inv_t_customersalesorder WHERE CHR_SALESORDERNO='"+cponumber+"' ")[0][0];
				sql =" SELECT  b.CHR_EMAILID,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID)  FROM inv_t_customersalesorder a , com_m_staff b WHERE a.CHR_REF = b.CHR_EMPID AND a.CHR_SALESORDERNO ='"+cponumber+"' ";
				String meemaildata[][]= CommonFunctions.QueryExecute(sql) ;
				String meemail= meemaildata[0][0];
				if(meemail.length()>12)
					meemail =meemail+",";
				else 
					meemail="";
				String to = CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+division)[0][0];
				String approvalmail = CommonFunctions.QueryExecute("SELECT CHR_INWARDMAIL  FROM   m_inventorysetting WHERE INT_ROWID=1")[0][0];
				String content = CPOClosedBusinessHeadContent(branchid,cponumber,Qnumber,Path);
				String subject = " CPO "+cponumber+"  Ack. by B.H [ Awaiting Billing ] ";
				String recipients[] =(meemail+to+","+approvalmail).split(",") ;
				String[] attachments = Template3.attachImageFile(request,Path,Qnumber);
				Mail.sendEmailWithAttachments(recipients, subject, content, attachments);
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	
	
	
	public static String  CPOAttachedMailContent(String branchid, String cponumber )
    {
    	String content="";
    	try
    	{ 	
			sql =" SELECT a.CHR_SALESORDERNO cpo  ,a.CHR_QUOTATIONNO quotation, ";	
			sql = sql + " FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) customer, DATE_FORMAT(a1.DAT_QUOTATIONDATE,'%d-%b-%Y') quotedate, ";
			sql = sql + " a.CHR_SHIPINGADDRESS address ,FUN_INV_DIVISION(a.INT_DIVIID) division,  ";
			sql = sql + " a.CHR_CUSTPURCHASENO po,  DATE_FORMAT(a.CHR_PURCHASEORDER_DATE,'%d-%b-%Y') podate, ";	 
			sql = sql + " DATE_FORMAT(a.CHR_DELIVERY_DATE,'%d-%b-%Y') dateofdelivery,	IF(a.CHR_BG='Y','YES','NO') bg, ";  	 
			sql = sql + " a.INT_PAYMENT_COMMITMENT_DAYS commitmentdays, 	IF(a.CHR_DELIVERY='Y','YES','NO') delivery ,  ";	 
			sql = sql + " IF(a.CHR_INSTALLATION='Y','YES','NO') installation,IF(a.CHR_STOCKTYPE='G','General','B2B') stocktype, ";  
			sql = sql + " IF(a.CHR_MULTIPLE_LOCATION='Y','YES','NO') multiplelocation, IF(a.CHR_INVOICEBLOCK='Y','YES','NO') invoiceblock, ";  
			sql = sql + " IF(a.CHR_MULTIPLE_BILL='Y','YES','NO') multiplebill,  IF(a.CHR_PARTIAL_BILL='Y','YES','NO') partialbill,  ";
			sql = sql + " a.CHR_DEMURRAGE damage,a.DOU_DEMARRAGE_PERCENTAGE damagepercent,DATE_FORMAT(a.DAT_DEMARRAGE_DATE,'%d-%b-%Y') damagedate, "; 
			sql = sql + " IF(a.CHR_BYBACK='Y','YES','NO') buyback, a.CHR_BYBACKDESC,a.DOU_BYBACKAMOUNT,  ";
			sql = sql + " FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF) ,ROUND(INT_REF_PERCENTAGE1,0), ";
			sql = sql + " IF(a.CHR_REF1='0','',FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF1)),ROUND(INT_REF_PERCENTAGE2,0),  ";
			sql = sql + " IF(a.CHR_REF2='0','',FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF2)),ROUND(INT_REF_PERCENTAGE3,0),  ";
			sql = sql + " DATE_FORMAT(a1.DAT_CREATIONTIME,'%d-%b-%Y  %h:%m:%s %p'),  ";
			sql = sql + " DATE_FORMAT(a.DAT_CREATIONTIME,'%d-%b-%Y  %h:%m:%s %p'),  ";
			sql = sql + " datediff(a.DAT_CREATIONTIME,a1.DAT_CREATIONTIME)  ";
			sql = sql + " FROM inv_t_customersalesorder a ,inv_t_customerquotation a1, inv_m_tax b , inv_m_paymentterms c  , inv_m_project d "; 
			sql = sql + " WHERE a.CHR_QUOTATIONNO =a1.CHR_QUOTATIONNO AND a.INT_TAXID =b.INT_TAXID	  AND a.INT_PROJECTID =d.INT_PROJECTID   ";
			sql = sql + " AND a.INT_PAYMENTTERMID =c.INT_PAYMENTTERMID  ";
			sql = sql + " AND a.CHR_SALESORDERNO = '"+cponumber+"' ";
			String data[][]=CommonFunctions.QueryExecute(sql);
			
			 
			
			
			//stylesheet
			content = content + StyleSheet.styleSheet();
			//top content
			content = content + Template2.topContent("Customer purchase order Received ");
			
			
			
			//Content start
			content = content + "<table width='100%' border='0' align='center' cellpadding='2' cellspacing='2'> ";
			
			content = content + "<tr bgcolor='#FF9900'> ";
			content = content + "<td width='192' align='left' valign='top' class='boldEleven'><b>Quotation Ref No</td> ";
			content = content + "<td width='226' align='left' valign='top' class='boldEleven'>"+data[0][1]+"</td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'><b>Quotation Entry Date</td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][30]+"</td> ";
			content = content + "</tr> ";
			
			
			content = content + "<tr> ";
			content = content + "<td width='192' align='left' valign='top' class='boldEleven'><b><h5>CPO Ref No</h5></td> ";
			content = content + "<td width='226' align='left' valign='top' class='boldEleven'><h5>"+data[0][0]+"</h5></td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'><b>CPO Entry Date </td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][31]+"</td> ";
			content = content + "</tr> ";
			
			
			content = content + " <tr bgcolor='#FF9900'> ";
			content = content + "<td align='left' valign='top' class='boldEleven'><b>P.O Number </td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][6]+"</td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'><b>P.O date </td> ";
			content = content + " <td align='left' valign='top' class='boldEleven'>"+data[0][7]+"</td> ";
			content = content + " </tr> ";
			
			
			content = content + "<tr> ";
			content = content + "<td align='left' valign='top' class='boldEleven'><b>Customer </td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][2]+"</td> ";
			content = content + " <td align='left' valign='top' class='boldEleven'><b>Shipping Address</td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][4]+"</td> ";
			content = content + " </tr> ";
			
			content = content + " <tr bgcolor='#FF9900'> ";
			content = content + "<td align='left' valign='top' class='boldEleven'><b>Possible Date of Delivery</td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][8]+"</td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'><b>Division</td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][5]+"</td> ";
			content = content + "</tr> ";
			
			
			content = content + "<tr> ";
			content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Bank Guarantee</td> ";
			content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][9]+"</td> ";
			content = content + "<td valign='top' class='boldEleven'><b>&nbsp;</td> ";
			content = content + "<td class='boldEleven'>&nbsp;</td> ";
			content = content + "</tr> ";
			
			content = content + " <tr bgcolor='#FF9900'> ";
			content = content + "<td valign='top' class='boldEleven'><b>Payment Commitment Days</td> ";
			content = content + "<td class='boldEleven'>"+data[0][10]+" - Days</td> ";
			content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Delivery</td> ";
			content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][11]+"</td> ";
			content = content + "</tr> ";
			
			content = content + "<tr> ";
			content = content + " <td valign='top' class='boldEleven'><b>Installation / Implementation</td> ";
			content = content + "<td class='boldEleven'>"+data[0][12]+"</td> ";
			content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Stock Type</td> ";
			content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][13]+"</td> ";
			content = content + "</tr> ";
			
			content = content + "<tr bgcolor='#FF9900'> ";
			content = content + "<td valign='top' class='boldEleven'><b>Billed in Multiple Location</td> ";
			content = content + "<td class='boldEleven'>"+data[0][14]+"</td> ";
			content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Block Invoice</td> ";
			content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][15]+"</td> ";
			content = content + " </tr> ";
			
			content = content + "<tr> ";
			content = content + "<td valign='top' class='boldEleven'><b>Multiple Bill</td> ";
			content = content + "<td class='boldEleven'>"+data[0][16]+"</td> ";
			content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Partial Bill</td> ";
			content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][17]+"</td> ";
			content = content + "</tr> ";
			
			content = content + "<tr bgcolor='#FF9900'> ";
			content = content + "<td height='22' align='left' valign='top' class='boldEleven'><b>Liquidated Damage </td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'>"+("Y".equals(data[0][18])?"Yes":"No")+"</td> ";
			if("Y".equals(data[0][19]))
			{
				content = content + "<td class='boldEleven'><b>Damage % </td> ";
				content = content + "<td class='boldEleven'>"+( (data[0][19]=="Y")?"Yes":"No" )+"</td> ";
			}
			else
			{
				content = content + "<td valign='top' class='boldEleven'>&nbsp;</td> ";
				content = content + "<td valign='top' class='boldEleven'>&nbsp;</td> ";
			}
			content = content + "</tr> ";
			
			if("Y".equals(data[0][19]))
			{
				content = content + "<tr> ";
				content = content + "<td valign='top' class='boldEleven'>&nbsp;</td> ";
				content = content + "<td valign='top' class='boldEleven'>&nbsp;</td> ";
				content = content + "<td valign='top' class='boldEleven'><b>Damage Days </td> ";
				content = content + "<td valign='top' class='boldEleven'>"+data[0][20]+"</td> ";
				content = content + "</tr> ";
			}
			
			content = content + "<tr bgcolor='#FF9900'> ";
			content = content + "<td valign='top' class='boldEleven'><b>M.E-1</td> ";
			content = content + "<td class='boldEleven'>"+data[0][24]+"</td> ";
			content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Percentage</td> ";
			content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][25]+"</td> ";
			content = content + "</tr> ";
			content = content + "<tr> ";
			
			if("".equals(data[0][26]))
			{
				content = content + "<tr> ";
				content = content + "<td valign='top' class='boldEleven'><b>M.E-2</td> ";
				content = content + "<td class='boldEleven'>"+data[0][26]+"</td> ";
				content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Percentage</td> ";
				content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][27]+"</td> ";
				content = content + "</tr> ";
				content = content + "<tr> ";
			}
			
			if("".equals(data[0][28]))
			{
				content = content + "<tr bgcolor='#FF9900'> ";
				content = content + "<td valign='top' class='boldEleven'><b>M.E-3</td> ";
				content = content + "<td class='boldEleven'>"+data[0][28]+"</td> ";
				content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Percentage</td> ";
				content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][29]+"</td> ";
				content = content + "</tr> ";
				content = content + "<tr> ";
			}
			
			//Goods description
			content = content + "<tr> ";
			content = content + "<td valign='top' class='boldEleven' colspan='4'>";
			sql="";
			sql = sql +" SELECT if(a.CHR_TYPE='I','ITEM','PRODUCT'),   ";
			sql = sql +"   FUN_INV_PRODUCTCODE(a.CHR_TYPE,a.CHR_ITEMID), ";
			sql = sql +" LEFT(FUN_INV_PRODUCTDESCRIPTION(a.CHR_TYPE,a.CHR_ITEMID),100) , ";  
			sql = sql +" a.INT_QUANTITY ,a.INT_WARRANTY    ";
			sql = sql +" From  inv_t_customersalesorderitem a   ";
			sql = sql +" WHERE a.CHR_SALESORDERNO ='"+cponumber+"' "; 
			String saledata[][] = CommonFunctions.QueryExecute(sql);
			if(saledata.length>0)
			{
				content = content + "<table width='100%'  border='1' align='center'  cellpadding=0 cellspacing=0  >";
				content = content + "<tr>";
				content = content + "<td class='boldEleven' ><center><b>S.No</b></center></td>";
				content = content + "<td class='boldEleven' ><center><b>Type</b></center></td>";
				content = content + "<td class='boldEleven' ><center><b>Item / Product</b></center></td>";
				content = content + "<td class='boldEleven' ><center><b>Description</b></center></td>";
				content = content + "<td class='boldEleven' ><center><b>Order Qty / Units</b></center></td>";
				content = content + "<td class='boldEleven' ><center><b>Warranty</b></center></td>";
				content = content + "</tr>";
				for(int u=0; u<saledata.length;u++)
				{
					content = content + "<tr>";
					content = content + "<td class='boldEleven' >"+(u+1)+".</td>";
					content = content + "<td class='boldEleven'>"+saledata[u][0]+"</td>";
					content = content + "<td class='boldEleven'>"+saledata[u][1]+"</td>";
					content = content + "<td class='boldEleven'>"+saledata[u][2]+"</td>";
					content = content + "<td class='boldEleven' align='right'>"+saledata[u][3]+"</td>";
					content = content + "<td class='boldEleven' align='center'>"+saledata[u][4]+" - Yrs</td>";
					content = content + "</tr>";
				}
				content = content + "</table>";
			}
			
			content = content + "</td> ";
			content = content + "</tr> ";
			content = content + "<tr> ";
		    content = content + "</table> ";
			
			content = content + "<br><div style=\"font-family:Georgia, 'Times New Roman', Times, serif; font-size:18px; color:#000000;\"><center><strong>Next Stage :- Waiting for billing team acknowledgement...<br></strong></center></div><br><br>";  
			//Content end
			
			
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
	
	
	
	
	//CPO Verification content
	public static String  CPOVerificationMailContent(String branchid, String cponumber,String Qnumber,String Path )
    {
    	String content="";
    	try
    	{ 	
			sql =" SELECT a.CHR_SALESORDERNO cpo  ,a.CHR_QUOTATIONNO quotation, ";	
			sql = sql + " FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) customer, DATE_FORMAT(a1.DAT_QUOTATIONDATE,'%d-%b-%Y') quotedate, ";
			sql = sql + " a.CHR_SHIPINGADDRESS address ,FUN_INV_DIVISION(a.INT_DIVIID) division,  ";
			sql = sql + " a.CHR_CUSTPURCHASENO po,  DATE_FORMAT(a.CHR_PURCHASEORDER_DATE,'%d-%b-%Y') podate, ";	 
			sql = sql + " DATE_FORMAT(a.CHR_DELIVERY_DATE,'%d-%b-%Y') dateofdelivery,	IF(a.CHR_BG='Y','YES','NO') bg, ";  	 
			sql = sql + " a.INT_PAYMENT_COMMITMENT_DAYS commitmentdays, 	IF(a.CHR_DELIVERY='Y','YES','NO') delivery ,  ";	 
			sql = sql + " IF(a.CHR_INSTALLATION='Y','YES','NO') installation,IF(a.CHR_STOCKTYPE='G','General','B2B') stocktype, ";  
			sql = sql + " IF(a.CHR_MULTIPLE_LOCATION='Y','YES','NO') multiplelocation, IF(a.CHR_INVOICEBLOCK='Y','YES','NO') invoiceblock, ";  
			sql = sql + " IF(a.CHR_MULTIPLE_BILL='Y','YES','NO') multiplebill,  IF(a.CHR_PARTIAL_BILL='Y','YES','NO') partialbill,  ";
			sql = sql + " a.CHR_DEMURRAGE damage,a.DOU_DEMARRAGE_PERCENTAGE damagepercent,DATE_FORMAT(a.DAT_DEMARRAGE_DATE,'%d-%b-%Y') damagedate, "; 
			sql = sql + " IF(a.CHR_BYBACK='Y','YES','NO') buyback, a.CHR_BYBACKDESC,a.DOU_BYBACKAMOUNT,  ";
			sql = sql + " FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF) ,ROUND(INT_REF_PERCENTAGE1,0), ";
			sql = sql + " IF(a.CHR_REF1='0','',FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF1)),ROUND(INT_REF_PERCENTAGE2,0),  ";
			sql = sql + " IF(a.CHR_REF2='0','',FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF2)),ROUND(INT_REF_PERCENTAGE3,0),  ";
			sql = sql + " a.DOU_TOTALAMOUNT ,";
			sql = sql + " DATE_FORMAT(a1.DAT_CREATIONTIME,'%d-%b-%Y  %h:%m:%s %p'),  ";
			sql = sql + " DATE_FORMAT(a.DAT_CREATIONTIME,'%d-%b-%Y  %h:%m:%s %p'),  ";
			sql = sql + " datediff(a.DAT_CREATIONTIME,a1.DAT_CREATIONTIME)  ";
			sql = sql + " FROM inv_t_customersalesorder a ,inv_t_customerquotation a1, inv_m_tax b , inv_m_paymentterms c  , inv_m_project d "; 
			sql = sql + " WHERE a.CHR_QUOTATIONNO =a1.CHR_QUOTATIONNO AND a.INT_TAXID =b.INT_TAXID	  AND a.INT_PROJECTID =d.INT_PROJECTID   ";
			sql = sql + " AND a.INT_PAYMENTTERMID =c.INT_PAYMENTTERMID  ";
			sql = sql + " AND a.CHR_SALESORDERNO = '"+cponumber+"' ";
			String data[][]=CommonFunctions.QueryExecute(sql);
			
			//stylesheet
			content = content + StyleSheet.styleSheet();
			//top content
			content = content + Template3.topContent("Customer Purchase Order Acknowledged by Billing Team ");
			
			
			//Content start
			content = content + "<table width='100%' border='0' align='center' cellpadding='2' cellspacing='2'> ";
			
			content = content + "<tr bgcolor='#FF9900'> ";
			content = content + "<td width='192' align='left' valign='top' class='boldEleven'><b>Quotation Ref No</td> ";
			content = content + "<td width='226' align='left' valign='top' class='boldEleven'>"+data[0][1]+"</td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'><b>Quotaion Entry Date</td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][31]+"</td> ";
			content = content + "</tr> ";
			
			content = content + "<tr> ";
			content = content + "<td width='192' align='left' valign='top' class='boldEleven'><b><h5>CPO Ref No</h5></td> ";
			content = content + "<td width='226' align='left' valign='top' class='boldEleven'><h5>"+data[0][0]+"</h5></td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'><b>CPO Entry Date</td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][31]+"</td> ";
			content = content + "</tr> ";
			
			
			 
			
			content = content + "<tr bgcolor='#FF9900'> ";
			content = content + "<td align='left' valign='top' class='boldEleven'><b>Customer </td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][2]+"</td> ";
			content = content + " <td align='left' valign='top' class='boldEleven'><b>Division</td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][5]+"</td> ";
			content = content + " </tr> ";
			
			content = content + " <tr > ";
			content = content + "<td align='left' valign='top' class='boldEleven'><b>Shipping Address</td> ";
			content = content + "<td align='left' valign='top' class='boldEleven' colspan='3'>"+data[0][4]+"</td> ";
			content = content + "</tr> ";
			
			content = content + " <tr bgcolor='#FF9900'> ";
			content = content + "<td align='left' valign='top' class='boldEleven'><b>P.O Number </td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][6]+"</td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'><b>P.O date </td> ";
			content = content + " <td align='left' valign='top' class='boldEleven'>"+data[0][7]+"</td> ";
			content = content + " </tr> ";
			
			content = content + "<tr > ";
			content = content + "<td valign='top' class='boldEleven'><b>Possible Date of Delivery</td> ";
			content = content + "<td class='boldEleven'>"+data[0][8]+"</td> ";
			content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Bank Guarantee</td> ";
			content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][9]+"</td> ";
			content = content + "</tr> ";
			
			content = content + " <tr bgcolor='#FF9900'> ";
			content = content + "<td valign='top' class='boldEleven'><b>Payment Commitment Days</td> ";
			content = content + "<td class='boldEleven'>"+data[0][10]+"</td> ";
			content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Delivery</td> ";
			content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][11]+" - Days</td> ";
			content = content + "</tr> ";
			
			content = content + "<tr > ";
			content = content + " <td valign='top' class='boldEleven'><b>Installation / Implementation</td> ";
			content = content + "<td class='boldEleven'>"+data[0][12]+"</td> ";
			content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Stock Type</td> ";
			content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][13]+"</td> ";
			content = content + "</tr> ";
			
			content = content + "<tr bgcolor='#FF9900'> ";
			content = content + "<td valign='top' class='boldEleven'><b>Billed in Multiple Location</td> ";
			content = content + "<td class='boldEleven'>"+data[0][14]+"</td> ";
			content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Block Invoice</td> ";
			content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][15]+"</td> ";
			content = content + " </tr> ";
			
			content = content + "<tr > ";
			content = content + "<td valign='top' class='boldEleven'><b>Multiple Bill</td> ";
			content = content + "<td class='boldEleven'>"+data[0][16]+"</td> ";
			content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Partial Bill</td> ";
			content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][17]+"</td> ";
			content = content + "</tr> ";
			
			content = content + "<tr bgcolor='#FF9900'> ";
			content = content + "<td height='22' align='left' valign='top' class='boldEleven'><b>Liquidated Damage</td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'>"+("Y".equals(data[0][18])?"Yes":"No")+"</td> ";
			if("Y".equals(data[0][19]))
			{
				content = content + "<td class='boldEleven'><b>Damage % </td> ";
				content = content + "<td class='boldEleven'>"+( (data[0][19]=="Y")?"Yes":"No" )+"</td> ";
			}
			else
			{
				content = content + "<td valign='top' class='boldEleven'>&nbsp;</td> ";
				content = content + "<td valign='top' class='boldEleven'>&nbsp;</td> ";
			}
			content = content + "</tr> ";
			
			if("Y".equals(data[0][19]))
			{
				content = content + "<tr bgcolor='#FF9900'> ";
				content = content + "<td valign='top' class='boldEleven'>&nbsp;</td> ";
				content = content + "<td valign='top' class='boldEleven'>&nbsp;</td> ";
				content = content + "<td valign='top' class='boldEleven'><b>Damage Days </td> ";
				content = content + "<td valign='top' class='boldEleven'>"+data[0][20]+"</td> ";
				content = content + "</tr> ";
			}
			
			content = content + "<tr bgcolor='#FF9900'> ";
			content = content + "<td valign='top' class='boldEleven'><b>M.E-1</td> ";
			content = content + "<td class='boldEleven'>"+data[0][24]+"</td> ";
			content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Percentage</td> ";
			content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][25]+"</td> ";
			content = content + "</tr> ";
			content = content + "<tr> ";
			
			if("".equals(data[0][26]))
			{
				content = content + "<tr> ";
				content = content + "<td valign='top' class='boldEleven'><b>M.E-2</td> ";
				content = content + "<td class='boldEleven'>"+data[0][26]+"</td> ";
				content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Percentage</td> ";
				content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][27]+"</td> ";
				content = content + "</tr> ";
				content = content + "<tr> ";
			}
			
			if("".equals(data[0][28]))
			{
				content = content + "<tr bgcolor='#FF9900'> ";
				content = content + "<td valign='top' class='boldEleven'><b>M.E-3</td> ";
				content = content + "<td class='boldEleven'>"+data[0][28]+"</td> ";
				content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Percentage</td> ";
				content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][29]+"</td> ";
				content = content + "</tr> ";
				content = content + "<tr> ";
			}
			
			content = content + "<tr bgcolor='#99ff00'> ";
			content = content + "<td valign='top' class='boldEleven'><b>PO Value</td> ";
			content = content + "<td class='boldEleven'>"+data[0][30]+"</td> ";
			content = content + "<td width='162' align='left' valign='top' class='boldEleven'>&nbsp;</td> ";
			content = content + "<td width='203' align='left' valign='top' class='boldEleven'>&nbsp;</td> ";
			content = content + "</tr> ";
			 
			 //Goods description
			content = content + "<tr> ";
			content = content + "<td valign='top' class='boldEleven' colspan='4'>";
			sql="";
			sql = sql +" SELECT if(a.CHR_TYPE='I','ITEM','PRODUCT'),   ";
			sql = sql +"   FUN_INV_PRODUCTCODE(a.CHR_TYPE,a.CHR_ITEMID), ";
			sql = sql +" LEFT(FUN_INV_PRODUCTDESCRIPTION(a.CHR_TYPE,a.CHR_ITEMID),100) , ";  
			sql = sql +" a.INT_QUANTITY ,a.INT_WARRANTY    ";
			sql = sql +" From  inv_t_customersalesorderitem a   ";
			sql = sql +" WHERE a.CHR_SALESORDERNO ='"+cponumber+"' "; 
			String saledata[][] = CommonFunctions.QueryExecute(sql);
			if(saledata.length>0)
			{
				content = content + "<table width='100%'  border='1' align='center'  cellpadding=0 cellspacing=0  >";
				content = content + "<tr>";
				content = content + "<td class='boldEleven' ><center><b>S.No</b></center></td>";
				content = content + "<td class='boldEleven' ><center><b>Type</b></center></td>";
				content = content + "<td class='boldEleven' ><center><b>Item / Product</b></center></td>";
				content = content + "<td class='boldEleven' ><center><b>Description</b></center></td>";
				content = content + "<td class='boldEleven' ><center><b>Order Qty / Units</b></center></td>";
				content = content + "<td class='boldEleven' ><center><b>Warranty</b></center></td>";
				content = content + "</tr>";
				for(int u=0; u<saledata.length;u++)
				{
					content = content + "<tr>";
					content = content + "<td class='boldEleven' >"+(u+1)+".</td>";
					content = content + "<td class='boldEleven'>"+saledata[u][0]+"</td>";
					content = content + "<td class='boldEleven'>"+saledata[u][1]+"</td>";
					content = content + "<td class='boldEleven'>"+saledata[u][2]+"</td>";
					content = content + "<td class='boldEleven' align='right'>"+saledata[u][3]+"</td>";
					content = content + "<td class='boldEleven' align='center'>"+saledata[u][4]+" - Yrs</td>";
					content = content + "</tr>";
				}
				content = content + "</table>";
			}
			
			content = content + "</td> ";
			content = content + "</tr> ";
			
			
			content = content + "</table> ";
			content = content + "<br><div style=\"font-family:Georgia, 'Times New Roman', Times, serif; font-size:18px; color:#ffffff;\"><center><strong>Next Stage :- Waiting for CPO Approval by Business Head for purchase request raising...<br>";  
			
			File file = null; 
			file = new File(Path+"uploadfiles/CPO_Order/"+Qnumber.replaceAll("/","_")+".pdf");
			if(file.exists())
				content = content + "<br> The Customer purchase order attached for your reference : <a download='"+Qnumber.replaceAll("/","_")+".pdf'  href='"+Qnumber.replaceAll("/","_")+".pdf'>click to open</a>";
			content = content + "</strong></center></div><br>";
			//Content end
			
			content = content + Template3.bottomContent(branchid);
			
			
			return content;
    		
    	}
    	catch(Exception e)
    	{
    		 
    		System.out.println(e.getMessage());
    	}
    	return content;
    }
	
	//CPO BH Closed content
	public static String  CPOClosedBusinessHeadContent(String branchid, String cponumber,String Qnumber,String Path )
    {
    	String content="";
    	try
    	{ 	
			sql =" SELECT a.CHR_SALESORDERNO cpo  ,a.CHR_QUOTATIONNO quotation, ";	
			sql = sql + " FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) customer, DATE_FORMAT(a1.DAT_QUOTATIONDATE,'%d-%b-%Y') quotedate, ";
			sql = sql + " a.CHR_SHIPINGADDRESS address ,FUN_INV_DIVISION(a.INT_DIVIID) division,  ";
			sql = sql + " a.CHR_CUSTPURCHASENO po,  DATE_FORMAT(a.CHR_PURCHASEORDER_DATE,'%d-%b-%Y') podate, ";	 
			sql = sql + " DATE_FORMAT(a.CHR_DELIVERY_DATE,'%d-%b-%Y') dateofdelivery,	IF(a.CHR_BG='Y','YES','NO') bg, ";  	 
			sql = sql + " a.INT_PAYMENT_COMMITMENT_DAYS commitmentdays, 	IF(a.CHR_DELIVERY='Y','YES','NO') delivery ,  ";	 
			sql = sql + " IF(a.CHR_INSTALLATION='Y','YES','NO') installation,IF(a.CHR_STOCKTYPE='G','General','B2B') stocktype, ";  
			sql = sql + " IF(a.CHR_MULTIPLE_LOCATION='Y','YES','NO') multiplelocation, IF(a.CHR_INVOICEBLOCK='Y','YES','NO') invoiceblock, ";  
			sql = sql + " IF(a.CHR_MULTIPLE_BILL='Y','YES','NO') multiplebill,  IF(a.CHR_PARTIAL_BILL='Y','YES','NO') partialbill,  ";
			sql = sql + " a.CHR_DEMURRAGE damage,a.DOU_DEMARRAGE_PERCENTAGE damagepercent,DATE_FORMAT(a.DAT_DEMARRAGE_DATE,'%d-%b-%Y') damagedate, "; 
			sql = sql + " IF(a.CHR_BYBACK='Y','YES','NO') buyback, a.CHR_BYBACKDESC,a.DOU_BYBACKAMOUNT,  ";
			sql = sql + " FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF) ,ROUND(INT_REF_PERCENTAGE1,0), ";
			sql = sql + " IF(a.CHR_REF1='0','',FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF1)),ROUND(INT_REF_PERCENTAGE2,0),  ";
			sql = sql + " IF(a.CHR_REF2='0','',FIND_A_EMPLOYEE_ID_NAME(a.CHR_REF2)),ROUND(INT_REF_PERCENTAGE3,0),  ";
			sql = sql + " a.DOU_TOTALAMOUNT ,";
			sql = sql + " DATE_FORMAT(a1.DAT_CREATIONTIME,'%d-%b-%Y  %h:%m:%s %p'),  ";
			sql = sql + " DATE_FORMAT(a.DAT_CREATIONTIME,'%d-%b-%Y  %h:%m:%s %p'),  ";
			sql = sql + " datediff(a.DAT_CREATIONTIME,a1.DAT_CREATIONTIME)  ";
			sql = sql + " FROM inv_t_customersalesorder a ,inv_t_customerquotation a1, inv_m_tax b , inv_m_paymentterms c  , inv_m_project d "; 
			sql = sql + " WHERE a.CHR_QUOTATIONNO =a1.CHR_QUOTATIONNO AND a.INT_TAXID =b.INT_TAXID	  AND a.INT_PROJECTID =d.INT_PROJECTID   ";
			sql = sql + " AND a.INT_PAYMENTTERMID =c.INT_PAYMENTTERMID  ";
			sql = sql + " AND a.CHR_SALESORDERNO = '"+cponumber+"' ";
			String data[][]=CommonFunctions.QueryExecute(sql);
			
			//stylesheet
			content = content + StyleSheet.styleSheet();
			//top content
			content = content + Template3.topContent("Customer Purchase Order closed by Business Head.");
			
			
			//Content start
			content = content + "<table width='100%' border='0' align='center' cellpadding='2' cellspacing='2'> ";
			
			content = content + "<tr bgcolor='#FF9900'> ";
			content = content + "<td width='192' align='left' valign='top' class='boldEleven'><b>Quotation Ref No</td> ";
			content = content + "<td width='226' align='left' valign='top' class='boldEleven'>"+data[0][1]+"</td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'><b>Quotaion Entry Date</td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][31]+"</td> ";
			content = content + "</tr> ";
			
			content = content + "<tr> ";
			content = content + "<td width='192' align='left' valign='top' class='boldEleven'><b><h5>CPO Ref No</h5></td> ";
			content = content + "<td width='226' align='left' valign='top' class='boldEleven'><h5>"+data[0][0]+"</h5></td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'><b>CPO Entry Date</td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][31]+"</td> ";
			content = content + "</tr> ";
			
			
			 
			
			content = content + "<tr bgcolor='#FF9900'> ";
			content = content + "<td align='left' valign='top' class='boldEleven'><b>Customer </td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][2]+"</td> ";
			content = content + " <td align='left' valign='top' class='boldEleven'><b>Division</td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][5]+"</td> ";
			content = content + " </tr> ";
			
			content = content + " <tr > ";
			content = content + "<td align='left' valign='top' class='boldEleven'><b>Shipping Address</td> ";
			content = content + "<td align='left' valign='top' class='boldEleven' colspan='3'>"+data[0][4]+"</td> ";
			content = content + "</tr> ";
			
			content = content + " <tr bgcolor='#FF9900'> ";
			content = content + "<td align='left' valign='top' class='boldEleven'><b>P.O Number </td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][6]+"</td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'><b>P.O date </td> ";
			content = content + " <td align='left' valign='top' class='boldEleven'>"+data[0][7]+"</td> ";
			content = content + " </tr> ";
			
			content = content + "<tr > ";
			content = content + "<td valign='top' class='boldEleven'><b>Possible Date of Delivery</td> ";
			content = content + "<td class='boldEleven'>"+data[0][8]+"</td> ";
			content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Bank Guarantee</td> ";
			content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][9]+"</td> ";
			content = content + "</tr> ";
			
			content = content + " <tr bgcolor='#FF9900'> ";
			content = content + "<td valign='top' class='boldEleven'><b>Payment Commitment Days</td> ";
			content = content + "<td class='boldEleven'>"+data[0][10]+"</td> ";
			content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Delivery</td> ";
			content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][11]+" - Days</td> ";
			content = content + "</tr> ";
			
			content = content + "<tr > ";
			content = content + " <td valign='top' class='boldEleven'><b>Installation / Implementation</td> ";
			content = content + "<td class='boldEleven'>"+data[0][12]+"</td> ";
			content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Stock Type</td> ";
			content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][13]+"</td> ";
			content = content + "</tr> ";
			
			content = content + "<tr bgcolor='#FF9900'> ";
			content = content + "<td valign='top' class='boldEleven'><b>Billed in Multiple Location</td> ";
			content = content + "<td class='boldEleven'>"+data[0][14]+"</td> ";
			content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Block Invoice</td> ";
			content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][15]+"</td> ";
			content = content + " </tr> ";
			
			content = content + "<tr > ";
			content = content + "<td valign='top' class='boldEleven'><b>Multiple Bill</td> ";
			content = content + "<td class='boldEleven'>"+data[0][16]+"</td> ";
			content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Partial Bill</td> ";
			content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][17]+"</td> ";
			content = content + "</tr> ";
			
			content = content + "<tr bgcolor='#FF9900'> ";
			content = content + "<td height='22' align='left' valign='top' class='boldEleven'><b>Liquidated Damage</td> ";
			content = content + "<td align='left' valign='top' class='boldEleven'>"+("Y".equals(data[0][18])?"Yes":"No")+"</td> ";
			if("Y".equals(data[0][19]))
			{
				content = content + "<td class='boldEleven'><b>Damage % </td> ";
				content = content + "<td class='boldEleven'>"+( (data[0][19]=="Y")?"Yes":"No" )+"</td> ";
			}
			else
			{
				content = content + "<td valign='top' class='boldEleven'>&nbsp;</td> ";
				content = content + "<td valign='top' class='boldEleven'>&nbsp;</td> ";
			}
			content = content + "</tr> ";
			
			if("Y".equals(data[0][19]))
			{
				content = content + "<tr bgcolor='#FF9900'> ";
				content = content + "<td valign='top' class='boldEleven'>&nbsp;</td> ";
				content = content + "<td valign='top' class='boldEleven'>&nbsp;</td> ";
				content = content + "<td valign='top' class='boldEleven'><b>Damage Days </td> ";
				content = content + "<td valign='top' class='boldEleven'>"+data[0][20]+"</td> ";
				content = content + "</tr> ";
			}
			
			content = content + "<tr bgcolor='#FF9900'> ";
			content = content + "<td valign='top' class='boldEleven'><b>M.E-1</td> ";
			content = content + "<td class='boldEleven'>"+data[0][24]+"</td> ";
			content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Percentage</td> ";
			content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][25]+"</td> ";
			content = content + "</tr> ";
			content = content + "<tr> ";
			
			if("".equals(data[0][26]))
			{
				content = content + "<tr> ";
				content = content + "<td valign='top' class='boldEleven'><b>M.E-2</td> ";
				content = content + "<td class='boldEleven'>"+data[0][26]+"</td> ";
				content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Percentage</td> ";
				content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][27]+"</td> ";
				content = content + "</tr> ";
				content = content + "<tr> ";
			}
			
			if("".equals(data[0][28]))
			{
				content = content + "<tr bgcolor='#FF9900'> ";
				content = content + "<td valign='top' class='boldEleven'><b>M.E-3</td> ";
				content = content + "<td class='boldEleven'>"+data[0][28]+"</td> ";
				content = content + "<td width='162' align='left' valign='top' class='boldEleven'><b>Percentage</td> ";
				content = content + "<td width='203' align='left' valign='top' class='boldEleven'>"+data[0][29]+"</td> ";
				content = content + "</tr> ";
				content = content + "<tr> ";
			}
			
			content = content + "<tr bgcolor='#99ff00'> ";
			content = content + "<td valign='top' class='boldEleven'><b>PO Value</td> ";
			content = content + "<td class='boldEleven'>"+data[0][30]+"</td> ";
			content = content + "<td width='162' align='left' valign='top' class='boldEleven'>&nbsp;</td> ";
			content = content + "<td width='203' align='left' valign='top' class='boldEleven'>&nbsp;</td> ";
			content = content + "</tr> ";
			 
			 //Goods description
			content = content + "<tr> ";
			content = content + "<td valign='top' class='boldEleven' colspan='4'>";
			sql="";
			sql = sql +" SELECT if(a.CHR_TYPE='I','ITEM','PRODUCT'),   ";
			sql = sql +"   FUN_INV_PRODUCTCODE(a.CHR_TYPE,a.CHR_ITEMID), ";
			sql = sql +" LEFT(FUN_INV_PRODUCTDESCRIPTION(a.CHR_TYPE,a.CHR_ITEMID),100) , ";  
			sql = sql +" a.INT_QUANTITY ,a.INT_WARRANTY    ";
			sql = sql +" From  inv_t_customersalesorderitem a   ";
			sql = sql +" WHERE a.CHR_SALESORDERNO ='"+cponumber+"' "; 
			String saledata[][] = CommonFunctions.QueryExecute(sql);
			if(saledata.length>0)
			{
				content = content + "<table width='100%'  border='1' align='center'  cellpadding=0 cellspacing=0  >";
				content = content + "<tr>";
				content = content + "<td class='boldEleven' ><center><b>S.No</b></center></td>";
				content = content + "<td class='boldEleven' ><center><b>Type</b></center></td>";
				content = content + "<td class='boldEleven' ><center><b>Item / Product</b></center></td>";
				content = content + "<td class='boldEleven' ><center><b>Description</b></center></td>";
				content = content + "<td class='boldEleven' ><center><b>Order Qty / Units</b></center></td>";
				content = content + "<td class='boldEleven' ><center><b>Warranty</b></center></td>";
				content = content + "</tr>";
				for(int u=0; u<saledata.length;u++)
				{
					content = content + "<tr>";
					content = content + "<td class='boldEleven' >"+(u+1)+".</td>";
					content = content + "<td class='boldEleven'>"+saledata[u][0]+"</td>";
					content = content + "<td class='boldEleven'>"+saledata[u][1]+"</td>";
					content = content + "<td class='boldEleven'>"+saledata[u][2]+"</td>";
					content = content + "<td class='boldEleven' align='right'>"+saledata[u][3]+"</td>";
					content = content + "<td class='boldEleven' align='center'>"+saledata[u][4]+" - Yrs</td>";
					content = content + "</tr>";
				}
				content = content + "</table>";
			}
			
			content = content + "</td> ";
			content = content + "</tr> ";
			
			
			content = content + "</table> ";
			//Content end
			
			content = content + Template3.bottomContent(branchid);
			
			
			return content;
    		
    	}
    	catch(Exception e)
    	{
    		 
    		System.out.println(e.getMessage());
    	}
    	return content;
    }
}
