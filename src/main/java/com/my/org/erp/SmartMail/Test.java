package com.my.org.erp.SmartMail;

import java.util.*;
 

import javax.mail.*;
import javax.mail.internet.*;

import com.my.org.erp.setting.CommonData;
 

public class Test {

	/**
	 * @param args
	 */
	public static void main(String[] args) 
	{
		 
		String recipients[] ={""+CommonData.mailid,"abikalaiselvan@gmail.com"};
		String subject = "Test";
		String  content = " WELCOME TO JAVA MAIL";
		try
		{	
			boolean debug = false;
    		String host ="192.168.0.5"  ;
            String user ="connect"  ;
            String password ="connect"   ;
            String from =""+CommonData.mailid   ;
             
            Properties props = new Properties();
  	        props.setProperty("mail.transport.protocol", "smtp");
  	        props.setProperty("mail.host", ""+host);
	        props.setProperty("mail.user", ""+user);
  	        props.setProperty("mail.password", ""+password);
  	        
  	        Session session = Session.getDefaultInstance(props, null);
  	        session.setDebug(debug); 
  	        Message msg = new MimeMessage(session);
  	        InternetAddress addressFrom = new InternetAddress(from);
  	        msg.setFrom(addressFrom);
  	        
            InternetAddress[] addressTo = new InternetAddress[recipients.length]; 
  	        for (int i = 0; i < recipients.length; i++)
  	    	   addressTo[i] = new InternetAddress(recipients[i]);
  	        msg.setRecipients(Message.RecipientType.BCC, addressTo);
  	        msg.addHeader("MyHeaderName", "myHeaderValue");
  	        msg.setSubject(subject);
  	        msg.setContent(content, "text/html");
  	        Transport.send(msg);
  	        System.out.println("mail has been sent");
		}
    	catch(Exception e)
    	{
    		System.out.println(e.getMessage());
    	}
	}

}
