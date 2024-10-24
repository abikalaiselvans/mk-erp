package com.my.org.erp.examples;

 
	public class XMLMessage extends com.my.org.erp.example.utils.Message 
	{
		 String getText() { return "<msg>text</msg>";}
		 public static void main(String[] args) 
		 {
		 System.out.println(new XMLMessage().getText());
		 }
	}