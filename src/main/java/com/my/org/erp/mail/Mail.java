package com.my.org.erp.mail;
import java.security.Security;
import java.util.*;
import java.io.*;
import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

import com.my.org.erp.common.CommonFunctions;


public class Mail 
{
	/*
     * Inner class to act as a JAF datasource to send HTML e-mail content
     */
    static class HTMLDataSource implements DataSource {
        private String html;

        public HTMLDataSource(String htmlString) {
            html = htmlString;
        }

        public String getContentType() {
            return "text/html";
        }

        // Return html string in an InputStream.
        // A new stream must be returned each time.
        public InputStream getInputStream() throws IOException {
            if (html == null) throw new IOException("Null HTML");
            return new ByteArrayInputStream(html.getBytes());
        }

        public String getName() {
            return "JAF text/html dataSource to send e-mail only";
        }

        public OutputStream getOutputStream() throws IOException {
            throw new IOException("This DataHandler cannot write HTML");
        }
    }
	
	
	@SuppressWarnings("static-access")
	public static void sendGmail(String toaddress,String ccaddress,boolean attach ,String filepath, String subject, String content) 
	{
		 
		try {
			
			
			//Security.addProvider(new com.sun.net.ssl.internal.ssl.Provider());
			Properties props = new Properties();
			props.setProperty("mail.transport.protocol", "smtp");
			props.setProperty("mail.host", "smtp.gmail.com");
			props.put("mail.smtp.auth", "true");
			props.put("mail.smtp.port", "465");
			props.put("mail.debug", "true");
			props.put("mail.smtp.socketFactory.port", "465");
			props.put("mail.smtp.socketFactory.class","javax.net.ssl.SSLSocketFactory");
			props.put("mail.smtp.socketFactory.fallback", "false");

			Session session = Session.getDefaultInstance(props,new javax.mail.Authenticator() {
 
				protected PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication("abikalaiselvan",
							"abiaarthi");
				}
			});
			session.setDebug(true);
			Transport transport = session.getTransport();
			InternetAddress addressFrom = new InternetAddress("from@gmail.com");
			MimeMessage message = new MimeMessage(session);
			message.setSender(addressFrom);
			message.setSubject(subject);
			message.setContent(content, "text/html");
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(toaddress));
			message.setRecipients(Message.RecipientType.CC,InternetAddress.parse(ccaddress, true));
			//message.setRecipients(Message.RecipientType.BCC,InternetAddress.parse(ccadd, false));
			//"C:/test.jpg"
			if(attach)
				setFileAsAttachment(message, filepath);
			
			setHTMLContent( message) ;
			
			message.saveChanges();
			transport.connect();
			transport.send(message);
			transport.close();
			System.out.println("Mail has been sent..");
			
		} catch (AddressException e) {
			 
			 System.out.println(e.getMessage());
		} catch (NoSuchProviderException e) {
			 
			 System.out.println(e.getMessage());
		} catch (MessagingException e) {
			 
			 System.out.println(e.getMessage());
		}
		
	}  	
	
	public static void sendYahooMail() 
	{
		  try 
		  {
			  	Properties props = new Properties();
			  	props.setProperty("mail.transport.protocol", "smtp");
			  	props.setProperty("mail.host", "smtp.mail.yahoo.com");
			  	props.setProperty("mail.user", "abikalaiselvan");
			  	props.setProperty("mail.password", "abiaarthi");
	 
			  	Session mailSession = Session.getDefaultInstance(props, null);
			  	Transport transport = mailSession.getTransport();
			  	MimeMessage message = new MimeMessage(mailSession);
			  	message.setSubject("Testing javamail plain");
			  	message.setContent("This is a test", "text/plain");
			  	message.addRecipient(Message.RecipientType.TO, new InternetAddress("dharakalai@yahoo.com"));
			  	transport.connect();
			  	transport.sendMessage(message,message.getRecipients(Message.RecipientType.TO));
			  	transport.close();
			  	System.out.println("Mail has been sent...");
		} 
		  catch (AddressException e) 
		  {
			 
			 System.out.println(e.getMessage());
		  } 
		  catch (NoSuchProviderException e) 
		  {
			 
			 System.out.println(e.getMessage());
		  } 
		  catch (MessagingException e) 
		  {
			 
			 System.out.println(e.getMessage());
		  }
    }
	
	
	
	// Set a file as an attachment.  Uses JAF FileDataSource.
    public static void setFileAsAttachment(Message msg, String filename) throws MessagingException 
    {

        // Create and fill first part
        MimeBodyPart p1 = new MimeBodyPart();
        p1.setText("");

        // Create second part
        MimeBodyPart p2 = new MimeBodyPart();

        // Put a file in the second part
        FileDataSource fds = new FileDataSource(filename);
        p2.setDataHandler(new DataHandler(fds));
        p2.setFileName(fds.getName());

        // Create the Multipart.  Add BodyParts to it.
        Multipart mp = new MimeMultipart();
        mp.addBodyPart(p1);
        mp.addBodyPart(p2);

        // Set Multipart as the message's content
        msg.setContent(mp);
    }

	
	
	
	// Set a single part html content.
    // Sending data of any type is similar.
    public static void setHTMLContent(Message msg) throws MessagingException 
    {

        String html = "<html><head><title>" +
                        msg.getSubject() +
                        "</title></head><body  onpaste='return false;'><h1>" +
                        msg.getSubject() +
                        "</h1><p>This is a test of sending an HTML e-mail" +
                        " through Java.<img src=\"lord-ganesha.jpg\"></body></html>";
        

        // HTMLDataSource is an inner class
        msg.setDataHandler(new DataHandler(new HTMLDataSource(html)));
    }
	
	 


    public static void setMultipartContent(Message msg) throws MessagingException {
        MimeBodyPart p1 = new MimeBodyPart();
        p1.setText("");
        MimeBodyPart p2 = new MimeBodyPart();
        p2.setText("");
        Multipart mp = new MimeMultipart();
        mp.addBodyPart(p1);
        mp.addBodyPart(p2);
        msg.setContent(mp);
    }



    public static void setTextContent(Message msg) throws MessagingException {
            String mytxt = "Message here";
            msg.setText(mytxt);
            msg.setContent(mytxt, "text/plain");

    }



    public static void SimpleHTMLMail( String recipients[] , String subject,String content)
    {
    	try
    	{
	      
    		boolean debug = false;
    		String hData[][] = CommonFunctions.QueryExecute("SELECT CHR_HOST,CHR_USERID,CHR_PASSWORD,CHR_MAILID FROM  m_mailsetting WHERE INT_MAILID = 1");
		    String host =hData[0][0]   ;
            String user =hData[0][1]   ;
            String password =hData[0][2]   ;
            String from =hData[0][3]   ;
             
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
  	       
  	      
    	}
    	catch(Exception e)
    	{
    		System.out.println(e.getMessage());
    	}
    }



    public static void SimpleMail( String to, String subject,String content)
    {
    	try
    	{
            String hData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_HOST,CHR_USERID,CHR_PASSWORD,CHR_MAILID FROM  m_mailsetting WHERE INT_MAILID = 1");
            String host =hData[0][0]   ;
            String maild =hData[0][3]   ;
            Properties props = new Properties();
	        props.put("mail.smtp.host", ""+host);
	        props.put("mail.debug", "true");
	        Session sessio  = Session.getInstance(props);
	        Message msg = new MimeMessage(sessio );
	        msg.setFrom(new InternetAddress(""+maild));
	        InternetAddress[] address = {new InternetAddress(to)};
	        msg.setRecipients(Message.RecipientType.TO, address);
	        msg.setSubject(subject);
	        msg.setContent("This is a test", "text/html");
	        msg.setSentDate(new Date());
	   	 	msg.setText(content);
	   	 	Transport.send(msg);
	   	 	System.out.println("Mail has been sent..");
    	}
    	catch(Exception e)
    	{
    		try
    		{
    			
    		}
    		catch(Exception e1)
    		{
    			
    		}
    		System.out.println(e.getMessage());
    	}
    }



    public static void SimpleMail(String recipients[], String subject,String content)
    {
    	try
    	{
	        
    		boolean debug = false;
    		String hData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_HOST,CHR_USERID,CHR_PASSWORD,CHR_MAILID FROM  m_mailsetting WHERE INT_MAILID = 1");
		    String host =hData[0][0]   ;
            String user =hData[0][1]   ;
            String password =hData[0][2]   ;
            String from =hData[0][3]   ;
             
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
  	        InternetAddress[] to = new InternetAddress[recipients.length]; 
	        for (int i = 0; i < recipients.length; i++)
	    	   to[i] = new InternetAddress(recipients[i]);
	        msg.setRecipients(Message.RecipientType.BCC, to);
	        msg.setSubject(subject);
	        msg.setSentDate(new Date());
	   	 	msg.setText(content);
	   	 	Transport.send(msg);
	   	 	System.out.println("Mail has been sent..");
    	}
    	catch(Exception e)
    	{
    		System.out.println(e.getMessage());
    	}
    }

} //End of class