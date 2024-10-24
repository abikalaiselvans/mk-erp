package com.test.mail;

import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

import com.my.org.erp.setting.CommonData;

import java.io.File;
import java.util.Properties;

class SimpleMail2 
{
    public static void main(String[] args) throws Exception
    {
        System.out.println("Sending mail...");
        Properties props = new Properties();
        props.setProperty("mail.transport.protocol", "smtp");
        props.setProperty("mail.host", "192.168.0.5");
        props.setProperty("mail.user", ""+CommonData.mailid);
        props.setProperty("mail.password", "connect");

        Session mailSession = Session.getDefaultInstance(props);
        mailSession.setDebug(true);
        Transport transport = mailSession.getTransport();

        MimeMessage message = new MimeMessage(mailSession);
        message.setSubject("HTML  mail with images");
        message.setFrom(new InternetAddress(""+CommonData.mailid));
        message.addRecipient(Message.RecipientType.TO, new InternetAddress(""+CommonData.mailid));

        MimeMultipart multipart = new MimeMultipart("related");

        // first part  (the html)
        BodyPart messageBodyPart = new MimeBodyPart();
        String s = "<body> ";
        s = s+ " <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
        s = s+ " <tr>";
        s = s+ " <td ><img name=\"common\" id=\"common\" src=\"1.png\" onmouseover=\"common.src= 'common.png' \"  onmouseout=\" common.src= '1.png'\"/></td> ";
        s = s+ " </tr> ";
        s = s+ " </table> ";
        s = s+ " </body> ";
        String htmlText = "<H1>Hello</H1><br>"+s;
        messageBodyPart.setContent(htmlText, "text/html");

       
        // add it
        multipart.addBodyPart(messageBodyPart);
        
        File f = new File("D:/sa");
        File[] attachments = f.listFiles();
        for( int i = 0; i < attachments.length; i++ ) 
        {
       	 messageBodyPart = new MimeBodyPart();
       	 FileDataSource fileDataSource =new FileDataSource(attachments[i]);
       	 messageBodyPart.setDataHandler(new DataHandler(fileDataSource));
       	 messageBodyPart.setHeader("Content-ID","<image>");
       	 messageBodyPart.setFileName(attachments[i].getName());
       	 multipart.addBodyPart(messageBodyPart);
        }
        
       message.setContent(multipart);
       transport.connect();
        
       transport.sendMessage(message,message.getRecipients(Message.RecipientType.TO));
       transport.close();
        }
}