package com.my.org.erp.SmartHRM;

import java.io.File;
import java.io.IOException;
 
 
import java.sql.Statement;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
 
import javax.activation.FileDataSource;
 
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
 
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.SmartMailtemplates.Mail;
import com.my.org.erp.common.CommonFunctions;
import com.my.org.erp.setting.CommonData;
 
 
public class CareerActionHandler extends AbstractActionHandler 
{
	Statement st;
	
	@SuppressWarnings("deprecation")
	public synchronized void handle(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException 
	{
		try 
		{
			
			
			String action = request.getParameter("actionS");
			if (action.equals("HRMCareersClosed")  )
			{
				String id=request.getParameter("id");
				String fromdt=request.getParameter("fromdt");
				String todt=request.getParameter("todt");
				String sql=" UPDATE com_m_careers SET CHR_RESUMEVIEWSTATUS='Y' WHERE INT_CAREERID="+id;
				CommonFunctions.Execute(sql);
				con.close();   
				response.sendRedirect("Smart Attendance/Careerslist.jsp?&fromdt="+fromdt+"&todt="+todt);
			}
			else if (action.equals("HRMCareersSendaResume")  )
			{
				try 
				{
					String careid = request.getParameter("careid");
					String name = request.getParameter("name");
					String email = request.getParameter("email");
					String resumepath = request.getRealPath("/")+"uploadfiles\\CareersResume\\"+careid+".doc";
					File f = new File(resumepath);
					if(!f.exists())
						resumepath = request.getRealPath("/")+"images\\logo.jpg";
					
					String attachFiles[] = new String[1];
					attachFiles[0]= resumepath;
					
					System.out.println(resumepath);
					String subject=name+" HRM RESUME" ;
					String content =" \n\n\n Hi, Find the attached file  for "+name +"\n\n\n\n";
					content = content +" <br>Thanks & Regards, \n";
					content = content +" SMARTCAMPUS \n";
					content = content +" Mob: 9629314396 \n";
					//sendResumeEmail(careid,name,email,resumepath,subject,content);
					
					 
					System.out.println();
					System.out.println();
					String recipients[] = email.split(",");
					Mail.sendEmailWithAttachments(recipients, subject, content, attachFiles);
					
					 
					
					con.close();   
					response.sendRedirect("Smart HRM/CareersReport.jsp");
				} 
				catch (RuntimeException e) 
				{
					response.sendRedirect("../error/index.jsp?error=" + e.getMessage());
				}
			}
		} 
		catch (Exception e) 
		{
			System.out.println(e.getMessage());
			request.setAttribute("error", e.getMessage() );
            RequestDispatcher dispatchers = request.getRequestDispatcher("/error/index.jsp");
    		dispatchers.forward(request, response); 
			
		}
	}
	
	
	
	
	public static void sendResumeEmail(String careid,String name,String email,String resumepath,String subject,String content) 
	{
		String from =  CommonData.mailid;
		String to = email;
		String bodyText = content;
		String filename = resumepath;
		
		 
		Properties props = new Properties();
		props.setProperty("mail.transport.protocol", "smtp");
		props.setProperty("mail.host", "192.168.0.5");
		props.setProperty("mail.user", "connect");
		props.setProperty("mail.password", "connect");
		Session session = Session.getDefaultInstance(props, null);
 		try 
		{
			MimeMessage message = new MimeMessage(session);
			message.setFrom(new InternetAddress(from));
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(to));
			message.setSubject(subject);
			message.setSentDate(new Date());
			//
			// Set the email message text.
			//
			MimeBodyPart messagePart = new MimeBodyPart();
			messagePart.setText(bodyText);
			
			//
			// Set the email attachment file
			//
			MimeBodyPart attachmentPart = new MimeBodyPart();
			FileDataSource fileDataSource = new FileDataSource(filename) 
			{
				@Override
				public String getContentType() {
				return "application/octet-stream";
			}
		};

		attachmentPart.setDataHandler(new DataHandler(fileDataSource));
		  
		Multipart multipart = new MimeMultipart();
		multipart.addBodyPart(messagePart);
		multipart.addBodyPart(attachmentPart);
		 
		message.setContent(multipart);
		Transport.send(message);
		
		} 
		catch (MessagingException e) 
		{
			 System.out.println(e.getMessage());
		}
}

	
	
	
	
	 
	
		
}