package com.my.org.erp.SmartInventory;

import com.my.org.erp.SmartMailtemplates.Mail;
import com.my.org.erp.SmartMailtemplates.StyleSheet;
import com.my.org.erp.SmartMailtemplates.Template5;
import com.my.org.erp.common.CommonFunctions;

public class PurchaseRequestMailTemplate 
{

public static String sql =""; 
 
	//Purchase Request Raised
	public static void sendpurchaseRequestMail(String branchid, String purchaserequestnumber, String division,String Path, boolean flag)
	{
		try
		{
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
			{
				String to = CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+division)[0][0];
				String approvalmail = CommonFunctions.QueryExecute("SELECT CHR_PR_APPROVAL ,CHR_PR_CLOSED FROM   m_inventorysetting WHERE INT_ROWID=1")[0][0];
				String recipients[] =(to+","+approvalmail).split(",") ;
				String content = purchaseRequestMailContent(branchid,purchaserequestnumber,flag);
				System.out.println(content);
				String subject = " Purchase Request Raised "+purchaserequestnumber;
				String[] attachments = Template5.attachImageFile(Path);
				Mail.sendEmailWithAttachments(recipients, subject, content, attachments);
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	//Purchase Request Modified
	public static void sendpurchaseRequestModifiedMail(String branchid,String purchaserequestnumber, String division,String Path, boolean flag)
	{
		try
		{
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
			{
				 
				String to = CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+division)[0][0];
				String approvalmail = CommonFunctions.QueryExecute("SELECT CHR_PR_APPROVAL ,CHR_PR_CLOSED FROM   m_inventorysetting WHERE INT_ROWID=1")[0][0];
				String recipients[] =(to+","+approvalmail).split(",") ;
				String content = purchaseRequestMailContent(branchid,purchaserequestnumber,flag);
				System.out.println(content);
				String subject = " Purchase Request Modified "+purchaserequestnumber;
				String[] attachments = Template5.attachImageFile(Path);
				Mail.sendEmailWithAttachments(recipients, subject, content, attachments);
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	//Purchase Request Division
	public static void sendpurchaseRequestDivisionMail(String branchid,String purchaserequestnumber, String division,String Path,String description)
	{
		try
		{
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
			{
				 
				String to = CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+division)[0][0];
				String approvalmail = CommonFunctions.QueryExecute("SELECT CHR_PR_APPROVAL ,CHR_PR_CLOSED FROM   m_inventorysetting WHERE INT_ROWID=1")[0][0];
				String recipients[] =(to+","+approvalmail).split(",") ;
				String content = purchaseRequestDivisionMailContent(branchid,description);
				System.out.println(content);
				String subject = " Purchase Request : "+purchaserequestnumber +" from division"; 
				String[] attachments = Template5.attachImageFile(Path);
				Mail.sendEmailWithAttachments(recipients, subject, content, attachments);
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	//Purchase Request Admin
	public static void sendpurchaseRequestAdminMail(String branchid,String purchaserequestnumber, String division,String Path,String description)
	{
		try
		{
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
			{
				 
				String to = CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+division)[0][0];
				String approvalmail = CommonFunctions.QueryExecute("SELECT CHR_PR_APPROVAL ,CHR_PR_CLOSED FROM   m_inventorysetting WHERE INT_ROWID=1")[0][0];
				String recipients[] =(to+","+approvalmail).split(",") ;
				String content = purchaseRequestAdminMailContent(branchid,description);
				System.out.println(content);
				String subject = " Purchase Request : "+purchaserequestnumber +" from chairman";
				String[] attachments = Template5.attachImageFile(Path);
				Mail.sendEmailWithAttachments(recipients, subject, content, attachments);
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	//Purchase Request Accounts
	public static void sendpurchaseRequestAccountsMail(String branchid,String purchaserequestnumber, String division,String Path,String description)
	{
		try
		{
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
			{
				 
				String to = CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+division)[0][0];
				String approvalmail = CommonFunctions.QueryExecute("SELECT CHR_PR_APPROVAL ,CHR_PR_CLOSED FROM   m_inventorysetting WHERE INT_ROWID=1")[0][0];
				String recipients[] =(to+","+approvalmail).split(",") ;
				String content = purchaseRequestAccountMailContent(branchid,description);
				System.out.println(content);
				String subject = " Purchase Request : "+purchaserequestnumber +" from stock"; 
				String[] attachments = Template5.attachImageFile(Path);
				Mail.sendEmailWithAttachments(recipients, subject, content, attachments);
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	
	//Purchase Request Finance
	public static void sendpurchaseRequestFinanceMail(String branchid,String purchaserequestnumber, String division,String Path,String description)
	{
		try
		{
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
			{
				 
				String to = CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+division)[0][0];
				String approvalmail = CommonFunctions.QueryExecute("SELECT CHR_PR_APPROVAL ,CHR_PR_CLOSED FROM   m_inventorysetting WHERE INT_ROWID=1")[0][0];
				String recipients[] =(to+","+approvalmail).split(",") ;
				String content = purchaseRequestFinanceContent(branchid,description,purchaserequestnumber);
				System.out.println(content);
				String subject = " Purchase Request : "+purchaserequestnumber +" from finance";
				String[] attachments = Template5.attachImageFile(Path);
				Mail.sendEmailWithAttachments(recipients, subject, content, attachments);
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	//Purchase Request modified after approval
	public static void sendpurchaseRequestModifiedafterApprovalMail(String branchid, String purchaserequestnumber, String division,String Path, boolean flag)
	{
		try
		{
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
			{
				String to = CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+division)[0][0];
				String approvalmail = CommonFunctions.QueryExecute("SELECT CHR_PR_APPROVAL ,CHR_PR_CLOSED FROM   m_inventorysetting WHERE INT_ROWID=1")[0][0];
				String recipients[] =(to+","+approvalmail).split(",") ;
				String content = purchaseRequestMailContent(branchid,purchaserequestnumber,flag);
				String subject = " Purchase Request modified after approval "+purchaserequestnumber;
				String[] attachments = Template5.attachImageFile(Path);
				Mail.sendEmailWithAttachments(recipients, subject, content, attachments);
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	
	
	//Purchase Request Raised from CPO
	public static void sendpurchaseRequestCPOMail(String branchid,String purchaserequestnumber, String division,String Path, boolean flag,String extracontent)
	{
		try
		{
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
			{
				String to = CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+division)[0][0];
				String approvalmail = CommonFunctions.QueryExecute("SELECT CHR_PR_APPROVAL ,CHR_PR_CLOSED FROM   m_inventorysetting WHERE INT_ROWID=1")[0][0];
				String recipients[] =(to+","+approvalmail).split(",") ;
				String content = purchaseRequestMailCPOContent(branchid,purchaserequestnumber,flag,extracontent);
				System.out.println(content);
				String subject = " Purchase Request Raised "+purchaserequestnumber +" by Business Head.";
				String[] attachments = Template5.attachImageFile(Path);
				Mail.sendEmailWithAttachments(recipients, subject, content, attachments);
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	//Purchase Request Raised from SOA
	public static void sendpurchaseRequestSOAMail(String branchid,String cponumber,String division,String Path,String extracontent)
	{
		try
		{
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
			{
				String to = CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+division)[0][0];
				String approvalmail = CommonFunctions.QueryExecute("SELECT CHR_PR_APPROVAL ,CHR_PR_CLOSED FROM   m_inventorysetting WHERE INT_ROWID=1")[0][0];
				String recipients[] =(to+","+approvalmail).split(",") ;
				String content = CPOsaleorderMailContent(branchid,cponumber);
				System.out.println(content);
				String subject = " Saleorder Approved "+cponumber;
				String[] attachments = Template5.attachImageFile(Path);
				Mail.sendEmailWithAttachments(recipients, subject, content, attachments);
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	public static String  purchaseRequestMailContent( String branchid,String Requestno, boolean flag )
    {
    	String content="";
    	try
    	{ 	
	    		//stylesheet
				content = content + StyleSheet.styleSheet();
				//top content
				content = content + Template5.topContent("<center><h1>Purchase Request</h1></center>");
				
				
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
				String data[][] = CommonFunctions.QueryExecute(sql);
								
				 
				//content Start
				content=content+" <table cellspacing='2' cellpadding='2' width='99%' align='center' border='0'>";
				content=content+" <tr>";
				content=content+"<td height='17' valign='top'  class='boldEleven'><b>Request Number / Date </td> ";
				content=content+"<td align='left'><span class='boldEleven'>"+data[0][3] +"  dated on " +data[0][4]+" </span></td> ";
				
				
				content=content+" <td width='105'  ><b> </td>";
				content=content+" <td width='148' class='boldEleven'>  </td>";
				content=content+" </tr> ";
				content=content+" <tr> ";
				content=content+"<td  class='boldEleven' ><div align='left'><b>CustomerName</div></td> ";
				content=content+"<td  class='boldEleven' >"+data[0][5]+" </td> ";
				
				
				content=content+"<td  class='boldEleven'><b>Vendor Payment </td> ";
				content=content+"<td class='boldEleven'>"+data[0][7]+" </td> ";
				content=content+"</tr> ";
				content=content+"<tr> ";
				
				content=content+" <td width='118' height='17' valign='top'  class='boldEleven' ><b>Division</td>";
				content=content+" <td width='199' align='left' valign='top' class='boldEleven'>"+data[0][2]+"</td>"; 
				
				
				content=content+"<td   class='boldEleven'><b>Customer Commitment days </td> ";
				content=content+"<td   class='boldEleven'>"+data[0][8]+"- Days </td> ";
				content=content+"</tr> ";
				content=content+"<tr> ";
				content=content+"<td valign='top'   class='boldEleven'><b>Description </td> ";
				content=content+"<td valign='top'   class='boldEleven'>"+data[0][11]+" </td> ";
				content=content+"<td valign='top'   class='boldEleven'><b>M.E </td> ";
				content=content+" <td valign='top'   class='boldEleven'>"+data[0][9]+" / "+data[0][10]+" </td> ";
				content=content+"</tr> ";
				content=content+"<tr> ";
				content=content+"<td height='17' colspan='4' valign='top'  ><div id='divscroll' style='OVERFLOW:auto;width:100%;height:auto'> ";
				content=content+"<table width='100%' border='1'  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC'  > ";
				content=content+"<tr bgcolor='#ffffff'> ";
				content=content+"<td   class='boldEleven'><b>Vendor</b></td> ";
				content=content+"<td   class='boldEleven'><b>Type</b></td> ";
				content=content+"<td   class='boldEleven'><b>Item / Product</b></td> ";
				content=content+"<td   class='boldEleven'><b>Description</b></td> ";
				content=content+"<td   class='boldEleven'><b>Quantity</b></td> ";
				content=content+"<td   class='boldEleven'><b>Unit Purchase price </td> ";
				content=content+"<td   class='boldEleven'><b>PurchasePrice  </td> ";
				content=content+"<td   class='boldEleven'><b>Unit Sale price  </td> ";
				content=content+"<td   class='boldEleven'><b>Sale Price  </td> ";
				content=content+"<td   class='boldEleven'><b>Purchase Warranty  </td> ";
				content=content+"<td   class='boldEleven'><b>Sale Warranty  </td> ";
				
	
				if(flag)
				{
					content=content+"<td   class='boldEleven'><b>Contribution  </td> ";
					content=content+"<td   class='boldEleven'><b>Contribution(%) </td> ";
				}
				
				content=content+"<td    bgcolor='#CCCCCC'  class='boldEleven'><b>If Installation /Delivery/Additional Warranty Required: Yes/No  </td> ";
				content=content+"<td    bgcolor='#CCCCCC'  class='boldEleven'><b>Installation</td> ";
				content=content+"<td    bgcolor='#CCCCCC'  class='boldEleven'><b>Delivery</td> ";
				content=content+"<td    bgcolor='#CCCCCC'  class='boldEleven'><b>Additional Warranty</td> ";
				content=content+"<td    bgcolor='#CCCCCC'  class='boldEleven'><b>Gross Margin</td> ";
				content=content+"<td    bgcolor='#CCCCCC'  class='boldEleven'><b>Margin (%)</td> ";
				
				
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
						content=content+"<td valign='top' class='boldEleven'>"+itemDatas[u][19]+"</td>";
						content=content+"<td valign='top' class='boldEleven'>"+itemDatas[u][0]+"</td>";
						content=content+"<td valign='top' class='boldEleven'>"+itemDatas[u][1]+"</td>";                                                                                                                                     
						content=content+"<td align='right' class='boldEleven'>"+itemDatas[u][2]+"</td>" ;
						content=content+"<td align='right' class='boldEleven'> "+itemDatas[u][3]+" </td>" ;
						content=content+"<td align='right' class='boldEleven'> "+itemDatas[u][4]+"  </td>" ;
						content=content+"<td align='right' class='boldEleven'> "+itemDatas[u][5]+" </td>" ;
						content=content+"<td align='right' class='boldEleven'> "+itemDatas[u][6]+" </td>" ;
						content=content+"<td align='right' class='boldEleven'> "+itemDatas[u][7]+" </td>" ;
						content=content+"<td align='center' class='boldEleven'> "+itemDatas[u][21]+" </td>" ;
						content=content+"<td align='center' class='boldEleven'> "+itemDatas[u][22]+" </td>" ;
						 
						if(flag)
						{
							content=content+"<td align='right' class='boldEleven'> "+itemDatas[u][13]+" </td>" ;
							content=content+"<td align='right' class='boldEleven'> "+itemDatas[u][14]+" </td>" ;
						}
						content=content+"<td align='center'  bgcolor='#CCCCCC'  class='boldEleven'> "+itemDatas[u][8]+" </td>" ;
						content=content+"<td align='right'  bgcolor='#CCCCCC'  class='boldEleven'> "+itemDatas[u][9]+" </td>" ;
						content=content+"<td align='right'  bgcolor='#CCCCCC'  class='boldEleven'> "+itemDatas[u][10]+" </td>" ;
						content=content+"<td align='right'  bgcolor='#CCCCCC'  class='boldEleven'> "+itemDatas[u][11]+" </td>" ;
						content=content+"<td align='right'  bgcolor='#CCCCCC'  class='boldEleven'> "+itemDatas[u][12]+" </td>" ;
						content=content+"<td align='right'   bgcolor='#CCCCCC'  class='boldEleven'>"+itemDatas[u][20]+" </td>";
						
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
				content = content + "<br><div style=\"font-family:Georgia, 'Times New Roman', Times, serif; font-size:18px; color:#000000;\"><center><strong>Next Stage :- Waiting for Approval<br></strong></center></div><br><br>";  
				
				//content end
				
				//bottom content
				content = content + Template5.bottomContent(branchid);
			 
				return content;
    	}
    	catch(Exception e)
    	{
    		System.out.println(e.getMessage());
    	}
    	return content;	
    }
	
	public static String  purchaseRequestAdminMailContent(String branchid, String description )
    {
    	String content="";
    	try
    	{ 
    		//stylesheet
			content = content + StyleSheet.styleSheet();
			//top content
			content = content + Template5.topContentwithimage("<center><h1>Purchase Request Approved By Chairman </h1></center>");
			content = content + "<br><div style=\"font-family:Georgia, 'Times New Roman', Times, serif; font-size:18px; color:#000000;\"><center><strong>Next Stage :- Waiting for Finance Approval<br></strong></center></div><br><br>";  
			
			//content = content + "<h1><font color='#ff9900'>";
			//content = content + description;
			//content = content + "</font></h1><br>";
    		//bottom content
			content = content + Template5.bottomContent(branchid);
    		return content;
    	}
    	catch(Exception e)
    	{
    		System.out.println(e.getMessage());
    	}
    	return content;	
    }
	
	public static String  purchaseRequestDivisionMailContent(String branchid, String description )
    {
    	String content="";
    	try
    	{ 
    		//stylesheet
			content = content + StyleSheet.styleSheet();
			//top content
			content = content + Template5.topContentwithimage("<center><h1>Purchase Request @ Division  approved</h1></center>");
			content = content + "<br><div style=\"font-family:Georgia, 'Times New Roman', Times, serif; font-size:18px; color:#000000;\"><center><strong>Next Stage :- Waiting for Finance Approval<br></strong></center></div><br><br>";  
			
			//content = content + "<h1><font color='#ff9900'>";
			//content = content + description;
			//content = content + "</font></h1><br>";
    		//bottom content
			content = content + Template5.bottomContent(branchid);
    		return content;
    	}
    	catch(Exception e)
    	{
    		System.out.println(e.getMessage());
    	}
    	return content;	
    }
	
	public static String  purchaseRequestAccountMailContent(String branchid, String description )
    {
    	String content="";
    	try
    	{ 
    		//stylesheet
			content = content + StyleSheet.styleSheet();
			//top content
			content = content + Template5.topContentwithimage("<center><h1>Purchase Request @ stock</h1></center>");
			 
			content = content + "<h1><font color='#ff9900'>";
			content = content + description;
			content = content + "</font></h1><br>";
    		
			content = content + "<br><div style=\"font-family:Georgia, 'Times New Roman', Times, serif; font-size:18px; color:#000000;\"><center><strong>Next Stage :- Waiting for Finance Approval<br></strong></center></div><br><br>";  
			
			//bottom content
			content = content + Template5.bottomContent(branchid);
			System.out.println();
			System.out.println(description);
    		return content;
    	}
    	catch(Exception e)
    	{
    		System.out.println(e.getMessage());
    	}
    	return content;	
    }
	
	
	public static String  purchaseRequestFinanceContent(String branchid, String description ,String prnumber)
    {
    	String content="";
    	try
    	{ 
    		//stylesheet
			content = content + StyleSheet.styleSheet();
			//top content
			content = content + Template5.topContentwithimage("<center><h1>Purchase Request @ Finance</h1></center>");
			content = content + description;
			
			sql = "SELECT CHR_PURCHASEORDERNO,FUN_INV_GET_VENDORNAME(INT_VENDORID)  FROM inv_t_vendorpurchaseorder ";
			sql =sql+" WHERE CHR_POREQUESTNO='"+prnumber+"'";
			String data[][] = CommonFunctions.QueryExecute(sql);
			if(data.length>0)
			{
				content = content + "<br> <h1><font color='#ff9900'>";
				content = content + "The purchase orders are...";
				content = content + "<center><table bgcolor='#ff9900' width='400'>";
				content = content + "<tr bgcolor='#ff9900'>";
				content = content + "<td class='boldEleven'><center><b>S.No</b></center></td>";
				content = content + "<td class='boldEleven'><center><b>PO Number</b></center></td>";
				content = content + "<td class='boldEleven'><center><b>Vendor</b></center></td>";
				content = content + "</tr>";
				for(int u=0;u<data.length;u++)
				{
					if(u%2==0)
						content = content + "<tr  bgcolor='#ffffff'>";
					else
						content = content + "<tr  bgcolor='#ff9900'>";
					content = content + "<td class='boldEleven'>"+(u+1)+".</td>";
					content = content + "<td class='boldEleven'>"+data[u][0]+"</td>";
					content = content + "<td class='boldEleven'>"+data[u][1]+"</td>";
					content = content + "</tr>";
						
				}
				content = content + "</table></center>";	 
			}
			content = content + "</font></h1><br>";
    		
			//bottom content
			content = content + Template5.bottomContent(branchid);
    		return content;
    	}
    	catch(Exception e)
    	{
    		System.out.println(e.getMessage());
    	}
    	return content;	
    }
	
	
	public static String  purchaseRequestMailCPOContent( String branchid,String Requestno, boolean flag, String extracontent )
    {
    	String content="";
    	try
    	{ 	
	    		//stylesheet
				content = content + StyleSheet.styleSheet();
				//top content
				content = content + Template5.topContent("<center><h1>Purchase Request</h1></center>");
				
				
				String sql = " ";
				sql = " SELECT "; 
				sql = sql + " a.INT_POREQUESTID,b.CHR_BRANCHNAME,c.CHR_DIVICODE, a.CHR_POREQUESTNO,DATE_FORMAT(a.DAT_REQUESTDATE,'%d-%m-%Y'), ";
				sql = sql + " h.CHR_NAME,h.CHR_NAME, ";
				sql = sql + " f.CHR_PAYMENTNAME, ";
				sql = sql + " a.INT_CUSTOMERCOMMITMENTDAYS,a.CHR_REF,g.CHR_STAFFNAME,a.CHR_DES,a.CHR_APPROVEDSTATUS, ";
				sql = sql + " a.CHR_APPROVEDBY,DATE_FORMAT(a.DAT_APPROVEDDATE,'%d-%m-%Y'),a.CHR_APPROVEDDESCRIPTION ,";
				sql = sql + " a.INT_BRANCHID,a.INT_DIVIID,a.INT_CUSTOMERID,  ";
				sql = sql + " IF(a.CHR_MODE = 'S','STOCK ', a.CHR_CPOREF_NUMBER)  ";
				sql = sql + " FROM inv_t_purchaserequest a, com_m_branch b,inv_m_division c,inv_m_customerinfo d,inv_m_customergroup h,   ";
				sql = sql + " inv_m_paymentterms f,com_m_staff g ";
				sql = sql + " WHERE a.INT_BRANCHID = b.INT_BRANCHID ";
				sql = sql + " AND a.INT_DIVIID =c.INT_DIVIID ";
				sql = sql + " AND a.INT_CUSTOMERID = d.INT_CUSTOMERID AND d.INT_CUSTOMERGROUPID = h.INT_CUSTOMERGROUPID ";
				sql = sql + " AND a.INT_PAYMENTTERMID = f.INT_PAYMENTTERMID ";
				sql = sql + " AND a.CHR_REF=g.CHR_EMPID AND 	CHR_POREQUESTNO='"+Requestno+"'";
				String data[][] = CommonFunctions.QueryExecute(sql);
								
				 
				//content Start
				content=content+" <table cellspacing='2' cellpadding='2' width='99%' align='center' border='0'>";
				content=content+" <tr>";
				content=content+"<td height='17' valign='top'  class='boldEleven'><b>Request Number / Date </td> ";
				content=content+"<td align='left'><span class='boldEleven'>"+data[0][3] +"  dated on " +data[0][4]+" </span></td> ";
				content=content+" <td width='105' class='boldEleven'><b><h5> STOCK / CPO ref.no</h5></td>";
				content=content+" <td width='148' class='boldEleven'><h5>"+data[0][19]+"</h5></td>";
				content=content+" </tr> ";
				content=content+" <tr> ";
				content=content+"<td  class='boldEleven' ><div align='left'><b>CustomerName</div></td> ";
				content=content+"<td  class='boldEleven' >"+data[0][5]+" </td> ";
				
				
				content=content+"<td  class='boldEleven'><b>Vendor Payment </td> ";
				content=content+"<td class='boldEleven'>"+data[0][7]+" </td> ";
				content=content+"</tr> ";
				content=content+"<tr> ";
				
				content=content+" <td width='118' height='17' valign='top'  class='boldEleven' ><b>Division</td>";
				content=content+" <td width='199' align='left' valign='top' class='boldEleven'>"+data[0][2]+"</td>"; 
				
				
				content=content+"<td   class='boldEleven'><b>Customer Commitment days </td> ";
				content=content+"<td   class='boldEleven'>"+data[0][8]+"- Days </td> ";
				content=content+"</tr> ";
				content=content+"<tr> ";
				content=content+"<td valign='top'   class='boldEleven'><b>Description </td> ";
				content=content+"<td valign='top'   class='boldEleven'>"+data[0][11]+" </td> ";
				content=content+"<td valign='top'   class='boldEleven'><b>M.E </td> ";
				content=content+" <td valign='top'   class='boldEleven'>"+data[0][9]+" / "+data[0][10]+" </td> ";
				content=content+"</tr> ";
				
				content=content+"<tr> ";
				content=content+"<td height='17' colspan='4' valign='top'  ><div id='divscroll' style='OVERFLOW:auto;width:100%;height:auto'> ";
				content=content+"<table width='100%' border='1'  id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC'  > ";
				content=content+"<tr bgcolor='#ffffff'> ";
				content=content+"<td   class='boldEleven'><b>Vendor</b></td> ";
				content=content+"<td   class='boldEleven'><b>Type</b></td> ";
				content=content+"<td   class='boldEleven'><b>Item / Product</b></td> ";
				content=content+"<td   class='boldEleven'><b>Description</b></td> ";
				content=content+"<td   class='boldEleven'><b>Quantity</b></td> ";
				content=content+"<td   class='boldEleven'><b>Unit Purchase price </td> ";
				content=content+"<td   class='boldEleven'><b>PurchasePrice [ Exclusive of Tax ] </td> ";
				content=content+"<td   class='boldEleven'><b>Unit Sale price  </td> ";
				content=content+"<td   class='boldEleven'><b>Sale Price  [ Exclusive of Tax ]</td> ";
				content=content+"<td   class='boldEleven'><b>Purchase Warranty  </td> ";
				content=content+"<td   class='boldEleven'><b>Sale Warranty  </td> ";
				
	
				if(flag)
				{
					content=content+"<td   class='boldEleven'><b>Contribution  </td> ";
					content=content+"<td   class='boldEleven'><b>Contribution(%) </td> ";
				}
				
				content=content+"<td    bgcolor='#CCCCCC'  class='boldEleven'><b>If Installation /Delivery/Additional Warranty Required: Yes/No  </td> ";
				content=content+"<td    bgcolor='#CCCCCC'  class='boldEleven'><b>Installation</td> ";
				content=content+"<td    bgcolor='#CCCCCC'  class='boldEleven'><b>Delivery</td> ";
				content=content+"<td    bgcolor='#CCCCCC'  class='boldEleven'><b>Additional Warranty</td> ";
				content=content+"<td    bgcolor='#CCCCCC'  class='boldEleven'><b>Gross Margin</td> ";
				content=content+"<td    bgcolor='#CCCCCC'  class='boldEleven'><b>Margin (%)</td> ";
				
				
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
						content=content+"<td valign='top' class='boldEleven'>"+itemDatas[u][19]+"</td>";
						content=content+"<td valign='top' class='boldEleven'>"+itemDatas[u][0]+"</td>";
						content=content+"<td valign='top' class='boldEleven'>"+itemDatas[u][1]+"</td>";                                                                                                                                     
						content=content+"<td align='right' class='boldEleven'>"+itemDatas[u][2]+"</td>" ;
						content=content+"<td align='right' class='boldEleven'> "+itemDatas[u][3]+" </td>" ;
						content=content+"<td align='right' class='boldEleven'> "+itemDatas[u][4]+"  </td>" ;
						content=content+"<td align='right' class='boldEleven'> "+itemDatas[u][5]+" </td>" ;
						content=content+"<td align='right' class='boldEleven'> "+itemDatas[u][6]+" </td>" ;
						content=content+"<td align='right' class='boldEleven'> "+itemDatas[u][7]+" </td>" ;
						content=content+"<td align='center' class='boldEleven'> "+itemDatas[u][21]+" </td>" ;
						content=content+"<td align='center' class='boldEleven'> "+itemDatas[u][22]+" </td>" ;
						 
						if(flag)
						{
							content=content+"<td align='right' class='boldEleven'> "+itemDatas[u][13]+" </td>" ;
							content=content+"<td align='right' class='boldEleven'> "+itemDatas[u][14]+" </td>" ;
						}
						content=content+"<td align='center'  bgcolor='#CCCCCC'  class='boldEleven'> "+itemDatas[u][8]+" </td>" ;
						content=content+"<td align='right'  bgcolor='#CCCCCC'  class='boldEleven'> "+itemDatas[u][9]+" </td>" ;
						content=content+"<td align='right'  bgcolor='#CCCCCC'  class='boldEleven'> "+itemDatas[u][10]+" </td>" ;
						content=content+"<td align='right'  bgcolor='#CCCCCC'  class='boldEleven'> "+itemDatas[u][11]+" </td>" ;
						content=content+"<td align='right'  bgcolor='#CCCCCC'  class='boldEleven'> "+itemDatas[u][12]+" </td>" ;
						content=content+"<td align='right'   bgcolor='#CCCCCC'  class='boldEleven'>"+itemDatas[u][20]+" </td>";
						
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
				//content end
				
				
				content=content+extracontent;
				//bottom content
				content = content + Template5.bottomContent(branchid);
			 
				return content;
    	}
    	catch(Exception e)
    	{
    		System.out.println(e.getMessage());
    	}
    	return content;	
    }
	
	
	public static String  CPOsaleorderMailContent(String branchid, String cponumber )
    {
    	String content="";
    	try
    	{ 
    		//stylesheet
			content = content + StyleSheet.styleSheet();
			//top content
			content = content + Template5.topContentwithimage("<center><h1>Saleorder Approved </h1></center>");
			 
			sql = "";
			sql = sql+" SELECT a.CHR_SALESORDERNO ,a.CHR_QUOTATIONNO, a.CHR_CUSTPURCHASENO, "; 
			sql = sql+" FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),FUN_INV_DIVISION(a.INT_DIVIID),  ";
			sql = sql+" DATE_FORMAT(a.CHR_PURCHASEORDER_DATE,'%d-%b-%Y'), ";
			sql = sql+" DATE_FORMAT(a.CHR_DELIVERY_DATE,'%d-%b-%Y'),  ";
			sql = sql+" IF(a.CHR_INSTALLATION='Y','YES','NO'),IF(a.CHR_MULTIPLE_LOCATION='Y','YES','NO') , "; 
			sql = sql+" a.CHR_POREQUESTNO,  ";
			sql = sql + " DATE_FORMAT(a1.DAT_CREATIONTIME,'%d-%b-%Y  %h:%m:%s %p'),  ";
			sql = sql + " DATE_FORMAT(a.DAT_CREATIONTIME,'%d-%b-%Y  %h:%m:%s %p'),  ";
			sql = sql + " datediff(a.DAT_CREATIONTIME,a1.DAT_CREATIONTIME)  ";
			sql = sql+" FROM inv_t_customersalesorder a  ,inv_t_customerquotation a1 "; 
			sql = sql+" WHERE   a.CHR_SALESORDERNO = '"+cponumber+"' "; 
			String Data[][] =  CommonFunctions.QueryExecute(sql);
			if(Data.length>0)
			{	
				content = content + "<table width='90%' border='0' cellpadding=2 cellspacing=1 bgcolor='#ff9900' >";
				
				
				
				content = content + "<tr bgcolor='#ff9900'>";
				content = content + "<td class='boldEleven'><b>Sale order Ref.No</b></td>";
				content = content + "<td class='boldEleven'>"+Data[0][0]+"</td>";
				content = content + "</tr>";
				content = content + "<tr  bgcolor='#ffffff'>";
				content = content + "<td class='boldEleven'><b>Quotation No</b></td>";
				content = content + "<td class='boldEleven'>"+Data[0][1]+"</td>";
				content = content + "</tr>";
				content = content + "<tr bgcolor='#ff9900'>";
				content = content + "<td class='boldEleven'><b><h5>CPO No</h5></b></td>";
				content = content + "<td class='boldEleven'><h5>"+Data[0][2]+"</h5></td>";
				content = content + "</tr>";
				content = content + "<tr  bgcolor='#ffffff'>";
				content = content + "<td class='boldEleven'><b>Customer</b></td>";
				content = content + "<td class='boldEleven'>"+Data[0][3]+"</td>";
				content = content + "</tr>";
				content = content + "<tr bgcolor='#ff9900'>";
				content = content + "<td class='boldEleven'><b>Division</b></td>";
				content = content + "<td class='boldEleven'>"+Data[0][4]+"</td>";
				content = content + "</tr>";
				content = content + "<tr  bgcolor='#ffffff'>";
				content = content + "<td class='boldEleven'><b>PO Date</b></td>";
				content = content + "<td class='boldEleven'>"+Data[0][5]+"</td>";
				content = content + "</tr>";
				content = content + "<tr bgcolor='#ff9900'>";
				content = content + "<td class='boldEleven'><b>Possible Date of Delivery</b></td>";
				content = content + "<td class='boldEleven'>"+Data[0][6]+"</td>";
				content = content + "</tr>";
				content = content + "<tr  bgcolor='#ffffff'>";
				content = content + "<td class='boldEleven'><b>Installation</b></td>";
				content = content + "<td class='boldEleven'>"+Data[0][7]+"</td>";
				content = content + "</tr>";
				content = content + "<tr bgcolor='#ff9900'>";
				content = content + "<td class='boldEleven'><b>Multiple Location</b></td>";
				content = content + "<td class='boldEleven'>"+Data[0][8]+"</td>";
				content = content + "</tr>";
				content = content + "<tr  bgcolor='#ffffff'>";
				content = content + "<td class='boldEleven'><b>PR. No</b></td>";
				content = content + "<td class='boldEleven'>"+Data[0][9]+"</td>";
				content = content + "</tr>";
				content = content + "</table><br>";
			}	
			
    		//bottom content
			content = content + Template5.bottomContent(branchid);
    		return content;
    	}
    	catch(Exception e)
    	{
    		System.out.println(e.getMessage());
    	}
    	return content;	
    }
}
