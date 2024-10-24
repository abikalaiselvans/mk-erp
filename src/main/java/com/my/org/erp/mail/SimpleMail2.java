package com.my.org.erp.mail;

import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

import com.my.org.erp.setting.CommonData;

import java.util.Properties;

class SimpleMail2 
{
    public static void main(String[] args) throws Exception
    {
        
    	
        Properties props = new Properties();
        props.setProperty("mail.transport.protocol", "smtp");
		props.setProperty("mail.host", "smtp.gmail.com");
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.port", "465");
		props.put("mail.debug", "true");
		props.put("mail.smtp.socketFactory.port", "465");
		props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
		props.put("mail.smtp.socketFactory.fallback", "false");

		Session mailSession = Session.getDefaultInstance(props,new javax.mail.Authenticator() {
			 
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("abikalaiselvan",
						"abiaarthi");
			}
		});
		mailSession.setDebug(true);
		
        
        Transport transport = mailSession.getTransport();

        MimeMessage message = new MimeMessage(mailSession);
        message.setSubject("HTML  mail with images");
        message.setFrom(new InternetAddress("abikalaiselvan@gmail.com"));
        message.addRecipient(Message.RecipientType.TO,
             new InternetAddress(""+CommonData.mailid));

        //
        // This HTML mail have to 2 part, the BODY and the embedded image
        //
        MimeMultipart multipart = new MimeMultipart("related");

        // first part  (the html)
        BodyPart messageBodyPart = new MimeBodyPart();
        String htmlText = " ";
		messageBodyPart.setContent(htmlText, "text/html");

        // add it
        multipart.addBodyPart(messageBodyPart);
        
        // second part (the image)
        messageBodyPart = new MimeBodyPart();
        DataSource fds = new FileDataSource
          ("C:\\NF2202444894940.pdf");
        messageBodyPart.setDataHandler(new DataHandler(fds));
        messageBodyPart.setHeader("Content-ID","<image>");

        // add it
        multipart.addBodyPart(messageBodyPart);

        // put everything together
        message.setContent(multipart);

        transport.connect();
        transport.sendMessage(message,
            message.getRecipients(Message.RecipientType.TO));
        transport.close();
        
        }
}


/*
 *
 *import javax.mail.*;
import javax.mail.internet.*;

import java.util.Properties;

class SimpleMail {
    public static void main(String[] args) throws Exception{
        System.out.println("Sending mail...");
        Properties props = new Properties();
        props.setProperty("mail.transport.protocol", "smtp");
        props.setProperty("mail.host", "smtp.mymailserver.com");
        props.setProperty("mail.user", "myuser");
        props.setProperty("mail.password", "mypwd");

        Session mailSession = Session.getDefaultInstance(props, null);
        mailSession.setDebug(true);
        Transport transport = mailSession.getTransport();

        MimeMessage message = new MimeMessage(mailSession);
        message.setSubject("HTML  mail with images");
        message.setFrom(new InternetAddress("me@sender.com"));
        message.setContent("<h1>Hello world</h1>", "text/html");
        message.addRecipient(Message.RecipientType.TO,
             new InternetAddress("you@receiver.com"));

        transport.connect();
        transport.sendMessage(message,
            message.getRecipients(Message.RecipientType.TO));
        transport.close();
        }
}
One approach to include images in the mail body is to use the IMG tag and make the images available on a server. 
import javax.mail.*;
import javax.mail.internet.*;

import java.util.Properties;

class SimpleMail1 {
    public static void main(String[] args) throws Exception{
        System.out.println("Sending mail...");
        Properties props = new Properties();
        props.setProperty("mail.transport.protocol", "smtp");
        props.setProperty("mail.host", "smtp.mymailserver.com");
        props.setProperty("mail.user", "myuser");
        props.setProperty("mail.password", "mypwd");

        Session mailSession = Session.getDefaultInstance(props, null);
        mailSession.setDebug(true);
        Transport transport = mailSession.getTransport();

        MimeMessage message = new MimeMessage(mailSession);
        message.setSubject("HTML  mail with images");
        message.setFrom(new InternetAddress("me@sender.com"));
        message.setContent
          ("<h1>This is a test</h1>" 
           + "<img src=\"http://www.rgagnon.com/images/jht.gif\">", 
           "text/html");
        message.addRecipient(Message.RecipientType.TO,
             new InternetAddress("you@receiver.com"));

        transport.connect();
        transport.sendMessage(message,
            message.getRecipients(Message.RecipientType.TO));
        transport.close();
        }
}
The browser accesses these images just as if it were displaying an image in a Web page. Unfortunately, spammers have used this mechanism as a sneaky way to record who visits their site (and mark your email as valid). To protect your privacy, many Web-based (and other) email clients don't display images in HTML emails. 
An alternative to placing absolute URLs to images in your HTML is to include the images as attachments to the email. The HTML can reference the image in an attachment by using the protocol prefix cid: plus the content-id of the attachment. 

import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

import java.util.Properties;

class SimpleMail2 {
    public static void main(String[] args) throws Exception{
        System.out.println("Sending mail...");
        Properties props = new Properties();
        props.setProperty("mail.transport.protocol", "smtp");
        props.setProperty("mail.host", "smtp.mymailserver.com");
        props.setProperty("mail.user", "myuser");
        props.setProperty("mail.password", "mypwd");

        Session mailSession = Session.getDefaultInstance(props, null);
        mailSession.setDebug(true);
        Transport transport = mailSession.getTransport();

        MimeMessage message = new MimeMessage(mailSession);
        message.setSubject("HTML  mail with images");
        message.setFrom(new InternetAddress("me@sender.com"));
        message.addRecipient(Message.RecipientType.TO,
             new InternetAddress("you@receiver.com"));

        //
        // This HTML mail have to 2 part, the BODY and the embedded image
        //
        MimeMultipart multipart = new MimeMultipart("related");

        // first part  (the html)
        BodyPart messageBodyPart = new MimeBodyPart();
        String htmlText = "<H1>Hello</H1><img src=\"cid:image\">";
        messageBodyPart.setContent(htmlText, "text/html");

        // add it
        multipart.addBodyPart(messageBodyPart);
        
        // second part (the image)
        messageBodyPart = new MimeBodyPart();
        DataSource fds = new FileDataSource
          ("C:\\images\\jht.gif");
        messageBodyPart.setDataHandler(new DataHandler(fds));
        messageBodyPart.setHeader("Content-ID","<image>");

        // add it
        multipart.addBodyPart(messageBodyPart);

        // put everything together
        message.setContent(multipart);

        transport.connect();
        transport.sendMessage(message,
            message.getRecipients(Message.RecipientType.TO));
        transport.close();
        }
}
 
 * */
