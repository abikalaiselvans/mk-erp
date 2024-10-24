<%@ page language="java" import="java.io.*"%>

<%
	String name = (String)session.getAttribute("name");
	String nana = String.valueOf(name.charAt(0));
	nana = nana.toUpperCase();
	String sss = name.substring(1,name.length());
%>

<HTML>
<HEAD>
<TITLE> Ayush - Mail </TITLE>
</HEAD>
<style>
			.b
			{
				border:1px solid #9966FF;
				background:#Ffffff;
				color:#517049;
				FONT-FAMILY:"verdana"
				font-size:10px;
				font-weight:plain
			}
			.button
			{
				border:1px solid #9966FF;
				background:#Ffffff;
				color:#000000;
				FONT-FAMILY:"verdana"
				font-size:11px;
				font-weight:plain

			}
			</style>
<script language=javascript>
function sp(name)
{
Name=name;
Name=eval("document.frm."+Name+".value");
var spchararray=["~","`","!","(",")","$","%","^","&","*","+","|","<",">","/","?","#","[","]","\"","=",":","{","}","[","]","\\"];
for(i=0;i<=Name.length;i++){
var b=Name.charAt(i);
	{
		for(j=0;j<=spchararray.length;j++){
			if(b==spchararray[j])
			{
				alert("Should not  allowed special characters, expect  @ , - , _ , ; ,and , ");
				eval("document.frm."+name+".focus()");
				return true; 
			}
		}
	}

}		
}
function email(mail)
{
	if ((mail.indexOf('@')==-1)||(mail.indexOf('.')==-1)||((mail.indexOf('.'))-2)==(mail.indexOf('@'))||((mail.indexOf('.'))-1)== (mail.indexOf('@'))||(mail.charAt(mail.indexOf('@')-1)==""))
		{	
			alert("correct this mail id    "+mail);
			document.frm.cc.focus();
			return true;
		}
}
function mail(mail)
{
	if ((mail.indexOf('@')==-1)||(mail.indexOf('.')==-1)||((mail.indexOf('.'))-2)==(mail.indexOf('@'))||((mail.indexOf('.'))-1)== (mail.indexOf('@'))||(mail.charAt(mail.indexOf('@')-1)==""))
		{	
			alert("correct this mail id    "+mail);
			document.frm.bcc.focus();
			return true;
		}
}
function validation()
{
	if ((document.frm.to.value == "")||(document.frm.to.value.indexOf('@') == -1)||(document.frm.to.value.indexOf('.') == -1)) 
	{
		alert("please check your 'To' emailid");	
		document.frm.to.select();
		return false;
	}
 	if ((document.frm.from.value == "")||(document.frm.from.value.indexOf('@') == -1)||(document.frm.from.value.indexOf('.') == -1)) 
	{
		alert("please check your 'From' emailid");	
		document.frm.from.select();
		return false;
	}  
	if(document.frm.subject.value == "") 
	{
		alert("please enter some subject");	
		document.frm.subject.focus();
		return false;
	}  
	if(document.frm.body.value == "")
	{
		alert("Please enter some message");
		document.frm.body.focus();
		return false;
	}	
var name=document.frm.cc.value;
if(name !=""){
var flag=false;
j=0;
for(i=0;i<name.length;i++){
if(name.charAt(i)==','||name.charAt(i)==';')
{
chk=name.substring(j,i);
if(email(chk))return false;
j=i+1;
flag=true;
}
}
if(flag==true)
{
name1=name.substring(j,name.length);
if(email(name1))return false;
}
if(flag==false){
if(email(name))return false;
}
if(name!=""){
if(sp('cc'))return false;
}
}
var name=document.frm.bcc.value;
if(name !=""){
var flag=false;
j=0;
for(i=0;i<name.length;i++){
if(name.charAt(i)==','||name.charAt(i)==';')
{
chk=name.substring(j,i);
if(mail(chk))return false;
j=i+1;
flag=true;
}
}
if(flag==true)
{
name1=name.substring(j,name.length);
if(mail(name1))return false;
}
if(flag==false){
if(mail(name))return false;
}
if(name!=""){
if(sp('bcc'))return false;
}
}


}
function attach()
{
	document.frm.h1.value="yes";
	window.open("/fusionmail/mail_attach.jsp");
}
</script>
<%
String loginid = (String)session.getAttribute("ID");


%>

<body  onpaste="return false;" marginwidth="0" marginheight="0" leftmargin="0" topmargin="0">
<%@ include file="mailtop2.html"%>
<table cellspacing=1 cellpadding=0 width=100%  border=0>
	<tr>
	<td height=25>

	</td>
	</tr>
</table>

<table width=100% align=center  border=0 cellpadding=5>
<tr>
		<td align="center" >
		<font face=veradana size=3 color=#996745><b>Welcome</b> </font> <font color=red face=veradana size=3 >
		<b><%="Mr/Mrs "+nana+sss%></b></font><font face="veradana" size=3 color=#996745><b>&nbsp;&nbsp;to Ayush Mail </b></font>
		</td>
	  </tr>
</table>
<br>


<form action="confirmmail.jsp" method="post" name="frm" onSubmit="return validation()">
<%
	  String email=request.getParameter("email");
%>

<TABLE BORDER=0 width=500 BGCOLOR = #9966FF ALIGN=CENTER cellspacing=0 cellpadding=1>
<tr>
	<td>
		<table BORDER=0  width=500 BGCOLOR = #D2D2FF  ALIGN=CENTER cellpadding=0 cellspacing=0>
		<TR>
			<TD align=center ><font face=verdana size=2 color = #9966FF><b>Ayush <img src="emailed.gif" width="45" height="52"> Mailing Service</b><BR><BR></td>
		</tr>	
		<TR>
			<TD>
				 <TABLE border=0 cellPadding=0 cellSpacing=0  align=center width="70%">
				 <TR>
					<TD align=left><FONT face=ARIAL size=-1><font color = #9966FF><B>To&nbsp;</B> </FONT></TD>
					

          <TD width=420 colspan=3>&nbsp;&nbsp;<INPUT maxLength=200 name=to value ="webmaster@ayushhealth.com"  Readonly=True size=46 class=b> 
        </TD></TR>
		  <TR>
          <TD align=left><FONT face=ARIAL size=-1><font color = #9966FF><B>From&nbsp;</B></FONT></TD>
          <TD colspan=3>&nbsp;&nbsp;<INPUT maxLength=512 name=from size=46  class=b value="<%=loginid%>@ayushhealth.com"> 
          </TD>
		</TR>
        <TR>
          <TD align=left><FONT  face=ARIAL size=-1><font color = #9966FF><B>Subject&nbsp; </B></FONT></TD>
          <TD  colspan=3>&nbsp;&nbsp;<INPUT maxLength=200 name=subject  size=46 class=b value="Activate my mail account"> 
		  </TD>
		</TR>
		<TR>
          	<td ><FONT  face=ARIAL size=-1><font color = #9966FF><B>CC </B></FONT></TD>
				<TD>&nbsp;&nbsp;<INPUT maxLength=400 class=b name=cc  size=17>	</TD>
				<TD><FONT  face=ARIAL size=-1><font color = #9966FF><B>Bcc </B></FONT></TD>	
				<TD align=right><INPUT maxLength=400 name=bcc class=b size=17></td>
			
		</TR>
		<TR>
<TD colspan=2><BR><FONT  face=ARIAL size=-1><font color = #9966FF><B>
		
		<input type='hidden' name='h1' value='no'>
</b></font>
</TD>
</TR>
		</TABLE>
	</TD>
</TR>


<TR>
<TD align=center><BR>
    <TEXTAREA cols=58 class=b name=body rows=13 wrap=VIRTUAL></TEXTAREA>
</TD>
</TR>
<tr>
	        <td align=center>
               <br>
                <input type = submit name= submit value = Send class="button">
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                <input type = reset value=Reset class=button>
                </font><br><br>
            </td>
</tr>
</TABLE>
</td>
</tr>
</table>
</form>
<%@ include file="/bottom.html" %>
</BODY>
</HTML>
