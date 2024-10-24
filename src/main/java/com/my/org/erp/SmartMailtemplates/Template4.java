package com.my.org.erp.SmartMailtemplates;

public class Template4 
{
	
	public static String[]  attachImageFile(String Path)
    {
		 
		String attachments[]=null;
    	try
    	{
    		attachments = new String [2];
			attachments[0] = Path+"images/mailtemplate/temp4/top.png";
			attachments[1] = Path+"images/mailtemplate/temp4/divider.png";
			return attachments;
    	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return attachments;
    }
	
	public static String  topContent(String title)
    {
    	String content="";
    	try
    	{ 
    		content = content + "<table width='100%' border='0' cellspacing='0' cellpadding='0'>  ";
    		content = content + "<tr>  ";
    		content = content + "<td align='center' valign='top' bgcolor='#98846c' style='background-color:#98846c;'><br>  ";
    		content = content + "<br>  ";
    		content = content + "<table width='600' border='0' align='center' cellpadding='0' cellspacing='10' bgcolor='#5c1707' style='background-color:#5c1707;'>  ";
    		content = content + "<tr>  ";
    		content = content + "<td align='center' valign='middle' bgcolor='#ffffff' style='background-color:#ffffff;'><table width='100%' border='0' cellspacing='0' cellpadding='0'>  ";
    		content = content + "<tr>  ";
    		content = content + "<td align='left' valign='top'><img src='top.jpg' width='580' height='180' style='display:block;'></td>  ";
    		content = content + "</tr>  ";
    		content = content + "<tr>  ";
    		content = content + "<td align='center' valign='top' bgcolor='#ffffff' style=\"background-color:#ffffff; font-family:Arial, Helvetica, sans-serif; font-size:13px; color:#000000;\">  ";
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
    		
    		 
    		 content = content + "</td> ";
    		 content = content + " </tr> ";
    		 content = content + " <tr> ";
    		 content = content + "<td align='center' valign='top' bgcolor='#ffffff' style='background-color:#ffffff; font-family:Arial, Helvetica, sans-serif; font-size:13px; color:#000000;'> ";
    		 content = content + Footer.footerContent(branchid);
			 content = content + "</td> ";
    		 content = content + " </tr> ";
    		 content = content + "</table></td> ";
    		 content = content + "</tr> ";
    		 content = content + "</table> ";
    		 content = content + "<br> ";
    		 content = content + " <br></td> ";
    		 content = content + " </tr> ";
    		 content = content + " </table> ";
			
    		return content;
    	}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
		return content;
	}
}