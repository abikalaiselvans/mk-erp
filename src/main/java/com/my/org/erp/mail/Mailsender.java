package com.my.org.erp.mail;
//Arul has sent this coding
 
import java.util.Date;

import javax.mail.*;
import javax.mail.internet.*;

import com.my.org.erp.setting.CommonData;
 

public class Mailsender {

	public static void send(String smtpHost, int smtpPort, String from,
			String sendTo[], String subject, String content)
			throws AddressException, MessagingException {
		String mailBodyTable =
            "	<table style=\"text-align: left; width: 489px; height: 200px;\" " +
            "	 border=\"1\" cellpadding=\"0\" cellspacing=\"0\">		" +
            "	  <tbody>							" + "	    <tr>							" +
            "	      <td style=\"width: 151px;\">Image </td>			" +
            "	      <td style=\"width: 806px;\" align='center'><img src=\"C:\\Documents and Settings\\user\\Desktop\\Own use\\arul.gif\"></td>				" +
            "	    </tr></tbody></table>							";
    
		for (int i = 0; i < sendTo.length; i++)
			System.out.println(smtpHost + " " + smtpPort + " " + from + " "
					+ sendTo[i]);
		// Create a mail session
		java.util.Properties props = new java.util.Properties();
		props.setProperty("mail.transport.protocol", "smtp");
		props.put("mail.smtp.host", smtpHost);
		props.put("mail.smtp.port", "" + smtpPort);
		Session session = Session.getDefaultInstance(props, null);

		// Construct the message
		Message msg = new MimeMessage(session);
		msg.setFrom(new InternetAddress(from));
		if (sendTo != null) {
			InternetAddress[] addressTo = new InternetAddress[sendTo.length];
			for (int i = 0; i < sendTo.length; i++) {
				addressTo[i] = new InternetAddress(sendTo[i]);
			}
			msg.setRecipients(Message.RecipientType.TO, addressTo);
		}

		msg.setSubject(subject);
		msg.setContent(mailBodyTable,"text/html");
		//msg.setText(content); this for normal text content
		msg.setSentDate(new Date());
		// Send the message
		Transport.send(msg);
	}

	public static void main(String[] args) throws Exception {
		// Send a test message
		String[] SendTo = { "abikalaiselvan@yahoo.co.in" };
		send("192.168.0.5", 26, ""+CommonData.mailid, SendTo, "Hello",
				"<h1>Hi good evening, This mail send from java for testing....,");
	}

}
