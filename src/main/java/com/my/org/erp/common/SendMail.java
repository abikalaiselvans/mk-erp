package com.my.org.erp.common;

import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendMail
{

  private static final String SMTP_HOST_NAME = "SMTP_HOST_NAME";
  private static final String SMTP_AUTH_USER = "SMTP_AUTH_USER";
  private static final String SMTP_AUTH_PWD  = "SMTP_AUTH_PWD"; 

  public static void main(String args[]) throws Exception
  {
	  
	  String[] emailList = {"dharakalai@yahoo.com", "abiakalaiselvan@yahoo.co.in"};
	  SendEMail(emailList,"gjgj");	  
  }
  public static boolean SendEMail(String []toAddressList,String msg){
	  boolean resu = false;
	  try{
		  SendMail smtpMailSender = new SendMail();
		  resu = smtpMailSender.postMail( toAddressList, msg);
		  //com.my.org.erp.common.CommonFunctions.dbusername
		  //com.my.org.erp.common.CommonFunctions.dbpassword;
		  //com.my.org.erp.common.CommonFunctions.dburl;
	  }
	  catch(Exception e){
		  //System.out.println(e.getMessage());
		   System.out.println(e.getMessage());
		  resu = false;
	  }	    
	  return resu;	  
  }
  public boolean postMail( String recipients[ ], String message) throws MessagingException
  {
     boolean debug = false;
     String from = "abikalaiselvan@gmail.com";
     String subject = "Confermation for the ......";
     //Set the host smtp address
     Properties props = new Properties();
     props.put("mail.smtp.host", SMTP_HOST_NAME);
     props.put("mail.smtp.auth", "true");

    Authenticator auth = new SMTPAuthenticator();
    Session session = Session.getDefaultInstance(props, auth);

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
    // Setting the Subject and Content Type
    msg.setSubject(subject);
    msg.setContent(message, "text/html;charset=iso-8859-1;");
    try{
    Transport.send(msg);
    }
    catch (Exception e) {
		//System.out.println(e.getMessage());
		 System.out.println(e.getMessage());
    	return false;
	}
    return true;
 }

private class SMTPAuthenticator extends javax.mail.Authenticator
{

    public PasswordAuthentication getPasswordAuthentication()
    {
        String username = SMTP_AUTH_USER;
        String password = SMTP_AUTH_PWD;
        return new PasswordAuthentication(username, password);
    }
}

}


