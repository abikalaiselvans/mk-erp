package com.my.org.erp.mail;

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

import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.setting.CommonData;

public class GMail {

	
	public static void main(String[] args) 
	{
		
		try 
		{
			//String hData[][] =  CommonFunctions.QueryExecute("SELECT CHR_HOST,CHR_USERID,CHR_PASSWORD,CHR_MAILID FROM  m_mailsetting WHERE INT_MAILID = 1");
			String host ="smtp.gmail.com"  ;//0
			String password ="abiaarthi";//"abikalaiselvan";2
			String mailFrom ="abikalaiselvan@gmail.com"   ;//3
			String to = ""+CommonData.mailid;
			String port = "25";  
			String subject =  "Testing purpose" ;  
			String bodyMessage = " ";  
			String[] attachments = null;
			/*	new String [1];
			attachments[0] ="c:/NF2202444894940.pdf";*/
			String content =" <h1> WELCOME TO JAVA </h1>  ";
			bodyMessage = bodyMessage+content;
			sendEmailWithAttachments(host, port, mailFrom, password,  to, subject, bodyMessage, attachments);
		} 
		catch(Exception e) 
		{
			System.out.println(e.getMessage());
		}

	}
	
	
	
	
	public static void sendEmailWithAttachments(String host, String port,  
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
	        properties.put("mail.debug", "true");
			properties.put("mail.smtp.socketFactory.port", "465");
			properties.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
			properties.put("mail.smtp.socketFactory.fallback", "false");
			
	         
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

}
