package com.my.org.erp.SmartAttendance;

import java.io.IOException;
import java.sql.CallableStatement;
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
import javax.servlet.http.HttpSession;

import com.my.org.erp.ServiceLogin.AbstractActionHandler;
import com.my.org.erp.ServiceLogin.DateUtil;
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
			if (action.equals("ATTCareers")  )
			{
				String name=request.getParameter("name");
				String fname=request.getParameter("fname");
				String dob=request.getParameter("dob");
				dob=DateUtil.FormateDateSQL(dob);
				String gender=request.getParameter("gender");
				String marital=request.getParameter("marital");
				String language1=request.getParameter("language1");
				String read1=request.getParameter("read1");
				String write1=request.getParameter("write1");
				String speak1=request.getParameter("speak1");
				String language2=request.getParameter("language2");
				String read2=request.getParameter("read2");
				String write2=request.getParameter("write2");
				String speak2=request.getParameter("speak2");
				String language3=request.getParameter("language3");
				String read3=request.getParameter("read3");
				String write3=request.getParameter("write3");
				String speak3=request.getParameter("speak3");
				if(!"X".equals(read1))
					read1="N";
				if(!"X".equals(read2))
					read2="N";
				if(!"X".equals(read3))
					read3="N";
				if(!"X".equals(write1))
					write1="N";
				if(!"X".equals(write2))
					write2="N";
				if(!"X".equals(write3))
					write3="N";
				

				if(!"X".equals(speak1))
					speak1="N";
				if(!"X".equals(speak2))
					speak2="N";
				if(!"X".equals(speak3))
					speak3="N";
				
				String exemployee=request.getParameter("exemployee");
				String passportno=request.getParameter("passportno");
				String passdate=request.getParameter("passdate");
				passdate=DateUtil.FormateDateSQL(passdate);
				
				String qualification=request.getParameter("qualification");
				String interestarea=request.getParameter("interestarea");
				String certificates=request.getParameter("certificates");
				String description=request.getParameter("description");
				
				String emailid=request.getParameter("emailid");
				String Mobile=request.getParameter("mobile");
				String yearofexperience=request.getParameter("yearofexperience");
				String applypost=request.getParameter("applypost");
				String referencename=request.getParameter("referencename");
				String previousdetails=request.getParameter("previousdetails");
				
				String currentlocation=request.getParameter("currentlocation");
				String interestedlocation=request.getParameter("interestedlocation");
				String referencephone=request.getParameter("referencephone");
				
				//currentlocation,interestedlocation,referencephone
				
				CallableStatement cs = con.prepareCall("{call COM_PRO_CAREERS(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
				cs.setString(1, "INSERT");
				cs.setString(2, "1");
				cs.setString(3, name);
				cs.setString(4, fname);
				cs.setString(5, dob);
				cs.setString(6, gender);
				cs.setString(7, marital);
				cs.setString(8, language1);
				cs.setString(9, read1);
				cs.setString(10, write1);
				cs.setString(11, speak1);
				cs.setString(12, language2);
				cs.setString(13, read2);
				cs.setString(14, write2);
				cs.setString(15, speak2);
				cs.setString(16, language3);
				cs.setString(17, read3);
				cs.setString(18, write3);
				cs.setString(19, speak3);
				cs.setString(20, exemployee);//DateUtil.FormateDateSQL(dor)
				cs.setString(21, passportno);
				cs.setString(22, passdate);
				cs.setString(23, qualification);
				cs.setString(24, interestarea);
				cs.setString(25, certificates);
				cs.setString(26, emailid);
				cs.setString(27,Mobile);
				cs.setString(28,yearofexperience);
				cs.setString(29,applypost);
				cs.setString(30,referencename);
				cs.setString(31,previousdetails);
				cs.setString(32,description);
				cs.setString(33,currentlocation);
				cs.setString(34,interestedlocation);
				cs.setString(35,referencephone);
				cs.setString(36,"N");
				cs.execute();
				HttpSession session = request.getSession();
				session.setAttribute("CAREERID",com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT MAX(INT_CAREERID) FROM  com_m_careers")[0][0]);
				con.close();   
				response.sendRedirect("Careerresponse.jsp");
				
				
			} 
			else if (action.equals("ATTCareersUpdate")  )
			{
				try 
				{
					String id=request.getParameter("id");
					String name=request.getParameter("name");
					String fname=request.getParameter("fname");
					String dob=request.getParameter("dob");
					dob=DateUtil.FormateDateSQL(dob);
					String gender=request.getParameter("gender");
					String marital=request.getParameter("marital");
					String language1=request.getParameter("language1");
					String read1=request.getParameter("read1");
					String write1=request.getParameter("write1");
					String speak1=request.getParameter("speak1");
					String language2=request.getParameter("language2");
					String read2=request.getParameter("read2");
					String write2=request.getParameter("write2");
					String speak2=request.getParameter("speak2");
					String language3=request.getParameter("language3");
					String read3=request.getParameter("read3");
					String write3=request.getParameter("write3");
					String speak3=request.getParameter("speak3");
					if(!"X".equals(read1))
						read1="N";
					if(!"X".equals(read2))
						read2="N";
					if(!"X".equals(read3))
						read3="N";
					if(!"X".equals(write1))
						write1="N";
					if(!"X".equals(write2))
						write2="N";
					if(!"X".equals(write3))
						write3="N";
					if(!"X".equals(speak1))
						speak1="N";
					if(!"X".equals(speak2))
						speak2="N";
					if(!"X".equals(speak3))
						speak3="N";
					String exemployee=request.getParameter("exemployee");
					String passportno=request.getParameter("passportno");
					String passdate=request.getParameter("passdate");
					passdate=DateUtil.FormateDateSQL(passdate);
					String qualification=request.getParameter("qualification");
					String interestarea=request.getParameter("interestarea");
					String certificates=request.getParameter("certificates");
					String description=request.getParameter("description");
					String emailid=request.getParameter("emailid");
					String Mobile=request.getParameter("mobile");
					String yearofexperience=request.getParameter("yearofexperience");
					String applypost=request.getParameter("applypost");
					String referencename=request.getParameter("referencename");
					String previousdetails=request.getParameter("previousdetails");
					String currentlocation=request.getParameter("currentlocation");
					String interestedlocation=request.getParameter("interestedlocation");
					String referencephone=request.getParameter("referencephone");
					
					//currentlocation,interestedlocation,referencephone
					
					CallableStatement cs = con.prepareCall("{call COM_PRO_CAREERS(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
					cs.setString(1, "UPDATE");
					cs.setString(2, id);
					cs.setString(3, name);
					cs.setString(4, fname);
					cs.setString(5, dob);
					cs.setString(6, gender);
					cs.setString(7, marital);
					cs.setString(8, language1);
					cs.setString(9, read1);
					cs.setString(10, write1);
					cs.setString(11, speak1);
					cs.setString(12, language2);
					cs.setString(13, read2);
					cs.setString(14, write2);
					cs.setString(15, speak2);
					cs.setString(16, language3);
					
					cs.setString(17, read3);
					cs.setString(18, write3);
					cs.setString(19, speak3);
					cs.setString(20, exemployee);//DateUtil.FormateDateSQL(dor)
					cs.setString(21, passportno);
					cs.setString(22, passdate);
					cs.setString(23, qualification);
					cs.setString(24, interestarea);
					cs.setString(25, certificates);
					cs.setString(26, emailid);
					cs.setString(27,Mobile);
					cs.setString(28,yearofexperience);
					cs.setString(29,applypost);
					cs.setString(30,referencename);
					cs.setString(31,previousdetails);
					cs.setString(32,description);
					cs.setString(33,currentlocation);
					cs.setString(34,interestedlocation);
					cs.setString(35,referencephone);
					cs.setString(36,"N");
					;
					cs.execute();
					
					//send a mail to person and HR
					String hr=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_HRMAILID FROM m_institution WHERE INT_ID=1")[0][0];
					//CareerResume.sendMailtoPerson(emailid, "Resume",id );
					//CareerResume.sendMailtoHr(hr, "Resume",id);
					 
					String content ="\n\n\n Your personal informations has been sent to our HR Team . \n\nOur team will contact you for further details.\n\nThis is your reference number : "+id+" Thank you.";
					content = content+"\n\nYou have any queries please mail to hr@careind.net or call us at 044-24340906 Extn 26. ";
					CareerResume.SimpleMail(hr, emailid, "Resume", content);
					
					String sql ="SELECT CHR_NAME,CHR_FATHERNAME,CHR_APPLIEDPOST FROM com_m_careers WHERE INT_CAREERID="+id;
					String data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					
					content=data[0][0]+" "+data[0][1]+" Uploaded the Resume. His/Her Reference Number :"+id+"  Thank you. ";
					CareerResume.SimpleMail(hr,hr, "Resume", content);
					con.close();   
					response.sendRedirect("Careerresponses.jsp");
				} catch (RuntimeException e) {
					 
					 System.out.println(e.getMessage());
				}
				

			}
			else if (action.equals("ATTCareersClosed")  )
			{
				String id=request.getParameter("id");
				String fromdt=request.getParameter("fromdt");
				String todt=request.getParameter("todt");
				String sql=" UPDATE com_m_careers SET CHR_RESUMEVIEWSTATUS='Y' WHERE INT_CAREERID="+id;
				com.my.org.erp.common.CommonFunctions.Execute(sql);
				con.close();   
				response.sendRedirect("Smart Attendance/Careerslist.jsp?&fromdt="+fromdt+"&todt="+todt);
			}
			else if (action.equals("ATTCareersSendaResume")  )
			{
				
				try 
				{
					String careid = request.getParameter("careid");
					String name = request.getParameter("name");
					String email = request.getParameter("email");
					String resumepath = request.getRealPath("/")+"CareersResume\\"+careid+".doc";
					 
					String subject=name+" RESUME" ;
					String content =" \n\n\n Hi, Find the attached file  for "+name +"\n\n\n\n";
					content = content +" Thanks & Regards, \n";
					//content = content +" KALAISELVAN K \n";
					content = content +" SMARTCAMPUS \n";
					content = content +" Mob: 9629314396 \n";
					sendResumeEmail(careid,name,email,resumepath,subject,content);
					con.close();   
					response.sendRedirect("Smart Attendance/CareersReport.jsp");
				} 
				catch (RuntimeException e) 
				{
					response.sendRedirect("error/index.jsp?error=" + e.getMessage());
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
		attachmentPart.setFileName(filename);
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