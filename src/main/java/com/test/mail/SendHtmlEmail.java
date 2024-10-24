package com.test.mail;

import java.util.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

class SendHtmlEmail
{
   public static void main(String [] args)
   {

      String host="mail.javatpoint.com";//change accordingly
      String to="sonoojaiswal1987@gmail.com";//change accordingly
      final String user="sonoojaiswal@javatpoint.com";//change accordingly
      final String password="xxxxx";//change accordingly

      Properties properties = System.getProperties();
      properties.setProperty("mail.smtp.host",host );
      properties.put("mail.smtp.auth", "true");

      Session session = Session.getDefaultInstance(properties,
	new javax.mail.Authenticator() {
	 protected PasswordAuthentication getPasswordAuthentication() {
	  return new PasswordAuthentication(user,password);
	 }
      });
      
      try{
         MimeMessage message = new MimeMessage(session);
         message.setFrom(new InternetAddress(user));
         message.addRecipient(Message.RecipientType.TO,
                                  new InternetAddress(to));

        message.setSubject("HTML Message");
        message.setContent("<h1>sending html mail check</h1>","text/html" );
  
       Transport.send(message);
         System.out.println("message sent....");
      }catch (MessagingException ex) {ex.printStackTrace();}
   }
}