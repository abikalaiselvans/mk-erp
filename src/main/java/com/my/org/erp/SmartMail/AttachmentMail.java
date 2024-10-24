package com.my.org.erp.SmartMail;

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

public class AttachmentMail 
{

	public static void sendEmailWithAttachments( String host, String port,  
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
	            System.out.println("mail has been sent...");
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	
}
