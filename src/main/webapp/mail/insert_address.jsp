<%@ page language="java" import="java.sql.*,java.util.Enumeration,java.util.Hashtable" %>
<jsp:useBean id="pool" class="com.ayush.beans.ConnectionPool" scope="page"/>
<%
String month[]={"","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};


String login_id = (String)session.getValue("UserID");
String mesg = request.getParameter("mesg");if(mesg==null)mesg = "";

if(login_id==null)		{
		response.sendRedirect("/default.jsp");
		}
%>
<HTML>
<HEAD>
<TITLE> Ayush  Email </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="Rajasekar K">
<META NAME="Keywords" CONTENT="Health,Doctor,Education,Mail,Universal">
<META NAME="Company" CONTENT="ImageFusion Pvt Ltd">
<link rel="stylesheet" href="../mail/compose.css">
<style>
.b
			{
				border:1px solid #666699;
				background:#Ffffff;
				color:#330099;
				FONT-FAMILY:"verdana"
				font-size:10px;
				font-weight:plain
			}
</style>
<script Language="JavaScript" src="txtcheck.js">
</script>

<script Language="JavaScript">
function checkall(ch)
{
	for(var i = 0; i < ch ; i++)
	{
		document.address.address_item[i].checked = true;
	}
}
function clearall(ch)
{
	for(var i = 0; i <  ch ; i++)
	{
		document.address.address_item[i].checked = false;
	}
}

function sendMail(ch)
{
	var to = window.opener.document.getElementById('to').value;
	var bcc = window.opener.document.getElementById('bcc').value;
	var cc = window.opener.document.getElementById('cc').value;
	var to1 = "";
	var cc1 = "";
	var bcc1 = "";
if(ch==1)
	{
	if(document.address.address_item.checked)
			{
				if(to1!="")
				{
					to1+=",";
				}
				to1+=document.address.address_item.value;
			}
			if(document.address.address_item2.checked)
			{
				if(cc1!="")
				{
					cc1+=",";
				}
				cc1+=document.address.address_item2.value;
			}
			if(document.address.address_item2.checked)
			{
				if(bcc1!="")
				{
					bcc1+=",";
				}
				bcc1+=document.address.address_item.value;
			}
	}else{
	for(i=0;i<ch;i++)
		{
			if(document.address.address_item[i].checked)
			{
				if(to1!="")
				{
					to1+=",";
				}
				to1+=document.address.address_item[i].value;
			}
		}
		for(i=0;i<ch;i++)
		{
			if(document.address.address_item1[i].checked)
			{
				if(cc1!="")
				{
					cc1+=",";
				}
				cc1+=document.address.address_item1[i].value;
			}
		}
		for(i=0;i<ch;i++)
		{
			if(document.address.address_item2[i].checked)
			{
				if(bcc1!="")
				{
					bcc1+=",";
				}
				bcc1+=document.address.address_item1[i].value;
			}
		}
	}
	if(to!="")
	{
		to1 = "," + to1;
	}
	to1 = to + to1;
	if(cc!="")
	{
		cc1 = "," + cc1;
	}
	cc1 = cc + cc1;
	if(bcc!="")
	{
		bcc1=","+bcc1;
	}
	bcc1 = bcc + bcc1;
	window.opener.document.getElementById('to').value=to1;
	window.opener.document.getElementById('cc').value=cc1;
	window.opener.document.getElementById('bcc').value=bcc1;
	window.close();
}
function check()
{
	if(document.quickaddress.fname.value=="")
	{
		alert("Please enter the first name");
		document.quickaddress.fname.focus();
		return false;
	}
	if(!namecheck(document.quickaddress.fname))
	{
		alert("Please enter only characters in this field");
		document.quickaddress.fname.focus();
		document.quickaddress.fname.select();
		return false;
	}

	if(document.quickaddress.lname.value=="")
	{
		alert("Please enter the last name");
		document.quickaddress.lname.focus();
		return false;
	}
	if(!namecheck(document.quickaddress.lname))
	{
		alert("Please enter only characters in this field");
		document.quickaddress.lname.focus();
		document.quickaddress.lname.select();
		return false;
	}
	if(document.quickaddress.nname.value=="")
	{
		alert("Please enter the nick name");
		document.quickaddress.nname.focus();
		return false;
	}
	if(!namecheck(document.quickaddress.nname))
	{
		alert("Please enter only characters in this field");
		document.quickaddress.nname.focus();
		document.quickaddress.nname.select();
		return false;
	}
	if(document.quickaddress.p_email.value=="")
	{
		alert("Please enter the e-mail address");
		document.quickaddress.p_email.focus();
		return false;
	}
	if(!emailcheck(document.quickaddress.p_email))
	{
		alert("Please enter valid e-mail address");
		document.quickaddress.p_email.focus();
		document.quickaddress.p_email.select();
		return false;
	}
	return true;
}


</script>
</HEAD>

<BODY>
<br>
<form name=address method=post action="/ayushman_mail/mail/compose.html" >
<TABLE class=mtable align=center cellspacing=0 cellpadding=0 border=0 width="80%">



<%!
	Connection con=null;
	Statement stmt=null;
	ResultSet rs=null;

	String fname="",lname="",nname="",p_email="",w_email="",o_email="",p_phone="",b_phone="",mobile="",fax="",paddress="",pcity="",pstate="",pcountry="",baddress="",bcity="",bstate="",bcountry="";
	int aid=0;
%>
<%
int check=0;
try{
if (pool.getSize()==0)
	{
		pool.setSize(10);
		pool.initializePool();
	}
con = pool.getConnection();
stmt = con.createStatement();

rs = stmt.executeQuery("select count(*), aid, fname, lname, nname, p_email  "+
		               "from  "+
		               "tbladdress_book  "+
		               "where "+
		               "login_id='"+login_id+"' group by aid, fname, lname, nname, p_email");
	  
while(rs.next())		{
	if(rs.getInt(1)==0){
%>
		<tr><td align=center colspan=4><font face=arial size=2 color=red>No address listings are available</font></td></tr>
<%		
	}
	if(check==0)
		{%>
<TR bgcolor=#6B7094>
	<TD style="padding-top:5px;padding-bottom:1px"><font face=arial size=2 color=#FFFFFF>
	&nbsp;&nbsp;To&nbsp;&nbsp;
	Bcc&nbsp;&nbsp;
	Cc&nbsp;&nbsp;
	</font></TD>
	<td><font face=arial size=2 color=#FFFFFF>Nick Name</font></td>
	<td><font face=arial size=2 color=#FFFFFF>Email</font></td>
	<td><font face=arial size=2 color=#FFFFFF>&nbsp;</font></td>
</TR>
<tr bgcolor=#FFF9FC><td colspan=4>&nbsp;</td></tr>
		<%}%>
<%
		check++;
		aid=rs.getInt("aid");
		fname=rs.getString("fname");
		lname=rs.getString("lname");
		nname=rs.getString("nname");
		p_email = rs.getString("p_email");
	
		%>


<TR>
	<TD>
	<INPUT TYPE="checkbox" NAME="address_item" value="<%=p_email%>">&nbsp;&nbsp;
	<INPUT TYPE="checkbox" NAME="address_item1" value="<%=p_email%>">&nbsp;&nbsp;
	<INPUT TYPE="checkbox" NAME="address_item2" value="<%=p_email%>">&nbsp;&nbsp;
	</TD>
	<td style="padding-bottom:5px;padding-top:5px;"><a href="view_address_details.jsp?aid=<%=aid%>"><%=nname%></a></td>
	<td><%=p_email%></td>
	<td><a href="update_address.jsp?aid=<%=aid%>">Edit</a></td>
</TR>

	 
	<%}//While Ends

}
catch(Exception e)
	{
	out.println(e);
	}
finally		{
		try
			{
				if(rs!=null)
					rs.close();
				if(stmt!=null)
					stmt.close();
				if (con!=null)		
					pool.releaseConnection(con);
				}
			catch(Exception e)
				{	
				out.println(e);
				}
		}

if(check!=0){%>
<tr><td bgcolor=#FFFFFF colspan=4 style="padding-top:5px;padding-bottom:1px">&nbsp;</td></tr>
<tr bgcolor=#6B7094><td colspan=4 align=center><INPUT TYPE=BUTTON NAME=check_all VALUE="Check All" onClick="javascript:checkall(<%=check%>)" class=sbttn>&nbsp;&nbsp;<INPUT TYPE=BUTTON NAME=clear_all VALUE="Clear All" onClick="javascript:clearall(<%=check%>)" class=sbttn>&nbsp;&nbsp;<INPUT TYPE=BUTTON NAME=send VALUE="Send Mail" onClick="javascript:sendMail(<%=check%>)" class=sbttn>&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>
<%}%>
</TABLE>
</form>
<%if(mesg!=null)
{ %>
	<div align=center><font face=verdana size=3 color=green><%=mesg%></font></div>
	
<%	mesg = "";
} %>
<br>
<form name=quickaddress method=post action="/mail_new/save_address.jsp?address=quick" onSubmit = "return check()" >
<table border=0 align=center width="80%" cellspacing=0 cellpadding=0 class=b>
<tr><td>

<TABLE align=center width="80%" cellspacing=4 cellpadding=3 border=0>
<tr><td align=center colspan=2><font face=verdana size=2 color=#663399><b>Add New Express Address</b></font></td></tr>
<TR><TD><font face=verdana size=1 color=#663399><b>First Name</b></font></TD><td><font face=verdana size=1 color=#663399><b>Last Name</b></font></td></TR>
<TR><TD><input type=text name=fname class=b maxlength=40></TD><td><input type=text name=lname class=b maxlength=40></td></TR>
<TR><TD><font face=verdana size=1 color=#663399><b>Nick Name</b></font></TD><td><font face=verdana size=1 color=#663399><b>E-mail</b></font></td></TR>
<TR><TD><input type=text name=nname class=b maxlength=40></TD><td><input type=text name=p_email class=b maxlength=49></td></TR>
<tr><td align=center colspan=2><input type=submit name=submit value="Add to Address List" class=sbttn>&nbsp;&nbsp;&nbsp;&nbsp;<input type=button name =close  value="Close"   accesskey="c"  class=sbttn onclick="window.close();"></td></tr>
<tr><td>&nbsp;</td></tr>
</TABLE>

</tr></td>
</table>
<br>
<!--<center><a href="view_address.jsp"><font color="#330066" size=2 face=verdana>View Contacts</font></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/ayushman_mail/address/add_address.jsp"><font color="#330066" size=2 face=verdana>Add address in detail</font></a></center>-->
<br></form>
</BODY>
</HTML>
