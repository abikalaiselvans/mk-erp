package com.my.org.erp.Mailer;

import java.awt.*;
import java.applet.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import com.my.org.erp.SmartInventory.InventoryFunctions;
import com.my.org.erp.common.CommonFunctions;
/*
 * <applet code="Clock" width=300 height=300>
    </applet>
 */
public class Clock extends Applet implements Runnable
{

	Thread thread;
	String csql="";
	String today ="";
	public void init()
	{
		setSize(600,120);
	}

	public void run()
	{
		while(thread!=null)
		{
			try
			{
                thread.sleep(1000);
                repaint();
			}
			catch(InterruptedException ex)
			{
                repaint();
			}

		}
 }

	public void start()
	{
		if(thread==null)
		{
           thread=new Thread(this);
           thread.start();
		}
	}
	public void stop()
	{
           thread=null;
    }

 DateFormat d= DateFormat.getTimeInstance();
 SimpleDateFormat sdf = new SimpleDateFormat("dd-M-yyyy HH:mm:ss");
 SimpleDateFormat sd = new SimpleDateFormat("HH");	
 
 public void paint(Graphics g)
 {
	 g.setFont(new Font(("Monospace"), Font.BOLD, 50));
     g.drawString(sdf.format(new Date()), 150, 50);
     int i = Integer.parseInt(sd.format(new Date()));
     if(i >= 12)
     {
    	 try 
    	 { 
    		 InventoryFunctions.dailyCollectionReport() ;
    	 } 
    	 catch (Exception e) 
    	 {
			e.printStackTrace();
		}
    	 
     }	 
     else
    	 g.drawString("", 150, 150);
 }
 
 
 
}
 