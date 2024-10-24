package com.my.org.erp.SmartMailtemplates;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import com.my.org.erp.ServiceLogin.DateUtil;

public class Template3 
{
	
	public static String[]  attachImageFile(HttpServletRequest request,String Path,String Qnumber)
    {
		 
		String attachments[]=null;
    	try
    	{
    		attachments = new String [5];
			attachments[0] = Path+"images/mailtemplate/cpoverification/bot.png";
			attachments[1] = Path+"images/mailtemplate/cpoverification/grey_bot.png";
			attachments[2] = Path+"images/mailtemplate/cpoverification/grey_top.png";
			attachments[3] = Path+"images/mailtemplate/cpoverification/top.png";
			String filepath = request.getRealPath("/");
			File f = null;
			f = new File(Path+"uploadfiles/CPO_Order/"+Qnumber.replaceAll("/","_")+".pdf");
			if(f.exists())
				attachments[4] = Path+"uploadfiles/CPO_Order/"+Qnumber.replaceAll("/","_")+".pdf";
			else
				attachments[4] = Path+"images/mailtemplate/cpoverification/top.png";
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
    		content = content + "<table width='100%' border='0' cellspacing='0' cellpadding='0'> ";
			content = content + "<tr> ";
			content = content + "<td align='center' valign='top' ><br> ";//bgcolor='#444444' style='background-color:#444444;'
			content = content + "<br> ";
			content = content + "<table width='600' border='0' cellspacing='0' cellpadding='0'> ";
			content = content + "<tr> ";
			content = content + "<td align='left' valign='top'><img src='top.png' width='600' height='18' style='display:block;'></td> ";
			content = content + "</tr> ";
			content = content + "<tr> ";
			content = content + "<td align='left' valign='top' bgcolor='#f73f9b' style=\"background-color:#f73f9b; font-family:Arial, Helvetica, sans-serif; font-size:13px; color:#ffffff; padding:0px 15px 10px 15px;\"> ";
			content = content + "<div style='font-size:22px;'><b><strong><CENTER>"+title+"</CENTER></strong></b></div> ";
			        
			content = content + "</td> ";
			content = content + "</tr> ";
			/*content = content + "<tr> ";
			content = content + "<td height='72' align='center' valign='middle' bgcolor='#353535'  ><i>CPO Verified</i></td> ";
			content = content + "</tr> ";*/
			content = content + "<tr> ";
			content = content + "<td align='left' valign='top' bgcolor='#1ba5db' style='background-color:#1ba5db; padding:15px;'> ";
			
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
			content = content + "</tr> ";
			content = content + "<tr> ";
			content = content + "<td align='left' valign='top'><img src='bot.png' width='600' height='18' style='display:block;'></td> ";
			content = content + "</tr> ";
			content = content + "</table> ";
			content = content + "<table width='600' border='0' cellspacing='0' cellpadding='0' style='margin-top:10px;'> ";
			content = content + "<tr> ";
			content = content + "<td align='center' valign='middle'><img src='grey_top.png' width='600' height='13' style='display:block;'></td> ";
			content = content + "</tr> ";
			content = content + "<tr> ";
			content = content + "    <td align='center' valign='middle' bgcolor='#e1e1e1'><table width='600' border='0' align='center' cellpadding='0' cellspacing='0'> ";
			content = content + "<tr> ";
			content = content + "<td width='5%' align='left' valign='middle'>&nbsp;</td> ";
			content = content + "<td width='95%' align='left' valign='middle' style='color:#595959; font-size:11px; font-family:Arial, Helvetica, sans-serif;'> ";
			content = content + Footer.footerContent(branchid);
			content = content + "</tr> ";
			content = content + "</table></td> ";
			content = content + "</tr> ";
			content = content + "<tr> ";
			content = content + "<td align='center' valign='middle'><img src='grey_bot.png' width='600' height='13' style='display:block;'></td> ";
			content = content + "</tr> ";
			content = content + "</table> ";
			content = content + "<br> ";
			content = content + "<br></td> ";
			content = content + "</tr> ";
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