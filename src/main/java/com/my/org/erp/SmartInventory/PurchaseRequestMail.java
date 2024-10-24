package com.my.org.erp.SmartInventory;

 
import java.util.Properties;
 
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.my.org.erp.common.CommonFunctions;
 
public class PurchaseRequestMail 
{ 


	public static void PurchaseRequestsendtoMail( String to ,String subject,String content)
    {
    	try
    	{
    		String hData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_HOST,CHR_USERID,CHR_PASSWORD,CHR_MAILID FROM  m_mailsetting WHERE INT_MAILID = 1");
		    String host =hData[0][0]   ;
            String user =hData[0][1]   ;
            String password =hData[0][2]   ;
            String from =hData[0][3]   ;
             
            Properties props = new Properties();
  	        props.setProperty("mail.transport.protocol", "smtp");
  	        props.setProperty("mail.host", ""+host);
	        props.setProperty("mail.user", ""+user);
  	        props.setProperty("mail.password", ""+password);
  	        
  	        Session mailSession = Session.getDefaultInstance(props, null);
  	        mailSession.setDebug(true);
  	        Transport transport = mailSession.getTransport();
  	        MimeMessage message = new MimeMessage(mailSession);
  	        message.setSubject(subject );
  	        
  	        message.setFrom(new InternetAddress(""+from));
  	        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
	        //message.addRecipient(Message.RecipientType.CC, new InternetAddress("swa@careind.net"));
	        //message.addRecipient(Message.RecipientType.BCC, new InternetAddress("snm@careind.net"));
			
  	      	
  	        message.setContent(content, "text/html");
  	        message.saveChanges();
  	      	
			transport.connect();
  	        transport.sendMessage(message, message.getRecipients(Message.RecipientType.TO));
  	        transport.close();
  	        
  	       
  
         
  	        
    	}
    	catch(Exception e)
    	{
    		 
    	}
    }
	
	

	public static void PurchaseRequestsendtoMail( String recipients[] ,String subject,String content)
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
	
	
	
	public static String  PurchaseRequestContent( boolean flag,String Requestno )
    {
    	String content="";
		try
    	{ 
    		
			content="";
			
			
			content=" <table width='95%' border='0' cellpadding='2' cellspacing='2' bgcolor='#003399'>";
			content=content+" <tr>";
			content=content+" <td align='center'><font style=\"color:ff0000; font-weight:bold\" >PURCHASE REQUEST</font></td>" ;
			content=content+" </tr>";
			content=content+" <tr>";
			content=content+" <td bgcolor='#FFFFFF' > ";
			content=content+" <table cellspacing='2' cellpadding='2' width='99%' align='center' border='0'>";
			content=content+" <tbody>";
			content=content+" <tr>";
			content=content+" <td height='16' colspan='4' align='center'valign='top' class='boldThirteen'>   ";
			      
							 						
			String sql = " ";
			sql = " SELECT "; 
			sql = sql + " a.INT_POREQUESTID,b.CHR_BRANCHNAME,c.CHR_DIVICODE, a.CHR_POREQUESTNO,DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%m-%Y'), ";
			sql = sql + " h.CHR_NAME,h.CHR_NAME, ";
			sql = sql + " f.CHR_PAYMENTNAME, ";
			sql = sql + " a.INT_CUSTOMERCOMMITMENTDAYS,a.CHR_REF,g.CHR_STAFFNAME,a.CHR_DES,a.CHR_APPROVEDSTATUS, ";
			sql = sql + " a.CHR_APPROVEDBY,DATE_FORMAT(a.DAT_APPROVEDDATE,'%d-%m-%Y'),a.CHR_APPROVEDDESCRIPTION ,a.INT_BRANCHID,a.INT_DIVIID,a.INT_CUSTOMERID  ";
			sql = sql + " FROM inv_t_purchaserequest a, com_m_branch b,inv_m_division c,inv_m_customerinfo d,inv_m_customergroup h,   ";
			sql = sql + " inv_m_paymentterms f,com_m_staff g ";
			sql = sql + " WHERE a.INT_BRANCHID = b.INT_BRANCHID ";
			sql = sql + " AND a.INT_DIVIID =c.INT_DIVIID ";
			sql = sql + " AND a.INT_CUSTOMERID = d.INT_CUSTOMERID AND d.INT_CUSTOMERGROUPID = h.INT_CUSTOMERGROUPID ";
			sql = sql + " AND a.INT_PAYMENTTERMID = f.INT_PAYMENTTERMID ";
			sql = sql + " AND a.CHR_REF=g.CHR_EMPID AND 	CHR_POREQUESTNO='"+Requestno+"'";
			System.out.println(sql);
			String data[][] = CommonFunctions.QueryExecute(sql);
							
			content=content+" </td>";
			content=content+" </tr>";
			content=content+" <tr>";
			
			content=content+"<td height='17' valign='top'  ><b>Request Number / Date </td> ";
			content=content+"<td align='left'><span class='boldEleven'>"+data[0][3] +"  dated on " +data[0][4]+" </span></td> ";
			
			
			content=content+" <td width='105'  ><b> </td>";
			content=content+" <td width='148' class='boldEleven'>  </td>";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+"<td  ><div align='left'><b>CustomerName</div></td> ";
			content=content+"<td  >"+data[0][5]+" </td> ";
			
			
			content=content+"<td  ><b>Vendor Payment </td> ";
			content=content+"<td class='boldEleven'>"+data[0][7]+" </td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			
			content=content+" <td width='118' height='17' valign='top'  ><b>Division</td>";
			content=content+" <td width='199' align='left' valign='top'>"+data[0][2]+"</td>"; 
			
			
			content=content+"<td  ><b>Commitment days </td> ";
			content=content+"<td  >"+data[0][8]+"- Days </td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td valign='top'  ><b>Description </td> ";
			content=content+"<td valign='top'  >"+data[0][11]+" </td> ";
			content=content+"<td valign='top'  ><b>M.E </td> ";
			content=content+" <td valign='top'  >"+data[0][9]+" / "+data[0][10]+" </td> ";
			content=content+"</tr> ";
			content=content+"<tr> ";
			content=content+"<td height='17' colspan='4' valign='top'  ><div id='divscroll' style='OVERFLOW:auto;width:100%;height:auto'> ";
			content=content+"<table width='100%' border='1'  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC'  > ";
			content=content+"<tr bgcolor='#ffffff'> ";
			content=content+"<td  ><b>Vendor</b></td> ";
			content=content+"<td  ><b>Type</b></td> ";
			content=content+"<td  ><b>Item / Product</b></td> ";
			content=content+"<td  ><b>Description</b></td> ";
			content=content+"<td  ><b>Quantity</b></td> ";
			content=content+"<td  ><b>Unit Purchase price </td> ";
			content=content+"<td  ><b>PurchasePrice  </td> ";
			content=content+"<td  ><b>Unit Sale price  </td> ";
			content=content+"<td  ><b>Sale Price  </td> ";
			content=content+"<td  ><b>Purchase Warranty  </td> ";
			content=content+"<td  ><b>Sale Warranty  </td> ";
			

			if(flag)
			{
				content=content+"<td  ><b>Contribution  </td> ";
				content=content+"<td  ><b>Contribution(%) </td> ";
			}
			
			content=content+"<td    bgcolor='#CCCCCC' ><b>If Installation /Delivery/Additional Warranty Required: Yes/No  </td> ";
			content=content+"<td    bgcolor='#CCCCCC' ><b>Installation</td> ";
			content=content+"<td    bgcolor='#CCCCCC' ><b>Delivery</td> ";
			content=content+"<td    bgcolor='#CCCCCC' ><b>Additional Warranty</td> ";
			content=content+"<td    bgcolor='#CCCCCC' ><b>Gross Margin</td> ";
			content=content+"<td    bgcolor='#CCCCCC' ><b>Margin (%)</td> ";
			
			
			content=content+"</tr> ";
			          
					  
					 sql = " SELECT if(a.CHR_TYPE=\"I\",\"Item\",\"Product\"), ";
					 sql = sql +" if(a.CHR_TYPE=\"I\",(SELECT c.CHR_ITEMNAME FROM inv_m_item c WHERE c.CHR_ITEMID=a.CHR_ITEMID) , ";
					 sql = sql +" (SELECT d.CHR_PRODUCTCODE  FROM inv_m_produtlist d WHERE d.CHR_PRODUCTID=a.CHR_ITEMID) ";
					 sql = sql +"  ), ";
					 sql = sql +" a.CHR_DESC,a.INT_QUANTITY,a.DOU_UNITPRICE,a.DOU_PURCHASEPRICE,DOU_UNITSALEPRICE,a.DOU_SALESPRICE, ";
					 sql = sql +" if(a.CHR_ADDITIONALWARRANTY=\"Y\",\"Yes\",\"No\"), a.DOU_INSTALLATION, a.DOU_DELIVERY,a.DOU_ADDITIONALWARRANTY, ";
					 sql = sql +" a.DOU_GROSSVALUE,a.DOU_CONTRIBUTION, a.DOU_CONTRIBUTION_PERCENTAGE, a.CHR_ACCEPT,a.INT_ROWID,a.DOU_UNITSALEPRICE, ";
					 sql = sql +" ROUND(a.DOU_SALESPRICE/a.INT_QUANTITY,2)  ,b.CHR_VENDORNAME ,a.DOU_MARGIN, ";
					 sql = sql +" a.CHR_PURCHASEWARRANTY, a.CHR_SALESWARRANTY  ";
					 sql = sql +"  FROM inv_t_purchaserequestitem  a , inv_m_vendorsinformation  b ";
					 sql = sql +" WHERE a.INT_VENDORID  =b.INT_VENDORID  AND a.CHR_POREQUESTNO='"+Requestno+"' ORDER BY a.CHR_TYPE  ";
					  
					 
					 String itemDatas[][] =  CommonFunctions.QueryExecute(sql);
					 for(int u=0;u<itemDatas.length;u++)
					{
						 
					  	try 
					  	{
							if(u%2==0)
								content=content+"<tr  bgcolor='#ffddff'>" ;
							else
								content=content+"<tr  bgcolor='#ffffff'>"  ;
							content=content+"<td valign='top'>"+itemDatas[u][19]+"</td>";
							content=content+"<td valign='top'>"+itemDatas[u][0]+"</td>";
							content=content+"<td valign='top'>"+itemDatas[u][1]+"</td>";                                                                                                                                     
							content=content+"<td align='right'>"+itemDatas[u][2]+"</td>" ;
							content=content+"<td align='right'> "+itemDatas[u][3]+" </td>" ;
							content=content+"<td align='right'> "+itemDatas[u][4]+"  </td>" ;
							content=content+"<td align='right'> "+itemDatas[u][5]+" </td>" ;
							content=content+"<td align='right'> "+itemDatas[u][6]+" </td>" ;
							content=content+"<td align='right'> "+itemDatas[u][7]+" </td>" ;
							content=content+"<td align='center'> "+itemDatas[u][21]+" </td>" ;
							content=content+"<td align='center'> "+itemDatas[u][22]+" </td>" ;
							 
							if(flag)
							{
								content=content+"<td align='right'> "+itemDatas[u][13]+" </td>" ;
								content=content+"<td align='right'> "+itemDatas[u][14]+" </td>" ;
							}
							content=content+"<td align='center'  bgcolor='#CCCCCC' > "+itemDatas[u][8]+" </td>" ;
							content=content+"<td align='right'  bgcolor='#CCCCCC' > "+itemDatas[u][9]+" </td>" ;
							content=content+"<td align='right'  bgcolor='#CCCCCC' > "+itemDatas[u][10]+" </td>" ;
							content=content+"<td align='right'  bgcolor='#CCCCCC' > "+itemDatas[u][11]+" </td>" ;
							content=content+"<td align='right'  bgcolor='#CCCCCC' > "+itemDatas[u][12]+" </td>" ;
							content=content+"<td align='right'   bgcolor='#CCCCCC' >"+itemDatas[u][20]+" </td>";
							
						}
					  	catch (Exception e) 
					  	{
					  		System.out.println(e.getMessage());
					  	}
						 
						 
					}	
				 
		content=content+"</table> ";
		content=content+"</div></td> ";
		content=content+"</tr> ";
		content=content+"<tr> ";
		content=content+"<td height='22' valign='top'  ><!--DWLayoutEmptyCell-->&nbsp;</td> ";
		content=content+"<td align='left'><!--DWLayoutEmptyCell-->&nbsp;</td> ";
		content=content+"<td valign='top'  ><!--DWLayoutEmptyCell-->&nbsp;</td> ";
		content=content+"<td valign='top'  ><!--DWLayoutEmptyCell-->&nbsp;</td> ";
		content=content+"</tr> ";
		content=content+"</tbody> ";
		content=content+"</table> ";
		 
		
		content=content+" </td>";
		content=content+" </tr>";
		content=content+" </table>";
	
			
			return content;
    		
    	}
    	catch(Exception e)
    	{
    		 
    		System.out.println(e.getMessage());
    	}
    	return content;
    }
	
	 
	
	 

  

  
 


}
