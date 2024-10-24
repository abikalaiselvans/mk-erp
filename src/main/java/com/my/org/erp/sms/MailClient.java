package com.my.org.erp.sms;

import javax.mail.*;
import javax.mail.internet.*;

import java.security.Security;
import java.util.Properties;
public class MailClient
{


	public void sendMail(String from, String to, String subject, String messageBody) throws MessagingException, AddressException
	{
		
		
		//Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
		Properties props = new Properties();
		props.setProperty("mail.transport.protocol", "smtp");
		props.setProperty("mail.host", "smtp.gmail.com");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");
		props.put("mail.debug", "true");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.socketFactory.fallback", "false");

		Session session = Session.getDefaultInstance(props,new javax.mail.Authenticator() {

			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("abikalaiselvan",
						"abiaarthi");
			}
		});
		session.setDebug(true);
		
	 
		// Define a new mail message
		MimeMessage message = new MimeMessage(session);
		message.setFrom(new InternetAddress(from));
		message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
		message.setSubject(subject);

		message.setText(messageBody);

		// Send the message
		Transport t = session.getTransport("smtps");
		try 
		{
			t.connect( );
			t.sendMessage(message, message.getAllRecipients());
		} 
		finally 
		{
			t.close();
		}

}

	
public static void main(String[] args)
{
	try
	{
		MailClient client = new MailClient();
		String from="abikalaiselvan@gmail.com";
		String to = "abikalaiselvan@gmail.com";
		String subject="Test";
		String message="I'm testing. Do you see this?";
		client.sendMail(from,to,subject,message);
	}
	catch(Exception e)
	{	
		e.printStackTrace(System.out);
	}
}

}
 