<%@ page language="java" import="java.io.*,java.util.*,javax.mail.*,javax.mail.internet.*,javax.activation.*" buffer="none" %>
<jsp:useBean id="mail" scope="application" class="com.ayush.utils.SendMail"/>

<%  
    boolean mailsend=false;
    //String host=(String)application.getInitParameter("host");
	String host=mail.exchangeServer;
    //out.println("host>>>>>>"+host);
	String from=request.getParameter("from");
	//out.println("from>>>>>>"+from);
	String to=request.getParameter("to");
	//out.println("to>>>>>>>>"+to);
	String bcc=request.getParameter("bcc");
	//out.println("bcc>>>>>>>"+bcc);
	String cc=request.getParameter("cc");
		//out.println("cc>>>>>>>"+cc);
	String body=request.getParameter("body");
		//out.println("body>>>>>>>"+body);
	String subject=request.getParameter("subject");
		//out.println("subj>>>>>>>"+subject);
    String receipient=to+","+cc+","+bcc;  
		//out.println("rece>>>>>>>"+receipient);
	String next="";
	String notsend="";


	Properties props = System.getProperties(); 
	props.put("mail.smtp.host", host);
    Session sess = Session.getDefaultInstance(props, null);

	StringTokenizer rectok=new StringTokenizer(receipient,",");
	try{
					out.println("hai");
		while(rectok.hasMoreTokens()){ 
								out.println("hai");
			next=rectok.nextToken();
						out.println(next);
			javax.mail.Message message=new MimeMessage(sess);
			message.setFrom(new InternetAddress(from));
			InternetAddress[] address={new InternetAddress(next)};
			message.setRecipients(javax.mail.Message.RecipientType.TO,address);
			message.setSubject(subject);
			message.setSentDate(new Date());
			message.setText(body);
			Transport.send(message);
			mailsend=true;
	   }
	}catch(Exception ex){
		mailsend=false;	
		notsend=next;
	}
%>
<html>
	<body  onpaste='return false;'>
	<%@ include file="mailtop2.html"%>
	<br><br>
	<table align="center">
		<tr>
		   <%if(mailsend){ %>
			<td align="center"><font color="#FF0000" size=3><b>Your mail has been sent successfully!</b></font>
			</td> 
			<%}else{%>
			<td align="center">
			<font color="#FF0000" size=3><b>Your mail has not been sent</b>	
			</td>
			<%}%>
		</tr>
		
	</table>
	<body  onpaste='return false;'>
</html>