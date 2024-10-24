package com.my.org.erp.SmartMailtemplates;

public class Template2 
{
	
	public static String[]  attachinwardImageFile(String Path)
    {
		 
		String attachments[]=null;
    	try
    	{
    		attachments = new String [2];
    		attachments[0] =Path+"images/mailtemplate/goodsreceived/mainpic.png";
			attachments[1] =  Path+"images/mailtemplate/goodsreceived/top.jpg";
    		return attachments;
    	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return attachments;
    }
	
	public static String[]  attachshippedImageFile(String Path)
    {
		 
		String attachments[]=null;
    	try
    	{
    		attachments = new String [2];
    		attachments[0] = Path+"images/mailtemplate/shipped/mainpic.png";
    		attachments[1] = Path+"images/mailtemplate/shipped/top.jpg";
    		
    		return attachments;
    	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return attachments;
    }
	
	public static String[] cpoattachedImageFile(String Path)
    {
		 
		String attachments[]=null;
    	try
    	{
    		attachments = new String [2];
    		attachments[0] = Path+"images/mailtemplate/cpoattached/mainpic.png";
    		attachments[1] = Path+"images/mailtemplate/cpoattached/top.jpg";
    		return attachments;
    	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return attachments;
    }
	
	public static String[] paymentUpdatedImageFile(String Path)
    {
		 
		String attachments[]=null;
    	try
    	{
    		attachments = new String [2];
    		attachments[0] = Path+"images/mailtemplate/cpoattached/mainpic.png";
    		attachments[1] = Path+"images/mailtemplate/cpoattached/top.jpg";
    		
    		return attachments;
    	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return attachments;
    }
	
	public static String  topContent( String title)
    {
    	String content="";
    	try
    	{ 
    		content =  "<table width='90%' border='0' align='center' cellpadding='0' cellspacing='0'>";
			content = content + "<tr  bgcolor='#478730' style='background-color:#478730;'>";
			content = content + " <td align='left' valign='top' ><div style=\"font-family:Georgia, 'Times New Roman', Times, serif; font-size:18px; color:#ffffff;\"><center><strong>"+title+"</strong></center></div></td>";
			content = content + "</tr>";
			content = content + "<tr>";
			content = content + "<td align='center' valign='top' bgcolor='#f1f69d' style='background-color:#f1f69d; font-family:Arial, Helvetica, sans-serif; font-size:13px; color:#000000; padding:10px;'><table width='100%' border='0' cellspacing='0' cellpadding='0' style='margin-top:10px;'>";
			content = content + " <tr>";
			content = content + " <td align='left' valign='top' style='font-family:Arial, Helvetica, sans-serif; font-size:13px; color:#525252;'>";
			//content = content + "<img src='mainpic.png' width='213' height='319' align='right' style='margin-left:10px;'>";
			content = content + "<br>";
			content = content + "<div style='font-size:28px;'></div>";
			content = content + "<div>";
    		
    		return content;
    	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return content;
	}
	
	
	public static String  bottomContent(String branchid)
    {
    	String content="";
    	try
    	{ 
    		content = content + "</div></td>";
			content = content + "</tr>";
			content = content + "</table></td>";
			content = content + " </tr>";
			content = content + " <tr>";
			content = content + "<td align='left' valign='top' bgcolor='#478730' style='background-color:#478730;'><table width='100%' border='0' cellspacing='0' cellpadding='15'>";
			content = content + "<tr>";
			content = content + "<td align='left' valign='top' style='color:#ffffff; font-family:Arial, Helvetica, sans-serif; font-size:13px;'>";
			content = content + Footer.footerContent(branchid);
			content = content + "</td></tr>";
			content = content + "</table></td>";
			content = content + "</tr>";
			content = content + "</table> ";
    		return content;
    	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return content;
	}
	
	public static String  bottomContent()
    {
    	String content="";
    	try
    	{ 
    		content = content + "</div></td>";
			content = content + "</tr>";
			content = content + "</table></td>";
			content = content + " </tr>";
			content = content + " <tr>";
			content = content + "<td align='left' valign='top' bgcolor='#478730' style='background-color:#478730;'><table width='100%' border='0' cellspacing='0' cellpadding='15'>";
			content = content + "<tr>";
			content = content + "<td align='left' valign='top' style='color:#ffffff; font-family:Arial, Helvetica, sans-serif; font-size:13px;'>";
			content = content + Footer.footerContent();
			content = content + "</td></tr>";
			content = content + "</table></td>";
			content = content + "</tr>";
			content = content + "</table> ";
    		return content;
    	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return content;
	}
}