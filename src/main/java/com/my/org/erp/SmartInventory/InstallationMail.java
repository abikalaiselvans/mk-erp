package com.my.org.erp.SmartInventory;

import com.my.org.erp.SmartMailtemplates.Mail;
import com.my.org.erp.SmartMailtemplates.StyleSheet;
import com.my.org.erp.SmartMailtemplates.Template2;
import com.my.org.erp.common.CommonFunctions;

public class InstallationMail 
{
	public static String sql =""; 
	
	//Engineer assigned in installation
	public static void sendEngineerAssignedforInstallationMail(String branchid,String salno, String division,String Path)
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
				sql = "SELECT  FIND_A_EMPLOYEE_ID_NAME(CHR_EMPID),DATE_FORMAT(DAT_INSTALLATION,'%d-%b-%Y %h:%m:%s %p') FROM inv_t_directsales_installation  WHERE CHR_SALESNO = '"+salno+"' GROUP BY CHR_SALESNO ";
				String engineer =CommonFunctions.QueryExecute(sql)[0][0];
				String assigndate =CommonFunctions.QueryExecute(sql)[0][1];
				String to = CommonFunctions.QueryExecute("SELECT CHR_EMAILID FROM inv_m_division  WHERE INT_DIVIID="+division)[0][0];
				String approvalmail = CommonFunctions.QueryExecute("SELECT CHR_INWARDMAIL  FROM   m_inventorysetting WHERE INT_ROWID=1")[0][0];
				String content = EngineerAssignedforInstallationContent(branchid,salno,engineer,assigndate);
				
				String subject = " Engineer[ "+engineer+" ]  assigned for installation to "+meemaildata[0][1] +" [ Awaiting for installation updation ]";
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
	
	
	public static String  EngineerAssignedforInstallationContent(String branchid, String salenumber ,String engineer, String assigndate )
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
			content = content + Template2.topContent("INSTALLATION ASSIGNED  ");

			 
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
			content = content + "<td class='boldEleven'><b><h5>Engineer</h5></td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'><h5>"+engineer+"</h5></td>";
			content = content + " </tr>";
			
			content = content + "<tr bgcolor='#20B2AA'>";
			content = content + "<td class='boldEleven'><b>Engineer Assign Date</td>";
			content = content + "<td>&nbsp;</td>";
			content = content + "<td  class='boldEleven'>"+assigndate+"</td>";
			content = content + " </tr>";
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
	
	
	
	
	//Installation Updation
	public static void sendInstallationUpdationMail(String branchid,String salno, String division,String Path,String installationrowid)
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
				String content = InstallationUpdationContent(branchid,salno,installationrowid);
				
				String subject = "Installation completed [ "+meemaildata[0][1] +" ]";
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
	
	
	public static String  InstallationUpdationContent(String branchid, String salenumber ,String installationrowid )
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
			String data[][]=CommonFunctions.QueryExecute(sql);
			
			//stylesheet
			content = content + StyleSheet.styleSheet();
			
			//top content
			content = content + Template2.topContent("INSTALLATION COMPLETED  ");

			 
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
			
			sql ="";
			sql = "SELECT FIND_A_EMPLOYEE_ID_NAME(CHR_EMPID),CHR_SERIALNO, ";
			sql = sql + " DATE_FORMAT(DAT_INSTALLATION,'%d-%b-%Y %h:%m:%s %p'),DATE_FORMAT(DAT_UPDATION,'%d-%b-%Y %h:%m:%s %p'), ";
			sql = sql + "  CHR_REASON,CHR_UPDATION_DESC ";
			sql = sql + " FROM inv_t_directsales_installation  WHERE INT_INSTALLATIONID =  "+installationrowid;
			String data1[][]=CommonFunctions.QueryExecute(sql);
			if(data1.length>0)
			{
				content = content + "<tr bgcolor='#B0E0E6'>";
				content = content + "<td class='boldEleven'><b>Engineer</td>";
				content = content + "<td>&nbsp;</td>";
				content = content + "<td  class='boldEleven'>"+data1[0][0]+"</td>";
				content = content + " </tr>";
				
				content = content + "<tr bgcolor='#20B2AA'>";
				content = content + "<td class='boldEleven'><b>Machine Serial</td>";
				content = content + "<td>&nbsp;</td>";
				content = content + "<td  class='boldEleven'>"+data1[0][1]+"</td>";
				content = content + " </tr>";
				
				content = content + "<tr bgcolor='#B0E0E6'>";
				content = content + "<td class='boldEleven'><b>Assign Date</td>";
				content = content + "<td>&nbsp;</td>";
				content = content + "<td  class='boldEleven'>"+data1[0][2]+"</td>";
				content = content + " </tr>";
				
				content = content + "<tr bgcolor='#20B2AA'>";
				content = content + "<td class='boldEleven'><b>Completion date</td>";
				content = content + "<td>&nbsp;</td>";
				content = content + "<td  class='boldEleven'>"+data1[0][3]+"</td>";
				content = content + " </tr>";
				
				content = content + "<tr bgcolor='#B0E0E6'>";
				content = content + "<td class='boldEleven'><b>Description</td>";
				content = content + "<td>&nbsp;</td>";
				content = content + "<td  class='boldEleven'>"+data1[0][5]+"</td>";
				content = content + " </tr>";
				
				
				
				
			}
			
			
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
