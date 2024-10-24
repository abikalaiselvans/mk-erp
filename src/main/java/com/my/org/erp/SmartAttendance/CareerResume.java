package com.my.org.erp.SmartAttendance;


import java.util.Date;
import java.util.Properties;


import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;

import javax.mail.internet.MimeMessage;

import javax.servlet.http.HttpServlet;

import com.my.org.erp.setting.CommonData;


public class CareerResume extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	String readData[][];
	
	

	public static void sendMailtoPerson(String to, String subject,String id)
    {
    	try
    	{
    		
    		String s= "";
    		@SuppressWarnings("unused")
			String refid= "CARE/"+id+"/"+com.my.org.erp.common.CommonFunctions.AccountYear();
    		
    		s=s+" <!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'> ";
    		s=s+" <html xmlns='http://www.w3.org/1999/xhtml'> ";
    		s=s+" <head> ";
    		s=s+" <meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1' /> ";
    		s=s+" <title>CARE</title> ";
    		s=s+" <style type='text/css'> ";
    		s=s+" <!-- ";
    		s=s+" .style1 { ";
    		s=s+" 	font-family: Verdana, Arial, Helvetica, sans-serif; ";
    		s=s+" 	font-size: 10px; ";
    		s=s+" 	font-weight: bold; ";
    		s=s+" } ";
    		s=s+" .style2 { ";
    		s=s+" 	font-family: Verdana, Arial, Helvetica, sans-serif; ";
    		s=s+" 	font-size: 9px; ";
    		s=s+" } ";
    		s=s+" .style3 { ";
    		s=s+" 	font-size: 18; ";
    		s=s+" 	color: #FF0000; ";
    		s=s+" } ";
    		s=s+" .style4 {color: #FFFFFF} ";
    		s=s+" --> ";
    		s=s+" </style> ";
    		 s=s+"  ";
    		s=s+" </head> ";
    		s=s+" <body  onpaste='return false;'> ";
    		s=s+" <p>&nbsp;</p> ";
    		s=s+" <p>&nbsp;</p> ";
    		s=s+" <table width='66%' height='150' border='1' align='center' cellpadding='2' cellspacing='0' bordercolor='#0033FF'> ";
    		 s=s+"  <tr> ";
    		s=s+"     <td width='100%' height='19' bgcolor='#0099FF'> <div align='center' class='style1'> ";
    		s=s+"       <h1>CARE </h1> ";
    		 s=s+"    </div></td> ";
    		 s=s+"  </tr> ";
    		s=s+"   <tr bgcolor='#996600'> ";
    		s=s+"     <td bgcolor='#FFFFFF'><p align='justify' class='style2 style3'><span class='style2'>Your personal informations has been sent to our HR Team .  ";
    		s=s+" Our team will contact you for further details.This is your reference number :"+id+" Thank you.</span></p> ";
    		s=s+"       <p align='justify' class='style2 style3'><span class='style4'> If</span><span class='bolddeepred'> you have any queries please mail to ";
    		s=s+"  hr@careind.net or call us at 044-24340906 Extn 26.</span></p> ";
    		s=s+" <p align='justify' class='bolddeepred'><a href='Login.jsp'></a></p></td> ";
    		s=s+"   </tr> ";
    		s=s+" </table> ";
    		s=s+" </body> ";
    		s=s+" </html> ";


    		Properties props = new Properties();
  	        props.setProperty("mail.transport.protocol", "smtp");
  	        props.setProperty("mail.host", "192.168.0.27");
  	        props.setProperty("mail.user", "connect");
  	        props.setProperty("mail.password", "connect");

  	        Session mailSession = Session.getDefaultInstance(props, null);
  	        mailSession.setDebug(true);
  	        Transport transport = mailSession.getTransport();

  	        MimeMessage message = new MimeMessage(mailSession);
  	        message.setSubject("Resume");
  	        message.setFrom(new InternetAddress(""+CommonData.mailid));
  	        message.setContent(s, "text/html");
  	        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
  	        transport.connect();
  	        transport.sendMessage(message, message.getRecipients(Message.RecipientType.TO));
  	        transport.close();
  	        System.out.println(to+" mail has been sent ");
    	      
    	}
    	catch (MessagingException mex) 
    	{
    		mex.printStackTrace();
    		 
    	}
    }
	
	
	public static void sendMailtoHr(String to, String subject,String id)
    {
    	try
    	{
    		
    		String s= "";
    		@SuppressWarnings("unused")
			String refid= "CARE/"+id+"/"+com.my.org.erp.common.CommonFunctions.AccountYear();
    		String content =" <style type='text/css'> ";
    		content=content+"<!-- ";
    		content=content+".style1 { ";
    		content=content+"	font-family: Verdana, Arial, Helvetica, sans-serif; ";
    		content=content+"font-size: 10px; ";
    		content=content+"font-weight: bold; ";
    		content=content+"} ";
    		content=content+".style2 { ";
    		content=content+"font-family: Verdana, Arial, Helvetica, sans-serif; ";
    		content=content+"font-size: 9px; ";
    		content=content+"} ";
    		content=content+"--> ";
    		content=content+"</style> ";
    		content=content+"</head> ";

    		content=content+"<body  onpaste='return false;'><br><br> ";
    		content=content+"<table align=center width='100%' border='1' cellpadding='2' cellspacing='2' bordercolor='#0033FF'> ";
    		content=content+"<tr> ";
    		content=content+"<td width='100%' bgcolor='#0099FF'> <div align='center' class='style1'><h1>CARE</h1> </div></td> ";
    		content=content+"</tr> ";
    		content=content+"<tr bgcolor='#CCCCCC'> ";
    		String sql ="SELECT CHR_NAME,CHR_FATHERNAME,CHR_APPLIEDPOST FROM com_m_careers WHERE INT_CAREERID="+id;
    		String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		content=content+"<td bgcolor='#CCCCCC' height=100><p class='style2'><h3> "+data[0][0]+" "+data[0][1]+" Uploaded the Resume. His/Her Reference Number :<b>"+id+"</b>  Thank you. </h3></p>    </td> ";
    		content=content+"</tr> ";
    		content=content+"</table> ";
    		content=content+"</body> ";
    		s =content;
    		
    		Properties props = new Properties();
  	        props.setProperty("mail.transport.protocol", "smtp");
  	        props.setProperty("mail.host", "192.168.0.5");
  	        props.setProperty("mail.user", "connect");
  	        props.setProperty("mail.password", "connect");

  	        Session mailSession = Session.getDefaultInstance(props, null);
  	        mailSession.setDebug(true);
  	        Transport transport = mailSession.getTransport();

  	        MimeMessage message = new MimeMessage(mailSession);
  	        message.setSubject("Resume");
  	        message.setFrom(new InternetAddress(""+CommonData.mailid));
  	        message.setContent(s, "text/html");
  	        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
  	        transport.connect();
  	        transport.sendMessage(message, message.getRecipients(Message.RecipientType.TO));
  	        transport.close();
  	        System.out.println(to+" mail has been sent ");
    	      
    	}
    	catch (MessagingException mex) 
    	{
    		 
    		
    	}
    }

	 
	public static void SimpleMail(String from , String to, String subject,String content)
    {
    	try
    	{
	        String host = "192.168.0.5";
	        Properties props = new Properties();
	        props.put("mail.smtp.host", host);
	        props.put("mail.debug", "true");
	        Session sessio  = Session.getInstance(props);
	        Message msg = new MimeMessage(sessio );
	        msg.setFrom(new InternetAddress(from));
	        InternetAddress[] address = {new InternetAddress(to)};
	        msg.setRecipients(Message.RecipientType.TO, address);
	        msg.setSubject(subject);
	        msg.setSentDate(new Date());
	   	 	msg.setText(content);
	   	 	Transport.send(msg);
	   	 	System.out.println("Mail has been sent..");
    	}
    	catch(Exception e)
    	{
    		
    	}
    }  

     


}
