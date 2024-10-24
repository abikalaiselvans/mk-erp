package com.my.org.erp.mail;

 
 
import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.*;
import javax.mail.internet.*;

import com.my.org.erp.setting.CommonData;

import java.util.Properties;
 
public class SendSMTPMailUsingGmail 
{
 
    static final String SMTP_HOST = "192.168.0.5";
    static final int SMTP_HOST_PORT = 25;
    static final String SMTP_AUTH_USER = "connect";
    static final String SMTP_AUTH_PWD = "connect";
    public static void main(String[] args) throws Exception 
    {
        String subject="Find the file attached";
        new SendSMTPMailUsingGmail().sendEmail(subject);
    }
 
    public void sendEmail(String subject) throws Exception 
    {
 
        /**
         * Set the mail properties.
         */
        Properties props = new Properties();
        props.put("mail.smtps.host", SMTP_HOST);
        props.put("mail.transport.protocol", "smtps");
         
        Session mailSession = Session.getDefaultInstance(props);
 
        mailSession.setDebug(true);
 
        MimeMessage message = new MimeMessage(mailSession);
 
        message.setSubject(subject);
        //message.setContent("This is a test", "text/plain");
        Address toAddress = new InternetAddress(""+CommonData.mailid);
 
        /**The second parameter is the name as you want it to appear**/
        Address ccAddress = new InternetAddress("gaa@careind.net", "GOHILA  ");
        Address myAddress = new InternetAddress("pak@careind.net");
 
        /**Creating a bunch of email addresses for CC**/
        Address [] addressList= new Address [] {ccAddress, myAddress};
 
        /**
         * There are three different receipient types
         * Message.RecipientType.TO
         * Message.RecipientType.CC
         * Message.RecipientType.BCC
         *
         */
 
        /**
         * Adding a receiver (TO)
         */
        message.addRecipient(Message.RecipientType.TO, toAddress);
 
        /**
         * Adding an array of Receipients for CC
         */
        message.addRecipients(Message.RecipientType.CC, addressList);
 
        BodyPart messageBodyPart = new MimeBodyPart();
        /**
         * Defining a message text. This is the mail email message
         */
        messageBodyPart.setText("Please find the file attached.\n");
        MimeMultipart mmultipart = new MimeMultipart();
        mmultipart.addBodyPart(messageBodyPart); //message
        /**
         * Preparing an attachment
         */
        //MimeBodyPart mimeBodyPartAttachmet=addAttachment("C:/temp/myImage-grayedout.jpg");
       // mmultipart.addBodyPart(mimeBodyPartAttachmet);
        message.setContent(mmultipart, "multipart/mixed");//attachment
 
        Transport transport = mailSession.getTransport();
        transport.connect(SMTP_HOST, SMTP_HOST_PORT,
                SMTP_AUTH_USER, SMTP_AUTH_PWD);
 
        transport.sendMessage(message,
        message.getRecipients(Message.RecipientType.TO));
        transport.close();
 
    }
    /**
     *
     * @param fileNameToAttach
     * @return
     * @throws Exception
     *
     * Creates an sends an MimeBodyPart object for attachment to email
     */
    public  static MimeBodyPart addAttachment(String fileNameToAttach) throws Exception
    {
        MimeBodyPart mimeBodyPart = new MimeBodyPart();
        FileDataSource fileDataSource = new FileDataSource(fileNameToAttach);
        mimeBodyPart.setDataHandler(new DataHandler(fileDataSource));
        mimeBodyPart.setFileName(fileNameToAttach);
 
        return mimeBodyPart;
    }
 
}