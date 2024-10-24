<%@ page language="java"  import="java.util.*,javax.mail.*,javax.mail.internet.*,javax.activation.*" %> 
<jsp:useBean id="mail" scope="application" class="com.ayush.utils.SendMail"/>
<%String userid=(String)session.getAttribute("UserID");
  //out.println("userid:::::"+userid);

if(userid==null)
	{%>
	<jsp:forward page="/login.jsp">
	<jsp:param name="control" value="mail"/>
	</jsp:forward>
	
	<%return;
	}else{
	String name=(String)session.getValue("name");
	String nana=String.valueOf(name.charAt(0));
	nana=nana.toUpperCase();
	String sss=name.substring(1,name.length());
		
%>
<%!String[]  mon={"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
 int total=-1, mid=0, totmsg=0,midcount=0;
 String remsession;
 boolean SHOW_NEXT, SHOW_BACK;
%>


<html>
<head>
<script src="inbox.js">
</script>
<script language="javascript">
function next15()
        {
document.forminbox.next15.value=document.forminbox.remaining.value;
document.forminbox.action="read_mail.jsp";
document.forminbox.submit();
}
function back15()
        {
document.forminbox.next15.value=document.forminbox.previous.value;
document.forminbox.action="read_mail.jsp";
document.forminbox.submit();
}

</script>

<title>Ayush Mail</title>
<meta name="description" content="this is my company's website. The site contains information on our products and sercices">
<meta name="keywords" content="ayushhealth.com,health portal,Image Fusion pvt ltd, chennai,India">
<meta name="company" content="Image fusion pvt ltd">
<meta name="copyright" content="1998-2002 All rights reserved Imagefusion.com pvt Ltd">

</head>
<body  onpaste="return false;" marginwidth="0" marginheight="0" leftmargin="0" topmargin="0" class=body>


<link rel="stylesheet" href="nav.css">
<link rel="stylesheet" href="compose.css">

<STYLE>
TR.H{BACKGROUND-COLOR: #DFEBFD}
TABLE.Mtable TD {border-bottom:1px solid #88CDD0; font-family:verdana,sans-serif; font-size:11px;color:#000099}

</STYLE>
	
<%
//String host = "202.71.144.130";
//String host = "192.168.1.217";
String host = mail.exchangeServer;
int cnt=0;
String username = (String)session.getValue("ID");
session.putValue("username",username);
String password = (String)session.getValue("password");
Vector folders=(Vector)session.getValue("FolderName");
// Create empty properties
Properties props = new Properties();

// Get session
//Session sess = Session.getDefaultInstance(props, null);
Session sess = Session.getInstance( props, null);
// Get the store
try{
Store store = sess.getStore("imap");
store.connect(host, username, password);
String folderName =request.getParameter("currentfolder");
String sessfold=(String)session.getValue("currentfolder");

String src="";
boolean flag=false;
int inboxunreadMessages=0,_unreadMessages=0;
if(folderName==null&&sessfold!=null)
	{
		folderName=sessfold;
		src="images/folder_open.gif";
		flag=true;		
	}


if(folderName==null&&sessfold==null)
	{
		folderName="INBOX";
		src="images/folder_open.gif";
		flag=true;		
	}
	else
	{
		Folder TempFolder=store.getFolder("INBOX");
		TempFolder.open(Folder.READ_ONLY);
		inboxunreadMessages=TempFolder.getUnreadMessageCount();
		src="images/folder_close.gif";
		if(folderName.equalsIgnoreCase("inbox"))
			src="images/folder_open.gif";
	}

// Get folder
Folder folder = store.getFolder(folderName);
folder.open(Folder.READ_ONLY);
if(flag)
	{
		inboxunreadMessages=folder.getUnreadMessageCount();
	}
	else
	{
		_unreadMessages=folder.getUnreadMessageCount();
	}

// Get directory
int totalMessages = folder.getMessageCount();
String remain=request.getParameter("next15");
    if(remain!=null&&!remain.equals(""))
    {
        try{
    midcount=Integer.parseInt(remain);
    }catch(Exception expn){out.println("<br>FIRES HERE!!!"+expn);}
    }
    else{
    midcount=totalMessages;
    }


if(midcount>=15)
    {
totmsg=15;
}
else{
totmsg=midcount;
}
javax.mail.Message message[] = folder.getMessages();
int n=message.length;
String bgcolor="";
ArrayList FolderName = new ArrayList();
%>
<form name=forminbox method=post>
    <input type=hidden name=next15>
    <input type=hidden name=prev15>
	<table border=0 width="780"  align=center cellspacing=0 cellpadding=0>
<tr>
	<td>

<table border=0 width="100%" cellspacing=0 cellpadding=0>
	<tr><td colspan=2><%@ include file="mailtop2.html" %></td></tr>
<tr>
	<td valign=top align=center width="20%" bgcolor=#ECECFD>
	<%@ include file="mail_left.jsp"%>
	</td>
	

<td width=80% valign=top>
<table border=0 align=center width="95%" cellpadding=0 cellspacing=0>
<tr>
	<td  width=15% ><font face=verdana size=2 color=#996699><b><%=folderName%></b></font>
	</td>
	
<td  align=left width=50%><font face=veradana size=2 color=#996745><b>Welcome</b> </font> <font color=red face=veradana size=3 ><b><%=nana+sss%></b></font><font face="veradana" size=3 color=#996745></font>
</td></tr>
</table>
<table border=0 align=center width="95%" cellpadding=0 cellspacing=0>
<tr>
	<td   style="padding-bottom:5px;padding-top:5px;"><input type = button class=sbttn value = Delete onClick="deleteMessages(<%=totmsg%>)">
	</td>
	<td align=center style="padding-bottom:5px;padding-top:5px;"><input type = button class=sbttn value = "Mark As Unread" onClick="unread(<%=totmsg%>)">
	</td>
	<td align="center" style="padding-bottom:5px;padding-top:5px;">
		<select name=foldertomove class=drpdwn onChange="moveToFolder(<%=totmsg%>)">
		<option selected value="empty">Move to Folder</option>

		<%if(folder !=null)
		 {
			Object Folder_Name[]=FolderName.toArray();
			for (int j=0;j<Folder_Name.length;j++)
			 {  
		String str=(String)Folder_Name[j];	// to avoid the current folder in the Option
		if(!str.equalsIgnoreCase(folder.toString())){ try{%>  
		<option value="<%=(String)Folder_Name[j]%>"><%=(String)Folder_Name[j]%></option>
		<%}catch(Exception exn){out.println("This is :"+exn);}}}
		}
		%>

		</select>
		<!-- current folder's name --> 
		<input type=hidden name=currentfolder value=<%=folderName%>>
		<input type=hidden name=id>
	</td>

</tr>
</table>

<table border=0 align=center width="95%" cellpadding=0 cellspacing=0 CLASS=MTABLE>
<tr bgcolor=#3E3E9B>
<td width="5%">&nbsp;</td>
<td width="5%">&nbsp;</td>
<td width="5%">&nbsp;</td>
<td align=left style="padding-bottom:5px;padding-top:5px;"><font face=verdana size=1 color=white width="30%"><B>From</B></td>
<td align=left style="padding-bottom:5px;padding-top:5px;"><font face=verdana size=1 color=white width="45%"><B>Subject</B></td>
<td align=left style="padding-bottom:5px;padding-top:5px;"><font face=verdana size=1 color=white width="10%">&nbsp;<B>Date</B>&nbsp;</td>
<td align=left style="padding-bottom:5px;padding-top:5px;"><font face=verdana size=1 color=white width="5%"><B>Size</B></td>

</tr>	

<%int messageNumber=0;
  session.putValue("currentfolder",folderName);
  boolean isFirst=true;
	if(totalMessages==0)
	{%>
	<tr><td align=center colspan=6><br><br><br><font face=verdana size=5 color=#006699>This Folder has no Messages<br><br></td></tr>
	<%}
else 
	{
	String st="",attach="";
	String image="";
	//--totalMessages;
    
    String rem=request.getParameter("next15");
   
    if(rem!=null&&!rem.equals(""))
    {
    total=Integer.parseInt(rem);
    }
    else{
    total=totalMessages;
    SHOW_BACK=false;
    }
    if(total>totalMessages)
        {
    total=totalMessages;
    }
    if(total>15)
        {
    mid=total-15;
    SHOW_NEXT=true;
        }
    else {
    mid=0;    
    SHOW_NEXT=false;
        }
    if(total>0&&total!=totalMessages)
        {
    SHOW_BACK=true;
    }
	for (int i=total-1; i>=mid; i--) 
    	{
	st=message[i].getContentType();
	//out.println(i+"   "+message[i].getContentType());
	if((st.equalsIgnoreCase("multipart/mixed")))
	    	{
		attach="have_attachments.gif";
		    }
    else
		    {
		attach="have_no_attachments.gif";
		    }

	if(message[i].isSet(Flags.Flag.SEEN))
		{	bgcolor="ffffff"; 	image="images/readmail.gif";	
	    }
	else
		{bgcolor="EAECFE";image="images/newmail.gif";}
	messageNumber=message[i].getMessageNumber();
	if(isFirst)
		{%>
		<input type=hidden name=MaxMessageNumber value=<%=messageNumber%>>
		<%}
	isFirst=false;
	//.substring(0,10)
	cnt++;
	
%>


<tr bgcolor=<%=bgcolor%>>
		<td align=center><img src="<%=image%>"></td>
	<td ><a href="javascript:ShowLetter(<%=message[i].getMessageNumber()%>)" ><img  border =0 src="<%=attach%>" width=15 height=15></a></td>
		<td ><input type = checkbox name = msgno value="<%=messageNumber%>" onClick="cca(this)"></td>
		
	<td>
		<font face="verdana,sans-serif" size=1><%=message[i].getFrom()[0]%> </td>
	  <td><font face="verdana,sans-serif" size=1><a href="javascript:ShowLetter(<%=message[i].getMessageNumber()%>)" class=messagetxt><%=message[i].getSubject()%></a></td>
	</td>
		<%Date date=message[i].getSentDate();
		  int dat1=0;
		  int mont=0;
			if(date !=null)
		{
		 mont=date.getMonth(); 
		  dat1=date.getDate();
		String dat=date.toString();
		}
	%>
	<td align=left><font face="verdana,sans-serif" size=1>&nbsp;<% if (date!=null){out.println(mon[mont]);%><%out.println(dat1);}%></td>
	<%
	out.flush();
	int _byte=message[i].getSize();
	if(_byte<1024)          
		_byte=1;
	else
		_byte=_byte/1024;
	//String d1=dat.subString(0,16);
	
	
	%>
	
 
<td align=left><font face="verdana,sans-serif" size=1><%=_byte%>k</td>

<%  
	}
	}

// Close connection 
%>
</tr>
<tr>
<td  colspan=7 align=left bgcolor=#3E3E9B style="padding-bottom:5px;padding-top:5px;"><A HREF="javascript:checkall(<%=cnt%>)"><font face=verdana size=1 color=#FFFFCC>Check All</A>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<A HREF="javascript:clearall(<%=cnt%>)"><font face=verdana size=1 color=#FFFFCC>Clear All</A>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</B></td>
</tr>
</table>
<table border=0 align=center width="95%" cellpadding=0 cellspacing=0>
<tr>
	<td width=21% style="padding-bottom:5px;padding-top:5px;" onClick="deleteMessages(<%=totmsg%>)"><input type = button class=sbttn value = Delete>
	</td>
	<td width=30% align=center style="padding-bottom:5px;padding-top:5px;"><input type = button class=sbttn value = "Mark As Unread" onClick="unread(<%=totmsg%>)">
	</td>
	<td width=30% align=right style="padding-bottom:5px;padding-top:5px;">
		<select name=foldertomove1 class=drpdwn onChange="moveToFolder(<%=totmsg%>)">
		<option selected value="empty">Move to Folder</option>

		<%if(folder !=null)
		 {
			Object Folder_Name[]=FolderName.toArray();
			for (int j=0;j<Folder_Name.length;j++)
			 {
			String str=(String)Folder_Name[j];
			if(!str.equalsIgnoreCase(folder.toString())){ try{%>
		<option value="<%=(String)Folder_Name[j]%>"><%=(String)Folder_Name[j]%></option>
		<%}catch(Exception exn){out.println("This is :"+exn);}}}
		}
		%>
		</select>
	</td>   <%int bcnt=totalMessages-total;%>
            <td width="14%" align="center"><%if(SHOW_BACK&&bcnt>0){%><a href="javascript:back15()"><%}%><font face=arial size=1 color=blue>back</font></a> 
        <%if(SHOW_BACK&&bcnt>0){%><font color=red size=1 face=arial>(<%=bcnt%>)</font><%}%>
        <font face=arial size=1 color=brown>|</font><%if(SHOW_NEXT){%>
            <a href="javascript:next15()"><%}%><font face=arial size=1 color=blue>next</font></a>
            <%if(SHOW_NEXT){%><font color=red size=1 face=arial>(<%if(mid>0){%><%=mid%><%}%>)</font><%}%> </td>
</tr>
</table>
<%          
folder.close(false);
	store.close();
	}catch (Exception e){out.println("Here is the Problem: "+e);}
%>
		
</td>
</tr>
</table>
<input type=hidden name=remaining value=<%=mid%>>
<input type=hidden name=previous value=<%=total+15%>>
</form>
</body>
</html>
<%@ include file="/bottom.html"%>
<%String error=request.getParameter("error");

if(error!=null){%>
<script>
window.showModalDialog("Error.jsp?error=<%=error%>",'wname',"dialogWidth:360px;dialogHeight:217px;help:0;scroll:0;status:0;");
</script>
<%}
}
%>
