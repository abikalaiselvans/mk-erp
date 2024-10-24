/**
 * 
 */
package com.my.org.erp.regex;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author Administrator
 *
 */
public class RegexFunctions 
{
	
	
	/*
	 * String ExString = "This is a Java program.  This is another Java Program.";
       String result=removeDuplicateWhitespace(ExString);
       System.out.println(result);
	 */
	
	public static CharSequence  removeDuplicateWhitespace(CharSequence inputStr) 
	{
	      String patternStr = "\\s+";
	      String replaceStr = " ";
	      Pattern pattern = Pattern.compile(patternStr);
	      Matcher matcher = pattern.matcher(inputStr);
	      return matcher.replaceAll(replaceStr);
	  }
	
	
	/*
	 * isPhoneValid("1-999-585-4009");
      isPhoneValid("999-585-4009");
      isPhoneValid("1-585-4009");
      isPhoneValid("585-4009");
      isPhoneValid("1.999-585-4009");
      isPhoneValid("999 585-4009");
      isPhoneValid("1 585 4009");
      isPhoneValid("111-Java2s");
	 */
	
	public static boolean isPhoneValid(String phone) 
	{
	      boolean retval = false;
	      String phoneNumberPattern =  "(\\d-)?(\\d{3}-)?\\d{3}-\\d{4}";
	      retval = phone.matches(phoneNumberPattern);
	      String msg = "NO MATCH: pattern:" + phone
	      + "\r\n regex: " + phoneNumberPattern;
	      if (retval) {
	         msg = " MATCH: pattern:" + phone 
	         + "\r\n regex: " + phoneNumberPattern;
	      }
	      System.out.println(msg + "\r\n");
	      return retval;
	 }
	
	
}
