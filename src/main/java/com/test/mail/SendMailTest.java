package com.test.mail;

import com.my.org.erp.setting.CommonData;

public class SendMailTest {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		 
		SendMail s = new SendMail(""+CommonData.mailid,"abikalaiselvan@gmail.com","","");
		s.send();
		
	}

}
