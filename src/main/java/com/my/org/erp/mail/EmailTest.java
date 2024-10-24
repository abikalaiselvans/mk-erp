package com.my.org.erp.mail;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.my.org.erp.setting.CommonData;

public class EmailTest {

	public static void main(String[] args) {
 
		    //Creating a result for getting status that messsage is delivered or not!
		    String result;
		    // Get recipient's email-ID, message & subject-line from index.html page
		    final String to = "abikalaiselvan@gmail.com";
		    final String subject = "sub";
		    final String messg = "mess";
		 
		    // Sender's email ID and password needs to be mentioned
		    final String from = "abikalaiselvan@gmail.com";
		    final String pass = "K@21kalai";
		 
		 
		    // Defining the gmail host
		    String host = "smtp.gmail.com";
		 
		    // Creating Properties object
		    Properties props = new Properties();
		 
		    // Defining properties
		    props.put("mail.user", from);
		    props.put("mail.password", pass);
		    props.put("mail.smtp.host", "smtp.gmail.com");
		   /* props.put("mail.smtp.socketFactory.port", "465");
		    props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
		    props.put("mail.smtp.auth", "true");
		    props.put("mail.smtp.port", "465");*/
		    props.put("mail.smtp.starttls.enable", "true");
		    props.put("mail.smtp.auth", "true");
		    props.put("mail.smtp.host", "smtp.gmail.com");
		    props.put("mail.smtp.port", "587");
		    props.put("mail.smtp.starttls.enable","true");
		    
		    props.put("mail.smtp.host", "smtp.gmail.com"); 
		    props.put("mail.smtp.port", "25"); 
		    props.put("mail.debug", "true"); 
		    props.put("mail.smtp.auth", "true"); 
		    props.put("mail.smtp.starttls.enable","true"); 
		    props.put("mail.smtp.EnableSSL.enable","true");
		    props.setProperty("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");   
		    props.setProperty("mail.smtp.socketFactory.fallback", "false");   
		    props.setProperty("mail.smtp.port", "465");   
		    props.setProperty("mail.smtp.socketFactory.port", "465"); 

		 
		    // Authorized the Session object.
		    Session mailSession = Session.getInstance(props, new javax.mail.Authenticator() {
		        @Override
		        protected PasswordAuthentication getPasswordAuthentication() {
		            return new PasswordAuthentication(from, pass);
		        }
		    });
		 
		    try {
		        // Create a default MimeMessage object.
		        MimeMessage message = new MimeMessage(mailSession);
		        // Set From: header field of the header.
		        message.setFrom(new InternetAddress(from));
		        // Set To: header field of the header.
		        message.addRecipient(Message.RecipientType.TO,
		                new InternetAddress(to));
		        // Set Subject: header field
		        message.setSubject(subject);
		        // Now set the actual message
		        message.setText(messg);
		        // Send message
		        Transport.send(message);
		        result = "mail sent successfully from W3Adda.com....";
		    } catch (MessagingException mex) {
		        mex.printStackTrace();
		        result = "Error: unable to send mail....";
		    }
		 System.out.println(result);
	}

 
}