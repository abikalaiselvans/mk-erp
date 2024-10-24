package com.my.org.erp.mail;

import java.util.Date;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.my.org.erp.setting.CommonData;

public class Sample {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		 
    	try
		{
	        System.out.println("ddddddddddddddddd");
            String a[] ={""+CommonData.mailid+",pak@careind.net,gaa@careind.net"};
	        postMail(a,"Testing Purpose","Testing " );
	   	 	System.out.println("Mail has been sent..");
    	}
    	catch(Exception e)
    	{
    		 
    	}
	}

	
	public static void postMail( String recipients[ ], String subject, String message  ) throws MessagingException
	{
	    boolean debug = false;

	     //Set the host smtp address
	     
         String host ="192.168.0.5"   ;
         String user ="connect"  ;
         String password ="connect"   ;
         String from =""+CommonData.mailid  ;
          
         Properties props = new Properties();
         props.setProperty("mail.transport.protocol", "smtp");
         props.setProperty("mail.host", ""+host);
         props.setProperty("mail.user", ""+user);
         props.setProperty("mail.password", ""+password);
	       
         
	    // create some properties and get the default Session
	    Session session = Session.getDefaultInstance(props, null);
	    session.setDebug(debug);

	    // create a message
	    Message msg = new MimeMessage(session);

	    // set the from and to address
	    InternetAddress addressFrom = new InternetAddress(from);
	    msg.setFrom(addressFrom);

	    InternetAddress[] addressTo = new InternetAddress[recipients.length]; 
	    for (int i = 0; i < recipients.length; i++)
	    {
	        addressTo[i] = new InternetAddress(recipients[i]);
	    }
	    msg.setRecipients(Message.RecipientType.TO, addressTo);
	   

	    // Optional : You can also set your custom headers in the Email if you Want
	    msg.addHeader("MyHeaderName", "myHeaderValue");

	    // Setting the Subject and Content Type
	    msg.setSubject(subject);
	    msg.setContent(message, "text/plain");
	    Transport.send(msg);
	}
}
