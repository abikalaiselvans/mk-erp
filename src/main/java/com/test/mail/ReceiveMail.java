package com.test.mail;

import java.io.IOException;
import java.util.Properties;
import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;

import com.my.org.erp.setting.CommonData;
import com.sun.mail.pop3.POP3Store;

public class ReceiveMail
{
	public static void receiveEmail(String pop3Host, String storeType, String user, String password) 
	{
		try 
		{
			Properties properties = new Properties();
			properties.put("mail.pop3.host", pop3Host);
			Session emailSession = Session.getDefaultInstance(properties);
			POP3Store emailStore = (POP3Store) emailSession.getStore(storeType);
			emailStore.connect(user, password,"");

			Folder emailFolder = emailStore.getFolder("Inbox");
			emailFolder.open(Folder.READ_ONLY);

			Message[] messages = emailFolder.getMessages();
			for (int i = 0; i < messages.length; i++) 
			{
				Message message = messages[i];
				System.out.println("---------------------------------");
				System.out.println("Email Number " + (i + 1));
				System.out.println("Subject: " + message.getSubject());
				System.out.println("From: " + message.getFrom()[0]);
				System.out.println("Text: " + message.getContent().toString());
			}

			emailFolder.close(false);
			emailStore.close();

	} 
	catch (NoSuchProviderException e) 
	{
			 System.out.println(e.getMessage());
	} 
	catch (MessagingException e) 
	{
		 System.out.println(e.getMessage());
	}
	catch (IOException e) 
	{
		 System.out.println(e.getMessage());
	}
 }

 public static void main(String[] args) 
 {

	 
 /* String host = "mail.javatpoint.com";//change accordingly
  String mailStoreType = "pop3";
  String username= "sonoojaiswal@javatpoint.com";
  String password= "xxxxx";//change accordingly
  */
	 
  
  System.out.println("Before connecting..............");
  String host = "192.168.0.5/mail";//change accordingly
  String mailStoreType = "pop3";
  String username= ""+CommonData.mailid;
  String password= "connect";//change accordingly
  System.out.println("Before connecting..............");
  receiveEmail(host, mailStoreType, username, password);

 }
}