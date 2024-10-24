package com.my.org.erp.example.mail;

import com.my.org.erp.setting.CommonData;

public class SampleMail {

	/**
	 * @param args
	 */
	public static void main(String[] args) 
	{
		 

		System.out.println("Before Mail");
		com.my.org.erp.mail.Mail.sendGmail(""+CommonData.mailid, ""+CommonData.mailid, false, "c:/apple.JPG", "Testing ", "Hi, This is testing purpose only");
		System.out.println("After Mail");
	}

}
