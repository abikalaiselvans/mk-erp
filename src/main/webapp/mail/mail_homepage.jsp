<%@ page language="java" import="java.util.*,javax.mail.*,javax.mail.internet.*,javax.activation.*,java.sql.*"%>
<jsp:useBean id="pool" class="com.ayush.beans.ConnectionPool" scope="application" />
<jsp:useBean id="mail" scope="application" class="com.ayush.utils.SendMail"/>
<%
String userid = (String)session.getAttribute("UserID");
String namee = (String)session.getValue("name");
String ctrl = (String)session.getValue("ctrl");

if(namee == null)	{
out.println("Name is Null"+namee);
%>

<jsp:forward page="/hel_login.jsp">
	<jsp:param name="control" value="mail" />
</jsp:forward>

<%	
return;

}else		{

	String username = (String)session.getValue("USRID");
	String name=(String)session.getValue("EMPID");
	String nana=String.valueOf(name.charAt(0));
	nana=nana.toUpperCase();
	String sss=name.substring(1,name.length());
	String host=mail.exchangeServer;
	Properties props = new Properties();
	Connection con=null;
	Statement stmt=null;
	ResultSet rs=null;
    String password = (String)session.getAttribute("USRPWD");
    
    String qry="";
	
if((ctrl!=null)&&(ctrl.equalsIgnoreCase("ven")))	{
	
	qry = "select folder_name from m_user where CHR_USRNAME='"+userid+"'"; 

}
else	{
	qry = "select folder_name from m_user where CHR_USRNAME="+userid;
				
	}
// Create empty properties
// Get session

Session sess = Session.getDefaultInstance(props, null);
//Session sess = Session.getInstance(props, null);
// Get the store

try{
	
Store store = sess.getStore("imap");
store.connect(host,username,password);
// Get folder
Folder folder = store.getFolder("INBOX");
folder.open(Folder.READ_ONLY);

// Get directory
int i=0,n=0;
int newMessages = folder.getNewMessageCount();
int inboxunreadMessages=folder.getUnreadMessageCount();
int totalMessages=folder.getMessageCount();
Vector folders=new Vector();

boolean flag=false;
		if(pool.getSize()==0){
			pool.setSize(10);
			pool.initializePool();
		}
		con=pool.getConnection();
		stmt = con.createStatement();
		Folder Trashfolder = store.getFolder("Trash");
		if(Trashfolder.exists())
		 {}
		else{ Trashfolder.create(0);
		}
		rs=stmt.executeQuery(qry);
		
		while(rs.next())
		{
			
			folders.addElement(rs.getString("FOLDER_NAME"));
			flag=true;
		}
		
session.putValue("FolderName",folders);
String folderName ="INBOX";
String src="images/folder_close.gif";
ArrayList FolderName = new ArrayList();
int _unreadMessages=0;

%>
<html>
<head>
<title>Inbox for <%=nana+sss%></title>
</head>
<link rel="stylesheet" href="nav.css">
<link rel="stylesheet" href="compose.css">

<body  onpaste="return false;" marginwidth="0" marginheight="0" leftmargin="0" topmargin="0" class=body>
<table border=0 width="780"  align=center cellspacing=0 cellpadding=0>
<tr>
<td>

<body  onpaste="return false;" marginwidth="0" marginheight="0" leftmargin="0" topmargin="0"
	class=body>
<table border=0 width="780" align=center cellspacing=0 cellpadding=0>
	<tr>
		<td>


<table border=0 width="100%" cellspacing=0 cellpadding=0>
			<tr>
				<td colspan=2><%@ include file="mailtop2.html"%></td>
			</tr>
			<tr>
				<td width=20% align="center" rowspan=2><%@ include
					file="mail_left.jsp"%></td>
				<td><font face=veradana size=3 color=#996745><b>&nbsp;&nbsp;Welcome</b>
				</font> <font color=red face=veradana size=3> <b><%=nana+sss%></b></font><font
					face="veradana" size=3 color=#996745><b>&nbsp;&nbsp;to
				Ayush Mail </b></font></td>
			</tr>
			<tr>
				<td align=left valign=top><font face=verdana size=2
					color=#996745>&nbsp;&nbsp;You have </font><font color=red size=2 face=verdana><b>&nbsp;
				<%=newMessages%>&nbsp; </b></font><font face=verdana size=2 color=#996745>new
				Mails in your Inbox</font> <a href="read_mail.jsp"><font face=verdana
					size=2 color=blue>Go to Inbox </font></a> <input type=hidden
					name=currentfolder value=<%=folderName %>></td>
			</tr>
		</table>
		<table width="957" height="25" align="center">
			<tr>
				<td align="right"><input type="button" name="Back" value="Back" onClick="javascript:history.go(-1)"</td>
			</tr>
		</table>
		<BR>
		<BR>
		<BR>
		<BR>

</body>
</html>

<%
// Close connection 
folder.close(true);
store.close();
}catch (Exception e){
  out.println("Exeception"+e);
	//response.sendRedirect("problem.jsp");
}
finally {
	
  if(stmt!=null) stmt.close();
  if(rs!=null)	rs.close();
  if(con!=null) pool.releaseConnection(con);
	}
}
%>
<%@ include file="/bottom.jsp"%>