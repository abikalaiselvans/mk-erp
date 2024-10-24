package com.my.org.erp.SmartInventory;

import com.my.org.erp.SmartMailtemplates.Mail;
import com.my.org.erp.SmartMailtemplates.StyleSheet;
import com.my.org.erp.SmartMailtemplates.Template2;
import com.my.org.erp.common.CommonFunctions;

public class AdvanceMail 
{
	public static String sql =""; 
	//Advance Paymnet
	public static void sendAdvanceMail(String branchid,String division , String advanceunumber,String Path, String Mode)
	{
		try
		{
			if("Y".equals(CommonFunctions.QueryExecute("SELECT CHR_MAILENABLE FROM m_inventorysetting WHERE INT_ROWID=1")[0][0]))
			{
				sql = "SELECT  b.CHR_EMAILID,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),c.CHR_EMAILID  FROM inv_t_advancepayment a , com_m_staff b, inv_m_division c   WHERE a.CHR_COLLECTEDBY = b.CHR_EMPID AND a.INT_DIVIID =c.INT_DIVIID AND a.CHR_ADVANCEID = '"+advanceunumber+"'";
				String meemaildata[][]= CommonFunctions.QueryExecute(sql) ;
				String meemail= meemaildata[0][0];
				if(meemail.length()>10)
					meemail =meemail+",";
				else 
					meemail="";
				String to = meemaildata[0][2];//CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+division)[0][0];
				String advancemail = CommonFunctions.QueryExecute("SELECT CHR_ADVANCEMAIL  FROM m_inventorysetting WHERE INT_ROWID=1")[0][0];
				String content = sendAdvanceMailContent(branchid,advanceunumber,Mode);
				String subject = "";
				if("A".equals(Mode))
					subject = " Advance Payment Received from "+meemaildata[0][1];
				else
					subject = " Advance Payment Modified for "+meemaildata[0][1];
				String recipients[] =(meemail+to+","+advancemail).split(",") ;
				String[] attachments = Template2.paymentUpdatedImageFile(Path);
				Mail.sendEmailWithAttachments(recipients, subject, content, attachments);
			}
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	 
	
	public static String  sendAdvanceMailContent(String branchid, String advanceunumber ,String Mode )
    {
    	String content="";
    	try
    	{ 	
    		//stylesheet
			content = content + StyleSheet.styleSheet();
			//top content
			if("A".equals(Mode))
				content = content + Template2.topContent("Customer Advance payment Received ");
			else
				content = content + Template2.topContent("Customer Advance payment modified ");
			
			sql = " SELECT CHR_ADVANCEID,FIND_A_CUSTOMER_NAME(INT_CUSTOMERID) customer,FIND_A_PAYMENT_TERM(INT_PAYMENTTERMID) payment,  ";
			sql = sql + " IF(FIND_A_PAYMENT_TERM(INT_PAYMENTTERMID)='CASH' ,'',FIND_A_BANKGROUP_NAME(INT_BANKID)) bank,   ";
			sql = sql + " CHR_PAYNO,DATE_FORMAT(DAT_PAYMENTDATE,'%d-%b-%Y'),DOU_ADVANCEAMOUNT,   ";
			sql = sql + " CHR_DESC,FIND_A_EMPLOYEE_ID_NAME(CHR_COLLECTEDBY),FIND_A_PAYMENT_CREDITEDTO(INT_DEPOSITID)  ";  
			sql = sql + " FROM    inv_t_advancepayment    ";
			sql = sql + " WHERE CHR_ADVANCEID =  '"+advanceunumber+"'  ";
			String data[][]=CommonFunctions.QueryExecute(sql);
			if(data.length>0)
			{
				content = content + "<table width='100%' border='0' align='center' cellpadding='2' cellspacing='2'> ";
				
				content = content + "<tr bgcolor='#FF9900'> ";
				content = content + "<td width='192' align='left' valign='top' class='boldEleven'><b>Advance Ref No</td> ";
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
				content = content + "<td width='192' align='left' valign='top' class='boldEleven'><b>Advance Amount</td> ";
				content = content + "<td width='226' align='left' valign='top' class='boldEleven'>"+data[0][6]+"</td> ";
				content = content + "<td align='left' valign='top' class='boldEleven'><b>Description</td> ";
				content = content + "<td align='left' valign='top' class='boldEleven'>"+data[0][7]+"</td> ";
				content = content + "</tr> ";
				
				content = content + "<tr bgcolor='#FF9900'> ";
				content = content + "<td width='192' align='left' valign='top' class='boldEleven'><b>Collected By</td> ";
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
