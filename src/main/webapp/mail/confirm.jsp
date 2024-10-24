<%@ page language="java" import="java.util.*,java.net.*,javax.mail.*,javax.activation.*,javax.mail.internet.*,java.io.*" buffer="none" %>
<jsp:useBean id="mail" scope="application" class="com.ayush.utils.SendMail"/>
<HTML>
<HEAD>
<TITLE> Ayush- Mail Confirm page </TITLE>
</HEAD>
<link rel="stylesheet" href="compose.css">
<link rel="stylesheet" href="nav.css">
<Body marginwidth=0 marginheight=0 leftmargin=0 topmargin=0>
<form>
<table width=780 height=100% align=center border=0 cellpadding=0 cellspacing=0>
<tr>
<td valign=top >
<table width=100% border=0 cellpadding=0 cellspacing=0>
<tr>
<td colspan=2><jsp:include page="mailtop2.html" flush="true" />
</td>
</tr>
<tr>
<td width=15% class="navBg">
<table width=100%  height=240 border=0 cellpadding=0 cellspacing=0>
<tr>
<td>
<table border="0" cellpadding=0 cellspacing=0 >
					<tr>
				<td><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
				<td class="navBorderOut"><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
				<td><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
					</tr>
				 	<tr>
						<td><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
						<td class="navBorderOut"><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
						<td><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
					</tr>
						 <tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1
						 width=1 border=0 alt=""></td></tr>
							<tr><td class="navBg"><img src="images/dot.gif" height=19 width=8 border=0
							 alt=""></td>
							<td width="100%"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="mail_homepage.jsp" onmouseover="status='Compose';return true" 
							 class="navtxt">MailHome</a></font></td></tr>
							<tr><td colspan=2 class="navBorderOut"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							 <tr><td class="navBg"><img src="images/dot.gif" height=19 width=8 border=0
							 alt=""></td>
							<td width="100%"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="read_mail.jsp" onmouseover="status='Compose';return true" 
							 class="navtxt">Inbox</a></font></td></tr>
							<tr><td colspan=2 class="navBorderOut"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td class="navBg"><img src="images/dot.gif" height=19 width=8 border=0
							 alt=""></td>
							<td width="100%"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="compose_mail.jsp" onmouseover="status='Compose';return true" 
							 class="navtxt">Compose</a></font></td></tr>
							<tr><td colspan=2 class="navBorderOut"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td class="navBg"><img src="images/dot.gif" height=19 width=8 border=0
							 alt=""></td>
							<td width="100%"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="view_address.jsp" 
							onmouseover="status='Address Book';return true" class="navtxt">Address Book</a></font></td></tr>
							<tr><td colspan=2 class="navBorderOut"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td class="navBg"><img src="images/dot.gif" height=19 width=8 border=0
							 alt=""></td>
							<td width="100%"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="http://login.mail.lycos.com/bounce.shtml?goto=options&cached=1" onmouseover="status='Options';return true" 
							 class="navtxt">Options</a></font></td></tr>
                        	<tr><td colspan=2 class="navBorderOut"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
						
                        <tr><td class="navBg"><img src="images/dot.gif" height=19 width=8 border=0
							 alt=""></td>
							<td width="100%"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="/servlet/logoff?control=mail" onmouseover="status='Compose';return true" 
							 class="navtxt">SignOut</a></font></td></tr>
							</table>
</td>
<td width=80% align="center">
<br><br>
<table border="0" cellpadding=0 cellspacing=0>
<tr>
<td>&nbsp;</td>
</tr>

<tr>
	<td align=center >
	<font face=verdana size=2 color=#3300CC><b>AyushHealth Mailing Service </b>: Message Confirmation</font><BR><BR>
	</td>
</tr>
<%
	String path=application.getRealPath("/")+"mail_new/attachment/test/";

	String host = mail.exchangeServer;

	//String host=(String)application.getInitParameter("host");
	String subject=request.getParameter("subject");
	String from=request.getParameter("from");
	String to=request.getParameter("to");
	
	String h1=request.getParameter("h1");
	String bcc=request.getParameter("bcc");
	String cc=request.getParameter("cc");
	String body=request.getParameter("body");
	ArrayList arCC=new ArrayList();
	ArrayList arTO=new ArrayList();
	ArrayList arBCC=new ArrayList();

%>

<tr>
	<td align=center>
		<p> <font face=arial size=2 color=#000099>Your message has been sent To:</p>
	</td>
</tr>
<tr><td>&nbsp;&nbsp;</td></tr>
<tr>
    <td align=center>
	<p>

<%	String receipientTO="";  
	String receipientCC="";
	String receipientBCC="", receipient = "";
if(to!=null){
	receipient=to;}
	if(cc!=null)
	{
		receipient=cc;}
		if(cc!=null && to!=null)
		{
			receipient=to+","+cc;
		}
				if(cc!=null && bcc!=null)
		{
			receipient=bcc+","+cc;
		}
				if(to!=null && bcc!=null)
		{
			receipient=to+","+bcc;
		}
		if(bcc!=null)
		{receipient=bcc;}
	if(cc!=null){
		receipientCC=cc;
		StringTokenizer rectok=new StringTokenizer(receipientCC,",");
		while(rectok.hasMoreTokens()){
			arCC.add(rectok.nextToken());
			//cc1=rectok.nextToken();
		}
	}
	if(to!=null){
		receipientTO=to;
		StringTokenizer rectok=new StringTokenizer(receipientTO,",");
		while(rectok.hasMoreTokens()){
			arTO.add(rectok.nextToken());
			}
		}
	if(bcc!=null){
		receipientBCC=bcc;
		StringTokenizer rectok=new StringTokenizer(receipientBCC,",");
		while(rectok.hasMoreTokens()){
			arBCC.add(rectok.nextToken());
			}
		}
			
	Properties props = System.getProperties();
	Vector files_add=new Vector();
	Vector vec_len=new Vector();
	long len=0;
	Enumeration enumer=null;
	int filecount=0;
	if(h1.equals("yes")){
		files_add=(Vector)session.getValue("files_add");
		filecount=files_add.size();
		vec_len=(Vector)session.getValue("vec_len");
		Long Len=(Long)session.getValue("len");
		len=Len.longValue();
		enumer=files_add.elements();
	}
//props.put("mail.smtp.host", host);
props.put("mail.smtp.host", host);
// Get session

Session sess = Session.getInstance( props, null);
//Session sess = Session.getDefaultInstance(props, null); ///// changed by Kali/2009 dated Feb 21/2009
StringBuffer next =new StringBuffer();
	try{
			// Define message
			javax.mail.Message message=new MimeMessage(sess);
			message.setFrom(new InternetAddress(from));
			if(to!=null){
				
			InternetAddress[] addressTO=new InternetAddress[arTO.size()];
			for(int i=0;i<arTO.size();i++)
				{
				
					addressTO[i]=new InternetAddress(arTO.get(i).toString());
					out.println("\t <font face=arial size=2 color=red>"+addressTO[i]+","+"</font>");
					
					message.addRecipient(javax.mail.Message.RecipientType.TO,addressTO[i]);
					

				}
			}
			if(bcc!=null){
			InternetAddress[] addressBCC=new InternetAddress[arBCC.size()];
			for(int i=0;i<arBCC.size();i++)
				{
				out.println("hai");
					addressBCC[i]=new InternetAddress(arBCC.get(i).toString());
					out.println("\t <font face=arial size=2 color=red>"+addressBCC[i]+"</font>");
					message.addRecipient(javax.mail.Message.RecipientType.BCC,addressBCC[i]);
					}
			}
			if(cc!=null){
			InternetAddress[] cc2=new InternetAddress[arCC.size()];
			for(int i=0;i<arCC.size();i++)
				{
					cc2[i]=new InternetAddress(arCC.get(i).toString());
					out.println(",\t <font face=arial size=2 color=red>"+cc2[i]+"</font>");
					message.addRecipient(javax.mail.Message.RecipientType.CC,cc2[i]);
				}
			}
			message.setSubject(subject);
			message.setSentDate(new Date());
			javax.mail.internet.MimeBodyPart mbp=new MimeBodyPart();
			if(filecount==0)
			{
				  message.setText(body);
			}
			else
			{
				    mbp.setText(body);
					javax.mail.Multipart multipart=new MimeMultipart();
					multipart.addBodyPart(mbp);
					message.setDisposition(Part.ATTACHMENT);

					while(enumer.hasMoreElements())
					{
								String obj=(String)enumer.nextElement();
								String fp=path+obj;
								File f=new File(fp);
								mbp=new MimeBodyPart();
								DataSource ds=new FileDataSource(fp);
								mbp.setDataHandler(new DataHandler(ds));
								mbp.setFileName(fp);
								multipart.addBodyPart(mbp);
								message.setContent(multipart);
				}
				
					
		}
			Transport.send(message);
		// Send message
		%>
<font face=arial size=2 color=#3838BA> <%=next%>
    </p>
	</td>
</tr>
<%	}
	catch(Exception e11)
	{
		out.println("This is Exception"+e11);
	}finally	{
		session.removeValue("to");
		session.removeValue("bcc");
		session.removeValue("subject");
		session.removeValue("cc");
		session.removeValue("hi");
		session.removeValue("come");
		session.removeValue("body");
		
	}
%>

</table>
</td>
</tr>
<!-- <tr><td colspan=2 align="center"><input type=button name="more" value="SendMoreMails"></td></tr>
 --></table>
</td></tr></table>
<table align="center">
<tr>
<td align=right>
<input type=button name=Back value=Back onClick="javascript:history.go(-1)">
</td>
</tr>
</table>

</td></tr>
<tr><td valign="bottom">
<table border="0">
<tr><td>
<jsp:include page="/bottom.jsp" flush="true"/>
</td></tr>
</table>
</td>
</tr>
</table>
</form>
</body>
</html>