package com.my.org.erp.mail;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.activation.FileDataSource;
import javax.mail.Authenticator;
import javax.mail.BodyPart;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.mail.internet.MimeMultipart;

import java.util.Properties;

class tester 
{
    @SuppressWarnings("static-access")
    public static void main(String args[]) 
    {
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.stmp.user", "abc@gmail.com");          
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.password", "password");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");
        
        Session session = Session.getDefaultInstance(props, new Authenticator() 
        {
            protected PasswordAuthentication getPasswordAuthentication() 
            {
                String username = "abc@gmail.com";
                String password = "password";
                return new PasswordAuthentication(username,password); 
            }
        });
        
        String[] to = {"test1@gmail.com","test2@yahoo.in","test3@gmail.com","test4@gmail.com"};
        String from = "abc@gmail.com";
        String subject = "Testing...";
        MimeMessage msg = new MimeMessage(session);
        try 
        {
            msg.setFrom(new InternetAddress(from));
            InternetAddress[] addressTo = new InternetAddress[to.length];
            for (int i = 0; i < to.length; i++)
            {
                addressTo[i] = new InternetAddress(to[i]);
            }
            msg.setRecipients(RecipientType.TO, addressTo); 
            msg.setSubject(subject);
            BodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setText("This is message body");
            Multipart multipart = new MimeMultipart();
            multipart.addBodyPart(messageBodyPart);
            messageBodyPart = new MimeBodyPart();
            String filename = "file.txt";
            DataSource source = new FileDataSource(filename);
            messageBodyPart.setDataHandler(new DataHandler(source));
            messageBodyPart.setFileName(filename);
            multipart.addBodyPart(messageBodyPart);
            msg.setContent(multipart );
            Transport transport = session.getTransport("smtp");
            transport.send(msg);
            System.out.println("E-mail sent !");
        }
        catch(Exception exc) {
            System.out.println(exc);
        }
    }
}