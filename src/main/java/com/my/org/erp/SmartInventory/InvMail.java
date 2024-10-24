package com.my.org.erp.SmartInventory;

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

public class InvMail {

	public static void sendEmailWithAttachments(    
              String recipients[],  
            String subject, String message, String[] attachFiles)  
                throws AddressException, MessagingException, IOException 
     {
		try
		{
			String hData[][] =  CommonFunctions.QueryExecute("SELECT CHR_HOST,CHR_USERID,CHR_PASSWORD,CHR_MAILID FROM  m_mailsetting WHERE INT_MAILID = 1");
		    String host =hData[0][0]   ;
            String userName =hData[0][1]   ;
            String password =hData[0][2]   ;
            String from =hData[0][3]   ;
            String toAddress ="";
            for(int i = 0; i < recipients.length; i++) {
            	if(recipients[i].length()>0)
            		toAddress = toAddress+ recipients[i] + ",";
            }
            System.out.println("*********************************"+toAddress+"****************************");
			 	Properties properties = new Properties();  
		        properties.put("mail.smtp.host", host);  
		        properties.put("mail.smtp.port", "465");  
		        properties.put("mail.smtp.auth", "true");  
		        properties.put("mail.smtp.starttls.enable", "true");  
		        properties.put("mail.user", userName);  
		        properties.put("mail.password", password);  
		        
		    	properties.put("mail.smtp.host", host);
				properties.put("mail.smtp.socketFactory.port", "465");
				properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
				properties.put("mail.smtp.auth", "true");
				properties.put("mail.smtp.port", "465");
				
		      
		         
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
		        
		        
		        InternetAddress[] recipientAddress = new InternetAddress[recipients.length];
		        int counter = 0;
		        for (String recipient : recipients) {
		            recipientAddress[counter] = new InternetAddress(recipient.trim());
		            counter++;
		        }
		        msg.setRecipients(Message.RecipientType.TO, recipientAddress);  
		        
		        
		        
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
	                    //System.out.println("========????"+new File(filePath).getName());
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
	
	
	public static void invoiceSendtoMails(String recipients[], String subject,
			String content) {
		try {

			String hData[][] =  CommonFunctions.QueryExecute("SELECT CHR_HOST,CHR_USERID,CHR_PASSWORD,CHR_MAILID FROM  m_mailsetting WHERE INT_MAILID = 1");
		    String host =hData[0][0]   ;
            String user =hData[0][1]   ;
            String password =hData[0][2]   ;
            String from =hData[0][3]   ;
            String to ="";
            for(int i = 0; i < recipients.length; i++) {
               to = to+ recipients[i] + ",";
            }
			// Recipient's email ID needs to be mentioned.
			// Sender's email ID needs to be mentioned
			//String from = "abikalaiselvan@gmail.com";
			// Assuming you are sending email from through gmails smtp
			//String host = "127.0.0.1";
			// Get system properties
			Properties properties = System.getProperties();
			// Setup mail server
			/*properties.put("mail.smtp.host", host);
			properties.put("mail.smtp.port", "25");
			properties.put("mail.smtp.socketFactory.port", 25);
			properties.put("mail.smtp.ssl.enable", true);
			properties.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
			properties.put("mail.smtp.auth", true);
			*/
			properties.put("mail.smtp.host", host);
			properties.put("mail.smtp.socketFactory.port", "465");
			properties.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
			properties.put("mail.smtp.auth", "true");
			properties.put("mail.smtp.port", "465");
			
			// Get the Session object.// and pass username and password
			Session session = Session.getInstance(properties,
					new javax.mail.Authenticator() {
						protected PasswordAuthentication getPasswordAuthentication() {
							return new PasswordAuthentication(
									user, password);
						}
					});
			// Used to debug SMTP issues
			session.setDebug(true);

			try {
				// Create a default MimeMessage object.
				MimeMessage message = new MimeMessage(session);
				// Set From: header field of the header.
				message.setFrom(new InternetAddress(from));
				// Set To: header field of the header.
				message.addRecipient(Message.RecipientType.TO,
						new InternetAddress(to));
				// Set Subject: header field
				message.setSubject(subject);
				// Now set the actual message
				//message.setText(content);
				message.setContent(content, "text/html");
				System.out.println("sending...");
				// Send message
				Transport.send(message);
				System.out.println("Sent message successfully....");
			} catch (MessagingException mex) {
				mex.printStackTrace();
			}
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}

	}
	
	
}
