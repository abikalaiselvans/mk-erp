package com.my.org.erp.SmartCommon;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpServletRequest;

import com.my.org.erp.ServiceLogin.DateUtil;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.setting.CommonData;

 

public class StaffRegistrationMethod 
{

	
	
	//Mail for All employee care
	public static void sendNewJoinnerInfoMailtoAllEmp(String newempid,String Path,String to)
    {
    	try
    	{

    		String ssql =" SELECT  a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,b.CHR_COMPANYNAME,c.CHR_BRANCHNAME, d.CHR_DEPARTNAME,e.CHR_DESIGNAME,f.CHR_OFFICENAME,DATE_FORMAT(DT_DOB,'%d-%b-%Y'),a.CHR_GENDER,a.CHR_MARITALSTATUS,DATE_FORMAT(a.DT_WEDDATE,'%d-%b-%Y'), a.CHR_EMAILID,a.CHR_PERMAILID ,a.CHR_MOBILE,g.CHR_QUALIFICATIONNAME,a.CHR_PREVIOUSDETAILS,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),if(a.INT_ATTENDANCECYCLE=1,'1-31','20th-19th')   FROM   com_m_staff a ,  com_m_company b,  com_m_branch c,com_m_depart d,com_m_desig e, com_m_office  f,com_m_qualification g WHERE a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID = c.INT_BRANCHID AND a.INT_DEPARTID = d.INT_DEPARTID  AND a.INT_DESIGID = e.INT_DESIGID 	AND a.INT_OFFICEID = f.INT_OFFICEID AND a.CHR_QUALIFICATION = g.INT_QUALIFICATIONID AND a.CHR_EMPID='"+newempid+"' ";
    		String pdatas[][] = CommonFunctions.QueryExecute(ssql);
    		
    		String cpyshortname=CommonFunctions.QueryExecute("SELECT CHR_SHORTNAME FROM M_INSTITUTION WHERE INT_ID=1")[0][0];
 			String hData[][] = CommonFunctions.QueryExecute("SELECT CHR_HOST,CHR_USERID,CHR_PASSWORD,CHR_MAILID FROM  m_mailsetting WHERE INT_MAILID = 1");
    		String host =hData[0][0]   ;
            String password =hData[0][2]   ;
            String mailFrom =hData[0][3]   ;
            String port = "25";  
			String subject =  "****** WELCOME TO THE "+cpyshortname.toUpperCase()+" FAMILY *****" ;  
			String bodyMessage = " ";  
			
			String[] attachments = new String [2];
			attachments[0] =Path+"images/mailbackground.jpg";
			attachments[1] =  Path+"images/logo.jpg";
			
			 
			
    		String content ="   ";
    		content=content+"<html> ";
    		content=content+"<head>";
    		content=content+"<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'> ";
    		content=content+"<title>:: SMARTCAMPUS ::</title> ";
    		
    	 
    		content=content+"<style type='text/css'> ";
    		content=content+"<!-- ";
    		content=content+" .style12 { ";
    		content=content+"	FONT-WEIGHT: normal; ";
    		content=content+"	FONT-SIZE: 10px; ";
    		content=content+"	COLOR: #000000; ";
    		content=content+"	LINE-HEIGHT: 15px; ";
    		content=content+"	FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
    		content=content+"	TEXT-DECORATION: none ";
    		content=content+" }	 ";
    		 
    		content=content+" body {";
    		content=content+"       padding:0px;";
    		content=content+"       margin:0px;";
    	 	content=content+"	 background: url('mailbackground.jpg');";
    		content=content+" } ";
    		 
    		
    	   
    		content=content+".style15 {FONT-WEIGHT: bold; FONT-SIZE: 10px; COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; } ";
    		content=content+"--> ";
    		content=content+"</style> ";
    		 
    		
    		content=content+"</head> ";
 
    	 
    		content=content+"<br><br> <table width='800'   bgcolor='#0099FF' border='0'  align='center' cellpadding='2' cellspacing='2'   > ";
    		content=content+"  <tr> ";
    		content=content+"    <td align='center' colspan='2'  valign='middle' > </td> ";
    		content=content+"  </tr> ";
    		
    		content=content+"  <tr> ";
    		content=content+"  <tr  bgcolor='#0099FF'> ";
    		content=content+"    <td colspan='2'  valign='middle' align='center' ><h3> <img name=\"common\" id=\"common\" src=\"logo.jpg\"  />&nbsp;&nbsp;&nbsp;&nbsp;<font color='#ffffff'>DEAR ALL, Lets Welcome a new member in "+cpyshortname+" Family </font></h3></td> ";
    		content=content+"  </tr> ";
    		
    		
    		
    		content=content+"  <tr  bgcolor='#ffffff'  > ";
    		content=content+"    <td  width='75%'><table width='400' border='0' align='center' cellpadding='4' cellspacing='4'> ";
    		content=content+"      <tr> ";
    		content=content+"       <td width='178'><span class='style15'>Emp Id </span></td> ";
    		content=content+"        <td width='222'><span class='style12'>"+pdatas[0][0]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Name</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][1]+"</span></td> ";
    		content=content+"      </tr> ";
    		
    		content=content+"      <tr> ";
    		if("Female".equals(pdatas[0][9]))
    		{
    			if("M".equals(pdatas[0][10]))
    				content=content+"<td><span class='style15'>Spouse Name </span></td> ";
    			else
    				content=content+"<td><span class='style15'>Father Name </span></td> ";
    		}
    		else
    			content=content+"<td><span class='style15'>Father Name </span></td> ";
    		
    		content=content+"        <td><span class='style12'>"+pdatas[0][2]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Company</span></td> ";
    		content=content+"       <td><span class='style12'>"+pdatas[0][3]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"     <tr> ";
    		content=content+"        <td><span class='style15'>Branch</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][4]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"        <td><span class='style15'>Department</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][5]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Designation</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][6]+"</span></td> ";
    		content=content+"      </tr> ";
    		
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Office</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][7]+"</span></td> ";
    		content=content+"      </tr> ";
    		
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Attendance Cycle</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][18]+"</span></td> ";
    		content=content+"      </tr> ";
    		
    		
    		content=content+"      <tr> ";
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Date of Joinning</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][17]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"<td><span class='style15'>Date of Birth </span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][8]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"     <tr> ";
    		content=content+"        <td><span class='style15'>Gender</span></td> ";
    		content=content+"       <td><span class='style12'>"+pdatas[0][9]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Married Status </span></td> ";
    		if("M".equals(pdatas[0][10]))
				content=content+"       <td><span class='style12'>Married</span></td> ";
			else
				content=content+"       <td><span class='style12'>Unmarried</span></td> ";
    		content=content+"     </tr> ";
    		content=content+"      <tr> ";
			if("M".equals(pdatas[0][10]))
			{
    			content=content+"       <td><span class='style15'>Wedding Date </span></td> ";
    			content=content+"       <td><span class='style12'>"+pdatas[0][11]+"</span></td> ";
    			content=content+"      </tr> ";
			}	
    		content=content+"     <tr> ";
    		content=content+"        <td><span class='style15'>Office - Email</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][12]+"</span></td> ";
    		content=content+"    </tr> ";
    		content=content+"    <tr> ";
    		content=content+"       <td><span class='style15'>Per - Email </span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][13]+"</span></td> ";
    		content=content+"     </tr> ";
    		content=content+"     <tr> ";
    		content=content+"      <td><span class='style15'>Qualification</span></td> ";
    		content=content+"       <td><span class='style12'>"+pdatas[0][15]+"</span></td> ";
    		content=content+"    </tr> ";
			content=content+"     <tr> ";
    		content=content+"      <td><span class='style15'>Previous Details</span></td> ";
    		content=content+"       <td><span class='style12'>"+pdatas[0][16]+"</span></td> ";
    		content=content+"    </tr> ";
    		content=content+"   </table></td> ";
    		
    		
    		
    		
    		content=content+" </tr> ";
			content=content+"  <tr> ";
    		content=content+"    <td colspan='2' align='center'  bgcolor='#0099FF'><h4><font color='#ffffff'> Lets Congratulate & wish ";
    		if("Male".equals(pdatas[0][9].trim()))
    			content=content+" him ";
    		else
    			content=content+" her ";
    		
    		content=content+" success for a good beginning towards the long journey with the team @ "+cpyshortname+".... </font></h4></td> ";
    		content=content+"  </tr> ";
    		content=content+"</table> ";
    		content=content+"<br><br>"; 
    		content=content+"</html> ";
    		bodyMessage = bodyMessage+content;
    		sendEmailWithAttachments(newempid,host, port, mailFrom, password,  to, subject, bodyMessage, attachments);
	
    	
    	}
    	catch(Exception e)
    	{
    		System.out.println(e.getMessage());
    	}
    }
	
	
	//Mail for All employee care with Photo
	public static void sendNewJoinnerInfoMailtoAllEmpwithPhoto(String newempid,String Path,String to)
    {
    	try
    	{
    		
    		String ssql =" SELECT  a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,b.CHR_COMPANYNAME,c.CHR_BRANCHNAME, d.CHR_DEPARTNAME,e.CHR_DESIGNAME,f.CHR_OFFICENAME,DATE_FORMAT(DT_DOB,'%d-%b-%Y'),a.CHR_GENDER,a.CHR_MARITALSTATUS,DATE_FORMAT(a.DT_WEDDATE,'%d-%b-%Y'), a.CHR_EMAILID,a.CHR_PERMAILID ,a.CHR_MOBILE,g.CHR_QUALIFICATIONNAME,a.CHR_PREVIOUSDETAILS,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),if(a.INT_ATTENDANCECYCLE=1,'1-31','20th-19th')   FROM   com_m_staff a ,  com_m_company b,  com_m_branch c,com_m_depart d,com_m_desig e, com_m_office  f,com_m_qualification g WHERE a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID = c.INT_BRANCHID AND a.INT_DEPARTID = d.INT_DEPARTID  AND a.INT_DESIGID = e.INT_DESIGID 	AND a.INT_OFFICEID = f.INT_OFFICEID AND a.CHR_QUALIFICATION = g.INT_QUALIFICATIONID AND a.CHR_EMPID='"+newempid+"' ";
    		String pdatas[][] = CommonFunctions.QueryExecute(ssql);
    		
    		String cpyshortname=CommonFunctions.QueryExecute("SELECT CHR_SHORTNAME FROM M_INSTITUTION WHERE INT_ID=1")[0][0];
 			String hData[][] = CommonFunctions.QueryExecute("SELECT CHR_HOST,CHR_USERID,CHR_PASSWORD,CHR_MAILID FROM  m_mailsetting WHERE INT_MAILID = 1");
    		String host =hData[0][0]   ;
            String password =hData[0][2]   ;
            String mailFrom =hData[0][3]   ;
            String port = "25";  
			String subject =  "****** WELCOME TO THE "+cpyshortname.toUpperCase()+" FAMILY *****" ;  
			String bodyMessage = " ";  
			
			String[] attachments = new String [3];
			attachments[0] =Path+"images/mailbackground.jpg";
			attachments[1] =Path+"uploadfiles/StaffPhoto/"+newempid+".jpg"; 
			attachments[2] =  Path+"images/logo.jpg";
			
			/*
			String[] attachments = new String [4];
			attachments[0] =  Path+"images/logo.jpg";
			attachments[1] =Path+"images/mail_background.jpg";
			attachments[2] =Path+"StaffPhoto/"+newempid+".jpg"; 
			attachments[3] =Path+"images/welcome.jpg";
			*/
			
    		String content ="   ";
    		content=content+"<html> ";
    		content=content+"<head>";
    		content=content+"<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'> ";
    		content=content+"<title>:: SMARTCAMPUS ::</title> ";
    		
    	 
    		content=content+"<style type='text/css'> ";
    		content=content+"<!-- ";
    		content=content+" .style12 { ";
    		content=content+"	FONT-WEIGHT: normal; ";
    		content=content+"	FONT-SIZE: 10px; ";
    		content=content+"	COLOR: #000000; ";
    		content=content+"	LINE-HEIGHT: 15px; ";
    		content=content+"	FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
    		content=content+"	TEXT-DECORATION: none ";
    		content=content+" }	 ";
    		 
    		content=content+" body {";
    		content=content+"       padding:0px;";
    		content=content+"       margin:0px;";
    	 	content=content+"	 background: url('mailbackground.jpg');";
    		content=content+" } ";
    		 
    		
    	   
    		content=content+".style15 {FONT-WEIGHT: bold; FONT-SIZE: 10px; COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; } ";
    		content=content+"--> ";
    		content=content+"</style> ";
    		 
    		
    		content=content+"</head> ";
 
    	 
    		content=content+"<br><br> <table width='800'   bgcolor='#0099FF' border='0'  align='center' cellpadding='2' cellspacing='2'   > ";
    		content=content+"  <tr> ";
    		content=content+"    <td align='center' colspan='2'  valign='middle' > </td> ";
    		content=content+"  </tr> ";
    		
    		content=content+"  <tr> ";
    		content=content+"  <tr  bgcolor='#0099FF'> ";
    		content=content+"    <td colspan='2'  valign='middle' align='center' ><h3> <img name=\"common\" id=\"common\" src=\"logo.jpg\"  />&nbsp;&nbsp;&nbsp;&nbsp;<font color='#ffffff'>DEAR ALL, Lets Welcome a new member in "+cpyshortname+" Family </font></h3></td> ";
    		content=content+"  </tr> ";
    		
    		
    		
    		content=content+"  <tr  bgcolor='#ffffff'  > ";
    		content=content+"    <td  width='75%'><table width='400' border='0' align='center' cellpadding='4' cellspacing='4'> ";
    		content=content+"      <tr> ";
    		content=content+"       <td width='178'><span class='style15'>Emp Id </span></td> ";
    		content=content+"        <td width='222'><span class='style12'>"+pdatas[0][0]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Name</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][1]+"</span></td> ";
    		content=content+"      </tr> ";
    		
    		content=content+"      <tr> ";
    		if("Female".equals(pdatas[0][9]))
    		{
    			if("M".equals(pdatas[0][10]))
    				content=content+"<td><span class='style15'>Spouse Name </span></td> ";
    			else
    				content=content+"<td><span class='style15'>Father Name </span></td> ";
    		}
    		else
    			content=content+"<td><span class='style15'>Father Name </span></td> ";
    		
    		content=content+"        <td><span class='style12'>"+pdatas[0][2]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Company</span></td> ";
    		content=content+"       <td><span class='style12'>"+pdatas[0][3]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"     <tr> ";
    		content=content+"        <td><span class='style15'>Branch</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][4]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"        <td><span class='style15'>Department</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][5]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Designation</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][6]+"</span></td> ";
    		content=content+"      </tr> ";
    		
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Office</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][7]+"</span></td> ";
    		content=content+"      </tr> ";
    		
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Attendance Cycle</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][18]+"</span></td> ";
    		content=content+"      </tr> ";
    		
    		
    		content=content+"      <tr> ";
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Date of Joinning</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][17]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"<td><span class='style15'>Date of Birth </span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][8]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"     <tr> ";
    		content=content+"        <td><span class='style15'>Gender</span></td> ";
    		content=content+"       <td><span class='style12'>"+pdatas[0][9]+"</span></td> ";
    		content=content+"      </tr> ";
    		content=content+"      <tr> ";
    		content=content+"       <td><span class='style15'>Married Status </span></td> ";
    		if("M".equals(pdatas[0][10]))
				content=content+"       <td><span class='style12'>Married</span></td> ";
			else
				content=content+"       <td><span class='style12'>Unmarried</span></td> ";
    		content=content+"     </tr> ";
    		content=content+"      <tr> ";
			if("M".equals(pdatas[0][10]))
			{
    			content=content+"       <td><span class='style15'>Wedding Date </span></td> ";
    			content=content+"       <td><span class='style12'>"+pdatas[0][11]+"</span></td> ";
    			content=content+"      </tr> ";
			}	
    		content=content+"     <tr> ";
    		content=content+"        <td><span class='style15'>Office - Email</span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][12]+"</span></td> ";
    		content=content+"    </tr> ";
    		content=content+"    <tr> ";
    		content=content+"       <td><span class='style15'>Per - Email </span></td> ";
    		content=content+"        <td><span class='style12'>"+pdatas[0][13]+"</span></td> ";
    		content=content+"     </tr> ";
    		content=content+"     <tr> ";
    		content=content+"      <td><span class='style15'>Qualification</span></td> ";
    		content=content+"       <td><span class='style12'>"+pdatas[0][15]+"</span></td> ";
    		content=content+"    </tr> ";
			content=content+"     <tr> ";
    		content=content+"      <td><span class='style15'>Previous Details</span></td> ";
    		content=content+"       <td><span class='style12'>"+pdatas[0][16]+"</span></td> ";
    		content=content+"    </tr> ";
    		content=content+"   </table></td> ";
    		
    		
    		
    		content=content+"   <td width='25%' align='center' valign='middle'><table width='100' border='0' align='center' cellpadding='2' cellspacing='2' bordercolor='#000000' bgcolor='#0066CC'  > ";
    		content=content+"     <tr> ";
    		content=content+"       <td><div align='center'><font color='yellow'><b>PHOTO<b></font></div></td> ";
    		content=content+"     </tr> ";
    		content=content+"     <tr> ";
    		content=content+"      <td ><img name=\"photo\" id=\"photo\" src=\""+newempid+".jpg\"  width='100' height='150' /></td> ";
    		content=content+"     </tr> ";
    		content=content+"    </table></td> ";
    		
    		
    		content=content+" </tr> ";
			content=content+"  <tr> ";
    		content=content+"    <td colspan='2' align='center'  bgcolor='#0099FF'><h4><font color='#ffffff'> Lets Congratulate & wish ";
    		if("Male".equals(pdatas[0][9].trim()))
    			content=content+" him ";
    		else
    			content=content+" her ";
    		
    		content=content+" success for a good beginning towards the long journey with the team @ "+cpyshortname+".... </font></h4></td> ";
    		content=content+"  </tr> ";
    		content=content+"</table> ";
    		content=content+"<br><br>"; 
    		content=content+"</html> ";
    		bodyMessage = bodyMessage+content;
    		
    		sendEmailWithAttachments(newempid,host, port, mailFrom, password,  to, subject, bodyMessage, attachments);
	
    	}
    	catch(Exception e)
    	{
    		System.out.println(""+e.getMessage());
    	}
    }
	
	public static void sendNewJoinnerHelpMail(HttpServletRequest req,String newempid,String Path,String to)
    {
    	try
    	{
    		
    		String cpyshortname= CommonFunctions.QueryExecute("SELECT CHR_SHORTNAME FROM M_INSTITUTION WHERE INT_ID=1")[0][0];
 			String hData[][] =  CommonFunctions.QueryExecute("SELECT CHR_HOST,CHR_USERID,CHR_PASSWORD,CHR_MAILID FROM  m_mailsetting WHERE INT_MAILID = 1");
    		String host =hData[0][0]   ;
            String password =hData[0][2]   ;
            String mailFrom =hData[0][3]   ;
            String port = "25";  
			String subject =  "****** WELCOME TO THE "+cpyshortname.toUpperCase()+" FAMILY *****" ;  
			String bodyMessage = " ";  
			String[] attachments = new String [1];
			attachments[0] = Path+"images/logo.jpg";
			//attachments[1] = Path+"images/SmartHelp.pdf";
			String ssql =" SELECT  a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_STAFFFNAME,b.CHR_COMPANYNAME,c.CHR_BRANCHNAME, d.CHR_DEPARTNAME,e.CHR_DESIGNAME,f.CHR_OFFICENAME,DATE_FORMAT(DT_DOB,'%d-%b-%Y'),a.CHR_GENDER,a.CHR_MARITALSTATUS,DATE_FORMAT(a.DT_WEDDATE,'%d-%b-%Y'), a.CHR_EMAILID,a.CHR_PERMAILID ,a.CHR_MOBILE,g.CHR_QUALIFICATIONNAME,a.CHR_PREVIOUSDETAILS,DATE_FORMAT(a.DT_DOJCOLLEGE,'%d-%b-%Y'),RIGHT( a.CHR_EMPID,6)   FROM   com_m_staff a ,  com_m_company b,  com_m_branch c,com_m_depart d,com_m_desig e, com_m_office  f,com_m_qualification g WHERE a.INT_COMPANYID = b.INT_COMPANYID AND a.INT_BRANCHID = c.INT_BRANCHID AND a.INT_DEPARTID = d.INT_DEPARTID  AND a.INT_DESIGID = e.INT_DESIGID 	AND a.INT_OFFICEID = f.INT_OFFICEID AND a.CHR_QUALIFICATION = g.INT_QUALIFICATIONID AND a.CHR_EMPID='"+newempid+"' ";
    		String pdatas[][] =  CommonFunctions.QueryExecute(ssql);
    		String content ="   ";
    		content=content+"<html> ";
    		content=content+"<head>";
    		content=content+"<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'> ";
    		content=content+"<title>:: SMARTCAMPUS ::</title> ";
    		content=content+"<style type='text/css'> ";
    		content=content+"<!-- ";
    		content=content+" .style12 { ";
    		content=content+"	FONT-WEIGHT: normal; ";
    		content=content+"	FONT-SIZE: 10px; ";
    		content=content+"	COLOR: #000000; ";
    		content=content+"	LINE-HEIGHT: 15px; ";
    		content=content+"	FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; ";
    		content=content+"	TEXT-DECORATION: none ";
    		content=content+"}	 ";
    		content=content+".style15 {FONT-WEIGHT: bold; FONT-SIZE: 10px; COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; } ";
    		content=content+"--> ";
    		content=content+"</style> ";
    		content=content+"</head> ";
    		content=content+"<body  onpaste='return false;'>  ";
    		content=content+"<table width='80%' border='1' align='center' cellpadding='0' cellspacing='0' bordercolor='#0099FF'>  "; 
    		content=content+"<tr>   ";
    		content=content+"<td height='50'  valign='middle'  bgcolor='#0099FF'><font color='#ffffff'>&nbsp;				   </font>  ";
    		content=content+" <table width='64%' border='0' align='center' cellpadding='0' cellspacing='0'>  ";
    		content=content+" <tr>  ";
    		content=content+"<td rowspan='5' align='center' valign='middle'> <img name='common' id='common' src='logo.jpg'  /></td>  ";
    		content=content+"<td><font color='#ffffff'>  ";
    		content=content+"<h3 align='center'>WELCOME TO CARE IT SOLUTIONS PVT LTD. </h3>  ";
    		content=content+" </font></td>  ";
    		content=content+" </tr>  ";
    		content=content+" <tr>  ";
    		content=content+"<td><div align='center'></div></td>  ";
    		content=content+" </tr>  ";
    		content=content+"<tr>  ";
    		content=content+"<td><div align='center'><strong><font color='#ffffff'>No 481, 2nd Floor, Annasalai, </font></strong></div></td>  ";
    		content=content+"</tr>  ";
    		content=content+"<tr>  ";
    		content=content+" <td><div align='center'><strong><font color='#ffffff'>Nandanam, Chennai - 600035. </font></strong></div></td>  ";
    		content=content+"</tr>  ";
    		content=content+"<tr>  ";
    		content=content+"<td><div align='center'><strong><font color='#ffffff'>Phone : +91 - 44 - 24340906 </font></strong></div></td>  ";
    		content=content+" </tr>  ";
    		content=content+" <tr>  ";
    		content=content+" <td colspan='2'>&nbsp;</td>  ";
    		content=content+"</tr>  ";
    		content=content+"<tr>  ";
    		content=content+" <td colspan='2'><div align='center'><strong><font color='#ffffff'>Branches : Chennai | Bangalore | Secunderabad | Madurai | Trichy | Pondicherry </font></strong></div></td>  ";
    		content=content+"</tr>  ";
    		content=content+"<tr>  ";
    		content=content+"<td>&nbsp;</td>  ";
    		content=content+"<td>&nbsp;</td>  ";
    		content=content+" </tr>  ";
    		content=content+"</table>  ";
    		content=content+"</td>   ";
    		content=content+"</tr>   ";
    		content=content+"<tr>   ";
    		content=content+"<td><table width='80%' border='0' align='center' cellpadding='4' cellspacing='4'>  ";
    		content=content+"<tr>  ";
    		content=content+"<td>&nbsp;</td>  ";
    		content=content+" </tr>  ";
    		content=content+"<tr>  ";
    		content=content+"<td width='178'>Hi, "+ pdatas[0][1] +"   "+ pdatas[0][2]+" <br>  </td>  ";
    		content=content+"</tr>  ";
    		content=content+"<tr>  ";
    		content=content+"<td   bgcolor='#5cb85c'>Employee ID  :"+ pdatas[0][0]  +" <br>  </td>  ";
    		content=content+"</tr>  ";
    		
    		content=content+"<tr>  ";
    		content=content+"<td>Congratulations! for joinning our "+cpyshortname+" family on "+ pdatas[0][17] +" </td>  ";
    		content=content+"</tr>  ";
    		content=content+"<tr>  ";
    		content=content+" <td>Hope you have step into the next path of your life with "+cpyshortname+".   </td>  ";
    		content=content+" </tr>  ";
    		content=content+"<tr>  ";
    		content=content+" <td>We promise you that all your aspiration would be fullfilled here.</td>  ";
    		content=content+"</tr>  ";
    		content=content+"<tr>  ";
    		content=content+" <td>We would like to share the below details for any of your queries...</td>  ";
    		content=content+"</tr>  ";
    		content=content+"<tr>  ";
    		content=content+" <td>Please open a browser and type the URL&nbsp;<a href='http://connect.careind.net'  style=\"text-decoration:none\" >http://connect.careind.net</a></td>  ";
    		content=content+"</tr>  ";
    		content=content+"<tr>  ";
    		content=content+"<td bgcolor='#5cb85c'>Enter your username [&nbsp;last 6 digits of your employee id   : "+ pdatas[0][18] +" ] and password [ default is care1234]</td>  ";
    		content=content+" </tr>  ";
    		content=content+"<tr>  ";
    		content=content+"<td>You can view  your all inforamtion from our employee portal such as Attendance, Leave, Payslip,conveyance and etc..</td>  ";
    		content=content+" </tr>  ";
    		content=content+"<tr>  ";
    		content=content+" <td>Your original ID card will be issued with in 7 working days from H.O. </td>  ";
    		content=content+"</tr>  ";
    		content=content+" <tr>  ";
    		content=content+"<td>Kindly collect the same from your respective office In case if you are eligible for access card, SIM card, Visiting card kindly contact your reporting manager from approval &amp; further process to the communicated to HR. </td>  ";
    		content=content+"</tr>  ";
    		content=content+"<tr>  ";
    		content=content+"<td>you would like to download the help file   <a target='_blank' href='"+CommonFunctions.getPath(req)+"/DownloadServlet.do?file=Help/SmartStaffHelp.pdf"+"'>download</a></td>  ";
    		content=content+"</tr>  ";
    		content=content+" <tr>  ";
    		content=content+"<td>&nbsp;</td>  ";
    		content=content+"</tr>   ";
    		content=content+"</table></td>  "; 
    		content=content+"</tr>   ";
    		content=content+" <tr>   ";
    		content=content+"<td bgcolor='#0099FF'><h4> <font color='#FFFFFF'><center>If any clarification in <a href='http://connect.careind.net' style=\"text-decoration:none\">http://connect.careind.net</a> then post a mail to <a href='mailto:"+CommonData.mailid+"' style=\"text-decoration:none\">"+CommonData.mailid+".</a><center></font></h4></td>  ";
    		content=content+"</tr>   ";
    		content=content+"</table>   ";
    		content=content+" </body>   ";
    		content=content+" </html>   ";
    		bodyMessage = bodyMessage+content;
    		sendEmailWithAttachments(newempid,host, port, mailFrom, password,  to, subject, bodyMessage, attachments);
	
    	}
     	catch(Exception e)
		{
			
		}
    }
	
	
	
	
	
	
	
	public static void sendEmailWithAttachments(String newempid,String host, String port,  
            final String userName,  final String password, String toAddress,  
            String subject, String message, String[] attachFiles)  
                throws AddressException, MessagingException, IOException 
     {
		try
		{
			 	Properties properties = new Properties();  
		        properties.put("mail.smtp.host", host);  
		        properties.put("mail.smtp.port", port);  
		        properties.put("mail.smtp.auth", "true");  
		        properties.put("mail.smtp.starttls.enable", "true");  
		        properties.put("mail.user", userName);  
		        properties.put("mail.password", password);  
		      
		         
		        Authenticator auth = new Authenticator()
		        {  
		            public PasswordAuthentication getPasswordAuthentication() 
		            {  
		                return new PasswordAuthentication(userName, password);  
		            }  
		        };  
		        
		        Session session = Session.getInstance(properties, auth);  
		      
		        MimeMessage msg = new MimeMessage(session);  
		        msg.setFrom(new InternetAddress(userName));  
		        InternetAddress[] toAddresses = {new InternetAddress(toAddress)};  
		        msg.setRecipients(Message.RecipientType.BCC, toAddresses);  
		        msg.setSubject(subject);  
		        msg.setSentDate(new Date());  
		        MimeBodyPart messageBodyPart = new MimeBodyPart();  
	            messageBodyPart.setContent(message, "text/html");  
	            
	            Multipart multipart = new MimeMultipart();  
	            multipart.addBodyPart(messageBodyPart);       
	          
	            if (attachFiles != null && attachFiles.length > 0) 
	            {  
	                for (String filePath : attachFiles) 
	                {  
	                    MimeBodyPart attachPart = new MimeBodyPart();  
	                    DataSource source = new FileDataSource(filePath);  
	                    attachPart.setDataHandler(new DataHandler(source));  
	                    attachPart.setFileName(new File(filePath).getName());  
	                    multipart.addBodyPart(attachPart);  
	                }  
	            }  
	          
	            msg.setContent(multipart);  
	            Transport.send(msg);  
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	
	
	public static void insertUserRecord(String regid,String officeid,boolean flag, PreparedStatement apstm, Connection con )throws  Exception 
     {
		try
		{ 
			
			if(flag)
			{	
				
				String password =  CommonFunctions.QueryExecute("SELECT CHR_PASSWORD FROM m_institution  WHERE INT_ID=1")[0][0];
				int length = regid.length();
				String s = regid.substring(length-6);

				String sql ="INSERT INTO M_USER (CHR_EMPID,CHR_USRNAME,CHR_USRPWD,CHR_USRDES,CHR_TYPE,DT_UPDATEDATE,CHR_UPDATESTATUS,CHR_MENUHRM,CHR_MENUATTENDANCE,CHR_MENUPAYROL,CHR_MENUMANAGEMENT,CHR_MENUMARKETING,CHR_MENUINVENTORY,CHR_MENUSTOCK,CHR_MENUACCOUNT,CHR_MENUUTILITY,CHR_MENUSTAFF,CHR_OFFICELIST)";
				sql = sql +" VALUES (";
				sql = sql +"? , "; 
				sql = sql +"? , "; 
				sql = sql +"(ENCODE(?,'9865043008'))  , ";
				sql = sql +"? , ";
				sql = sql +"'S' , ";
				sql = sql +"DATE(NOW()) ,'Y' ,'0','0', '0','0','0','0','0','0','0', ";
				sql = sql +"'"+CommonFunctions.returnRootMenuid("SELECT INT_MENUID FROM  m_menu_staff WHERE CHR_MENUDES ='Root'")+"'  ,"; 
				sql = sql +officeid; 
				sql = sql +"  )";
				apstm = con.prepareStatement(sql);
				apstm.setString(1,regid);
				apstm.setString(2,s);
				apstm.setString(3,password);
				apstm.setString(4,regid);
				apstm.execute();

				sql ="INSERT INTO com_m_staffid VALUES(?)";
				apstm = con.prepareStatement(sql);
				apstm.setString(1,s);
				apstm.execute();
				 
			}
			
		}
		catch(Exception e)
		{
			System.out.println("User Registration :"+e.getMessage());
		}
	}
	
	
	
	public static void insertStaffLeave(String regid, PreparedStatement apstm, Connection con,String auserid )throws  Exception 
    {
		try
		{ 
				String leavedata1[][] = CommonFunctions.RecordSetArray(con,"select  CHR_SYMBOL,INT_BELOWONEYEAR,INT_ABOVEONEYEAR  from  att_m_leavetype order by INT_LEAVEID");
				if(leavedata1.length>1)
				{
					String sql = " INSERT INTO att_m_leave (CHR_EMPID,INT_YEAR,";
					for(int u=0; u<leavedata1.length;u++)
						sql = sql +" CHR_LEAVE"+(u+1)+",INT_NOD"+(u+1)+",INT_NOD"+(u+1)+"BALANCE,";
					sql = sql +" CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ) ";
					
					sql = sql +" VALUES ( ?,YEAR(NOW()), ";
					for(int u=0; u<leavedata1.length;u++)
						sql = sql +" '"+leavedata1[u][0]+"' ,0,0, ";
					sql = sql + "?,DATE(NOW()),'Y' )";
					System.out.println(sql);
					apstm = con.prepareStatement(sql);
					apstm.setString(1,regid);
					apstm.setString(2,auserid);
					apstm.execute();
				}
				 
 
		}
		catch(Exception e)
		{
			System.out.println("Leave Insertion "+e.getMessage());
		}
	}
	
	
}
