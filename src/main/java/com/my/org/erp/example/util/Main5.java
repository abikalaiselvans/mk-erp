package com.my.org.erp.example.util;

import java.util.Enumeration;
import java.util.Hashtable;

public class Main5 {
  public static void main(String[] args) {
    Hashtable<String, String> ht = new Hashtable<String, String>();

    ht.put("1", "One");
    ht.put("2", "Two");
    ht.put("3", "Three");

    Enumeration e = ht.keys();

    while (e.hasMoreElements()){
      System.out.println(e.nextElement());
    }
  }
}

/*
FTP Information
=======================
In addition to your cPanel, each account receives an FTP account for the purpose of uploading your files to the web server.

The FTP login below is for your main FTP account; you are able to create additional FTP logins within your cPanel account.

Your logins to FTP are as follows:

FTP Host: 50.22.16.2 -OR- ftp.finetechmachine.com (Once your domain resolves)
Username: finetech
Password: t6zYj02qD4

Please note that when uploading your files, make sure you upload INSIDE the "httpdocs" folder. Anything outside this folder will not be viewable by your website visitors.

*/