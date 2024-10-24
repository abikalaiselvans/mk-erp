package com.my.org.erp.mail;
import java.util.Date;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import com.my.org.erp.setting.CommonData;

public class EmailAttachmentDemo 
{
	public static void main(String[] args) 
	{
		EmailAttachmentDemo demo = new EmailAttachmentDemo();
		demo.sendEmail();
	}

	public void sendEmail() 
	{
		String from = ""+CommonData.mailid;
		String to = "prr@careind.net";
		String subject = "Important Message";
		String bodyText = "This is a important message with attachment";
		String filename = "c:/103.doc";
		
		Properties props = new Properties();
		props.setProperty("mail.transport.protocol", "smtp");
		props.setProperty("mail.host", "192.168.0.5");
		props.setProperty("mail.user", "connect");
		props.setProperty("mail.password", "connect");
		Session session = Session.getDefaultInstance(props, null);
 
		try 
		{
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(from));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
			message.setSubject(subject);
			message.setSentDate(new Date());
			//
			// Set the email message text.
			//
			MimeBodyPart messagePart = new MimeBodyPart();
			messagePart.setText(bodyText);
			
			//
			// Set the email attachment file
			//
			MimeBodyPart attachmentPart = new MimeBodyPart();
			FileDataSource fileDataSource = new FileDataSource(filename) 
			{
				@Override
				public String getContentType() {
				return "application/octet-stream";
			}
		};

		attachmentPart.setDataHandler(new DataHandler(fileDataSource));
		attachmentPart.setFileName(filename);
		Multipart multipart = new MimeMultipart();
		multipart.addBodyPart(messagePart);
		multipart.addBodyPart(attachmentPart);
		 
		message.setContent(multipart);
		Transport.send(message);
		
		} 
		catch (MessagingException e) 
		{
			 System.out.println(e.getMessage());
		}
}
}