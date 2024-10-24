package com.my.org.erp.SmartInventory;

import com.my.org.erp.SmartMailtemplates.Mail;
import com.my.org.erp.SmartMailtemplates.StyleSheet;
import com.my.org.erp.SmartMailtemplates.Template2;
import com.my.org.erp.common.CommonFunctions;

public class StockStransferMail 
{
	public static String sql =""; 
	
	//Goods shipped mail
	public static void sendStockTransferShippedMail(String branchid,String transferno, String division,String Path)
	{
		try
		{
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
			{
				String meemail= "";
				String to = CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+division)[0][0];
				String stocktransfermailmail = CommonFunctions.QueryExecute("SELECT CHR_STOCKTRANSFERMAIL  FROM   m_inventorysetting WHERE INT_ROWID=1")[0][0];
				String content = StockTransferDespatchedMailContent(branchid,transferno);
				String subject = " Stock Transfer Despatched "+transferno;
				String recipients[] =(meemail+to+","+stocktransfermailmail).split(",") ;
				String[] attachments = Template2.attachshippedImageFile(Path);
				Mail.sendEmailWithAttachments(recipients, subject, content, attachments);
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	public static String  StockTransferDespatchedMailContent(String branchid, String transferno )
    {
    	String content="";
    	
		try
    	{ 	
			 
			sql =  " SELECT a.CHR_STOCKTRANSFERID,DATE_FORMAT(a.DAT_TRANSFERDATE,'%d-%b-%Y'), FUN_INV_GET_DIVISION(a.INT_DIVIID), ";  
			sql = sql + "  FUN_GET_BRANCH_NAME(INT_BRANCHID_FROM),FUN_GET_BRANCH_NAME(INT_BRANCHID_TO), ";
			sql = sql + " if(a.CHR_DELIVERY='N','Pending',if(a.CHR_DELIVERY='P','Progress',if(a.CHR_DELIVERY='Y','Delivered','Rejected'))) delivery, ";   
			sql = sql + " if(a.CHR_DELIVERYTHROUGH ='C','Courier',if(a.CHR_DELIVERYTHROUGH='P','Person',if(a.CHR_DELIVERYTHROUGH='O','Own','Vehicle')))deliverythrough, ";   
			sql = sql + " a.CHR_COURIER_EMPID,a.CHR_COURIER_EMPID_MOBILE,   ";
			sql = sql + " if(a.INT_COURIERID =0 ,'',(SELECT e.CHR_COURIERNAME FROM inv_m_courier e WHERE e.INT_COURIERID =a.INT_COURIERID)) cmode,";  
			sql = sql + " DATE_FORMAT(a.DAT_COURIERDATE,'%d-%b-%Y %h:%m:%s   %p'),  ";
			sql = sql + " a.CHR_STARTING_PLACE,a.CHR_ENDING_PLACE,a.INT_COURIER_KILOMETER,";  
			sql = sql + " a.CHR_COURIER_DESC  ";
			sql = sql + " FROM inv_t_stocktransfer a WHERE CHR_STOCKTRANSFERID='"+transferno+"' ";
			System.out.println(sql);
			String data[][]=CommonFunctions.QueryExecute(sql);
			
			//stylesheet
			content = content + StyleSheet.styleSheet();
			
			//top content
			content = content + Template2.topContent("STOCK TRANSFER DESPATCED");
			
			//Content start
			content = content + "<table width='100%' border='0' align='center' cellpadding=3 cellspacing=3 >";
			
			 
			
			content = content + " <tr bgcolor='#20B2AA'>";
			content = content + "<td width='248' class='boldEleven'><b>Transfer Ref.No</td>";
			content = content + "<td width='24' >&nbsp;</td>";
			content = content + "<td width='339'  class='boldEleven'>"+transferno+"</td>";
			content = content + "</tr>";
			
			content = content + "<tr bgcolor='#B0E0E6'>";
			content = content + "<td class='boldEleven'><b>Transfer Date</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][1]+"</td>";
			content = content + "</tr>";
			
			content = content + "<tr bgcolor='#20B2AA'>";
			content = content + "<td class='boldEleven'><b>Division</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][2]+"</td>";
			content = content + "</tr>";
			
			content = content + "<tr bgcolor='#B0E0E6'>";
			content = content + "<td class='boldEleven'><b>From Branch</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+data[0][3]+"</td>";
			content = content + " </tr>";
			
			content = content + "<tr bgcolor='#20B2AA'>";
			content = content + "<td class='boldEleven'><b>To Branch</td>";
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
