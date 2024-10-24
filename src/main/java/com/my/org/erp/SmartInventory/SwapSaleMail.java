package com.my.org.erp.SmartInventory;

import com.my.org.erp.SmartMailtemplates.Mail;
import com.my.org.erp.SmartMailtemplates.StyleSheet;
import com.my.org.erp.SmartMailtemplates.Template2;
import com.my.org.erp.common.CommonFunctions;

public class SwapSaleMail
{
	public static String sql =""; 
	
	//Goods shipped mail
	public static void sendSalesShippedMail(String branchid,String salno, String division,String Path)
	{
		try
		{
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
			{
				sql =" SELECT  b.CHR_EMAILID,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),a.CHR_CPONUMBER   FROM inv_t_directsales a , com_m_staff b WHERE a.CHR_REF = b.CHR_EMPID AND a.CHR_SALESNO ='"+salno+"' ";
				String meemaildata[][]= CommonFunctions.QueryExecute(sql) ;
				String meemail= meemaildata[0][0];
				if(meemail.length()>12)
					meemail =meemail+",";
				else 
					meemail="";
				String to = CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+division)[0][0];
				String approvalmail = CommonFunctions.QueryExecute("SELECT CHR_INWARDMAIL  FROM   m_inventorysetting WHERE INT_ROWID=1")[0][0];
				String content = SalesShippedMailContent(branchid,salno);
				String subject = " Goods Shipped to "+meemaildata[0][1] +" [ Awaiting for delivery updation ]";
				String recipients[] =(meemail+to+","+approvalmail).split(",") ;
				String[] attachments = Template2.attachshippedImageFile(Path);
				Mail.sendEmailWithAttachments(recipients, subject, content, attachments);
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	//goods delivered mail
	public static void sendSalesDeliveredMail(String branchid,String salno, String division,String Path)
	{
		try
		{
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
			{
				sql =" SELECT  b.CHR_EMAILID,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),a.CHR_CPONUMBER,a.CHR_INSTALLATION   FROM inv_t_directsales a , com_m_staff b WHERE a.CHR_REF = b.CHR_EMPID AND a.CHR_SALESNO ='"+salno+"' ";
				String meemaildata[][]= CommonFunctions.QueryExecute(sql) ;
				String meemail= meemaildata[0][0];
				if(meemail.length()>12)
					meemail =meemail+",";
				else 
					meemail="";
				String to = CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+division)[0][0];
				String approvalmail = CommonFunctions.QueryExecute("SELECT CHR_INWARDMAIL  FROM   m_inventorysetting WHERE INT_ROWID=1")[0][0];
				String content = SalesDeliveredMailContent(branchid,salno);
				String subject = " Goods Delivered to "+meemaildata[0][1];
				if("Y".equals(meemaildata[0][3]))
					subject = subject +" [ Awaiting for installation ]";
				String recipients[] =( meemail+to+","+approvalmail).split(",") ;
				String[] attachments = Template2.attachshippedImageFile(Path);
				Mail.sendEmailWithAttachments(recipients, subject, content, attachments);
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	
	public static String  SalesDeliveredMailContent(String branchid, String salenumber )
    {
    	String content="";
    	
		try
    	{ 	
			 
			sql =  "SELECT a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'), FUN_INV_GET_DIVISION(a.INT_DIVIID),  "; 
			sql = sql + " FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ,a.CHR_SHIPPINGADDRESS,   ";
			sql = sql + " if(a.CHR_DELIVERY='N','Pending',if(a.CHR_DELIVERY='P','Progress',if(a.CHR_DELIVERY='Y','Delivered','Rejected'))) delivery,  ";
			sql = sql + " if(a.CHR_DELIVERYTHROUGH ='C','Courier',if(a.CHR_DELIVERYTHROUGH='P','Person',if(a.CHR_DELIVERYTHROUGH='O','Own','Vehicle'))) deliverythrough,  ";
			sql = sql + " a.CHR_COURIER_EMPID,a.CHR_COURIER_EMPID_MOBILE,   ";
			sql = sql + " if(a.INT_COURIERID =0 ,'',(SELECT e.CHR_COURIERNAME FROM inv_m_courier e WHERE e.INT_COURIERID =a.INT_COURIERID)) cmode,  ";
			sql = sql + "  DATE_FORMAT(a.DAT_COURIERDATE,'%d-%b-%Y %h:%m:%s   %p'),  ";
			sql = sql + " a.CHR_STARTING_PLACE,a.CHR_ENDING_PLACE,a.INT_COURIER_KILOMETER,  "; 
			sql = sql + " a.CHR_COURIER_DESC,   ";
			sql = sql + " a.CHR_RECEIVERNAME,a.CHR_RECEIVER_MOBILE,   "; 
			sql = sql + "  DATE_FORMAT(a.DAT_DISPATCHEDDATE,'%d-%b-%Y %h:%m:%s   %p'),   "; 
			sql = sql + "  a.CHR_CLOSEDBY,a.CHR_RECEIVER_DESC,  ";
			sql = sql + "  datediff(a.DAT_COURIERDATE,a.DAT_DISPATCHEDDATE) ,a.CHR_CPONUMBER  ";
			sql = sql + " FROM inv_t_directsales a WHERE a.CHR_SALESNO='"+salenumber+"' ";
			System.out.println(sql);
			String data[][]=CommonFunctions.QueryExecute(sql);
			
			//stylesheet
			content = content + StyleSheet.styleSheet();
			
			//top content
			content = content + Template2.topContent("GOODS DELIVERED ");

			 
			//Content start
			content = content + "<table width='100%' border='0' align='center' cellpadding=3 cellspacing=3 >";
			
			content = content + " <tr>";
			content = content + "<td width='248' class='boldEleven'><b><h5>CPO Ref.No</h5></td>";
			content = content + "<td width='24' >&nbsp;</td>";
			content = content + "<td width='339'  class='boldEleven'><h5>"+data[0][21]+"</h5></td>";
			content = content + "</tr>";
			
			
			content = content + " <tr bgcolor='#20B2AA'>";
			content = content + "<td width='248' class='boldEleven'><b>Invoice Ref.No</td>";
			content = content + "<td width='24' >&nbsp;</td>";
			content = content + "<td width='339'  class='boldEleven'>"+salenumber+"</td>";
			content = content + "</tr>";
			
			content = content + "<tr bgcolor='#B0E0E6'>";
			content = content + "<td class='boldEleven'><b>Invoice Date</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][1]+"</td>";
			content = content + "</tr>";
			
			content = content + "<tr bgcolor='#20B2AA'>";
			content = content + "<td class='boldEleven'><b>Division</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][2]+"</td>";
			content = content + "</tr>";
			
			content = content + "<tr bgcolor='#B0E0E6'>";
			content = content + "<td class='boldEleven'><b>Customer</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][3]+"</td>";
			content = content + " </tr>";
			
			content = content + "<tr bgcolor='#20B2AA'>";
			content = content + "<td class='boldEleven'><b>Shipping Address</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][4]+"</td>";
			content = content + " </tr>";
			
			content = content + "<tr bgcolor='#B0E0E6'>";
			content = content + "<td class='boldEleven'><b>Receiver Name</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][15]+"</td>";
			content = content + "</tr>";
			
			content = content + "<tr bgcolor='#20B2AA'>";
			content = content + "<td class='boldEleven'><b>Receiver Contact Number</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][16]+"</td>";
			content = content + "</tr>";
			
			content = content + "<tr bgcolor='#B0E0E6'>";
			content = content + "<td class='boldEleven'><b>Delivered Date & Time</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][17]+"</td>";
			content = content + "</tr>";
			
			content = content + "<tr bgcolor='#20B2AA'>";
			content = content + "<td class='boldEleven'><b>Delivered Description</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][19]+"</td>";
			content = content + "</tr>";
			
			content = content + "<tr bgcolor='#B0E0E6'>";
			content = content + "<td class='boldEleven'><b>Delivered Age</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][20]+"</td>";
			content = content + "</tr>";
			
			 
			
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
	
	
	
	
	public static String  SalesShippedMailContent(String branchid, String salenumber )
    {
    	String content="";
    	
		try
    	{ 	
			 
			sql =  "SELECT a.CHR_SALESNO,DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'), FUN_INV_GET_DIVISION(a.INT_DIVIID),  "; 
			sql = sql + " FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID) ,a.CHR_SHIPPINGADDRESS,   ";
			sql = sql + " if(a.CHR_DELIVERY='N','Pending',if(a.CHR_DELIVERY='P','Progress',if(a.CHR_DELIVERY='Y','Delivered','Rejected'))) delivery,  ";
			sql = sql + " if(a.CHR_DELIVERYTHROUGH ='C','Courier',if(a.CHR_DELIVERYTHROUGH='P','Person',if(a.CHR_DELIVERYTHROUGH='O','Own','Vehicle'))) deliverythrough,  ";
			sql = sql + " a.CHR_COURIER_EMPID,a.CHR_COURIER_EMPID_MOBILE,   ";
			sql = sql + " if(a.INT_COURIERID =0 ,'',(SELECT e.CHR_COURIERNAME FROM inv_m_courier e WHERE e.INT_COURIERID =a.INT_COURIERID)) cmode,  ";
			sql = sql + "  DATE_FORMAT(a.DAT_COURIERDATE,'%d-%b-%Y %h:%m:%s   %p'),  ";
			sql = sql + " a.CHR_STARTING_PLACE,a.CHR_ENDING_PLACE,a.INT_COURIER_KILOMETER,  "; 
			sql = sql + " a.CHR_COURIER_DESC ,a.CHR_CPONUMBER  ";
			sql = sql + " FROM inv_t_directsales a WHERE a.CHR_SALESNO='"+salenumber+"' ";
			System.out.println(sql);
			String data[][]=CommonFunctions.QueryExecute(sql);
			
			//stylesheet
			content = content + StyleSheet.styleSheet();
			
			//top content
			content = content + Template2.topContent("GOODS SHIPPED  FROM WAREHOUSE");
			
			//Content start
			content = content + "<table width='100%' border='0' align='center' cellpadding=3 cellspacing=3 >";
			
			content = content + " <tr>";
			content = content + "<td width='248' class='boldEleven'><b><h5>CPO Ref.No</h5></td>";
			content = content + "<td width='24' >&nbsp;</td>";
			content = content + "<td width='339'  class='boldEleven'><h5>"+data[0][15]+"</h5></td>";
			content = content + "</tr>";
			
			content = content + " <tr bgcolor='#20B2AA'>";
			content = content + "<td width='248' class='boldEleven'><b>Invoice Ref.No</td>";
			content = content + "<td width='24' >&nbsp;</td>";
			content = content + "<td width='339'  class='boldEleven'>"+salenumber+"</td>";
			content = content + "</tr>";
			
			content = content + "<tr bgcolor='#B0E0E6'>";
			content = content + "<td class='boldEleven'><b>Invoice Date</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][1]+"</td>";
			content = content + "</tr>";
			
			content = content + "<tr bgcolor='#20B2AA'>";
			content = content + "<td class='boldEleven'><b>Division</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][2]+"</td>";
			content = content + "</tr>";
			
			content = content + "<tr bgcolor='#B0E0E6'>";
			content = content + "<td class='boldEleven'><b>Customer</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][3]+"</td>";
			content = content + " </tr>";
			
			content = content + "<tr bgcolor='#20B2AA'>";
			content = content + "<td class='boldEleven'><b>Shipping Address</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][4]+"</td>";
			content = content + " </tr>";
			
			
			content = content + "<tr bgcolor='#20B2AA'>";
			content = content + "<td class='boldEleven'><b>Shipping through</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][6]+"</td>";
			content = content + " </tr>";
			
			content = content + "<tr bgcolor='#B0E0E6'>";
			content = content + "<td class='boldEleven'><b>Contact Ref</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][7]+"</td>";
			content = content + "</tr>";
		
			content = content + "<tr bgcolor='#20B2AA'>";
			content = content + "<td class='boldEleven'><b>Contact No.</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][8]+"</td>";
			content = content + "</tr>";
			
			content = content + "<tr bgcolor='#B0E0E6'>";
			content = content + "<td class='boldEleven'><b>Courier </td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][9]+"</td>";
			content = content + "</tr>";
			
			content = content + "<tr bgcolor='#20B2AA'>";
			content = content + "<td class='boldEleven'><b>Dispatch Date & Time</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][10]+"</td>";
			content = content + "</tr>";
			
			content = content + "<tr bgcolor='#B0E0E6'>";
			content = content + "<td class='boldEleven'><b>Starting place</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][11]+"</td>";
			content = content + "</tr>";
			
			content = content + "<tr bgcolor='#20B2AA'>";
			content = content + "<td class='boldEleven'><b>Ending Place</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][12]+"</td>";
			content = content + "</tr>";
			
			content = content + "<tr bgcolor='#B0E0E6'>";
			content = content + "<td class='boldEleven'><b>Kilometre</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][13]+"</td>";
			content = content + "</tr>";
			
			content = content + "<tr bgcolor='#20B2AA'>";
			content = content + "<td class='boldEleven'><b>Shipped Description</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][14]+"</td>";
			content = content + "</tr>";
			content = content + "</table>";
			
			content = content + "<br><div style=\"font-family:Georgia, 'Times New Roman', Times, serif; font-size:18px; color:#000000;\"><center><strong>Next Stage :- Waiting for updating delivered informations<br></strong></center></div><br><br>";  
			
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
