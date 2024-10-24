package com.my.org.erp.SmartMailtemplates;

public class Template5 
{
	
	public static String[]  attachImageFile(String Path)
    {
		 
		String attachments[]=null;
    	try
    	{
    		attachments = new String [1];
			attachments[0] = Path+"images/mailtemplate/temp5/top.png";
			return attachments;
    	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return attachments;
    }
	
	public static String  topContentwithimage(String title)
    {
    	String content="";
    	try
    	{ 
    		 
    		content = content + "<table width='100%' border='0' cellspacing='0' cellpadding='0'> ";
    		content = content + "<tr> ";
    		content = content + "<td align='center' valign='top' bgcolor='#726627' style='background-color:#726627;'><br> ";
    		content = content + " <br> ";
    		content = content + "<table width='600' border='0' cellspacing='0' cellpadding='0'> ";
    		content = content + "<tr> ";
    		content = content + "<td align='left' height='120' valign='top' ><img src='top.png'/></td> ";
    		content = content + "</tr> ";
    		content = content + "<tr> ";
    		content = content + "<td align='center' valign='top' bgcolor='#006c00' style='background-color:#006c00; font-family:Arial, Helvetica, sans-serif; font-size:13px; color:#000000;'><table width='100%' border='0' cellspacing='0' cellpadding='5'> ";
    		content = content + "<tr> ";
    		content = content + "<td width='50%' align='left' valign='top' style='color:#ffffff; font-family:Verdana, Geneva, sans-serif; font-size:11px;'>&nbsp;&nbsp;</td> ";
    		content = content + "<td align='right' valign='top' style='color:#ffffff; font-family:Verdana, Geneva, sans-serif; font-size:11px;'>&nbsp; </td> ";
    		content = content + "</tr> ";
    		content = content + "</table></td> ";
    		content = content + "</tr> ";
    		content = content + " <tr> ";
    		content = content + "<td align='center' valign='top' bgcolor='#ffffff' style=\"background-color:#ffffff; font-family:Arial, Helvetica, sans-serif; font-size:13px; color:#000000; padding:12px;\"><table width='100%' border='0' cellspacing='0' cellpadding='10' style='margin-bottom:10px;'> ";
    		content = content + "<td align='left' valign='top' style='font-family:Arial, Helvetica, sans-serif; font-size:13px; color:#525252;'> ";
    		content = content + " <div style=''font-size:18px; color:#006d00;'> </div> ";
            content = content + "<div style=''font-size:18px;'>"+title+"</div> ";
             content = content + "</td></table> ";
    		content = content + "<p> ";
    		return content;
    	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return content;
	}
	
	public static String  topContent(String title)
    {
    	String content="";
    	try
    	{ 
    		 
    		content = content + "<table width='100%' border='0' cellspacing='0' cellpadding='0'> ";
    		content = content + "<tr> ";
    		content = content + "<td align='center' valign='top' bgcolor='#726627' style='background-color:#726627;'><br> ";
    		content = content + " <br> ";
    		content = content + "<table width='80%' border='0' cellspacing='0' cellpadding='0'> ";
    		//content = content + "<tr> ";
    		//content = content + "<td align='left' height='120' valign='top' style='background-image:url(top.png)'>&nbsp; </td> ";
    		//content = content + "</tr> ";
    		content = content + "<tr> ";
    		content = content + "<td align='center' valign='top' bgcolor='#006c00' style='background-color:#006c00; font-family:Arial, Helvetica, sans-serif; font-size:13px; color:#000000;'><table width='100%' border='0' cellspacing='0' cellpadding='5'> ";
    		content = content + "<tr> ";
    		content = content + "<td width='50%' align='left' valign='top' style='color:#ffffff; font-family:Verdana, Geneva, sans-serif; font-size:11px;'></td> ";
    		content = content + "<td align='right' valign='top' style='color:#ffffff; font-family:Verdana, Geneva, sans-serif; font-size:11px;'>&nbsp; </td> ";
    		content = content + "</tr> ";
    		content = content + "</table></td> ";
    		content = content + "</tr> ";
    		content = content + " <tr> ";
    		content = content + "<td align='center' valign='top' bgcolor='#ffffff' style=\"background-color:#ffffff; font-family:Arial, Helvetica, sans-serif; font-size:13px; color:#000000; padding:12px;\"><table width='100%' border='0' cellspacing='0' cellpadding='10' style='margin-bottom:10px;'> ";
    		content = content + "<td align='left' valign='top' style='font-family:Arial, Helvetica, sans-serif; font-size:13px; color:#525252;'> ";
    		content = content + " <div style=''font-size:18px; color:#006d00;'> </div> ";
            content = content + "<div style=''font-size:28px;'>"+title+"</div> ";
             content = content + "</td></table> ";
    		
    		content = content + "<p> ";
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
    		
    		 
    		
    		content = content + "</p></td> ";
    		content = content + " </tr> ";
    		content = content + "<tr> ";
    		content = content + "<td align='left' valign='top' bgcolor='#006c00' style='background-color:#006c00;'><table width='100%' border='0' cellspacing='0' cellpadding='15'> ";
    		content = content + " <tr> ";
    		content = content + "<td align='left' valign='top' style='color:#ffffff; font-family:Arial, Helvetica, sans-serif; font-size:13px;'> ";
    		content = content + Footer.footerContent(branchid);
			content = content + "</td> ";
    		content = content + " </tr> ";
    		content = content + " </table></td> ";
    		content = content + "</tr> ";
    		content = content + " </table> ";
    		content = content + "<br> ";
    		content = content + "<br></td> ";
    		content = content + "</tr> ";
    		content = content + "</table>&nbsp; <br><br>";
    		return content;
    	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return content;
	}
}