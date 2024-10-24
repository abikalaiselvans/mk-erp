<%@ page language="java" import="java.sql.Connection,java.sql.ResultSet,java.sql.Statement" %>
<jsp:useBean id="pool" class="com.ayush.beans.ConnectionPool" scope="application"/>
<%!
	Connection con;
	Statement stmt;
	ResultSet rs;
%>



<%
int aid=Integer.parseInt(request.getParameter("aid"));
String login_id = (String)session.getValue("UserID");
	if(login_id==null)
		{
		response.sendRedirect("/default.jsp");
		}
String month[]={"","Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
String fname="",lname="",nname="",p_email="",w_email="",o_email="",p_phone="",b_phone="",mobile="",fax="",paddress="",pcity="",pstate="",pcountry="",baddress="",bcity="",bstate="",bcountry="",bdate="";
String bday="",bmonth="",byear="";

try{
if (pool.getSize()==0)
	{
		pool.setSize(10);
		pool.initializePool();
	}
con=pool.getConnection();
stmt =con.createStatement();
rs = stmt.executeQuery("select * from tbladdress_book where aid="+aid);

if(rs.next())		{
	 fname = rs.getString("fname");
	 lname = rs.getString("lname");
	 nname = rs.getString("nname");
	 p_email = rs.getString("p_email");
	 w_email=rs.getString("w_email");
	 o_email=rs.getString("o_email");
	 p_phone=rs.getString("p_phone");
	 b_phone=rs.getString("b_phone");
	 mobile=rs.getString("mobile");
	 fax=rs.getString("fax");
	 paddress=rs.getString("paddress");
	 pcity=rs.getString("pcity");
	 pstate=rs.getString("pstate");
	 pcountry=rs.getString("pcountry");
	 baddress=rs.getString("baddress");
	 bcity=rs.getString("bcity");
	 bstate=rs.getString("bstate");
	 bcountry=rs.getString("bcountry");
	 bdate=rs.getString("bdate");
	 
	}

	if(bdate!=null)
	{
	bday=bdate.substring(0,2);
	bmonth=bdate.substring(2,5);
	byear=bdate.substring(5,9);
	}

}
catch(Exception e)
{
	out.println(e);
}
finally
		{
			if(stmt!=null)stmt.close();
			if(rs!=null) rs.close();
			
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
<HTML>
<HEAD>
<TITLE> Ayush Email </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Keywords" CONTENT="Health,Doctor,Education,Mail,Universal">
<META NAME="Company" CONTENT="ImageFusion Pvt Ltd">
</HEAD>
<link rel="stylesheet" href="nav.css">
<link rel="stylesheet" href="compose.css">
<style>
	.b
			{
				border:1px solid #666699;
				background:#ffffff;
				color:#330099;
				FONT-FAMILY:"arial"
				font-size:10px;
				font-weight:plain
			}
</style>
<script src="txtcheck.js">
</script>
<script>
	function check()
	{
		if(document.address.fname.value=="")
		{
			alert("Please Enter the First Name");
			document.address.fname.focus();
			return false;
		}
		if(!namecheck(document.address.fname))
		{
			alert("Please check the First name ");
			document.address.fname.focus();
			document.address.fname.select();
			return false;
		}
		if(document.address.lname.value=="")
		{
			alert("Please Enter the Last Name");
			document.address.lname.focus();
			return false;
		}
		if(!namecheck(document.address.lname))
		{
			alert("Please check the last name");
			document.address.lname.focus();
			document.address.lname.select();
			return false;
		}
		if(document.address.nname.value=="")
		{
			alert("Please Enter the Nick Name");
			document.address.nname.focus();
			return false;
		}
		if(!namecheck(document.address.nname))
		{
			alert("Please check Nick name");
			document.address.nname.focus();
			document.address.nname.select();
			return false;
		}
		if(document.address.p_email.value=="")
		{
			alert("Please Enter the Email Id");
			document.address.p_email.focus();
			return false;
		}
		if(! emailcheck(document.address.p_email))
		{
			alert("Please Enter a valid E-mail address");
			document.address.p_email.focus();
			document.address.p_email.select();
			return false;
		}
		return true;
	}
</script>

<BODY topmargin=0 leftmargin=0>

<!--%@ include file="top.html"%-->
<FORM name=address METHOD=post ACTION="update_save_address.jsp" onSubmit="return check()">
<table border=0 width="780"  align=center cellspacing=0 cellpadding=0>
<tr>
	<td>

<table border=0 width="100%" cellspacing=0 cellpadding=0>	
<tr>
<td colspan=2><jsp:include page="mailtop2.html" flush="true" /></td>
</tr>
<tr>
<td width=15% valign=top bgcolor=#ECECFD>
	 <table border="0" cellpadding=0 cellspacing=0>
					<tr>
						<td><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
						<td class="navBorderOut"><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
						<td><img src="images/dot.gif" height=1 width=1 border=0 alt=""></td>
					</tr>
					<tr>
						<td class="navBorderOut"><img src="images/dot.gif" height=1 width=1
						 border=0 alt=""></td>
						<td class="navBg">
							<table border="0" cellpadding=0 cellspacing=0 	width="138">
								<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1
								 width=1 border=0 alt=""></td></tr>
							<tr><td class="navBg"><img src="images/dot.gif" height=19 width=8 border=0 alt=""></td>
							<td width="100%" class="navBg"><font face="Verdana,Sans-serif" color="#003366"
							 size=1><a href="mail_homepage.jsp" onmouseover="status='Mail Home';return true"  class="navtxt">Mail Home</a></font></td></tr>
							<tr><td colspan=2 class="navBorderOut"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td class="navBg"><img src="images/dot.gif" height="19"
							 width="8" border="0" alt=""><img src="images/dot.gif" height=19 width=8 border=0
							 alt=""></td>
							<td width="100%" class="navBg"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="compose_mail.jsp" onmouseover="status='MailBox Folders';return true" 
							class="navtxt">Compose</a></font></td></tr>
							<tr><td colspan=2 class="navBorderOut"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td class="navBg"><img src="images/dot.gif" height=19 width=8 border=0
							 alt=""></td>
							<td width="100%"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="read_mail.jsp" onmouseover="status='Compose';"class="navtxt"> Inbox</a></font></td></tr>
							<tr><td colspan=2 class="navBorderOut"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td colspan=2 class="navBorderIn"><img src="images/dot.gif" height=1 width=1
							 border=0 alt=""></td></tr>
							<tr><td class="navBgSelected"><img src="images/sm_blue_arrow.gif" height=19 width=8 border=0
							 alt=""></td>
							<td width="100%" class="navBgSelected"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="view_address.jsp" onmouseover="status='Address Book';" 
							 class="navtxt"><b>Address Book</b></a></font></td></tr>
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
							<tr><td class="navBg"><img src="images/dot.gif" height="19"
							 width="8" border="0" alt=""><img src="images/dot.gif" height=19 width=8 border=0
							 alt=""></td>
							<td width="100%" class="navBg"><font face="Verdana,Sans-serif" color="#FFFFFF" size=1><a href="/servlet/logoff?control=mail" onmouseover="status='MailBox Folders';return true" 
							class="navtxt">SignOut</a></font></td></tr>
					</table>
				   </td>
				   </tr>
					</table>
<td  align=center>


<TABLE cellspacing=1 cellpadding=1 border=0 width=85% align=left>
<tr><td align=center height=35 colspan=2><font face=veradana size=3 color=#996745><b>Update</b> </font> <font color=red face=veradana size=3 ><b><%=fname%> <%=lname%></b></font><font face="veradana" size=3 color=#996745><b>'s Address </b></font>
</td></tr>
<tr bgcolor=#ECECFD><td colspan=2 align=center><font face=verdana size=2 color=#000099>Name</font></td></tr>
<TR><TD><font color=red size = 2>*</font>&nbsp;<font face=verdana size=1 color=#000099>First Name</font></TD><TD align=left><input type=text class=b name=fname value="<%=fname%>" maxlength=49></TD></TR>
<TR><TD><font color=red size = 2>*</font>&nbsp;<font face=verdana size=1 color=#000099>Last Name</font></TD><TD align=left><input type=text class=b name=lname value="<%=lname%>" maxlength=49></TD></TR>
<TR><TD><font color=red size = 2>*</font>&nbsp;<font face=verdana size=1 color=#000099>Nick Name</font></TD><TD align=left><input type=text class=b name=nname value="<%=nname%>" maxlength=49></TD></TR>
<tr bgcolor=#ECECFD><td colspan=2 align=center><font face=verdana size=2 color=#000099>Email Ids</font></td></tr>
<TR><TD><font color=red size = 2>*</font>&nbsp;<font face=verdana size=1 color=#000099>Personal Email Id</font></TD><TD align=left><input type=text class=b name=p_email value="<%if(p_email!=null){%><%=p_email%><%}else{}%>" maxlength=49></TD></TR>
<TR><TD><font face=verdana size=1 color=#000099>&nbsp;&nbsp;&nbsp;Work Email Id</font></TD><TD align=left><input type=text class=b name=w_email value="<%if(w_email!=null){%><%=w_email%><%}else{}%>" maxlength=49></TD></TR>
<TR><TD><font face=verdana size=1 color=#000099>&nbsp;&nbsp;&nbsp;Other Email Id</font></TD><TD align=left><input type=text class=b name=o_email value="<%if(o_email!=null){%><%=o_email%><%}else{}%>" maxlength=49></TD></TR>
<tr bgcolor=#ECECFD><td colspan=2 align=center><font face=verdana size=2 color=#000099>Contact Numbers</font></td></tr>
<TR><TD><font face=verdana size=1 color=#000099>&nbsp;&nbsp;&nbsp;Personal Phone Number</font></TD><TD align=left><input type=text class=b name=p_phone value="<%if(p_phone!=null){%><%=p_phone%><%}else{}%>" maxlength=19></TD></TR>
<TR><TD><font face=verdana size=1 color=#000099>&nbsp;&nbsp;&nbsp;Work Phone Number</font></TD><TD align=left><input type=text class=b name=b_phone value="<%if(b_phone!=null){%><%=b_phone%><%}else{}%>" maxlength=19></TD></TR>
<TR><TD><font face=verdana size=1 color=#000099>&nbsp;&nbsp;&nbsp;Mobile Number</font></TD><TD align=left><input type=text class=b name=mobile value="<%if(mobile!=null){%><%=mobile%><%}else{}%>" maxlength=15></TD></TR>
<TR><TD><font face=verdana size=1 color=#000099>&nbsp;&nbsp;&nbsp;Fax</font></TD><TD align=left><input type=text class=b name=fax value="<%if(fax!=null){%><%=fax%><%}else{}%>" maxlength=19></TD></TR>

<tr bgcolor=#ECECFD><td colspan=2 align=center><font face=verdana size=2 color=#000099>Personal Address</font></td></tr>
<TR><TD><font face=verdana size=1 color=#000099>&nbsp;&nbsp;&nbsp;Address</font></TD><TD align=left><input type=text class=b name=paddress value="<%if(paddress!=null){%><%=paddress%><%}else{}%>" maxlength=49></TD></TR>
<TR><TD><font face=verdana size=1 color=#000099>&nbsp;&nbsp;&nbsp;City</font></TD><TD align=left><input type=text class=b name=pcity value="<%if(pcity!=null){%><%=pcity%><%}else{}%>" maxlength=49></TD></TR>
<TR><TD><font face=verdana size=1 color=#000099>&nbsp;&nbsp;&nbsp;State</font></TD><TD align=left><input type=text class=b name=pstate value="<%if(pstate!=null){%><%=pstate%><%}else{}%>" maxlength=49></TD></TR>
<TR><TD><font face=verdana size=1 color=#000099>&nbsp;&nbsp;&nbsp;Country</font></TD><TD align=left><input type=text class=b name=pcountry value="<%if(pcountry!=null){%><%=pcountry%><%}else{}%>" maxlength=49></TD></TR>


<tr bgcolor=#ECECFD><td colspan=2 align=center><font face=verdana size=2 color=#000099>Office Address</font></td></tr>
<TR><TD><font face=verdana size=1 color=#000099>&nbsp;&nbsp;&nbsp;Address</font></TD><TD align=left><input type=text class=b name=baddress value="<%if(baddress!=null){%><%=baddress%><%}else{}%>" maxlength=49></TD></TR>
<TR><TD><font face=verdana size=1 color=#000099>&nbsp;&nbsp;&nbsp;City</font></TD><TD align=left><input type=text class=b name=bcity value="<%if(bcity!=null){%><%=bcity%><%}else{}%>" maxlength=49></TD></TR>
<TR><TD><font face=verdana size=1 color=#000099>&nbsp;&nbsp;&nbsp;State</font></TD><TD align=left><input type=text class=b name=bstate value="<%if(bstate!=null){%><%=bstate%><%}else{}%>" maxlength=49></TD></TR>
<TR><TD><font face=verdana size=1 color=#000099>&nbsp;&nbsp;&nbsp;Country</font></TD><TD align=left><input type=text class=b name=bcountry value="<%if(bcountry!=null){%><%=bcountry%><%}else{}%>" maxlength=49></TD></TR>


<TR><TD><font face=verdana size=1 color=#000099>&nbsp;&nbsp;&nbsp;Date of Birth</font></TD><TD align=left>

			<SELECT NAME = bdate SIZE=1>
				<OPTION VALUE="<%=bday %><%=(bday!=null) ? "selected" : "" %>">
				<% for(int i=1; i< 32 ; i++) { %>
						<OPTION VALUE="0<%= i %>" >0<%= i %></OPTION>
				<%}%>
				
			</SELECT>
			<select name = bmonth>
			    <option selected value="<%if(bmonth!=null){%><%=bmonth%><%}else{}%>">
				<%if(bmonth!=null){%><%=bmonth%><%}else{}%>
				<%for(int j=1;j<13;j++){%>
				<option value = <%=month[j]%>><%=month[j]%></option>
				<%}%>
			</select>
			<SELECT NAME = byear SIZE=1>
				<OPTION VALUE="<%if(byear!=null){%><%=byear%><%}else{}%>" SELECTED><%if(byear!=null){%><%=byear%><%}else{}%>
				<%  int cur_year1 = 2000;
				for(int k = 90; k > 0 ; k--) { %>
				<OPTION VALUE="<%= cur_year1 %>"><%= cur_year1 %>
				<%cur_year1--; } %> 
				</OPTION>
			</SELECT></TD></TR>
	<tr bgcolor=#ECECFD><td colspan=3 align=left><font face=verdana size=1 color=#000099>&nbsp;</font></td></tr>
	<input type=hidden name=aid value="<%=aid%>">
	<tr><td align=center colspan=3><input type=submit class=sbttn name=sub value="Submit"   accesskey="s"   >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=reset value="Reset" class=sbttn>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type=button name=cancel value="Cancel" class=sbttn onClick="javascript:history.go(-1)"></td></tr>
	
</TABLE>
</td>
</tr>
</table>

</FORM>
</BODY>
<br>
<br>
<jsp:include page="/bottom.jsp"/>
</HTML>
