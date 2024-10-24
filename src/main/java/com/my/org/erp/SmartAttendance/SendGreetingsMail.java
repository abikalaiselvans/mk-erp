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
 
 

public class SendGreetingsMail extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	String readData[][];
	
	

	public static void sendMailtoPerson(String to, String subject)
    {
    	try
    	{
    			
    		String s= "";
    		s=s+" <html> ";
    		s=s+"<head>";
    		s=s+"<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>";
    		s=s+"<title>:: Care IT Solutions Pvt Ltd ::</title>";
    		s=s+"</head>  ";
    		s=s+"<body  onpaste='return false;'> ";
    		s=s+"<div align='center'>  ";
    		s=s+"<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >  ";
    		
    		s=s+"<tr bgcolor='#FFFFFF'>";
    		s=s+"<td><div align='center'>To protect your privacy,  Mail has blocked remote images in this message.<a href=\"http://192.168.0.26/SmartCampus/flyer/flyer.html\" target='_blank'> Show Images</a> </div></td>";
    		s=s+"</tr>";
    	    
    		s=s+" <tr bgcolor='#FFFFFF'> ";
    		s=s+"<td><div align='center'><img width='788' height='998' src='http://192.168.0.26/SmartCampus/flyer/clip_image001.jpg' border='0'></div></td>  ";
    		s=s+"  </tr> ";
    		s=s+"  </table> ";
    		s=s+"</div> ";
    		s=s+"</body>";
    		s=s+"</html>";
    		Properties props = new Properties();
  	        props.setProperty("mail.transport.protocol", "smtp");
  	        props.setProperty("mail.host", "192.168.0.5");
  	        props.setProperty("mail.user", "connect");
  	        props.setProperty("mail.password", "connect");

  	        Session mailSession = Session.getDefaultInstance(props, null);
  	        mailSession.setDebug(true);
  	        Transport transport = mailSession.getTransport();

  	        MimeMessage message = new MimeMessage(mailSession);
  	        message.setSubject(subject);
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
    		
    		SimpleMail( CommonData.mailid, CommonData.mailid,to+"-Receipient not available","");
    		mex.printStackTrace();
    		 
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
