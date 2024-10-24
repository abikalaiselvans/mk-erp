package com.test.mail;

import java.io.File;
import java.io.IOException;

import javax.mail.MessagingException;  
import javax.mail.internet.AddressException;  

import com.my.org.erp.setting.CommonData;
  
public class TestEmailSender 
{  
    public static void main(String[] args) throws AddressException,   MessagingException, IOException 
    {  
        try 
        {
			String host = "192.168.0.5";  
			String port = "465";  
			String mailFrom = ""+CommonData.mailid;  
			String mailTo = "abikalaiselvan@gmail.com";  
			String password = "connect";  
			String subject = ":: DIWALI GREETINGS :: ";  
			String bodyMessage = " ";  
			EmailSender sender = new EmailSender();  
			File f = new File("D:/sa");
			File[] a = f.listFiles();
			String[] attachments = new String [a.length];
			for( int i = 0; i < a.length; i++ ) 
				attachments[i] = a[i].toString();  
			
			sender.sendEmailWithAttachments(host, port, mailFrom, password,  mailTo, subject, bodyMessage, attachments);
		} 
        catch (RuntimeException e) 
        {
			 System.out.println(e.getMessage());
		}  
    }  
}  

