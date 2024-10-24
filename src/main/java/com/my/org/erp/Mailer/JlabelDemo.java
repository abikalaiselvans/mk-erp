package com.my.org.erp.Mailer;

import java.awt.GridLayout;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JFrame;


public class JlabelDemo extends JPanel implements Runnable
{

	static JLabel jlbLabel1;
	public JlabelDemo() 
	{
		setLayout(new GridLayout(1, 1));
		jlbLabel1 = new JLabel("Text Only Label");
		jlbLabel1.setHorizontalTextPosition(JLabel.CENTER);
		add(jlbLabel1);
	}
	
	public static void main(String[] args) 
	{
		JFrame frame = new JFrame("jLabel Usage Demo");
		frame.addWindowListener(new WindowAdapter() 
		{
			public void windowClosing(WindowEvent e) 
			{
				System.exit(0);
			}
		});
		
		frame.setContentPane(new JlabelDemo());
		frame.pack();
		frame.setVisible(true);
		JlabelDemo l =  new JlabelDemo();
		Thread t =null;
	    while(true)
	    {
	    	t = new Thread(l);
	    	t.start();
	    }   
	}

	
	public void run() 
	{
		 SimpleDateFormat sdf = new SimpleDateFormat("dd-M-yyyy HH:mm:ss");
		 SimpleDateFormat sd = new SimpleDateFormat("HH");
		 int i = Integer.parseInt(sd.format(new Date()));
		 if(i >= 12)
		 {
	    	 System.out.println("Mail triger Starting");
			 jlbLabel1.setText("Mail triger Starting");
		 } 
	     else
	     {
	    	 jlbLabel1.setText(sdf.format(new Date()));
	     }
	}
}