package com.my.org.erp.SmartInventory;

import com.my.org.erp.SmartMailtemplates.Mail;
import com.my.org.erp.SmartMailtemplates.StyleSheet;
import com.my.org.erp.SmartMailtemplates.Template2;
import com.my.org.erp.common.CommonFunctions;

public class DirectPurchaseMail 
{
	public static String sql =""; 
	public static void sendInwardMail(String branchid,String ponumber, String division,String Path)
	{
		try
		{
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
			{
				sql ="  SELECT  b.CHR_EMAILID,FIND_A_VENDOR_NAME(a.INT_VENDORID)   FROM inv_t_directpurchase a , com_m_staff b WHERE a.CHR_REF = b.CHR_EMPID AND a.CHR_PURCHASEORDERNO ='"+ponumber+"' ";
				String meemaildata[][]= CommonFunctions.QueryExecute(sql) ;
				String meemail= meemaildata[0][0];
				if(meemail.length()>12)
					meemail =meemail+",";
				else 
					meemail="";
				String to = CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+division)[0][0];
				String approvalmail = CommonFunctions.QueryExecute("SELECT CHR_INWARDMAIL  FROM   m_inventorysetting WHERE INT_ROWID=1")[0][0];
				String content = inwardMailContent(branchid,ponumber);
				String subject = " Goods Received from  "+meemaildata[0][1]+" [ "+ponumber +" ]";
				String recipients[] =(meemail+to+","+approvalmail).split(",") ;
				String[] attachments = Template2.attachinwardImageFile(Path);
				Mail.sendEmailWithAttachments(recipients, subject, content, attachments);
				
				 
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	public static String  inwardMailContent(String branchid, String ponumber )
    {
    	String content="";
    	
		try
    	{ 	
			 
			sql =  "SELECT CHR_PURCHASEORDERNO,DATE_FORMAT(DAT_ORDERDATE,'%d-%b-%Y'), ";
			sql = sql + "FUN_INV_GET_VENDORNAME(INT_VENDORID),FUN_INV_GET_DIVISION(INT_DIVIID), ";
			sql = sql + "FIND_A_EMPLOYEE_ID_NAME(CHR_REF),FIND_A_EMPLOYEE_ID_NAME_BY_USERID(CHR_USRNAME), ";
			sql = sql + "DATE_FORMAT(DAT_ACTUALINWARD,'%d-%b-%Y %h:%m:%s  %p'),CHR_POREQUESTNO  ";
			sql = sql + "FROM inv_t_directpurchase WHERE CHR_PURCHASEORDERNO='"+ponumber+"' ";
			String data[][]=CommonFunctions.QueryExecute(sql);
			
			sql = " SELECT IF(b.CHR_MODE = 'S','STOCK ', b.CHR_CPOREF_NUMBER) ";
			sql = sql + "FROM inv_t_directpurchase a, inv_t_purchaserequest b ";
			sql = sql + "WHERE a.CHR_POREQUESTNO  = b.CHR_POREQUESTNO ";
			sql = sql + "AND a.CHR_PURCHASEORDERNO='"+ponumber+"' ";
			String tdata[][]=CommonFunctions.QueryExecute(sql);
			String track="";
			if(tdata.length>0)
				track =tdata[0][0];
			
			//stylesheet
			content = content + StyleSheet.styleSheet();
			
			//top content
			content = content + Template2.topContent("GOODS RECEIVED  @ WAREHOUSE");
			
			 
			//Salute
			//content = content +"<font class='boldEleven'> <b>We would like to intimate that the ordered goods are receive in good condition @ our warehous.</font></br>";
			
			//Content start
			content = content + "<table width='100%' border='0' align='center' cellpadding=3 cellspacing=3 >";
			
			content = content + "<tr bgcolor='#20B2AA'>";
			content = content + "<td class='boldEleven'><b><h5>STOCK / CPO Ref. No.</h5></td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'><h5>"+track+"</h5></td>";
			content = content + "</tr>";
			
			content = content + " <tr bgcolor='#B0E0E6'>";
			content = content + "<td width='248' class='boldEleven'><b>Purchase Ref.No</td>";
			content = content + "<td width='24' >&nbsp;</td>";
			content = content + "<td width='339'  class='boldEleven'>"+ponumber+"</td>";
			content = content + "</tr>";
			
			content = content + "<tr bgcolor='#20B2AA'>";
			content = content + "<td class='boldEleven'><b>Purchase Request No</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][7]+"</td>";
			content = content + "</tr>";
			
			
			
			content = content + "<tr bgcolor='#B0E0E6'>";
			content = content + "<td class='boldEleven'><b>Invoice Date</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][1]+"</td>";
			content = content + "</tr>";
			content = content + "<tr bgcolor='#20B2AA'>";
			content = content + "<td class='boldEleven'><b>Vendor</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][2]+"</td>";
			content = content + " </tr>";
			content = content + "<tr bgcolor='#B0E0E6'>";
			content = content + "<td class='boldEleven'><b>Division</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][3]+"</td>";
			content = content + " </tr>";
			content = content + "<tr bgcolor='#20B2AA'>";
			content = content + "<td class='boldEleven'><b>Inward By</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][5]+"</td>";
			content = content + " </tr>";
			content = content + "<tr bgcolor='#B0E0E6'>";
			content = content + "<td class='boldEleven'><b>Inward Date &amp; Time</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][6]+"</td>";
			content = content + "</tr>";
		
			content = content + "<tr bgcolor='#20B2AA'>";
			content = content + "<td class='boldEleven'><b>Inward goods :</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "</tr>";
			content = content + "<tr bgcolor='#B0E0E6'>";
			content = content + "<td colspan='3'><br>";
			
			
			sql = " SELECT if(a.CHR_TYPE='I','ITEM','PRODUCT'), ";
			sql = sql+ " if( ";
			sql = sql+ " a.CHR_TYPE='I', ";
			sql = sql+ " (SELECT b.CHR_ITEMNAME FROM inv_m_item b WHERE b.CHR_ITEMID= a.CHR_ITEMID) , ";
			sql = sql+ " (SELECT c.CHR_PRODUCTCODE FROM inv_m_produtlist c WHERE c.CHR_PRODUCTID= a.CHR_ITEMID)  ";
			sql = sql+ " ),LEFT(FUN_INV_PRODUCTDESCRIPTION(a.CHR_TYPE,a.CHR_ITEMID),100) , ";
			sql = sql+ " a.INT_QUANTITY ,a.INT_WARRANTY  ";
			sql = sql+ " From  inv_t_directpurchaseitem a  ";
			sql = sql+ " WHERE a.CHR_PURCHASEORDERNO ='"+ponumber+"'";
			String saledata[][] = CommonFunctions.QueryExecute(sql);
			if(saledata.length>0)
			{
				content = content + "<table width='100%'  border='1' align='center'  cellpadding=0 cellspacing=0  >";
				content = content + "<tr bgcolor='#40E0D0'>";
				content = content + "<td class='boldEleven' ><center><b>S.No</b></center></td>";
				content = content + "<td class='boldEleven' ><center><b>Type</b></center></td>";
				content = content + "<td class='boldEleven' ><center><b>Item / Product</b></center></td>";
				content = content + "<td class='boldEleven' ><center><b>Description</b></center></td>";
				content = content + "<td class='boldEleven' ><center><b>Order Qty / Units</b></center></td>";
				content = content + "<td class='boldEleven' ><center><b>Warranty</b></center></td>";
				content = content + "</tr>";
				for(int u=0; u<saledata.length;u++)
				{
					if(u%2==0)
						content = content + "<tr  bgcolor='#20B2AA'>";
					else
						content = content + "<tr  bgcolor='#ffffff'>";
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
			
			content = content + "<br></td>";
			content = content + "</table>";
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
}
