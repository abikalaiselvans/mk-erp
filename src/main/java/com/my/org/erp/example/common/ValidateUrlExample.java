package com.my.org.erp.example.common;

import org.apache.commons.validator.UrlValidator;

public class ValidateUrlExample{
 
	public static void main(String[] args) {
 
	    UrlValidator urlValidator = new UrlValidator();
 
	    //valid URL
	    if (urlValidator.isValid("http://www.mkyong.com/index.html")) {
	       System.out.println("url is valid");
	    } else {
	       System.out.println("url is invalid");
	    }
 
	    //invalid URL
	    if (urlValidator.isValid("http://invalidURL^$&%$&^")) {
	        System.out.println("url is valid");
	    } else {
	        System.out.println("url is invalid");
	    }
 
	}
}