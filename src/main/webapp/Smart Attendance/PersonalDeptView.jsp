<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!

	Connection con =null;
	Statement st =null;
	ResultSet rs=null;
	String sql;
	String driver;
	String url;
	String depid;
	int i;	
%>
<%
	depid=request.getParameter("Department");
	
%>
<%
			
		con=conbean.getConnection();
	   	st=con.createStatement();
			
		sql="select  * from m_staff where INT_departid="+depid;
		rs = st.executeQuery(sql);
	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title> :: ATTENDANCE ::</title>


<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<style type="text/css">
<!--
.style8 {
	font-family: Verdana;
	font-size: 12px;
}
.style51 {font-family: Verdana; font-size: 14px; }
.style52 {font-size: 14px}
.style53 {font-family: Verdana; font-size: 14px;  }
.style54 {font-family: Verdana}
a:visited {
	color: #663366;
}
a:hover {
	color: #FF0000;
}
a:active {
	color: #0000FF;
}
-->
</style>
</head>

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="1000">
	<!--DWLayoutTable-->
	<tr>
		<td width="75" height="21">&nbsp;</td>
		<td width="799" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
		<td width="68">&nbsp;</td>
		<td width="32">&nbsp;</td>
	</tr>
	<tr>
		<td height="43">&nbsp;</td>
		<td colspan="2" valign="top">
		<table width="818" border="1" cellpadding="0" cellspacing="1">
			<!--DWLayoutTable-->
			<tr>
				<td colspan="6" align="center" valign="middle"><b>Personnel
				Information Department View</b></td>
			</tr>
			<tr>
				<td width="113" height="14">
				<div align="center" class="style51 style52">Emp Id</div>
				</td>
				<td width="186" height="14">
				<div align="center" class="style53">Name</div>
				</td>
				<td width="154" height="14">
				<div align="center" class="style53">D.O.J.</div>
				</td>
				<td width="113" height="14">
				<div align="center" class="style53">D.O.B.</div>
				</td>
				<td width="129" height="14">
				<div align="center" class="style53">Gender</div>
				</td>
				<td width="113" height="14">
				<div align="center" class="style53">Blood Group</div>
				</td>
				<td width="12"></td>
			</tr>
			<%
  while(rs.next())
		{
%>
			<tr>
				<td width="113" height="19"><span class="style54 style52">
				<% out.println(rs.getString("chr_EMPID")); %> </span></td>
				<td width="186" height="19"><span class="style54 style52">
				<% out.println(rs.getString("chr_staffname")); %> </span></td>
				<% 
		try{
		StringTokenizer dts=new StringTokenizer(rs.getString("dt_dojcollege"));
		StringTokenizer dt=new StringTokenizer(dts.nextToken(),"-");
		String y=dt.nextToken();
		String m=dt.nextToken();
		String d=dt.nextToken();
	 %>
				<td width="154" height="19"><span class="style54 style52">
				<% out.println(d+"-"+m+"-"+y); %> </span></td>
				<%
		}
		catch(Exception e)
		{
		}
	%>
				<% 
		try{
		StringTokenizer dts=new StringTokenizer(rs.getString("dt_dob"));
		StringTokenizer dt=new StringTokenizer(dts.nextToken(),"-");
		String y=dt.nextToken();
		String m=dt.nextToken();
		String d=dt.nextToken();
	 %>
				<td width="113" height="19"><span class="style54 style52">
				<% out.println(d+"-"+m+"-"+y); %> </span></td>
				<%
		}
		catch(Exception e)
		{
		}
	%>
				<td width="129" height="19"><span class="style54 style52">
				<% out.println(rs.getString("chr_gender")); %> </span></td>
				<td width="113" height="19"><span class="style54 style52">
				<% out.println(rs.getString("chr_bg")); %> </span></td>
				<td></td>
			</tr>
			<%
		}
		rs.close();
	 %>
		</table>
		</td>
		<td>&nbsp;</td>
	</tr>
</table>
<br>
<br>
<br>
<TABLE width="1000" border=0 align="left" cellPadding=0 cellSpacing=1>
	<!--DWLayoutTable-->
	<TBODY>
		<TR>
			<TD width="258" height="70">&nbsp;</TD>
			<TD width="93" valign="top"><a href="AttendanceMain.jsp"><img
				src="../Image/Smart%20Attendance/Home.gif" width="93" height="70"
				border="0"></a>
			</div>
			</TD>
			<TD width="279">&nbsp;</TD>
			<TD width="93" valign="top"><a href="Personal Details.jsp"><img
				src="Back.gif" width="92" height="69" border="0"></a></TD>
			<TD width="271">&nbsp;</TD>
		</TR>
		<TR>
			<td height="0"></td>
			<td></td>
			<td></td>
			<td></td>
			<td></td>
		</TR>
	</TBODY>
</TABLE>
<br>
<br>
<br>
<br>
<br>
<br>

</td>
<%@ include file="../footer.jsp"%>
</body>
</html>
