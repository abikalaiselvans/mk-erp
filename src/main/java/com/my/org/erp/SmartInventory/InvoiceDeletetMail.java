package com.my.org.erp.SmartInventory;

import com.my.org.erp.common.CommonFunctions;
 
public class InvoiceDeletetMail 
{ 


	public static String  InvoiceDeletesendtoMail(String subject, String invoicenumber,String desc,String Type )
    {
		String content ="";
		try
    	{
    		content =" <style type='text/css'> ";
			content=content+" <!-- ";
			content=content+" .style1 {color: #FFFFFF} ";
			content=content+" .style5 {font-size: 10} ";
			content=content+" .style6 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10; } ";
			content=content+" --> ";
			content=content+" </style> ";
			content=content+" <table width='80%' border='0' cellpadding='1' cellspacing='1' bgcolor='#0000FF'> ";
			content=content+" <tr> ";
			content=content+" <td> <h2 align='center' class='style1'>"+subject; 
			content=content+" </h2></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><table width='100%' border='0' cellpadding='0' cellspacing='0' bgcolor='#FFFFFF'> ";
			content=content+" <tr> ";
			content=content+" <td width='170'><h4>&nbsp;</h4></td> ";
			content=content+" <td width='332'><span class='style5'></span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>Invoice Number </h4></td> ";
			content=content+" <td><span class='style5'>"+invoicenumber+"</span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>&nbsp;</h4></td> ";
			content=content+" <td><span class='style6'> </span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>Invoice Type </h4></td> ";
			content=content+" <td><span class='style5'>"+Type+"</span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>&nbsp;</h4></td> ";
			content=content+" <td><span class='style6'> </span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>Description</h4></td> ";
			content=content+" <td><span class='style5'>"+desc+"</span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>&nbsp;</h4></td> ";
			content=content+" <td><span class='style5'></span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>Date of Deletion </h4></td> ";
			content=content+" <td><span class='style5'>"+ CommonFunctions.QueryExecute("select date_format(now(),'%d-%b-%Y')")[0][0]+"</span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>&nbsp;</h4></td> ";
			content=content+" <td><span class='style5'></span></td> ";
			content=content+" </tr> ";
			content=content+" </table></td> ";
			content=content+" </tr> ";
			content=content+" </table> ";
  	       return content;
    	}
    	catch(Exception e)
    	{
    		System.out.println(e.getMessage());
    	}
		return content;
    }
	
	
	public static String  InvoiceCancellsendtoMail(String subject, String invoicenumber,String desc,String Type )
    {
		String content ="";
		try
    	{
    		content =" <style type='text/css'> ";
			content=content+" <!-- ";
			content=content+" .style1 {color: #FFFFFF} ";
			content=content+" .style5 {font-size: 10} ";
			content=content+" .style6 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10; } ";
			content=content+" --> ";
			content=content+" </style> ";
			content=content+" <table width='80%' border='0' cellpadding='1' cellspacing='1' bgcolor='#0000FF'> ";
			content=content+" <tr> ";
			content=content+" <td> <h2 align='center' class='style1'>"+subject; 
			content=content+" </h2></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><table width='100%' border='0' cellpadding='0' cellspacing='0' bgcolor='#FFFFFF'> ";
			content=content+" <tr> ";
			content=content+" <td width='170'><h4>&nbsp;</h4></td> ";
			content=content+" <td width='332'><span class='style5'></span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>Invoice Number </h4></td> ";
			content=content+" <td><span class='style5'>"+invoicenumber+"</span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>&nbsp;</h4></td> ";
			content=content+" <td><span class='style6'> </span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>Invoice Type </h4></td> ";
			content=content+" <td><span class='style5'>"+Type+"</span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>&nbsp;</h4></td> ";
			content=content+" <td><span class='style6'> </span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>Description</h4></td> ";
			content=content+" <td><span class='style5'>"+desc+"</span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>&nbsp;</h4></td> ";
			content=content+" <td><span class='style5'></span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>Date of Cancell </h4></td> ";
			content=content+" <td><span class='style5'>"+ CommonFunctions.QueryExecute("select date_format(now(),'%d-%b-%Y')")[0][0]+"</span></td> ";
			content=content+" </tr> ";
			content=content+" <tr> ";
			content=content+" <td><h4>&nbsp;</h4></td> ";
			content=content+" <td><span class='style5'></span></td> ";
			content=content+" </tr> ";
			content=content+" </table></td> ";
			content=content+" </tr> ";
			content=content+" </table> ";
  	       return content;
    	}
    	catch(Exception e)
    	{
    		System.out.println(e.getMessage());
    	}
		return content;
    }
	
	
	
	
	  
	
	 

  

  
 


}
