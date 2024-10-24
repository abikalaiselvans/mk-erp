package com.test.mail;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import com.my.org.erp.setting.CommonData;

public class MailWithPasswordAuthentication 
{
	public static void main(String[] args) throws MessagingException 
	{
		new MailWithPasswordAuthentication().run();
	}

	
	private void run() throws MessagingException 
	{
		Message message = new MimeMessage(getSession());
		message.addRecipient(RecipientType.TO, new InternetAddress("abikalaiselvan@gmail.com"));
		message.addFrom(new InternetAddress[] { new InternetAddress("abikalaiselvan@gmail.com") });
		message.setSubject("the subject");
		message.setContent("the body", "text/plain");
		Transport.send(message);
	}

	private Session getSession() 
	{
		Authenticator authenticator = new Authenticator();
		Properties properties = new Properties();
		properties.setProperty("mail.smtp.submitter", authenticator.getPasswordAuthentication().getUserName());
		properties.setProperty("mail.smtp.auth", "true");
		properties.setProperty("mail.smtp.host", "cams.careind.net");
		properties.setProperty("mail.smtp.starttls.enable", "true");  
        properties.setProperty("mail.smtp.port", "25");
		return Session.getInstance(properties, authenticator);
	}

	private class Authenticator extends javax.mail.Authenticator 
	{
		private PasswordAuthentication authentication;
		public Authenticator() 
		{
			String username = ""+CommonData.mailid;
			String password = "connect";
			authentication = new PasswordAuthentication(username, password);
		}

		protected PasswordAuthentication getPasswordAuthentication() 
		{
			return authentication;
		}
	}
}