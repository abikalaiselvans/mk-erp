package com.my.org.erp.sms;

import javax.comm.*;
import java.util.*;

/** Check each port to see if it is open. **/
public class PortListOpen {

  public static void main (String [] args) {

    Enumeration port_list = CommPortIdentifier.getPortIdentifiers ();

    while (port_list.hasMoreElements ()) {
      // Get the list of ports
      CommPortIdentifier port_id = 
        (CommPortIdentifier) port_list.nextElement ();

      // Find each ports type and name
      if (port_id.getPortType () == CommPortIdentifier.PORT_SERIAL) {
          System.out.println ("Serial port: " + port_id.getName ());

      } else if (port_id.getPortType () ==
                 CommPortIdentifier.PORT_PARALLEL) {
          System.out.println ("Parallel port: " + port_id.getName ());

      } else
          System.out.println ("Other port: " + port_id.getName ());

      // Attempt to open it
      try {
        CommPort port = port_id.open ("PortListOpen",20);
        System.out.println ("  Opened successfully");
        port.close ();

      }
      catch  (PortInUseException pe){
          System.out.println ("  Open failed");
          String owner_name = port_id.getCurrentOwner ();
          if (owner_name == null)
              System.out.println ("  Port Owned by unidentified app");
          else
              // The owner name not returned correctly unless it is
              // a Java program.
              System.out.println ("  " + owner_name);
      }
    }
  } //main
} // PortListOpen