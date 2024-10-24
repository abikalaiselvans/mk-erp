package com.my.org.erp.SmartMail;
 
 
import java.util.*;
import java.io.*;

import javax.mail.*;
import javax.mail.internet.*;
import javax.activation.*;

import com.my.org.erp.common.CommonFunctions;


public class Mail 
{
	
	
	 //HTML BASED MAIL
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
	
	
	//HTML BASED ATTACHMENT MAIl

	public static void sendEmailWithAttachments(String recipients[],String subject, String content, String[] attachFiles)throws AddressException, MessagingException, IOException 
    {
		try
		{
			 	
				String hData[][] = CommonFunctions.QueryExecute("SELECT CHR_HOST,CHR_USERID,CHR_PASSWORD,CHR_MAILID FROM  m_mailsetting WHERE INT_MAILID = 1");
				String host =hData[0][0]   ;
            	final String userName =hData[0][1]   ;
            	final String password =hData[0][2]   ;
            	String from =hData[0][3]   ;
            	String port ="25"  ;
				Properties properties = new Properties();  
		        properties.put("mail.smtp.host", host);  
		        properties.put("mail.smtp.port", port);  
		        properties.put("mail.smtp.auth", "true");  
		        properties.put("mail.smtp.starttls.enable", "true");  
		        properties.put("mail.user", userName);  
		        properties.put("mail.password", password);  
		      
		         
		        Authenticator auth = new Authenticator()
		        {  
		            public PasswordAuthentication getPasswordAuthentication() 
		            {  
		                return new PasswordAuthentication(userName, password);  
		            }  
		        };  
		        
		        Session session = Session.getInstance(properties, auth);  
		      
		        MimeMessage msg = new MimeMessage(session);  
		        msg.setFrom(new InternetAddress(from ));  //userName
		        
		        InternetAddress[] toAddress = new InternetAddress[recipients.length]; 
	  	        for (int i = 0; i < recipients.length; i++)
	  	        	toAddress[i] = new InternetAddress(recipients[i]);
	  	        msg.setRecipients(Message.RecipientType.BCC, toAddress);
	  	         
		        msg.setSubject(subject);  
		        msg.setSentDate(new Date());  
		        MimeBodyPart messageBodyPart = new MimeBodyPart();  
	            messageBodyPart.setContent(content, "text/html");  
	            
	            Multipart multipart = new MimeMultipart();  
	            multipart.addBodyPart(messageBodyPart);       
	          
	            if (attachFiles != null && attachFiles.length > 0) 
	            {  
	                for (String filePath : attachFiles) 
	                {  
	                    MimeBodyPart attachPart = new MimeBodyPart();  
	                    DataSource source = new FileDataSource(filePath);  
	                    attachPart.setDataHandler(new DataHandler(source));  
	                    attachPart.setFileName(new File(filePath).getName());  
	                    multipart.addBodyPart(attachPart);  
	                }  
	            }  
	          
	            msg.setContent(multipart);  
	            Transport.send(msg);  
		}
		catch(Exception e)
		{
			System.out.println(e.getMessage());
		}
	}
	
	
	
	
	
	
	
	
	 

 
 


   

 

 

} //End of class