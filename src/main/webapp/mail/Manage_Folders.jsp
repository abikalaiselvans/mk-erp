<%@ page language="java"  import="java.util.*,javax.mail.*,javax.mail.internet.*,javax.activation.*" %>
<jsp:useBean id="mail" scope="application" class="com.ayush.utils.SendMail"/>
<link rel="stylesheet" href="compose.css">
<link rel="stylesheet" href="nav.css">
<%!String[]  mon={"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};%>

<%
String userid=(String)session.getAttribute("UserID");

if(userid==null)
{
%>
	<jsp:forward page="/login.jsp">
	<jsp:param name="control" value="mail"/>
	</jsp:forward>
	
	<%return;
	}else{

session.removeValue("currentfolder");
Vector Folder_Name = (Vector)session.getValue("FolderName");
 String name=(String)session.getValue("name");
	String nana=String.valueOf(name.charAt(0));
	nana=nana.toUpperCase();
	String sss=name.substring(1,name.length());
	
Properties props = new Properties();
Session sess = Session.getDefaultInstance(props, null);
String host = mail.exchangeServer;//String host = "192.168.10.15";//String host = "202.71.144.104"
String username = (String)session.getValue("ID");
String password = (String)session.getValue("password");
Store store = sess.getStore("imap");
store.connect(host, username, password);
Folder folder = store.getFolder("INBOX");
folder.open(Folder.READ_ONLY);
int newMessages = folder.getNewMessageCount();
int totalMessages = folder.getMessageCount();
%>
<html>
<head>
<title>Ayush Mail</title>
</head>
<body  onpaste="return false;" topmargin=0 leftmargin=0>

<form name=Manage action="post" >
<table border=0 width="780"  align=center cellspacing=0 cellpadding=0>
<tr>
	<td>

<table border=0 width="100%" cellspacing=0 cellpadding=0>
	<tr><td colspan=2><jsp:include page="mailtop2.html" flush="true"/></td></tr>
<tr>
<td  width="15%" align=center bgcolor=#ECECFD>
			
<table border="0" cellpadding=0 cellspacing=0>
<td class="navBg">

<table border="0" cellpadding=0 cellspacing=0 	width="138">

<tr><td class="navBg"><img src="images/dot.gif" height=19 width=8 border=0 alt=""></td>

<td width="100%"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="mail_homepage.jsp" onmouseover="status='Mail Home';return true" class="navtxt">MailHome</a></font></td>
</tr>

<tr><td colspan=2 class="navBorderOut"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							 <tr><td class="navBg"><img src="images/dot.gif" height=19 width=8 border=0
							 alt=""></td>
							<td width="100%"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="read_mail.jsp" onmouseover="status='Inbox';return true" 
							 class="navtxt">Inbox</a></font></td></tr>
							<tr><td colspan=2 class="navBorderOut"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td class="navBgSelected"><img src="images/sm_blue_arrow.gif" height="19"  width="8" border="0" alt=""></td>
							<td width="100%" class="navBgSelected"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1>Manage Folders</font></td></tr>
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
							<td width="100%"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="view_address.jsp" onmouseover="status='Address Book';return true" class="navtxt">Address Book</a></font></td></tr>
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
<tr><td class="navBg"><img src="images/dot.gif" height=19 width=8 border=0 alt=""></td>
<td width="100%"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="/servlet/logoff?control=mail" onmouseover="status='SignOut';return true" class="navtxt">SignOut</a></font></td></tr>
							
					</table>
							</td>
							</tr>
							 </table>
							 </td>
							 <td width=80%>
							<font face=verdana size=5 color=#996699><b>Manage Folders</b>	</font>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<font face=veradana size=3 color=#996745><b>Welcome</b> </font> <font color=red face=veradana size=3 ><b><%=nana+sss%></b></font><font face="veradana" size=3 color=#996745><b>&nbsp;&nbsp;to Ayush Mail </b></font>	
							
							<br>
					<table class=Mtable border =0 cellspacing=0 cellpadding=0 width="95%">
					<tr bgcolor="#336699" height="19">
					<td width="13" nowrap><font  color="#ffffff"><input name="allbox" type="checkbox" value="Check All" onClick="CA();" title="select or de-select all folders"></font>&nbsp;&nbsp;</td>
					<td nowrap width="45%"><font color="#ffffff"><b>Folder</b></font></td>
					<td nowrap><font color="#ffffff"><b>Messages&nbsp;&nbsp;</b></font></td>
					<td nowrap><font color="#ffffff"><b>New&nbsp;&nbsp;</b></font></td>
					<td align="right" nowrap><font class="sw" color="#ffffff"><b>Size</b></font></td>
					</tr>
					<tr>
						<td style="padding-bottom:5px;padding-top:5px;">&nbsp;</td>
							<td>Inbox</td>
							<td><%=totalMessages%></td>
							<td><%=newMessages%></td>
								<td>&nbsp;</td>
					</tr>
					<%
					folder = store.getFolder("Trash");
					folder.open(Folder.READ_ONLY);
					newMessages = folder.getNewMessageCount();
					totalMessages = folder.getMessageCount();
					%>
					<tr>
						<td style="padding-bottom:5px;padding-top:5px;">&nbsp;</td>
							<td>Trash</td>
							<td><%=totalMessages%></td>
							<td><%=newMessages%></td>
							<td>&nbsp;</td>
							</tr>
					<%
					int count=0;
					if(Folder_Name!=null)
					{
						Enumeration enumer = Folder_Name.elements();
						while (enumer.hasMoreElements())
						{
								String FolderName=(String)enumer.nextElement();
								folder = store.getFolder(FolderName);
								if(folder.exists())
								{
										folder.open(Folder.READ_ONLY);
										newMessages = folder.getNewMessageCount();
										totalMessages = folder.getMessageCount();
                                        //int siz=folder.length();

                                        
										%>
										<tr>
											<td ><input type="checkbox" name="foldername<%=count++%>" value=<%=FolderName%>></td>
												<td style="padding-bottom:5px;padding-top:5px;"><%=FolderName%></td>
												<td><%=totalMessages%></td>
												<td><%=newMessages%></td>
												<td>&nbsp;&nbsp;</td>
										</tr>


										<%
										}
								}
					}

					%>
					</table>
                        <br>
					<table border=0 width="80%">
						<tr>
							<td width="33%" align="center"><input type="button" Value=Rename class=sbttn onClick="rename()">
							</td>
							<td width="33%" align="center"><input type="button" Value=Delete class=sbttn onClick="Delete()">
							</td>
							<td width="33%" align="center"><input type="button" Value="Create New" class=sbttn onClick="create()">
							</td>
						</tr>
					</table>
				</td>
				</tr>
			</table>
		
			</form>
<body  onpaste='return false;'>

<script>
var cnt=<%=count%>;
function CA()
{
	
	var i=0;
	var flag=false;
	if(document.Manage.allbox.checked==true)
	{
		flag=true;
	}
	else{flag=false;}
	for( i=0;i<cnt;i++)
	{
		var j=eval("document.Manage.foldername"+i);
		
		j.checked=flag;
		
	}
	
}
function CheckNotClicked()
{
var count=0;
for( i=0;i<cnt;i++)
	{
		var j=eval("document.Manage.foldername"+i);
		if(j.checked==true)
		{
		count++;
		}
		
	}
	return count;
}
function rename()
{
	var count=0;
	count=CheckNotClicked();
	if(count==0){
	alert("Please select any folder name to rename");
	return;
	}
	else if (count>1)
	{
	alert("Please Select any one folder name to rename");
	return;

	}
	else
		{
		
		document.Manage.action="rename.jsp"
		document.Manage.submit();
	}
		
}
function Delete()
{
	var count=0;
	count=CheckNotClicked();
	if(count==0){
	alert("Please select any folder name to delete");
	return;
	}
	else
		{
		
		document.Manage.action="delete_folder.jsp"
		document.Manage.submit();
	}
		
}
function create()
{
  document.Manage.action="newfolder.jsp"
  document.Manage.submit();
}
</script>
</html>
<%}%>
	<%@ include file="/bottom.html"%>