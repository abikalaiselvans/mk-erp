package com.test.mail;

 
import java.io.File;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

import com.my.org.erp.setting.CommonData;

public class SendFileEmail
{
   public static void main(String [] args)
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

         // Set From: header field of the header.
         message.setFrom(new InternetAddress(from));

         // Set To: header field of the header.
         message.addRecipient(Message.RecipientType.TO,
                                  new InternetAddress(to));

         // Set Subject: header field
         message.setSubject("This is the Subject Line!");

         // Create the message part 
         BodyPart messageBodyPart = new MimeBodyPart();

         // Fill the message
         String s = "<body> ";
         s = s+ " <table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">";
         s = s+ " <tr>";
         s = s+ " <td ><img name=\"common\" id=\"common\" src=\"1.png\" onmouseover=\"common.src= 'common.png' \"  onmouseout=\" common.src= '1.png'\"/></td> ";
         s = s+ " </tr> ";
         s = s+ " </table> ";
         s = s+ " </body> ";
         messageBodyPart.setText("This is message body\n"+s);

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

         //Put parts in message
         message.setContent(multipart);
         
         
         /*ArrayList fileNames = new ArrayList();
         fileNames.add("D:/sa/1.png");
         fileNames.add("D:/sa/common.png");
         
         for(int i=0;i<fileNames.size();i++)
         {
             System.out.println(fileNames.get(i));

             messageBodyPart = new MimeBodyPart();
             DataSource source = new FileDataSource((String)fileNames.get(i));

             messageBodyPart.setDataHandler(new DataHandler(source));
             messageBodyPart.setFileName((String)fileNames.get(i));
             multipart.addBodyPart(messageBodyPart);
             message.setContent(multipart);
         }
         */
       
          

         // Send message
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
