<%@ page language="java"  import="java.text.*, java.io.*,java.util.*,javax.mail.*,javax.mail.internet.*,javax.activation.*" %>
<jsp:useBean id="mail" scope="application" class="com.ayush.utils.SendMail"/>
<jsp:useBean id="pool" class="com.ayush.beans.ConnectionPool"
	scope="application" />
<%
	String userid=(String)session.getAttribute("UserID");
	if(userid==null)
	{
%>
	<jsp:forward page="/login.jsp">
	<jsp:param name="control" value="mail"/>
	</jsp:forward>
	
	<%return;
	}else{%>

<%!
int page;
String _page;
String[]  mon={"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
//String host = "www.ayushhealth.com";
String host=""; 
Properties props = new Properties();
%>

<%
host = mail.exchangeServer;
//String host = "192.168.1.217";
String name=(String)session.getValue("name");
String nana=String.valueOf(name.charAt(0));
nana=nana.toUpperCase();
String sss=name.substring(1,name.length());
_page=request.getParameter("page");

 page=(_page==null)?1:Integer.parseInt(_page);
boolean Flag=false,flag=false;
%>
<html>
<head>

<SCRIPT LANGUAGE="JavaScript">

function delMessages()
{
		document.forminbox.action="delmessages.jsp";
		document.forminbox.submit();
}
function moveTo(count)
{
document.forminbox.action="movemessages.jsp";
document.forminbox.submit();
}

function SwitchFolder(name)
	{
	document.forminbox.folder.value=name;
	document.forminbox.action="read_mail.jsp";
	document.forminbox.submit();
	}
function Reply(value)
{
	
	document.forminbox.to.value=value;
	document.forminbox.action="parseContent.jsp?ctrl=rep";
	document.forminbox.submit();
}
function Forward()
{

	document.forminbox.action="parseContent.jsp?ctrl=fwd";
	document.forminbox.submit();
}

</SCRIPT>
<title>Ayush Mailing Service</title>
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
TABLE.Mtable TD {border-bottom:1px solid #6D81DA; font-family:verdana,sans-serif; font-size:11px;color:#000099}

</STYLE>
<%
int cnt=0;
String username = (String)session.getValue("ID");
String password = (String)session.getValue("password");
Vector folders=(Vector)session.getValue("FolderName");
// Create empty properties
String Message_body="";
String from="",To="";
String subject="";
// Get session
Session sess = Session.getDefaultInstance(props, null);

// Get the store
try{
Store store = sess.getStore("imap");
store.connect(host, username, password);
String folderName = request.getParameter("currentfolder");
String src="";
int inboxunreadMessages=0,_unreadMessages=0;
int totalMessages=0;
if(folderName==null)
	{
		folderName="INBOX";
		src="images/folder_open.gif";
		flag=true;
	}
	else{if(folderName.equals("INBOX"))
	{
		folderName="INBOX";
		src="images/folder_open.gif";
		flag=true;
	}else
		{
		Folder TempFolder = store.getFolder("INBOX");
		TempFolder.open(Folder.READ_ONLY);
		inboxunreadMessages = TempFolder.getUnreadMessageCount();
        totalMessages=TempFolder.getMessageCount();
		src="images/folder_close.gif";
		}
	}
	String messageid="";
    messageid=request.getParameter("id");
	
int id=Integer.parseInt(messageid);

// Get folder
Folder folder = store.getFolder(folderName);
folder.open(Folder.READ_WRITE);
javax.mail.Message message = folder.getMessage(id);
message.setFlag(Flags.Flag.SEEN,true);
if(flag)
	{
		inboxunreadMessages=folder.getUnreadMessageCount();
	}
	else
	{
		_unreadMessages=folder.getUnreadMessageCount();
	}
// Get directory
//Sent=message.getSubject();
ArrayList FolderName = new ArrayList();
Address[] add = message.getFrom();
from=add[0].toString();
subject= message.getSubject();
Date recdate=message.getReceivedDate();
DateFormat df= new SimpleDateFormat("dd/MM/yyyy");
//String da=df.format(recdate);
//out.println("date is :"+da);
//out.println("<br> Time is: "+recdate.getHours()+":"+recdate.getMinutes()+":"+recdate.getSeconds());


Address[] to = message.getAllRecipients();
for(int i=0;i<to.length;i++)
	{
	To=To+to[i].toString()+",";
	}
int maxID=Integer.parseInt(request.getParameter("MaxMessageNumber"));
%>
<form name=forminbox method=post>
<input type=hidden name=msgno value=<%=messageid%>>
<inpUT type=hidden  name=control value="showLetter.jsp">
<input type=hidden name=MaxMessageNumber value=<%=maxID%>>

<table border=0 width="780"  align=center cellspacing=0 cellpadding=0>
<tr>
	<td>

<table border=0 width="100%" cellspacing=0 cellpadding=0>
<tr><td colspan=2><%@ include file="mailtop2.html" %></td></tr>

<tr>
	<td valign=top align=center width="20%" bgcolor=#ECECFD>
	<%@include file="mail_left.jsp"%>			
	</td>
	
<td width=80% valign=top>
<table border=0 align=center width="100%" cellpadding=0 cellspacing=0>
	<tr>
	<td colspan="5" valign=top align="center"><font face=veradana size=3 color=#996745><b>Welcome</b> </font> <font color=red face=veradana size=3 ><b><%=nana+sss%></b></font><font face="veradana" size=3 color=#996745><b>&nbsp;&nbsp;to Ayush Mail </b></font></td>
	</tr>
<tr>
<td align=center colspan=2>
	<table border=0  width=100% align=left cellpadding=0 cellspacing=0>
	<tr bgcolor=#336699>

	<td  width="15%" align="center" style="padding-bottom:5px;padding-top:5px;"><input
									type=button class=sbttn value=Reply
									onClick="Reply('<%=from%>')">
	</td>
	<td width="20%" align="center" style="padding-bottom:5px;padding-top:5px;"><input type = button class=sbttn value = Forward onClick="Forward()">	</td>
	<td width="15%" align="center" style="padding-bottom:5px;padding-top:5px;"><input type = button class=sbttn value = Delete onClick="delMessages()">
	</td>
	<td width="25%" align="center" style="padding-bottom:5px;padding-top:5px;"><input type = button class=sbttn value = "Mark As Unread" onClick="unread()">
	</td>
	<td width="25%" align="center" style="padding-bottom:5px;padding-top:5px;">
		<select name=foldertomove class=drpdwn onChange="moveTo()">
		<option selected value="">Move to Folder</option>

		<%if(folder !=null){
			Object Folder_Name[]=FolderName.toArray();
			for (int j=0;j<Folder_Name.length;j++)
		{   String fname=(String)Folder_Name[j];
             if(!fname.equalsIgnoreCase(folderName))
                  {%>
		<option value="<%=(String)Folder_Name[j]%>"><%=(String)Folder_Name[j]%></option>
		<%}
            }
		}
		%>
		</select>
	</td>
</tr>
<tr><td colspan=5 align=center>&nbsp;&nbsp; </td></tr>
<tr><td colspan=4 align="center">&nbsp;&nbsp; </td>
<td align=center><font class=text><%if(id!=maxID){%><a href="javascript:ShowPrevLetter('<%=id%>')"><%}%> <font face=arial size=1 color=blue>Previous</font></a> <font face=arial size=1 color=blue> | </font><%if(id!=1){%><a href="javascript:ShowNextLetter('<%=id%>')"><%}%><font face=arial size=1 color=blue>Next</font></td></tr>
<tr >
	<td align=right><font face=verdana size=1><b>From&nbsp;<font face=verdana size=2>:</b>&nbsp;&nbsp;&nbsp;</td>
	<td colspan=2 style="padding-top:5px;padding-bottom:5px;border-bottom: solid #769DB5 1px;"><font class=text><%=from%>&nbsp;&nbsp;|&nbsp;<b><a href="view_address.jsp">Save Addresses</a></b>&nbsp;|	
	</td>    <td colspan=2>&nbsp;</td>
</tr>
<tr>
	<td ALIGN=RIGHT ><font face=verdana size=1><b>Subject&nbsp;<font face=verdana size=2>:</b>&nbsp;&nbsp;&nbsp;</td>
	<td colspan=2 style="border-bottom: solid #769DB5 1px;padding-top:5px;padding-bottom:5px;"><font class=text><%=subject%></td>     <td colspan=2>&nbsp;</td>
</tr>
            <tr>
	<td align=right> <font face=verdana size=1><b>Date&nbsp;:</b>&nbsp;&nbsp;&nbsp;</td>
	<td colspan=2 style="border-bottom: solid #769DB5 1px;padding-top:5px;padding-bottom:5px;"><font class=text><%=recdate%></td>
    <td colspan=2>&nbsp;</td>
</tr>

</table>
</td>
</tr>
<tr>
	<td align=left>
	<%

		message.setFlag(Flags.Flag.SEEN,true);
		Object content = message.getContent();
		String corr="";
		String cont="";
		if (message.isMimeType("text/plain")) 
		{
			Flag=true;
		//out.println("1");
//			cont=(String)content;older one
			corr=(String)content;//by velu
			//Message_body=cont;
            Message_body=corr;//by rama
			StringTokenizer st=new StringTokenizer(corr,"\n");
			while(st.hasMoreTokens())
			{
				cont=cont+st.nextToken();
				cont=cont+"<br>";
				//out.println(cont);
			}
//			cont=cont.replaceAll((new Character('\n')).toString(),"<BR>");
		%>
			<font face=verdana size=2>
			<%out.println(cont);
		}
		else if (message.isMimeType("text/html")) 
		{ 
			out.println("<br>");
			cont=(String)content;
			Message_body=cont;
			out.println(cont);
		}
		else if (message.isMimeType("multipart/alternative")) 
		{
			//out.println("<br>3");
			Multipart mp = (Multipart)message.getContent();
			int numParts = mp.getCount();
			for(int j=0;j<numParts;j++) 
			{
				/*if (mp.getBodyPart(j).isMimeType("text/plain"))
				{
					out.println("<br>4");
					//cont=(String)mp.getBodyPart(j).getContent();
					corr=(String)mp.getBodyPart(j).getContent();
//					Message_body=cont;
					Message_body=corr;
//					cont=cont.replaceAll((new Character('\n')).toString(),"<BR>");
					StringTokenizer st=new StringTokenizer(corr,"\n");
					while(st.hasMoreTokens())
					{
						cont=cont+st.nextToken();
						cont=cont+"<br>";
						//out.println(cont);
					}			
				    out.println(cont);
				}	*/					// since the content displays twice
				if (mp.getBodyPart(j).isMimeType("text/html"))
				{
					//out.println("<br>5");	
					Message_body=Message_body+(String)mp.getBodyPart(j).getContent();
					out.println((String)mp.getBodyPart(j).getContent());
				}
			}
		}
		else if (message.isMimeType("multipart/mixed")) 
		{
			//out.println("<br>6");
			Multipart mp = (Multipart)message.getContent();
			int numParts = mp.getCount();
			int j=0;
			while(j<numParts)
			//for (int j=0;j<numParts;j++) 
			{
		 		Part part = mp.getBodyPart(j);
				String disposition = part.getDisposition();
				//out.println("<br>DIS  "+disposition+"  J  "+j);
				if ((disposition != null) &&((disposition.equals(Part.ATTACHMENT)) || (disposition.equals(Part.INLINE)))) 
				{
					//out.println("<br>7 attachment");
					
					
					String filename = part.getFileName();
									
					int count=filename.lastIndexOf('.');
					String Extension=filename.substring(++count);
					filename=saveFile(application.getRealPath("/"), part.getFileName(),part.getInputStream());
					
					if(Extension.startsWith("gif")||Extension.startsWith("jpg"))
					{
						
						filename="http://localhost:8081"+filename.substring(50);%>
						<a href="<%=filename%>">View Attachment</a>
<%						//out.println("<img src=attachments/"+filename+">");
					}else
					{
						filename="http://localhost:8081"+filename.substring(50);
						%>
						<a href="<%=filename%>">View Attachment</a>
                  <%}
  				}
				else if (disposition == null) 
				{
					MimeBodyPart mbp = (MimeBodyPart)part;
				    if (mbp.isMimeType("text/plain")) 
		            {
					//out.println("<br>10 J Value "+j);
						Message_body=(String)mbp.getContent();
					  //Message_body=Message_body.replaceAll((new Character('\n')).toString(),"<BR>");	
					 // out.println("<br>118");
				         corr=Message_body;
						 StringTokenizer st=new StringTokenizer(corr,"\n");
						 while(st.hasMoreTokens())
						{
							cont=cont+st.nextToken();
										cont=cont+"<br>";
										//out.println(cont);
						}			
						Message_body=cont;
						out.println(Message_body);	
						//break;
					} 
					else
					{
						//out.println("<br>11");
						
						String filename=part.getFileName();
						out.println("File name  "+filename);
					int count=filename.lastIndexOf('.');
					String Extension=filename.substring(++count);
					filename=saveFile(application.getRealPath("/"), part.getFileName(),part.getInputStream());
						filename="http://localhost:8081/"+filename.substring(37);
						//out.println("<br> The substring: "+filename);						
						%><br><br><br>
						<a href=<%=filename%>>View Attachment</a>
						<%//Multipart mes=(Multipart)part.getContent();
						//out.println("<br>Message Type "+mes.getContentType());
						/*int num = mes.getCount();
						for (int k = 0; k < num; ++k) 
						{
							if (mes.getBodyPart(k).isMimeType("text/html"))
							{
								out.println("<br>12");	Message_body=Message_body+(String)mes.getBodyPart(k).getContent();
								out.println((String)mes.getBodyPart(k).getContent());
							}
						} */

					}/*else closing braces*/
				//out.println("<br>2hai");
				}/*else if closing braces*/
			  j=j+1;
			 // out.println("<br>1Hai");
			}/* for j loop*/
	    }
			
			%>
		<br>	
		<input type=hidden name=currentfolder value="<%=folderName%>">
	</td>
</tr>
<tr>
<td align=center colspan=2>
	<table border=0  width=100% align=left cellpadding=0 cellspacing=0>
	<tr bgcolor=#336699>

	<td width="15%" align=center style="padding-bottom:5px;padding-top:5px;"><input type = button class=sbttn value = Reply onClick="Reply('<%=from%>')">
	</td>
	<td width="20%" align="center" style="padding-bottom:5px;padding-top:5px;"><input type = button class=sbttn value = Forward onClick="Forward()">	</td>
	<td width="15%" align="center" style="padding-bottom:5px;padding-top:5px;"><input type = button class=sbttn value = Delete onClick="delMessages()">
	</td>
	<td width="25%" align="center"style="padding-bottom:5px;padding-top:5px;"><input type = button class=sbttn value = "Mark As Unread" onClick="unread()">
	</td>
	<td width="25%" align="center" style="padding-bottom:5px;padding-top:5px;">
		<select name=foldertomove class=drpdwn onChange="moveTo()">
		<option selected value="">Move to Folder</option>

		<% if(folder !=null){
			Object Folder_Name[]=FolderName.toArray();
			for (int j=0;j<Folder_Name.length;j++)
		        { 
            String fname=(String)Folder_Name[j];
            if(!fname.equalsIgnoreCase(folderName))
                {
                %>
		<option value="<%=fname%>"><%=fname%></option>
		<%  }
                }
		}
		%>
		</select>
	</td>
</tr>
</table>
</td>
</tr>
</table>

<%
folder.close(false);
	store.close();
	}catch (Exception e){out.println("error"+e);}
%>
</td>
</tr>
</table>
<input type=hidden name=to>

<input type=hidden name=id> 
<%
String forward="";
Message_body="<BLOCKQUOTE style=\"BORDER-LEFT: #1010ff 3px solid; MARGIN-LEFT: 4px; PADDING-LEFT:5px\"><b>--------OriginalMessage----------</b><br><table><tr><td><font face=verdana size=2><b>From:</td><td><font face=verdana size=2>"+from+"</td></tr><tr><td><font face=verdana size=2><b>To:</td><td><font face=verdana size=2>"+To+"</td></tr><tr><td><font face=verdana size=2><b>Subject:</td><td><font face=verdana size=2>"+subject+"</td></tr></table><br><br>"+Message_body+"</blockquote>";
session.setAttribute("ForwardContent",Message_body);
session.setAttribute("subject",subject);
}
%>

</form>


</body>
</html>
<%@ include file="/bottom.jsp"%>

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
function unread()
{
		document.forminbox.action="MarkUnread.jsp"
		document.forminbox.submit();
}
function ShowNextLetter(id)
{
	var id=id;
		id--;
	   document.forminbox.id.value = id; 	
	   document.forminbox.action = "showLetter.jsp"
	   document.forminbox.submit();
	
}
function ShowPrevLetter(id)
{
	var id=id;
		id++;
	   document.forminbox.id.value = id; 	
	   document.forminbox.action = "showLetter.jsp";
	   document.forminbox.submit();
	
}
</script>
<%!
public String saveFile(String realPath, String filename,InputStream input)
{

	String Filename=filename;
	
	String Extension="";
	int count=filename.lastIndexOf('.');
	//String path="d://server/servers/default/default-app/ayushman_mail/attachments/";
	String path=realPath+"/fusionmail/attachments/test/";
    File file = new File(path+filename);
	try{
	
	for (int i=0; file.exists(); i++) 
	{
		
		Filename=filename.substring(0,count)+i;
		Extension=filename.substring((count+1));
		Filename=Filename+"."+Extension;
		
		file = new File(path+Filename);
		
	}
	int byt=0;
	
	FileOutputStream filecontent=new FileOutputStream(file);
	do{
      byt = input.read();
	  filecontent.write(byt);

	}while(byt!=-1);
	filecontent.close();
	input.close();
	}catch(FileNotFoundException f){}
	catch(IOException e){}
	return Filename;
}
	
%>