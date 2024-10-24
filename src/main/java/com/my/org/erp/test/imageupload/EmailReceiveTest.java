package com.my.org.erp.test.imageupload;
import java.io.IOException;
import java.util.Properties;

import javax.mail.Folder;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.NoSuchProviderException;
import javax.mail.Session;

import com.sun.mail.pop3.POP3Store;

public class EmailReceiveTest {

	public static void main(String[] args) {

		String mailPop3Host = "http://post.careind.net/mail/";
		String mailStoreType = "pop3";
		String mailUser = "connect";
		String mailPassword = "connect";

		receiveEmail(mailPop3Host, mailStoreType, mailUser, mailPassword);
	}

	public static void receiveEmail(String pop3Host, String storeType, String user, String password) {

		try {
			Properties properties = new Properties();
			properties.put("mail.pop3.host", pop3Host);
			Session emailSession = Session.getDefaultInstance(properties);

			POP3Store emailStore = (POP3Store) emailSession.getStore(storeType);
			emailStore.connect(pop3Host,user, password );

			Folder emailFolder = emailStore.getFolder("INBOX");
			emailFolder.open(Folder.READ_ONLY);

			Message[] messages = emailFolder.getMessages();
			for (int i = 0; i < messages.length; i++) {
				Message message = messages[i];
				System.out.println("==============================");
				System.out.println("Email #" + (i + 1));
				System.out.println("Subject: " + message.getSubject());
				System.out.println("From: " + message.getFrom()[0]);
				System.out.println("Text: " + message.getContent().toString());
			}

			emailFolder.close(false);
			emailStore.close();
		} catch (NoSuchProviderException e) {
			 System.out.println(e.getMessage());
		} catch (MessagingException e) {
			 System.out.println(e.getMessage());
		} catch (IOException e) {
			 System.out.println(e.getMessage());
		}

	}

}
