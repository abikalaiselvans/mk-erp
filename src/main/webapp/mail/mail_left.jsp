<%@ page language="java" import="java.util.*"%>
<html>
<head>
<script language="javascript" src="inbox.js">

</script>
</head>
<body  onpaste="return false;" marginwidth="0" marginheight="0" leftmargin="0" topmargin="0" class=body>
<form name=forminbox method=post>
<link rel="stylesheet" href="nav.css">
<link rel="stylesheet" href="compose.css">

<STYLE>
TR.H{BACKGROUND-COLOR: #DFEBFD}
TABLE.Mtable TD {border-bottom:1px solid #88CDD0; font-family:verdana,sans-serif; font-size:11px;color:#000099}

</STYLE>
<table border=0 width="100%" cellspacing=0 cellpadding=0>
<tr>
	<td valign=top width="20%" bgcolor=#ECECFD>
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
						<tr>
					<td>&nbsp;&nbsp;<img src="<%=src%>" border="0" alt=""> </td>
					<td width="100%" ><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="javascript:SwitchFolder('Inbox');" class="navtxt-dark"><%if(flag){%><b><%}%>Inbox</b>&nbsp;(<%=inboxunreadMessages%>)</a></font></td>
				</tr>
		
							 <tr><td>&nbsp;&nbsp;<img src="images/folder_close.gif" border="0" alt="" width="17" height="14"><img src="images/dot.gif" height=19 width=8 border=0
							 alt=""></td>
							<td width="100%" ><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="trash.jsp" onmouseover="status='Trash Folder'" class="navtxt-dark">Trash</a></font></td></tr>
							 <tr><td colspan=2 >&nbsp;</td></tr>
								<tr><td colspan=2 align=left><font face="Verdana,Sans-serif" size=1><b>&nbsp;&nbsp;&nbsp;<a href="Manage_Folders.jsp">My Folders</a>&nbsp;<a href="javascript:AddFolder();">[Add]</a></b></td></tr>
							 <%if(folders!=null)
	             {%>
				  <%
						FolderName.add(folderName);
						Enumeration enumer=folders.elements();
						while (enumer.hasMoreElements())
						{
							String fname = (String)enumer.nextElement(); 
							//out.println("<br>121"+fname);
							FolderName.add(fname);
							flag=false;
							int unreadMessages=0;
							if(fname.equals(folderName))
							{
								src="images/folder_open.gif";
								flag=true;
								unreadMessages=_unreadMessages;
								//out.println("This is inside the if part:"+unreadMessages);
							}
							else
							{
								Folder Tempfolder = store.getFolder(fname);
								Tempfolder.open(Folder.READ_ONLY);
								unreadMessages=Tempfolder.getUnreadMessageCount();
								src="images/folder_close.gif";
							}
						//	FolderName.add("INBOX");
							 %>
			<tr><td >&nbsp;&nbsp;<img src="<%=src%>" border="0" alt=""><img src="images/dot.gif" height=19 width=8 border=0
							 alt=""></td>
							<td width="100%" ><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="javascript:SwitchFolder('<%=fname%>');"  class="navtxt-dark"><%if(flag){%><b><%}%><%=fname%>&nbsp;&nbsp;<b>(<%=unreadMessages%>)</a></font> </td>
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
							<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>

<tr><td class="navBg"><img src="images/dot.gif" height=19 width=8 border=0	 alt=""></td>
<td width="100%"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1>
<a href="/servlet/logoff?control=mail" onmouseover="status='SignOut';return true" class="navtxt">SignOut</a></font></td>
	</tr>



							<tr><td colspan=2 class="navBorderOut"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							
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

</tr>
</table>
