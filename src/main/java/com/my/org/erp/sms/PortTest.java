package com.my.org.erp.sms;

import javax.comm.*;


/** Look for COM# ports on the local machine. **/
public class PortTest
{
  public static void main (String [] args) {
    String port_name;
    int i =2;
    while (true){
      i++;
      port_name = "COM" + i;
      try {
        @SuppressWarnings("unused")
		CommPortIdentifier port_id =
             CommPortIdentifier.getPortIdentifier (port_name);
         System.out.println ("Port " + port_name + " exists");

      }
      catch (NoSuchPortException e) {
        System.out.println ("No port " + port_name);
        break;
      }
    }
  } // main
} // class PortTest