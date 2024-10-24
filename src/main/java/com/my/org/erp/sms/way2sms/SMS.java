package com.my.org.erp.sms.way2sms;

import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SMS {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		 
		
		String username = "9176997605";
		String password = "gohila123";
		String smtphost = "site3.way2sms.com";
		 
		String from = "9176997605@site3.way2sms.com";
		String to = "9629314396@site3.way2sms.com";
		String body = "Hello SMS World!";
		Transport myTransport = null;
		try 
		{
			Properties props = System.getProperties();
			props.put("mail.smtp.auth", "true");
			Session mailSession = Session.getDefaultInstance(props, null);
			Message msg = new MimeMessage(mailSession);
			msg.setFrom(new InternetAddress(from));
			InternetAddress[] address = {new InternetAddress(to)};
			msg.setRecipients(Message.RecipientType.TO, address);
			 
			msg.setText(body);
			msg.setSentDate(new Date());
			 
			myTransport = mailSession.getTransport("smtp");
			myTransport.connect(smtphost, username, password);
			msg.saveChanges();
			myTransport.sendMessage(msg, msg.getAllRecipients());
			myTransport.close();
			System.out.println("sent");
		} 
		catch (Exception e) 
		{
			 System.out.println(e.getMessage());
		}
	}

}
