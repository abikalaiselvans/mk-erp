package com.test.mail;

import java.io.File;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.BodyPart;
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

public class SendHtmlfile 
{
	public static void main(String[] args) 
	{
		  String to = ""+CommonData.mailid;
	      String from = ""+CommonData.mailid;
	      String host = "192.168.0.5";
	      Properties properties = System.getProperties();
	      properties.setProperty("mail.smtp.host", host);
	      Session session = Session.getDefaultInstance(properties);
	      try
	      {
	         MimeMessage message = new MimeMessage(session);
	         message.setFrom(new InternetAddress(from));
	         message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
	         message.setSubject("This is the Subject Line!");
	         BodyPart messageBodyPart = new MimeBodyPart();
	         String s = "<body> ";
	         s = s+ " <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
	         s = s+ " <tr>";
	         s = s+ " <td ><img name=\"common\" id=\"common\" src=\"1.png\" onmouseover=\"common.src= 'common.png' \"  onmouseout=\" common.src= '1.png'\"/></td> ";
	         s = s+ " </tr> ";
	         s = s+ " <tr>";
	         s = s+ " <td ><img name=\"common\" id=\"common\" src=\"common.png\" onmouseover=\"common.src= 'common.png' \"  onmouseout=\" common.src= '1.png'\"/></td> ";
	         s = s+ " </tr> ";
	         s = s+ " </table> ";
	         s = s+ " </body> ";
	         String htmlText = "<H1>Hello</H1><br>"+s;
	         messageBodyPart.setContent(htmlText, "text/html");
	         
	         // Create a multipar message
	         Multipart multipart = new MimeMultipart();

	         // Set text message part
	         multipart.addBodyPart(messageBodyPart);

	         // Part two is attachment
	         
	         
	         File f = new File("D:/sa");
	         File[] attachments = f.listFiles();
	         for( int i = 0; i < attachments.length; i++ ) 
	         {
	        	 messageBodyPart = new MimeBodyPart();
	        	 FileDataSource fileDataSource =new FileDataSource(attachments[i]);
	        	 messageBodyPart.setDataHandler(new DataHandler(fileDataSource));
	        	 messageBodyPart.setFileName(attachments[i].getName());
	        	 multipart.addBodyPart(messageBodyPart);
	         }

	         message.setContent(multipart);
	         Transport.send(message);
	          
	         
	         System.out.println("Sent message successfully....");
	      }
	      catch (MessagingException mex) 
	      {
	         mex.printStackTrace();
	         System.out.println(mex.getMessage());
	      }
	}

}
