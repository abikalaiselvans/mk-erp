package com.my.org.erp.chat;


import java.io.*;
import java.net.*;
import java.util.*;
import java.util.Enumeration;

public class ChatHandler implements Runnable {
  protected Socket socket;
 public String logins;
ChatServer obj;

public ChatHandler (String login)
{
this.logins=login;
}
  public ChatHandler (Socket socket,String logins) {
    this.socket = socket;
    this.logins= logins;
  }

  protected DataInputStream dataIn;
  protected DataOutputStream dataOut;
  protected Thread listener;

  public synchronized void start () {
    if (listener == null) {
      try {
        dataIn = new DataInputStream
          (new BufferedInputStream (socket.getInputStream ()));
        dataOut = new DataOutputStream
          (new BufferedOutputStream (socket.getOutputStream ()));

        //String message=yourname+" has logged on\n";
        //broadcastNew(message);

        listener = new Thread (this);
        listener.start ();

      } catch (IOException ignored) {}

    }
  }

  @SuppressWarnings("static-access")
public synchronized void stop () {
    if (listener != null) {
      try {
        if (listener != Thread.currentThread ())
          listener.interrupt ();
        listener = null;
        dataOut.close ();
String msg= "\n" + InetAddress.getLocalHost() + "has logged off.\n";
broadcast(msg);
obj.output.append("\n" + InetAddress.getLocalHost() + " has logged off.\n");
      } catch (IOException ignored) {
      }
    }
  }

   protected static Vector handlers = new Vector ();

  @SuppressWarnings("unchecked")
public void run () {
    try {
      handlers.addElement (this);
      while (!Thread.interrupted ()) {
        String message1 = dataIn.readUTF ();
       String message=message1;
        broadcast (message);
      }
    } catch (EOFException ignored) {
    } catch (IOException ex) {
      if (listener == Thread.currentThread ())
        ex.printStackTrace ();
    } finally {
      handlers.removeElement (this);
    }
    stop ();
  }

  protected void broadcast (String message) {
    synchronized (handlers) {
    	java.util.Enumeration enums = handlers.elements ();
      while (enums.hasMoreElements ()) {
        ChatHandler handler = (ChatHandler) enums.nextElement ();
        try {
          handler.dataOut.writeUTF (message);
          handler.dataOut.flush ();
        } catch (IOException ex) {
          handler.stop ();
        }
      }
    }
  }
  protected void broadcastNew (String message) {
    synchronized (handlers) {
      Enumeration enums = handlers.elements ();
      while (enums.hasMoreElements ()) {
        ChatHandler handler = (ChatHandler) enums.nextElement ();
        try {
          handler.dataOut.writeUTF (message);
          handler.dataOut.flush ();
        } catch (IOException ex) {
          handler.stop ();
        }
      }
    }
  }
}
