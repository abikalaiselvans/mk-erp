package com.test.mail;

import java.util.Properties;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.Message.RecipientType;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.my.org.erp.setting.CommonData;
 
public class Mail 
{
	String d_email = ""+CommonData.mailid,
	d_password = "connect",
	d_host = "192.168.0.5",//
	d_port = "25",
	m_to = "abikalaiselvan@gmail.com",
	m_subject = "subject",
	m_text = "this is just a test mail";

	public Mail() {
	Properties props = new Properties();
	props.put("mail.smtp.user", d_email);
	props.put("mail.smtp.host", d_host);
	props.put("mail.smtp.port", d_port);
	props.put("mail.smtp.starttls.enable","true");
	props.put("mail.smtp.auth", "true");
	props.put("mail.smtp.debug", "true");
	//props.put("mail.smtp.socketFactory.port", d_port);
	//props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
	//props.put("mail.smtp.socketFactory.fallback", "false");

	SecurityManager security = System.getSecurityManager();

	try {
	Authenticator auth = new SMTPAuthenticator();
	Session session = Session.getInstance(props, auth);
	//session.setDebug(true);

	MimeMessage msg = new MimeMessage(session);
	msg.setText(m_text);
	msg.setSubject(m_subject);
	msg.setFrom(new InternetAddress(d_email));
	msg.addRecipient(Message.RecipientType.TO, new
	InternetAddress(m_to));
	Transport.send(msg);
	} catch (Exception mex) {
	mex.printStackTrace();
	}
	}
	private class SMTPAuthenticator extends javax.mail.Authenticator {
	public PasswordAuthentication getPasswordAuthentication() {
	return new PasswordAuthentication(d_email, d_password);
	}
	}

	public static void main(String[] args){
	Mail sendmail=new Mail();
	}
} 