<%@ page language="java"  import="java.util.*,javax.mail.*,javax.mail.internet.*,javax.activation.*" %> 
<jsp:useBean id="mail" scope="application" class="com.ayush.utils.SendMail"/>
<%String userid=(String)session.getAttribute("UserID");
if(userid==null)
	{%>
	<jsp:forward page="/login.jsp">
	<jsp:param name="control" value="mail"/>
	</jsp:forward>
	
	<%return;
		}else{%>
<%!String[]  mon={"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};%>

<%	String name=(String)session.getValue("name");
	String nana=String.valueOf(name.charAt(0));
	nana=nana.toUpperCase();
	String sss=name.substring(1,name.length());	

String _page=request.getParameter("page");
int page1=(_page==null)?1:Integer.parseInt(_page);
session.removeValue("currentfolder");

%>
<html>
<head>
<script src="inbox.js"></script>
<title>Ayush Mail</title>
<meta name="description" content="this is my company's website. The site contains information on our products and sercices">
<meta name="keywords" content="ayushhealth.com,health portal,Image Fusion pvt ltd, chennai,India">
<meta name="company" content="Image fusion pvt ltd">
<meta name="copyright" content="1998-2002 All rights reserved Imagefusion.com pvt Ltd">
</head>
<body  onpaste="return false;" marginwidth="0" marginheight="0" leftmargin="0" topmargin="0" class=body>
<form name=forminbox method=post>
<link rel="stylesheet" href="nav.css">
<link rel="stylesheet" href="compose.css">

<STYLE>
TR.H{BACKGROUND-COLOR: #DFEBFD}
TABLE.Mtable TD {border-bottom:1px solid #88CDD0; font-family:verdana,sans-serif; font-size:11px;color:#000099}

</STYLE>
<%
int cnt=0;
String host =mail.exchangeServer; 
String username = (String)session.getValue("ID");
String password = (String)session.getValue("password");
Vector folders=(Vector)session.getValue("FolderName");
// Create empty properties
Properties props = new Properties();

// Get session
Session sess = Session.getDefaultInstance(props, null);

// Get the store
try{
Store store = sess.getStore("imap");
store.connect(host, username, password);

// Get folder
Folder folder = store.getFolder("Trash");
folder.open(Folder.READ_ONLY);

Folder ibox = store.getFolder("INBOX");
int iboxmsgs=ibox.getUnreadMessageCount();

// Get directory
javax.mail.Message message[] = folder.getMessages();
int totalMessages = folder.getMessageCount();
int n=message.length;
String bgcolor="";
ArrayList FolderName = new ArrayList();
%>

	<table border=0 width="780"  align=center cellspacing=0 cellpadding=0>
<tr>
	<td>

<Table border=0 align=center width=100%>
<tr><td colspan=3>
 <jsp:include page="mailtop2.html" flush="true" />
  </td>
 </tr>
<tr>
<td width=15% valign=top bgcolor=#ECECFD>
	<br>
				<table border="0" align=center cellpadding=0 cellspacing=0>
					<tr>
						<td><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
						<td class="navBorderOut"><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
						<td><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
					</tr>
					<tr>
						
						<td>
							<table border="0" BGCOLOR=#ECECFD cellpadding=0 cellspacing=0 	width="138">
							<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td class=navbg><img src="images/dot.gif" height=19 width=8 border=0 alt=""></td>
							<td width="100%" class="navBg"><font face="Verdana,Sans-serif" color="#003366"
							 size=1><a href="mail_homepage.jsp" onmouseover="status='Mail Home';return true"  class="navtxt">Mail Home</a></font></td></tr>
							<tr><td colspan=2 class="navBorderOut"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td >&nbsp;&nbsp;<img src="images/folder_close.gif" border="0" alt="" width="17" height="14"><img src="images/dot.gif" height=19 width=8 border=0
							 alt=""></td>
							<td width="100%" ><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="read_mail.jsp" onmouseover="status='MailBox Folders';return true" 
							 class="navtxt-dark">Inbox (<%=iboxmsgs%>)</a></font></td></tr>
						
							 <tr><td>&nbsp;&nbsp;<img src="images/folder_open.gif" border="0" alt="" width="17" height="14"><img src="images/dot.gif" height=19 width=8 border=0
							 alt=""></td>
							<td width="100%" ><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><font class=navtxt-dark><b>Trash</b></a></font>	</td></tr>
							 <tr><td colspan=2 >&nbsp;</td></tr>
								<tr><td colspan=2 align=left><font face="Verdana,Sans-serif" size=1><b>&nbsp;&nbsp;&nbsp;<a href="Manage_Folders.jsp">My Folders</a>&nbsp;<a href="javascript:AddFolder();">[Add]</a></b></td></tr>
							 <%if(folders!=null)
								{%>
								
								
									<%
									 Enumeration enumer=folders.elements();
									 while (enumer.hasMoreElements())
									{
										String fname = (String)enumer.nextElement(); FolderName.add(fname);
										 %>
										<tr><td >&nbsp;&nbsp;<img src="images/folder_close.gif" border="0" alt="" width="17" height="14"><img src="images/dot.gif" height=19 width=8 border=0
							 alt=""></td>
							<td width="100%" ><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="javascript:SwitchFolder('<%=fname%>');"  class="navtxt-dark"><%=fname%></a></font> </td>
									<% }
										
								}
								 %>
							</table>
						</td>
					</tr>
				</table>
					<br>
				 <table border="0" align = center cellpadding=0 cellspacing=0>
					<tr>
						<td><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
						<td class="navBorderOut"><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
						<td><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
					</tr>
					<tr>
						<td class="navBorderOut"><img src="images/dot.gif" height=1 width=1
						 border=0 alt=""></td>
						<td class="navBg" >
							<table border="0"  cellpadding=0 cellspacing=0 	width="138">
								<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1
								 width=1 border=0 alt=""></td></tr>
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
							<td width="100%"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="view_address.jsp" onmouseover="status='Address Book';return true" 
							 class="navtxt">Address Book</a></font></td></tr>
							<tr><td colspan=2 class="navBorderOut"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td class="navBg"><img src="images/dot.gif" height=19 width=8 border=0
							 alt=""></td>
							<td width="100%"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1>Options</font></td></tr>
							<tr><td colspan=2 class="navBorderOut"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
	<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td></tr>
				<tr><td class="navBg"><img src="images/dot.gif" height=19 width=8 border=0	 alt=""></td>
					<td width="100%"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="/servlet/logoff?control=mail" onmouseover="status='SignOut';return true" class="navtxt">SignOut</a></font></td>
				</tr>
							
					</table>
				  </td>
				 <td class="navBorderOut"><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
				</tr>
				<tr>
				<td><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
				<td class="navBorderOut"><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
				<td><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
				</tr>
				<tr><td></td><td>
			</table>
	</td>

<td width=80% valign=top>
<table border=0 align=center width="95%" cellpadding=0 cellspacing=0>
<tr>
	<td  width=45%><font face=verdana size=5 color=#996699><b>Trash</font>
	<td  align=left width=50%><font face=veradana size=3 color=#996745><b>Welcome</b> </font> <font color=red face=veradana size=3 ><b><%=nana+sss%></b></font><font face="veradana" size=3 color=#996745><b>&nbsp;&nbsp;to Ayush Mail </b></font>
</td>
</tr>
 <table border=0 align=center width="95%" cellpadding=0 cellspacing=0>
	<tr>
<tr>
	<td  style="padding-bottom:5px;padding-top:5px;"><input type = button class=sbttn value = Delete onClick=" deleteTrash(<%=totalMessages%>)">
	</td>
	<td align = center style="padding-bottom:5px;padding-top:5px;"><input type = button class=sbttn value = "Mark As Unread" onClick="unread(<%=totalMessages%>)">
	</td>
	<td align=center style="padding-bottom:5px;padding-top:5px;">
		<select name=foldertomove class=drpdwn onChange="moveToFolder(<%=totalMessages%>)">
		<option selected value="empty">Move to Folder</option>

		<%if(folder !=null){
			Object Folder_Name[]=FolderName.toArray();
			for (int j=0;j<Folder_Name.length;j++)
		{%>
		<option value="<%=(String)Folder_Name[j]%>"><%=(String)Folder_Name[j]%></option>
		<%}
		}
		%>
		</select>

	</td>

</tr>
</table>
<table border=0 align=center width="95%" cellpadding=0 cellspacing=0 CLASS=MTABLE>
<tr bgcolor=#3E3E9B>
<td width="5%">&nbsp;</td>
<td width="5%">&nbsp;</td>
<td align=left style="padding-bottom:5px;padding-top:5px;"><font face=verdana size=1 color=white width="30%"><B>From</B></td>
<td align=left style="padding-bottom:5px;padding-top:5px;"><font face=verdana size=1 color=white width="45%"><B>Subject</B></td>
<td align=left style="padding-bottom:5px;padding-top:5px;"><font face=verdana size=1 color=white width="10%"><B>Date</B></td>
<td align=left style="padding-bottom:5px;padding-top:5px;"><font face=verdana size=1 color=white width="5%"><B>Size</B></td>

</tr>	

<%if(totalMessages==0)
	{%>
	<tr><td align=center colspan=6><br><br><br><font face=verdana size=5 color=#006699>This Folder has no Messages<br><br></td></tr>
<%}
else{
String image="";
int messageNumber=0;
boolean isFirst=true;
	//--totalMessages;

for(int i=0;i<totalMessages;i++) 
	{
	if(message[i].isSet(Flags.Flag.SEEN))
		{	bgcolor="#Ffffff"; 	image="images/readmail.gif";	}
	else
		{bgcolor="EAECFE";image="images/newmail.gif";}

messageNumber=message[i].getMessageNumber();
	//out.println("The message NO:"+messageNumber);
	if(isFirst)
		{%>
		<input type=hidden name=MaxMessageNumber value=<%=messageNumber%>>
		<%}
	isFirst=false;


	if(message[i].isSet(Flags.Flag.DELETED))
		{
		continue;
		}
	//.substring(0,10)
	cnt++;
%>	
	
<tr bgcolor=<%=bgcolor%>>
		<td align=center><img src="<%=image%>"></td>
		<td align=center><input type = checkbox name = msgno value="<%=message[i].getMessageNumber()%>" onClick="cca(this)"></td>
		
	<td><font face="verdana,sans-serif" size=1><%=message[i].getFrom()[0] %></td>
		<%Date date=message[i].getSentDate();
		  int mont=0; 
		 int dat1=0;
		 String dat="";
		if(date !=null)
		{
		 mont=date.getMonth(); 
		 dat1=date.getDate();
		 dat=date.toString();
		}
		 
	
	int _byte=message[i].getSize();
	if(_byte<1024)          
		_byte=1;
	else
		_byte=_byte/1024;
	//String d1=dat.subString(0,16);
	%>
		
   <td><font face="verdana,sans-serif" size=1><a href="javascript:ShowLetter(<%=message[i].getMessageNumber()%>)" class=messagetxt><%=message[i].getSubject()%></td>
	</td>
	<td align=left><font face="verdana,sans-serif" size=1>&nbsp;<% if (date!=null){out.println(mon[mont]);%><%out.println(dat1);}%>&nbsp;</td>
	<td align=left><font face="verdana,sans-serif" size=1><%=_byte%>&nbsp;k</td>

<%    
	}
	}
// Close connection 
%>
</tr>
<tr>
<td  colspan=6 align=left bgcolor=#3E3E9B style="padding-bottom:5px;padding-top:5px;"><A HREF="javascript:checkall(<%=cnt%>)"><font face=verdana size=1 color=#FFFFCC>Check All</A>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF="javascript:clearall(<%=cnt%>)"><font face=verdana size=1 color=#FFFFCC>Clear All</A>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</B></td>
</tr>
</table>
<table border=0 align=center width="95%" cellpadding=0 cellspacing=0>
<tr>
	<td  style="padding-bottom:5px;padding-top:5px;" ><input type = button class=sbttn value = Delete onClick=" deleteTrash(<%=totalMessages%>)">
	</td>
	<td align=center style="padding-bottom:5px;padding-top:5px;"><input type = button class=sbttn value = "Mark As Unread" onClick="unread(<%=totalMessages%>)">
	</td>
		<td align=center style="padding-bottom:5px;padding-top:5px;">
		<select name=foldertomove1 class=drpdwn onChange="moveToFolder(<%=totalMessages%>)">
		<option selected value="empty" >Move to Folder</option>

		<%if(folder !=null){
			Object Folder_Name[]=FolderName.toArray();
			for (int j=0;j<Folder_Name.length;j++)
		{%>
		<option value="<%=(String)Folder_Name[j]%>"><%=(String)Folder_Name[j]%></option>
		<%}
		}
		%>
		</select>

	</td>

</tr>
</table>
<%
folder.close(false);
	store.close();
	}catch (Exception e){out.println(e);}
%>	
</td>
</tr>
</table>
<input type=hidden name=currentfolder value=trash>
		<input type=hidden name=id>
</form>
</td></tr></table>
</body>
</html>
<script>
function AddFolder()
    {
	var nn = window.prompt("Please enter a name for your folder.","");
	if (nn != null && nn != "null" && nn != "") 
		{

		    var str = "new_folder.jsp?foldername="+nn;
            window.open(str, "_top");
	   
		}
	    
    }
</script>
<%}%>
	<%@ include file="/bottom.html"%>