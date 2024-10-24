package com.my.org.erp.SmartUtility;


import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;

import javax.mail.internet.MimeMessage;


import javax.servlet.http.HttpServlet;

import java.io.*;


public class SendGreetingsMail extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	String readData[][];
	
	public static void readEemailIds(String groupid,String from)
    {
    	try
    	{
    		String sql="SELECT CHR_CUSTOMERNAME,CHR_COMPANYNAME,CHR_EMAIL,DATE(NOW()) FROM  email_m_customerinfo WHERE INT_CUSTOMERID>=1";
    		if(!"0".equals(groupid))
    			sql = sql + " AND INT_GROUPID="+groupid;
    		String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
    		com.my.org.erp.common.CommonFunctions.Execute("UPDATE email_m_setting SET CHR_MAILSENDFLAG='Y'");
    		if(data.length>0)
    		{
    			for(int u=0;u<data.length;u++)
    			{
    				if(!"-".equals(data[u][2]))
    				{
    					sendMailtoPerson(from,data[u][2], data[u][0]+ " / "+data[u][1]+ " /  Technical News Letter",data[u][3]);
    				}
    			}
    		}
    	}
    	catch( Exception e)
    	{
    		
    	}
    }
	
	
	public static void sendMailtoPerson(String from,String to, String subject,String filename)
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
    		s=s+"<td><div align='center'><img width='788' height='998' src='http://192.168.0.26/SmartCampus/flyer/"+filename+".jpg' border='0'></div></td>  ";
    		s=s+"  </tr> ";
    		s=s+"  </table> ";
    		s=s+"</div> ";
    		s=s+"</body>";
    		s=s+"</html>";
    		Properties props = new Properties();
  	        props.setProperty("mail.transport.protocol", "smtp");
  	        props.setProperty("mail.host", "192.168.0.5");
  	        props.setProperty("mail.user", from);
  	        props.setProperty("mail.password", from);

  	        Session mailSession = Session.getDefaultInstance(props, null);
  	        mailSession.setDebug(true);
  	        Transport transport = mailSession.getTransport();

  	        MimeMessage message = new MimeMessage(mailSession);
  	        message.setSubject(subject);
  	        message.setFrom(new InternetAddress(from));
  	        message.setContent(s, "text/html");
  	        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
  	        transport.connect();
  	        transport.sendMessage(message, message.getRecipients(Message.RecipientType.TO));
  	        transport.close();
  	        System.out.println(to+" mail has been sent ");
    	      
    	}
    	catch (MessagingException mex) 
    	{
    		
    		//NAGARAJAN S [snr@careind.net] SimpleMail(from,from,to+"-Receipient not available","");
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
	
	 

	public static void sendMailtoPersonFromhtmlFile(String from,String to, String subject,String filename)
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
    		s=s+"<td><div align='center'><img width='788' height='998' src='http://192.168.0.26/SmartCampus/flyer/"+filename+".jpg' border='0'></div></td>  ";
    		s=s+"  </tr> ";
    		s=s+"  </table> ";
    		s=s+"</div> ";
    		s=s+"</body>";
    		s=s+"</html>";
    		Properties props = new Properties();
  	        props.setProperty("mail.transport.protocol", "smtp");
  	        props.setProperty("mail.host", "192.168.0.5");
  	        props.setProperty("mail.user", from);
  	        props.setProperty("mail.password", from);

  	        Session mailSession = Session.getDefaultInstance(props, null);
  	        mailSession.setDebug(true);
  	        Transport transport = mailSession.getTransport();

  	        MimeMessage message = new MimeMessage(mailSession);
  	        message.setSubject(subject);
  	        message.setFrom(new InternetAddress(from));
  	        message.setContent(s, "text/html");
  	        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
  	        transport.connect();
  	        transport.sendMessage(message, message.getRecipients(Message.RecipientType.TO));
  	        transport.close();
  	        System.out.println(to+" mail has been sent ");
    	      
    	}
    	catch (MessagingException mex) 
    	{
    		
    		//NAGARAJAN S [snr@careind.net] SimpleMail(from,from,to+"-Receipient not available","");
    		mex.printStackTrace();
    		 
    	}
    }


	
	
	//Read HTML file to content
	public static String  readTextFromhtmlFile(String filename)
    {
    	String text=null;
		try
    	{
    		FileReader fr = new FileReader("../webapps/SmartCampus/flyer/"+filename);
    		BufferedReader br = new BufferedReader(fr);
    		String s=null;
    		text="";
    		while((s=br.readLine())!=null)
    		{
    			text = text+s;
    		}
    		br.close();
    		fr.close();
    		return text;
    	}
    	catch (Exception mex) 
    	{
    		
    		//NAGARAJAN S [snr@careind.net] SimpleMail(from,from,to+"-Receipient not available","");
    		mex.printStackTrace();
    		 
    	}
    	return null;
    }


	public static void sendHTMLMail(String from,String to, String subject,String content)
    {
    	try
    	{
    			
    		Properties props = new Properties();
  	        props.setProperty("mail.transport.protocol", "smtp");
  	        props.setProperty("mail.host", "192.168.0.5");
  	        props.setProperty("mail.user", from);
  	        props.setProperty("mail.password", from);
  	        Session mailSession = Session.getDefaultInstance(props, null);
  	        mailSession.setDebug(true);
  	        Transport transport = mailSession.getTransport();
  	        MimeMessage message = new MimeMessage(mailSession);
  	        message.setSubject(subject);
  	        message.setFrom(new InternetAddress(from));
  	        message.setContent(content, "text/html");
  	        message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
  	        transport.connect();
  	        transport.sendMessage(message, message.getRecipients(Message.RecipientType.TO));
  	        transport.close();
  	          
    	}
    	catch (MessagingException mex) 
    	{
    		mex.printStackTrace();
    		 
    	}
    }

	
	
}
