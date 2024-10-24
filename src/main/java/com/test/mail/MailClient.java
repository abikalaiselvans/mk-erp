package com.test.mail;

import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

import com.my.org.erp.setting.CommonData;

import java.io.*;
import java.util.Properties;
public class MailClient
{
	public void sendMail(String mailServer, String from, String to,
				String subject, String messageBody,
							String[] attachments) throws MessagingException, AddressException
{
		Properties props = System.getProperties();
		props.put("mail.smtp.host", mailServer);
		Session session = Session.getDefaultInstance(props, null);
		Message message = new MimeMessage(session);
		message.setFrom(new InternetAddress(from));
		message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
		message.setSubject(subject);
		BodyPart messageBodyPart = new MimeBodyPart();
		messageBodyPart.setContent(messageBody, "text/html");
		Multipart multipart = new MimeMultipart();
		multipart.addBodyPart(messageBodyPart);
		addAtachments(attachments, multipart);
		message.setContent(multipart);
		Transport.send(message);
}
	
protected void addAtachments(String[] attachments, Multipart multipart)throws MessagingException, AddressException
{
	for(int i = 0; i<= attachments.length -1; i++ )
	{
		String filename = attachments[i];
		MimeBodyPart attachmentBodyPart = new MimeBodyPart();
		DataSource source = new FileDataSource(filename);
		attachmentBodyPart.setDataHandler(new DataHandler(source));
		attachmentBodyPart.setFileName(filename);
		multipart.addBodyPart(attachmentBodyPart);
	}
}

	public static void main(String[] args)
	{
		try
		{
			MailClient client = new MailClient();
			String server="192.168.0.5";
			String from=""+CommonData.mailid;
			String to = ""+CommonData.mailid;
			String subject="Test";
			String message="<h1>Testing</h1>";
			String[] filenames ={"D:/sa/5.jpg,D:/sa/5.jpg"};
			client.sendMail(server,from,to,subject,message,filenames);
		}
		catch(Exception e)
		{
			e.printStackTrace(System.out);
		}
	}
}