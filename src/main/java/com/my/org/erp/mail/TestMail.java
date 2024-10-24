package com.my.org.erp.mail;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import com.my.org.erp.setting.CommonData;

public class TestMail {

	/**
	 * @param args
	 */
	public static void main(String[] args) 
	{
		 
		try 
		{
			MailAgent m = new MailAgent(""+CommonData.mailid,
			          "abikalaiselvan@gmail.com",
			          "gaa@careind.net",
			          "gaa@careind.net",
			          "Testing Purpose",
			          "<br><h1><center>Testing Purpose</center></h1><br>",
			          "192.168.0.5");
			m.sendMessage();
		} 
		catch (AddressException e) {
			 
			 System.out.println(e.getMessage());
		} catch (MessagingException e) {
			 
			 System.out.println(e.getMessage());
		}
		
	}

}
