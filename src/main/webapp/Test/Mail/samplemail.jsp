 
<%@ page import="com.my.org.erp.setting.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="java.io.File"%>
<%@ page import="java.io.IOException"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Properties"%>
<%@ page import="javax.activation.DataHandler"%>
<%@ page import="javax.activation.DataSource"%>
<%@ page import="javax.activation.FileDataSource"%>
<%@ page import="javax.mail.Authenticator"%>
<%@ page import="javax.mail.Message"%>
<%@ page import="javax.mail.MessagingException"%>
<%@ page import="javax.mail.Multipart"%>
<%@ page import="javax.mail.PasswordAuthentication"%>
<%@ page import="javax.mail.Session"%>
<%@ page import="javax.mail.Transport"%>
<%@ page import="javax.mail.internet.AddressException"%>
<%@ page import="javax.mail.internet.InternetAddress"%>
<%@ page import="javax.mail.internet.MimeBodyPart"%>
<%@ page import="javax.mail.internet.MimeMessage"%>
<%@ page import="javax.mail.internet.MimeMultipart"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="com.my.org.erp.SmartMail.AttachmentMail"%>

<%
try
{
	String cpyshortname=CommonFunctions.QueryExecute("SELECT CHR_SHORTNAME FROM M_INSTITUTION WHERE INT_ID=1")[0][0];
	String hData[][] = CommonFunctions.QueryExecute("SELECT CHR_HOST,CHR_USERID,CHR_PASSWORD,CHR_MAILID FROM  m_mailsetting WHERE INT_MAILID = 1");
	String host =hData[0][0]   ;
	String password =hData[0][2]   ;
	String mailFrom =hData[0][3]   ;
	String port = "465";  
	String subject =  "****** WELCOME TO THE  FAMILY *****" ;  
	String bodyMessage = " ";  
	String to = "abikalaiselvan@gmail.com";
	
	String[] attachments = new String [1];
	attachments[0] =request.getRealPath("/")+"images/mailbackground.jpg";
	 
 
	
	String content ="   ";
	content=content+"<html> ";
	content=content+"<head>";
	content=content+"<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'> ";
	content=content+"<title>:: SMARTCAMPUS ::</title> ";
	
	content=content+"<style type='text/css'> ";
	 
	
	content=content+" body { ";
	content=content+"	background: url('mailbackground.jpg');";
	 
	 
	content=content+" } ";
	 
 
 

	 
	content=content+"</style> ";

	content=content+"</head>  ";
	
	content=content+" <body > ";
	
	//background= 'mailbackground.jpg'
	content=content+"<table width='60' height='60' aign='center' > ";
	content=content+"  <tr> ";
	content=content+"    <td align='center' colspan='2' > s </td> ";
	content=content+"  </tr> ";
	content=content+"</table> ";
	
	 
	 
	content=content+"</body> ";
	content=content+"</html> ";
	 
	System.out.println();
	System.out.println(""+content);
	System.out.println();
	System.out.println();
	
	bodyMessage = bodyMessage+content;
	AttachmentMail.sendEmailWithAttachments( host, port, mailFrom, password,  to, subject, bodyMessage, attachments);
	out.println("Mail has been sent");
	
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
 
