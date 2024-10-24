<%@ page language="java" import="java.sql.Connection,java.sql.ResultSet,java.sql.Statement" %>
<jsp:useBean id="pool" class="com.ayush.beans.ConnectionPool" scope="application"/>
<%!
	Connection con=null;
	Statement stmt=null;
	ResultSet rs=null;

	String fname="",lname="",nname="",p_email="",w_email="",o_email="",p_phone="",b_phone="",mobile="",fax="",paddress="",pcity="",pstate="",pcountry="",baddress="",bcity="",bstate="",bcountry="",bdate="";
	String bday="",bmonth="",byear="";
%>
<%
String aid=request.getParameter("aid");
String login_id = (String)session.getValue("UserID");
	if(login_id==null)
		{
		response.sendRedirect("/login.jsp");
		}

try{
if (pool.getSize()==0)
	{
		pool.setSize(10);
		pool.initializePool();
	}
con=pool.getConnection();
stmt =con.createStatement();
rs=stmt.executeQuery("select * from tbladdress_book where aid="+aid);
if(rs.next())
	{
	 fname=rs.getString("fname");
	 lname=rs.getString("lname");
	 nname=rs.getString("nname");
	 p_email=rs.getString("p_email");
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
	out.println("Exception :"+e);
	}
finally
		{
			stmt.close();
			try
				{
				if (con!=null){	pool.releaseConnection(con);}
				}
			catch(Exception ex)
				{	
				out.println(ex);
				}
		}

%>
<HTML>
<HEAD>
<TITLE> Ayush Email </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<META NAME="Author" CONTENT="Rajasekar K">
<META NAME="Keywords" CONTENT="Health,Doctor,Education,Mail,Universal">
<META NAME="Company" CONTENT="ImageFusion Pvt Ltd">
<style>
	.b
			{
				border:1px solid #666699;
				background:#F5FAFA;
				color:#330099;
				FONT-FAMILY:"verdana"
				font-size:10px;
				font-weight:plain
			}
</style>
</HEAD>

<BODY>
<br><center><b><font face=verdana size=2 color=#990099><%=fname%><%=lname%>'s Address Book</font></b></center><br>
<TABLE align=center cellspacing=4 cellpadding=3 border=0 width="70%" class=b>
<%if(nname!=null){%>
<TR>
	<td><font face=verdana size=2 color=#000066>Nick Name</font></td>
	<td><font face=verdana size=2 color=#000066><%=nname%></font></td>
</TR>
<%}if((fname!=null)&&(lname!=null)){%>
<TR>
	<td><font face=verdana size=2 color=#000066>Name</font></td>
	<td><font face=verdana size=2 color=#000066><%=fname%><%=lname%></font></td>
</TR>
<%}if(p_email!=null){%>
<TR>
	<td><font face=verdana size=2 color=#000066>Email</font></td>
	<td><font face=verdana size=2 color=#000066><%=p_email%></font></td>
</TR>
<%}if(p_phone!=null){%>
<TR>
	<td><font face=verdana size=2 color=#000066>Personal Phone </font></td>
	<td><font face=verdana size=2 color=#000066><%=p_phone%></font></td>
</TR>
<%}if(mobile!=null){%>
<TR>
	<td><font face=verdana size=2 color=#000066>Mobile</font></td>
	<td><font face=verdana size=2 color=#000066><%=mobile%></font></td>
</TR>
<%}if(paddress!=null){%>
<TR>
	<td><font face=verdana size=2 color=#000066>Personal Address</font></td>
	<td><font face=verdana size=2 color=#000066><%=paddress%></font></td>
</TR>
<%}if(pcity!=null){%>
<TR>
	<td>&nbsp;</td>
	<td><font face=verdana size=2 color=#000066><%=pcity%></font></td>
</TR>
<%}if(pstate!=null){%>
<TR>
	<td>&nbsp;</td>
	<td><font face=verdana size=2 color=#000066><%=pstate%></font></td>
</TR>
<%}if(pcountry!=null){%>
<TR>
	<td>&nbsp;</td>
	<td><font face=verdana size=2 color=#000066><%=pcountry%></font></td>
</TR>
<%}if(baddress!=null){%>
<TR>
	<td><font face=verdana size=2 color=#000066>Office Address</font></td>
	<td><font face=verdana size=2 color=#000066><%=baddress%></font></td>
</TR>
<%}if(bcity!=null){%>
<TR>
	<td>&nbsp;</td>
	<td><font face=verdana size=2 color=#000066><%=bcity%></font></td>
</TR>
<%}if(bstate!=null){%>
<TR>
	<td>&nbsp;</td>
	<td><font face=verdana size=2 color=#000066><%=bstate%></font></td>
</TR>
<%}if(bcountry!=null){%>
<TR>
	<td>&nbsp;</td>
	<td><font face=verdana size=2 color=#000066><%=bcountry%></font></td>
</TR>
<%}if(bdate!=null){%>
<TR>
	<td><font face=verdana size=2 color=#000066>Date of Birth</font></td>
	<td><font face=verdana size=2 color=#000066><%=bday%>-<%=bmonth%>-<%=byear%></font></td>
</TR>
<%}%>
</TABLE>
<center><a href="view_address.jsp"><font face=arial size=2 color=blue>Back to Address Book</font></a></center><br>
</BODY>
</HTML>
<%@ include file="/bottom.html"%>