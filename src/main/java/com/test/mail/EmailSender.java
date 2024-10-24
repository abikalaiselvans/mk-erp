package com.test.mail;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.Reader;
import java.util.Date;
import java.util.Properties;


import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

public class EmailSender 
{
	
    public void sendEmailWithAttachments(String host, String port,  
            final String userName,  final String password, String toAddress,  
            String subject, String message, String[] attachFiles)  
                throws AddressException, MessagingException, IOException {  
        // sets SMTP properties  
        Properties properties = new Properties();  
        properties.put("mail.smtp.host", host);  
        properties.put("mail.smtp.port", port);  
        properties.put("mail.smtp.auth", "true");  
        properties.put("mail.smtp.starttls.enable", "true");  
        properties.put("mail.user", userName);  
        properties.put("mail.password", password);  
      
        // creates a new session with an authenticator  
        Authenticator auth = new Authenticator() {  
            public PasswordAuthentication getPasswordAuthentication() {  
                return new PasswordAuthentication(userName, password);  
            }  
        };  
        Session session = Session.getInstance(properties, auth);  
      
        // creates a new e-mail message  
        MimeMessage msg = new MimeMessage(session);  
      
        msg.setFrom(new InternetAddress(userName));  
        InternetAddress[] toAddresses = {new InternetAddress(toAddress)};  
        msg.setRecipients(Message.RecipientType.BCC, toAddresses);  
        msg.setSubject(subject);  
        msg.setSentDate(new Date());  
      
        
        String s = " ";
       
       
        s = s+ " <table width='600' border='0' cellpadding='3' cellspacing='5' bordercolor='#0099CC' bgcolor='#0099CC'> ";
        s = s+ " <tr> ";
        s = s+ "  <td><div align='center'><h1><font color='white'>WISHING YOU A VERY HAPPY DIWALI</font></h1> </div></td> ";
        s = s+ " </tr> ";
        s = s+ " <tr  bgcolor='#FFFFFF' ><td>";
       
      
        
        s = s+ " <center> <table width=\"600\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" bgcolor='#0099CC'>";
        s = s+ " <tr>";
        s = s+ " <td  align='center'><center><img name=\"common\" id=\"common\" src=\"5.jpg\"  /></center></td> ";
        s = s+ " </tr> ";
        
        
      /*  s = s+ " <tr>";
        s = s+ " <td align='center'> <font   color='#ffffff' >For details contact: Arun Kumar. P @ ( +91 ) - 9176997575. Email : <a style='text-decoration:none' href='mailto:arunkumar.p@careind.net'><font color='#ffffff' >arunkumar.p@careind.net</a></font></font></td> ";
        s = s+ " </tr> ";
        
        s = s+ " <tr>";
        s = s+ " <td align='center'> <font color='#ffffff'>For details contact: Sasidharan. M @ ( +91 ) - 9894804205. Email : <a style='text-decoration:none' href='mailto:sasidharan.m@careind.net'><font color='#ffffff' >sasidharan.m@careind.net </a></font></font></td> ";
        s = s+ " </tr> ";
        
        s = s+ " <tr>";
        s = s+ " <td align='center'> <font  color='#ffffff'>For details contact: ( +91 ) - 44 - 64541118  </font></td> ";
        s = s+ " </tr> ";
       
        s = s+ " <tr>";
        s = s+ " <td align='center'> <font color='#ffffff' ><b>CARE IT Solutions Pvt. Ltd.   2nd Floor | No. 481 Anna Salai | Nandanam |Chennai - 600 035 Phone : 044-24340906 - Extn : 4601 Fax : 044-24340835 </b></font></td> ";
        s = s+ " </tr> ";
        */
        
        s = s+ " </table> ";
        s = s+ " </center></td> " ;
       
        s = s+ " </table> ";
         	
		 
        
        message = message+s;
        
        // creates message part  
        MimeBodyPart messageBodyPart = new MimeBodyPart();  
        messageBodyPart.setContent(message, "text/html");  
        
       
        // creates multi-part  
        Multipart multipart = new MimeMultipart();  
        multipart.addBodyPart(messageBodyPart);       
      
        
       
        
        // adds attachments  
        if (attachFiles != null && attachFiles.length > 0) {  
            for (String filePath : attachFiles) {  
                MimeBodyPart attachPart = new MimeBodyPart();  
                DataSource source = new FileDataSource(filePath);  
                attachPart.setDataHandler(new DataHandler(source));  
                attachPart.setFileName(new File(filePath).getName());  
      
                multipart.addBodyPart(attachPart);  
            }  
        }  
      
        // sets the multi-part as e-mail's content  
        msg.setContent(multipart);  
      
        // sends the e-mail  
        Transport.send(msg);  
      
    }  
}
