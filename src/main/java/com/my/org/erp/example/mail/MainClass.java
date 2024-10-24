package com.my.org.erp.example.mail;

import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class MainClass 
{

  public static void main(String[] args) throws Exception 
  {

    
	  	try 
	  	{
			String hData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_HOST,CHR_USERID,CHR_PASSWORD,CHR_MAILID FROM  m_mailsetting WHERE INT_MAILID = 1");

			String host =hData[0][0]   ;
			String maild =hData[0][3]   ;
			String from=maild,to=maild;
     
			Properties props = new Properties();
			props.put("mail.smtp.host", ""+host);
			props.put("mail.debug", "true");
			
			Session mailConnection = Session.getInstance(props, null);
			Message msg = new MimeMessage(mailConnection);

			Address a = new InternetAddress(from, "A a");
			Address b = new InternetAddress(to);

			msg.setContent("Mail contect", "text/plain");
			msg.setFrom(a);
			msg.setRecipient(Message.RecipientType.TO, b);
			msg.setSubject("subject");

			Transport.send(msg);
		} 
	  	catch (RuntimeException e) 
	  	{
			 
			 System.out.println(e.getMessage());
			System.out.println(e.getMessage());
		}
  }
}