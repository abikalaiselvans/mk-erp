package Mailer;

 
import java.awt.*;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.mail.*;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.my.org.erp.setting.CommonData;

public class Mailer extends Frame{

    Label l1;
    
    public void display() throws MessagingException
    {
        setTitle("SMART MAIL");
        setLayout(new FlowLayout());
        setVisible(true);
        SimpleDateFormat sdf = new SimpleDateFormat("HH:mm a");
        Calendar cal = Calendar.getInstance();
        cal.getTime();
        l1=new Label(sdf.format(cal.getTime()));
        l1.setForeground(Color.BLUE);
     
        try 
        {
            while (true) 
            {
                l1.setText(sdf.format(Calendar.getInstance().getTime()));
                if(l1.getText().equals("14:50 PM"))
                {
                    String a[] = (""+CommonData.mailid).split(",");
                    Mailer.check(a,"subject","content");
                }
                add(l1);
                pack();
                Thread.sleep(60*1000);
            }
        }
        catch (InterruptedException e) 
        {
            e.printStackTrace();
        }
    }
    
    public static void check (String recipients[] , String subject,String content) throws AddressException, MessagingException
    {
        
        boolean debug = false;
        String host ="cams.careind.net";
        String user ="connect";
        String password ="connect";
        String from =""+CommonData.mailid;
        Properties props = new Properties();
        props.setProperty("mail.transport.protocol", "smtp");
        props.setProperty("mail.host", ""+host);
        props.setProperty("mail.user", ""+user);
        props.setProperty("mail.password", ""+password);
        Session session = Session.getDefaultInstance(props, null);
        session.setDebug(debug); 
        Message msg = new MimeMessage(session);
        InternetAddress addressFrom = new InternetAddress(from);
        msg.setFrom(addressFrom);
        InternetAddress[] addressTo = new InternetAddress[recipients.length]; 
        for (int i = 0; i < recipients.length; i++)
        	addressTo[i] = new InternetAddress(recipients[i]);
        msg.setRecipients(Message.RecipientType.BCC, addressTo);
        msg.addHeader("MyHeaderName", "myHeaderValue");
        msg.setSubject(subject);
        msg.setContent(content, "text/html");
		Transport.send(msg);   
    }  
    
    public static void main(String[] args) throws MessagingException 
    {
        new Mailer().display();
    }
    
}
