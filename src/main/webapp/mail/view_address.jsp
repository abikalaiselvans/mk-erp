<%@ page language="java" import="java.sql.Connection,java.sql.ResultSet,java.sql.Statement,java.util.Enumeration,java.util.Hashtable" %>
<jsp:useBean id="pool" class="com.ayush.beans.ConnectionPool" scope="application"/>
<%String userid=(String)session.getAttribute("UserID");
if(userid==null)
	{%>
	<jsp:forward page="/login.jsp">
	<jsp:param name="control" value="mail"/>
	</jsp:forward>
	
	<%return;
		}else{
    String from =request.getParameter("from");
    session.removeValue("currentfolder");
    %>
<HTML>
<HEAD>
<TITLE> Ayush Email </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Keywords" CONTENT="Health,Doctor,Education,Mail,Universal">
<META NAME="Company" CONTENT="ImageFusion Pvt Ltd">
<link rel="stylesheet" href="nav.css">
<link rel="stylesheet" href="compose.css">
<script Language="JavaScript" src="txtcheck.js">
</script>

<script Language="JavaScript">
function checkall(ch)
{
	for(var i = 0; i <= ch ; i++)
	{
		document.address.elements[i].checked = true;
	}
}
function clearall(ch)
{
	for(var i = 0; i <= ch ; i++)
	{
		document.address.elements[i].checked = false;
	}
}
/*function sendMail(ch)
{
	var j=0;
	for(var i = 0; i <= ch; i++)
	{
		if(document.address.elements[i].checked == true)
		{
			j++;
		}
	}
	if(j==0)
	{
		alert("You must check at least one contact to compose mail");
	}
	else
	{
		document.address.action="/mail_new/compose_mail.jsp?to="+to1;
		document.address.submit();
	}

	var to1="";
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
	
	
	}
	if(to!="")
	{
		to1=","+to1;
	}
	to1=to+to1;
	
	window.opener.document.frm.to.value=to1;

} */
function sendMail(ch)
{
	
	var to=window.opener.document.getElementById('to').value;
	var to1="";
	
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
	
	
	}
if(to!="")
	{
		to1=","+to1;
	}
	to1=to+to1;
	window.self.open("./compose_mail.jsp?to="+to1);
	//window.opener.document.frm.to.value=to1;
	window.close();
}
function delMail(ch)
{
	var j=0;
	for(var i = 0; i <= ch; i++)
	{
		if(document.address.elements[i].checked == true)
		{
			j++;
		}
	}
	if(j==0)
	{
		alert("You must check at least one contact to delete");
	}
	else
	{
	document.address.action="del_address.jsp?aid="
	document.address.submit();
	}
}

function check()
{
	if(document.quickaddress.fname.value=="")
	{
			alert("Please Enter the First Name");
			document.quickaddress.fname.focus();
			return false;
	}
	if(!namecheck(document.quickaddress.fname))
	{
		alert("Please Enter only Characters");
		document.quickaddress.fname.focus();
		document.quickaddress.fname.select();
		return false;
	}
	if(document.quickaddress.lname.value=="")
	{
			alert("Please Enter the Last Name");
			document.quickaddress.lname.focus();
			return false;
	}
	if(!namecheck(document.quickaddress.lname))
	{
		alert("Please Enter only Characters");
		document.quickaddress.lname.focus();
		document.quickaddress.lname.select();
		return false;
	}
	if(document.quickaddress.nname.value=="")
	{
			alert("Please Enter the Nick Name");
			document.quickaddress.nname.focus();
			return false;
	}
	if(!namecheck(document.quickaddress.nname))
	{
		alert("Please Enter only Characters");
		document.quickaddress.nname.focus();
		document.quickaddress.nname.select();
		return false;
	}
	if(document.quickaddress.p_email.value=="")
	{
		alert("Please Enter the E-Mail Addresses");
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
<%	String name=(String)session.getValue("name");
	String nana=String.valueOf(name.charAt(0));
	nana=nana.toUpperCase();
	String sss=name.substring(1,name.length());

String mesg=request.getParameter("mesg");

%>
<form name=address>

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
	 <table align="center" border="0" cellpadding=0 cellspacing=0>
					<tr>
						<td><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
						<td class="navBorderOut"><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
						<td><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
					</tr>
					<tr>
						<td class="navBorderOut"><img src="images/dot.gif" height=1 width=1
						 border=0 alt=""></td>
						<td class="navBg">
							<table align="center" border="0" cellpadding=0 cellspacing=0 	width="138">
								<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1
								 width=1 border=0 alt=""></td></tr>
							<tr><td class="navBg"><img src="images/dot.gif" height=19 width=8 border=0 alt=""></td>
							<td width="100%" class="navBg"><font face="Verdana,Sans-serif" color="#003366"
							 size=1><a href="mail_homepage.jsp" onmouseover="status='Mail Home';return true"  class="navtxt" alt=hello>Mail Home</a></font></td></tr>
							<tr><td colspan=2 class="navBorderOut"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td class="navBg"><img src="images/dot.gif" height=19 width=8 border=0 alt=""></td>
							<td width="100%" class="navBg"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="compose_mail.jsp" onmouseover="status='MailBox Folders';return true" 
							class="navtxt">Compose</a></font></td></tr>
							<tr><td colspan=2 class="navBorderOut"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td class="navBg"><img src="images/dot.gif" height=19 width=8 border=0
							 alt=""></td>
							<td width="100%"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="read_mail.jsp" onmouseover="status='Inbox';"class="navtxt"> Inbox</a></font></td></tr>
							<tr><td colspan=2 class="navBorderOut"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td class="navBgSelected"><img src="images/sm_blue_arrow.gif" height=19 width=8 border=0
							 alt=""></td>
							<td width="100%" class="navBgSelected"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><b>Address Book</b></font></td></tr>
							<tr><td colspan=2 class="navBorderOut"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td class="navBg"><img src="images/dot.gif" height=19 width=8 border=0
							 alt=""></td>
							<td width="100%"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1>Options</a></font></td></tr>
							<tr><td colspan=2 class="navBorderOut"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td class="navBg"><img src="images/dot.gif" height=19 width=8 border=0
							 alt=""></td>
							<td width="100%"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1>System Status</a></font></td></tr>
						   	<tr><td colspan=2 class="navBorderOut"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>

					<tr><td class="navBg"><img src="images/dot.gif" height=19 width=8 border=0
							 alt=""></td>
							<td width="100%"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="/servlet/logoff?control=mail" onmouseover="status='SignOut';" 
							 class="navtxt">SignOut</a></font></td></tr>
				
					</table>
				  </td>
				 <td class="navBorderOut"><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
				</tr>


				

			</table>
</td>
<td valign=left>
<TABLE class=Mtable cellspacing=0 cellpadding=0 border=0 width=100%>
<tr>
<td colspan=2 align="left"><font face=verdana size=3 color=#996699><b>Address Book</b></font>
	</td>	

<td colspan=1 align="left">
<font face=verdana size=1 color=#996745>Welcome </font><font color=red face=verdana size=2 ><b><%=nana+sss%></b></font><font face="verdana" size=2 color=#996745> </font>
</td>
</tr>
<%if(mesg!=null)
{ %>
	<tr>
<td colspan=4 align="center"><font face=verdana size=3 color=green><%=mesg%></font>
	</td>	
   </tr>
<%	
} %>
<TR bgcolor=#6B7094>
	<td style="padding-top:5px;padding-bottom:2px">&nbsp;</td>
	<td><font face=arial size=2 color=#FFFFFF>Nick Name</font></td>
	<td><font face=arial size=2 color=#FFFFFF>Email Id</font></td>
	<td><font face=arial size=2 color=#FFFFFF>&nbsp;</font></td>
</TR>


<%!
	Connection con=null;
	Statement stmt=null;
	ResultSet rs=null;
	boolean flag=false;
	
	

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
con=pool.getConnection();
stmt =con.createStatement();
String ss="select * from tbladdress_book where login_id='"+userid+"' order by aid";
//out.println("asda"+ss);
rs=stmt.executeQuery(ss);

if(!rs.next())
	{%>
		<tr><td align=center colspan=4><font face=arial size=2 color=red><BR><BR><BR><BR>No address listings are available</font>
		<BR><BR><BR><BR></td></tr>
	<%}
else{

		
	do{
		check++;
		aid=rs.getInt("aid");
		fname=rs.getString("fname");
		lname=rs.getString("lname");
		nname=rs.getString("nname");
		p_email=rs.getString("p_email");
		//out.println(p_email);
		
	%>		


<TR>
	<TD>
	<INPUT TYPE="checkbox" NAME="address_item" value="<%=p_email%>">&nbsp;
	</TD>
	<td style="padding-bottom:5px;padding-top:5px;" >
		<a href="view_address_details.jsp?aid=<%=aid%>"><%=nname%>
	</font></a></td>
	<td><%=p_email%></td>
	<td><!--href="update_address.jsp?aid=--><a	  href="update_address.jsp?aid=<%=aid%>">Edit</font></a>
	</td>
</TR>
<%}while(rs.next());
	}
	
}
catch(Exception e)
	{
	out.println("Error:::"+e);
	}
finally
		{	 if(rs!=null) rs.close();
			 if(stmt!=null) stmt.close();
			
			try
				{
				if (con!=null){	pool.releaseConnection(con);}
				}
			catch(Exception e)
				{	
				out.println(e);
				}
		}

%>
<tr bgcolor=#6B7094><td colspan=4 align=center ><INPUT TYPE=BUTTON NAME=check_all VALUE="Check All" onClick="javascript:checkall(<%=check%>)" class=sbttn>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT TYPE=BUTTON NAME=clear_all VALUE="Clear All" onClick="javascript:clearall(<%=check%>)" class=sbttn>	<INPUT TYPE=BUTTON NAME=send VALUE="Send Mail" onClick="javascript:sendMail(<%=check%>)" class=sbttn>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<INPUT TYPE=BUTTON NAME=del VALUE="Delete" onClick="javascript:delMail(<%=check%>)" class=sbttn></td></tr>
</TABLE>
<br>

</form>

</td>
<td width=20%>
<form name=quickaddress method=post action="save_address.jsp?address=quick" onSubmit = "return check()" >

<TABLE align=center width="80%" bgcolor=#ECECFD cellspacing=1 cellpadding=1 border=0>

<tr><td align=center colspan=2><font face=verdana size=2 color=#663399><b>Quick Address</b></font></td></tr>
<TR>
	<TD><font face=verdana size=1 color=#663399><b>Nick Name</b></font></TD>
</tr>
<TR>
	<TD><input type=text name=nname class=b maxlength=40></TD>
</tr>

<tr>
	<td><font face=verdana size=1 color=#663399><b>E-mail</b></font></td>
</TR>
<tr>
	<td><input type=text name=p_email class=b maxlength=49></td>
</TR>
<TR>
<TD><font face=verdana size=1 color=#663399><b>First Name</b></font></TD>
</tr>
<TR>
<TD><input type=text name=fname class=b maxlength=40></TD>
</tr>
<tr>
<td><font face=verdana size=1 color=#663399><b>Last Name</b></font></td>
</TR>
<tr>
<td><input type=text name=lname class=b maxlength=40></td>
</TR>
<tr><td align=center colspan=2><input type=submit name=submit value=" Add " class=sbttn>&nbsp;&nbsp;&nbsp;&nbsp;<input type=reset name =reset value="Clear" class=sbttn></td>
</tr>

</TABLE>

</form>
</td>
</tr>
</table>
</BODY>
</HTML>
<%}%>
	<%@ include file="/bottom.jsp"%>