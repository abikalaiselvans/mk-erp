package com.my.org.erp.Mailer;

import java.awt.Color;
import java.awt.FlowLayout;
import java.awt.Frame;
import java.awt.Label;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;

public class JavaDailyMailer extends Frame
{

	Label l1;
    JButton b1;
    int Hour=12;
    int minute=30;
    
    public void display()  
    {
        setTitle("SAMRT CAMPUS");
        setLayout(new  FlowLayout(100, 100, 100));
        setVisible(true);
        
         
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm a");
        Calendar cal = Calendar.getInstance();
        cal.getTime();
        l1=new Label(sdf.format(cal.getTime()));
        l1.setForeground(Color.BLUE);
        b1=new JButton("EXIT");
        b1.addActionListener(new ActionListener() 
        {
            public void actionPerformed(ActionEvent ae) 
            {
                  System.exit(0);
            }
        });
     
        
        try 
        {
            while (true) 
            {
                add(l1);
                add(b1);
                pack();
            	Thread.sleep(1000);
            }
        }
        catch (InterruptedException e) 
        {
            e.printStackTrace();
        }
}
    
	public static void main(String[] args) 
	{
		new JavaDailyMailer().display();

	}

}
