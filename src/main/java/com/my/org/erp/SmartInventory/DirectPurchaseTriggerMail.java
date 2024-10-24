package com.my.org.erp.SmartInventory;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.common.CommonInfo;
public class DirectPurchaseTriggerMail 
{

	
	public static void  sendtoMail( String recipients[] ,String subject,String content)
    {
    	try
    	{
    		boolean debug = false;
    		String hData[][] =  CommonFunctions.QueryExecute("SELECT CHR_HOST,CHR_USERID,CHR_PASSWORD,CHR_MAILID FROM  m_mailsetting WHERE INT_MAILID = 1");
		    String host =hData[0][0]   ;
            String user =hData[0][1]   ;
            String password =hData[0][2]   ;
            String from =hData[0][3]   ;
             
            Properties props = new Properties();
  	        props.setProperty("mail.transport.protocol", "smtp");
  	        props.setProperty("mail.host", ""+host);
	        props.setProperty("mail.user", ""+user);
  	        props.setProperty("mail.password", ""+password);
  	        
  	        Session session = Session.getDefaultInstance(props, null);
  	        session.setDebug(debug); 
  	        Message msg = new MimeMessage(session);
  	        InternetAddress addressFrom = new InternetAddress(from);
  	        msg.setFrom(addressFrom);
  	        
            InternetAddress[] addressTo = new InternetAddress[recipients.length]; 
  	        for (int i = 0; i < recipients.length; i++)
  	    	   addressTo[i] = new InternetAddress(recipients[i]);
  	        msg.setRecipients(Message.RecipientType.BCC, addressTo);
  	        msg.addHeader("MyHeaderName", "myHeaderValue");
  	        msg.setSubject(subject);
  	        msg.setContent(content, "text/html");
  	        Transport.send(msg);
  	       

    	}
    	catch(Exception e)
    	{
    		 System.out.println(e.getMessage()); 
    	}
    }
	
	
	
	public static String  PurchaseContent(String branchid, String salesid )
    {
    	String q="";
		try
    	{ 
			 
			String sql="";

			 
		 
			sql ="select INT_BRANCHID,CHR_PURCHASEORDERNO,INT_VENDORID,DATE_FORMAT(DAT_ORDERDATE,'%d-%b-%Y'),INT_PAYMENTTERMID ";
			sql = sql +",CHR_DES,FIND_A_EMPLOYEE_ID_NAME(CHR_REF),DOU_AMOUNT,DOU_DISCOUNT,INT_TAXID,DOU_TAXAMOUNT,ROUND(DOU_TOTALAMOUNT,0), ";
			sql = sql +" DOU_PAIDAMOUNT,CHR_PAYMENTSTATUS,INT_DIVIID,CHR_VENDORPO,DOU_FRIEGHT_CHARGE,";
			sql = sql +" CHR_POREQUESTNO, CHR_CANCEL from inv_t_directpurchase";
			sql = sql +" WHERE CHR_PURCHASEORDERNO ='"+salesid+"'";
			String cashdata[][] = CommonFunctions.QueryExecute(sql);
			String cancellimage="";
			if("Y".equals(cashdata[0][18]))
				cancellimage=" background='../Image/report/cancelled1.jpg' ";
			
			 
			q = q + " <table width='700' border='1' align='left' cellpadding='0' cellspacing='0' bordercolor='#000000'> ";
			q = q + " <tr> ";
			q = q + " <td>";
			q = q + " <table width='663' border='0' align='left' cellpadding='0' cellspacing='0' "+cancellimage+" > ";
			q = q + " <tr> ";
			q = q + " 	<td width='650'></td>";
			q = q + " </tr>";
			q = q + " <tr>";
			q = q + " 	<td align='center' class='bolddeeplogin'>";
			q = q + " 	<div align='center'>PURCHASE INVOICE </div>";
			q = q + " 	</td>";
			q = q + " </tr>";
			q = q + " <tr>";
			q = q + " 	<td>&nbsp;</td>";
			q = q + " </tr>";
			q = q + " <tr>";
			q = q + " 	<td>";
			q = q + " 	<table width='673' border='0' align='center' cellpadding='1' cellspacing='1'>";
			q = q + " <tr>";
			q = q + "<td width='150' valign='top' class='boldEleven'>";
			q = q + "<div align='left'><strong> Ref. No. </strong></div></td>";
			q = q + " <td width='229' valign='top' class='boldEleven'>";
			q = q + " <div align='left'>"+cashdata[0][1]+"</div></td>";
			q = q + " <td width='150' valign='top' class='boldEleven'><strong>Purchase	Date </strong></td>";
			q = q + " <td width='217' valign='top' class='boldEleven'>"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(cashdata[0][3])+"</td>";
			q = q + " </tr> ";
			q = q + " <tr> ";
			q = q + " <td valign='top' class='boldEleven'>&nbsp;</td> ";
			q = q + " <td valign='top' class='boldEleven'> ";
			q = q + " <td valign='top' class='boldEleven'><strong>Payment Terms</strong></td>";
			q = q + " <td valign='top' class='boldEleven'>";
			
			String paymentids[][] =  CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms");
			String pid = cashdata[0][4].trim();			
			for(int u=0; u<paymentids.length; u++)
			{
				if(pid.equals(paymentids[u][0]))
					q = q +   paymentids[u][1] ;
				
						
			}	
			q = q + " </td>";
			q = q + " </tr>";
			q = q + " <tr>";
			q = q + " <td valign='top' class='boldEleven'><strong>Vendor Ref.No </strong></td>";
			q = q + " <td valign='top' class='boldEleven'>"+cashdata[0][15];
			q = q + " <td valign='top' class='boldEleven'><strong>Purchase Request </strong></td>";
			q = q + " <td valign='top' class='boldEleven'>"+cashdata[0][17]+"</td>";
			q = q + " </tr> ";
			q = q + " <tr> ";
			q = q + " <td valign='top' class='boldEleven'><strong>Vendor Address </strong></td> ";
			q = q + " <td valign='top' class='boldEleven'>";
									
			sql = " SELECT  a.CHR_VENDORNAME,a.CHR_CONTACTPERSON,a.CHR_ADDRESS1,a.CHR_ADDRESS2, ";
			sql = sql + " e.CHR_CITYNAME,d.CHR_DISTRICT,  ";
			sql = sql + " c.CHR_STATENAME,   CONCAT('PIN :',a.INT_PINCODE),CONCAT('MOBILE :',a.CHR_MOBILE),   ";
			sql = sql + " a.INT_ACTIVE,a.CHR_PHONE,a.CHR_EMAIL     ";
			sql = sql + " FROM  inv_m_vendorsinformation a, com_m_country b,com_m_state c,com_m_district d,  ";
			sql = sql + " com_m_city e  ,inv_m_vendorsgroup f   ";
			sql = sql + " WHERE a.INT_GROUPID = f.INT_GROUPID  ";
			sql = sql + " AND a.INT_COUNTRYID = b.INT_COUNTRYID   "; 
			sql = sql + " AND a.INT_STATEID =c.INT_STATEID     ";
			sql = sql + " AND a.INT_DISTRICTID= d.INT_DISTRICTID  ";
			sql = sql + " AND a.INT_CITYID =e.INT_CITYID AND INT_VENDORID="+cashdata[0][2];  
			String vendor[][]=CommonFunctions.QueryExecute( sql);
			if(vendor.length>0)
			{
				q = q +   vendor[0][0]+",<br>";
				if(!"-".equals(vendor[0][1]))
					q = q +   vendor[0][1]+",<br>";
				if(!"-".equals(vendor[0][2]))	
					q = q +   vendor[0][2]+",<br>";
				if(!"-".equals(vendor[0][3]))
					q = q +   vendor[0][3]+",<br>";
				if(!"-".equals(vendor[0][4]))
					q = q +   vendor[0][4]+".<br>";

			}
								                     
			q = q + " <td valign='top' class='boldEleven'><strong>Customer Name </strong></td>";
			q = q + " <td valign='top' class='boldEleven'> ";
			sql="SELECT FUN_GET_CUSTOMER_ADDRESS(INT_CUSTOMERID,'<br>') FROM inv_t_purchaserequest WHERE CHR_POREQUESTNO='"+cashdata[0][17]+"'";
			q = q + CommonFunctions.QueryExecute(sql)[0][0] ;
			q = q + " </td> ";
			q = q + " </tr> ";
			q = q + " <tr> ";
			q = q + " <td valign='top' class='boldEleven'>&nbsp;</td> ";
			q = q + " <td valign='top' class='boldEleven'> ";
			q = q + " <td valign='top' class='boldEleven'>&nbsp;</td> ";
			q = q + " <td valign='top' class='boldEleven'>&nbsp;</td> ";
			q = q + " </tr> ";
			q = q + " </table> ";
			q = q + " </td> ";
			q = q + " </tr> ";
			q = q + " <tr> ";
			q = q + " <td></td> ";
			q = q + " </tr> ";
			q = q + " <tr> ";
			q = q + " <td align='center'> ";
			
			
			q = q + " <table width='98%' border='1' cellpadding='2' cellspacing='1' bgcolor='#999999'> ";
			q = q + " <tr bgcolor='#FFFFFF'> ";
			q = q + " <td height='23' class='boldEleven'><b>S.No</b></td> ";
			q = q + " <td height='23' class='boldEleven'><b>Type</b></td> ";
			q = q + " <td height='23' class='boldEleven'><b>Item</b></td> ";
			q = q + " <td class='boldEleven' width=500><b>Description</b></td> ";
			q = q + " <td class='boldEleven'><b>Quantity/Unit</b></td> ";
			q = q + " <td class='boldEleven'><b>Unit Price</b></td> ";
			q = q + " <td class='boldEleven'><b>Discount(%)</b></td> ";
			q = q + " <td class='boldEleven'><b>Unit Discount</b></td> ";
			q = q + " <td class='boldEleven' valign='top'><b>Total</b></td> ";
			 
									  
		 	String iname="";
			String itemname="";
			String itemcolor="";
			String iitype=""; 
							  
			 sql ="SELECT CHR_PURCHASEORDERNO,FUN_INV_PRODUCTCODE(CHR_TYPE,CHR_ITEMID),IF(CHR_TYPE='I','ITEM','PRODUCT'),CHR_DESC,INT_QUANTITY,DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL FROM inv_t_directpurchaseitem WHERE CHR_PURCHASEORDERNO='"+salesid+"'";
			
			String itemDatas[][] = CommonFunctions.QueryExecute(sql);
			
			int lens = itemDatas.length;
			iname="";
			itemname="";
			String stock="";
			String ptypes="";
					for(int u=0;u<itemDatas.length;u++)
					{
						
						q = q + " <tr  bgcolor='#FFFFFF'>";
						q = q + " <td  class='boldEleven' valign='top'>"+(u+1)+"</td>  "; 
						q = q + " <td  class='boldEleven' valign='top'>"+itemDatas[u][2]+"</td> "; 
						q = q + " <td  class='boldEleven'  valign='top'>"+itemDatas[u][1]+"</td>' "; 
						q = q + " <td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][3]+"</td>";
						q = q + " <td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][4]+"</td>";
						q = q + " <td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][5]+"</td>";
						q = q + " <td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][6]+"</td>";
						q = q + " <td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][7]+"</td>";
						q = q + " <td  class='boldEleven'  valign='top' align='right'>"+itemDatas[u][8]+"</td>";
							
					}		
			 
								
					q = q + " </table>";
					q = q + " </td>";
					q = q + " </tr>";
					q = q + " <tr>";
					q = q + " <td>&nbsp;</td>";
					q = q + " </tr>";
					q = q + " <tr> ";
					q = q + " <tr> ";
					q = q + " <td>&nbsp;</td> ";
					q = q + " </tr> ";
					q = q + " <tr> ";
					q = q + " <td> ";
					q = q + " <table width='688' border='0' align='center' cellpadding='1' cellspacing='1'> ";
					q = q + " <tr> ";
					q = q + " <td width='114' rowspan='4' valign='top' class='boldEleven'><strong>Description</strong></td> ";
					q = q + " <td width='197' rowspan='4' valign='top' class='boldEleven'>"+cashdata[0][5]+"</td> ";
					q = q + " <td width='107' valign='top' class='boldEleven'> ";
					q = q + " <div align='left'><strong>Total</strong></div>						</td> ";
					q = q + " <td width='169' valign='top' class='boldEleven' id='totals1'> ";
					q = q + " <div align='right'>"+cashdata[0][7]+"</div>						</td> ";
					q = q + " </tr> ";
					q = q + " <tr> ";
					q = q + " <td valign='top' class='boldEleven'> ";
					q = q + " <div align='left'><strong>Total Discount (%) </strong></div>						</td> ";
					q = q + " <td width='169' valign='top' class='boldEleven' id='totaldiscount1'> ";
					q = q + " <div align='right'>"+cashdata[0][8]+"</div>						</td> ";
					q = q + " </tr> ";
					q = q + " <tr> ";
					q = q + " <td valign='top' class='boldEleven'> ";
					q = q + " <div align='left'><strong>Tax Group </strong></div>						</td> ";
					q = q + " <td width='169' valign='top' class='boldEleven' id='tax1'> ";
					q = q + " <div align='right'> ";
								 
					String taxids[][] = CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME ,DOU_VALUE from inv_m_tax");
					String tid =  cashdata[0][9];
					for(int u=0; u<taxids.length; u++)
					{
						if(tid.trim().equals(taxids[u][0]))
							q = q +  taxids[u][1] ;
						
					}		
			 
				q = q + " </div>						</td> ";
				q = q + " </tr> ";
				q = q + " <tr> ";
				q = q + " <td valign='top' class='boldEleven'> ";
				q = q + " <div align='left'><strong>Sales Tax (%) </strong></div> </td> ";
				q = q + " <td width='169' valign='top' class='boldEleven' id='salestax1'> ";
				q = q + " <div align='right'> ";
								 
			  String taxs[][] =  CommonFunctions.QueryExecute("Select DOU_VALUE from inv_m_tax WHERE INT_TAXID ="+tid);
			  q = q +   taxs[0][0];
			  q = q + " </div> </td> ";
			  q = q + " </tr> ";
			  q = q + " <tr> ";
			  q = q + "  <td class='boldEleven'><div align='left'><strong>Reference </strong></div></td> ";
			  q = q + " <td class='boldEleven'><div align='left'>"+cashdata[0][6]+"</div></td> ";
			  q = q + " <td class='boldEleven'> ";
			  q = q + " <div align='left'><strong>Sales Tax Amount </strong></div>						</td> ";
			  q = q + " <td width='169' class='boldEleven' id='salestaxamount1'> ";
			  q = q + " <div align='right'>"+cashdata[0][10]+"</div></td> ";
			  q = q + " </tr> ";
			  q = q + " <tr> ";
			  q = q + " <td class='boldEleven'>&nbsp;</td> ";
			  q = q + " <td class='boldEleven'>&nbsp;</td> ";
			  q = q + " <td class='boldEleven'><strong>Frieght Charge </strong></td> ";
			  q = q + " <td class='boldEleven'  width='169' id='nettotal1'><div align='right'>"+cashdata[0][16]+"</div></td> ";
			  q = q + " </tr>";
			  q = q + " <tr>";
			  q = q + " <td class='boldEleven'> ";
			  q = q + " <div align='left'></div> </td> ";
			  q = q + " <td class='boldEleven'> ";
			  q = q + " <div align='left'></div> </td> ";
			  q = q + " <td class='boldEleven'> ";
			  q = q + " <div align='left'><strong>Net Total </strong></div> </td> ";
			  q = q + " <td width='169' class='boldEleven' id='nettotal1'> ";
			  q = q + " <div align='right'>"+cashdata[0][11]+"</div> </td>";
			  q = q + " </tr>";
			  q = q + " </table>";
			  q = q + " </td> ";
			  q = q + " </tr> ";
			  q = q + " <tr> ";
			  q = q + " <td></td> ";
			  q = q + " </tr> ";
			  q = q + " <tr> ";
			  q = q + " <td></td> ";
			  q = q + " </tr> ";
			  q = q + " <tr> ";
			  q = q + " <td valign='top' class='boldEleven'>&nbsp;</td> ";
			  q = q + " </tr> ";
			   
			  q = q + " <tr> ";
			  q = q + " <td valign='top' class='boldEleven'>&nbsp;</td> ";
			  q = q + " </tr> ";
			  q = q + " </table> ";
			  q = q + " </td> ";

			  q = q + " </tr> ";
			  q = q + " </table> ";
			  q = q + " </div> ";
			
			  return q;
    	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return q;
    }
}
