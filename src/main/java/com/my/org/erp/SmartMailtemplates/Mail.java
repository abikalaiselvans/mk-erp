package com.my.org.erp.SmartMailtemplates;

import java.io.File;
import java.io.IOException;
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

import com.my.org.erp.common.CommonFunction;
import com.my.org.erp.common.CommonFunctions;

public class Mail 
{
	public static void sendtoMail( String recipients[] ,String subject,String content)
    {
    	try
    	{
    		boolean debug = false;
    		String hData[][] =  CommonFunctions.QueryExecute("SELECT CHR_HOST,CHR_USERID,CHR_PASSWORD,CHR_MAILID FROM  m_mailsetting WHERE INT_MAILID = 1");
		    String host =hData[0][0]   ;
            String user =hData[0][1]   ;
            String password =hData[0][2]   ;
            String from =hData[0][3]   ;
             
            Properties props = new Properties();
  	        props.setProperty("mail.transport.protocol", "smtp");
  	        props.setProperty("mail.host", ""+host);
	        props.setProperty("mail.user", ""+user);
  	        props.setProperty("mail.password", ""+password);
  	        
  	        Session session = Session.getDefaultInstance(props, null);
  	        session.setDebug(debug); 
  	        Message msg = new MimeMessage(session);
  	        InternetAddress addressFrom = new InternetAddress(from);
  	        msg.setFrom(addressFrom);
  	        
            InternetAddress[] addressTo = new InternetAddress[recipients.length]; 
  	        for (int i = 0; i < recipients.length; i++)
  	    	   addressTo[i] = new InternetAddress(recipients[i]);
  	        msg.setRecipients(Message.RecipientType.BCC, addressTo);
  	        msg.addHeader("MyHeaderName", "myHeaderValue");
  	        msg.setSubject(subject);
  	        msg.setContent(content, "text/html");
  	        Transport.send(msg);
    	}
    	catch(Exception e)
    	{
    		 System.out.println(e.getMessage()); 
    	}
    }
	
	
	public static void sendEmailWithAttachments( String recipients[] ,String subject,String message, String[] attachFiles)  
                throws AddressException, MessagingException, IOException 
     {
		try
		{
			boolean debug = false;
			
			String hData[][] =  CommonFunctions.QueryExecute("SELECT CHR_HOST,CHR_USERID,CHR_PASSWORD,CHR_MAILID FROM  m_mailsetting WHERE INT_MAILID = 1");
		    String host =hData[0][0]   ;
            String user =hData[0][1]   ;
            String password =hData[0][2]   ;
            String from =hData[0][3]   ;
             
            Properties props = new Properties();
  	        props.setProperty("mail.transport.protocol", "smtp");
  	        props.setProperty("mail.host", ""+host);
	        props.setProperty("mail.user", ""+user);
  	        props.setProperty("mail.password", ""+password);
  	        
  	        Session session = Session.getDefaultInstance(props, null);
  	        session.setDebug(debug); 
  	        Message msg = new MimeMessage(session);
  	        InternetAddress addressFrom = new InternetAddress(from);
  	        msg.setFrom(addressFrom);
  	        
            InternetAddress[] addressTo = new InternetAddress[recipients.length]; 
  	        for (int i = 0; i < recipients.length; i++)
  	    	   addressTo[i] = new InternetAddress(recipients[i]);
  	     
  	      msg.setRecipients(Message.RecipientType.BCC, addressTo);
	      msg.addHeader("MyHeaderName", "myHeaderValue");
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
          System.out.println("Mail has been sent...");
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	
}
