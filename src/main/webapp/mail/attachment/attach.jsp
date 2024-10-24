<%@ page language="java" import="java.util.Vector,java.util.Enumeration;" %>
<%
	session=request.getSession(true);
	String to=request.getParameter("to");
	String bcc=request.getParameter("bcc");
	String subject=request.getParameter("sub");
	String body = request.getParameter("body");
	String cc=request.getParameter("cc");
	String h1=request.getParameter("h1");
	String come=request.getParameter("come");
	if(to==null)
	{
	to=(String)session.getValue("to");
	bcc=(String)session.getValue("bcc");
	body = (String)session.getValue("body");
	subject=(String)session.getValue("subject");
	cc=(String)session.getValue("cc");
	h1=(String)session.getValue("h1");
	come=(String)session.getValue("come");
	}
	else
	{
	session.putValue("to",to);
	session.putValue("bcc",bcc);
	session.putValue("body",body);
	session.putValue("subject",subject);
	session.putValue("cc",cc);
	session.putValue("h1",h1);
	session.putValue("come",come);
	
	}
	bcc=(bcc==null)?"":bcc;
	cc=(cc==null)?"":cc;

	int i=3;
	String I=request.getParameter("i");

	if(I!=null)
	{
		i = Integer.parseInt(I);
	}

	String error=request.getParameter("error");
	if(error!=null)
	{
		out.println("Uploaded file(s) size exceeds 1 MB");
	}
%>
<Html>
<head>
<title>Attachments</title>
</head>
<body  onpaste="return false;" topmargin=0eftmargin=0>
<TABLE border=0  cellPadding=0 cellSpacing=0 width="780" height=100% align=center>
<tr>
<td valign=top>
<jsp:include page="mailtop21.html" flush="true"/>
<form action="attachment_bak.jsp" name = frm enctype="MULTIPART/FORM-DATA" method=post  >
<TABLE border=1  cellPadding=0 cellSpacing=0 width="40%" align=center>
<tr><td height=30>
	<tr><td colspan=2 align='center'><IMG src="/mail_new/images/mail.gif" WIDTH=310 HEIGHT=65></td></tr>
	<tr></tr>
</td></tr>
<tr>
<td> 
<table>
<tr><td></td></tr>
<%
int fcount=0;
if(i<3)
{
	Long Len=(Long)session.getValue("len");
	long len=Len.longValue();
	Vector files_add=(Vector)session.getValue("files_add");
	Vector vec_len=(Vector)session.getValue("vec_len");
	Enumeration enume=files_add.elements();
	int x=0;
	String next;
	
		while(enume.hasMoreElements())		{
			next=(String)enume.nextElement();
			session.putValue("attach"+fcount,next);%>
			<tr>
			<td height=20>
			<%=next%>
			<a href="remove.jsp?mode=remove<%=x%>">Remove</a>
			</td>
			</tr>	
<%
			fcount++;
			x++;
			}
%>
	</table>
	</td>
	
	<td>
	<table>

<%
	Enumeration enum_size=vec_len.elements();
	int y=0;
		while(enum_size.hasMoreElements())
		{
			Long Size=(Long)enum_size.nextElement();
			int size=Size.intValue();
			int b=0;
			b=size/1024;
			String kb=b+"";
			int bb=size%1024;
			if(bb!=0)
				kb=b+"."+bb+"&nbsp;&nbsp;KB";
%>
			<tr>
			<td height=20>
			File Size - <%=kb%>
			</td>
			</tr>	
<%
			y++;
			}
			%>
				</table>
				</td>
				</tr>
<%
		}
if(i!=0)
{
	for(int a=0;a<i;a++)
	{
%>
<tr>
	<td height=15>
		<input type=file name=filename<%=a%>>
	</td>
</tr>
<%	}
	if(i==3)
	{
		
	%>
	<INPUT TYPE="hidden" name=first value="first">
	<%	}	%>

<tr>
	<td colspan=2><INPUT TYPE="hidden" name="i" value=<%=i%>>
	<input type="submit" name = sub value="Attach">&nbsp;&nbsp;&nbsp;
	<input type = button value = close name = Close Onclick="for1()">
	<input type = hidden name = to  value = <%=to%> >
	<input type=hidden name=subject value=<%=subject%>>
	<input type=hidden name=body value=<%=body%>>
	<input type=hidden name=come value=<%=come%>>
	
	</td>
</tr>
<%	}
	String ffcount=""+fcount;session.putValue("fcount",ffcount);%>
</table>
</td></tr></TABLE>

<script language="javascript">
		function for1()
		{
		var to=document.frm.to.value;
		var subject=document.frm.subject.value;
		var come = document.frm.come.value;
		var body = document.frm.body.value;
		
		if(come=="compose")
		{
			location="http://localhost:8081/mail_new/compose_mail.jsp?to="+to+"&body='"+body+"'&subject='"+subject+"'&come='"+come+"'";
		
		}
		else if(come=="health")
		{
			
			location="http://localhost:8080/fusionmai1l/hel_mailform.jsp?to="+to+"&subject='"+subject+"'&come='"+come+"'";
			
		}
		}
		</script>
</td></tr>
<tr><td valign="bottom">
<table border="0">
<tr>
	<td>
<%-- <%@include file="/bottom.jsp" %> --%>
</td></tr></table>

</form>
</body>
</html>