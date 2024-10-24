<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon" />
<%!

	Connection con ;
	Statement st ;
	ResultSet rs;
	String sql;
	String driver;
	String url;
	String depid;
	String mth;
	int yr;
	int i;	
%>
<%
	depid=request.getParameter("Department");
	mth=request.getParameter("Month");
	yr=Integer.parseInt(request.getParameter("Year"));
	
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
.style53 {font-family: Verdana; font-size: 14px;}
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

<body  onpaste='return false;'>
<p class="style8">&nbsp;</p>
<p class="style8">
<p>&nbsp;</p>
<center>
<table width="729" cellpadding="1" cellspacing="1" border="1"
	 >
	<tr align="center">
		<td height="30" colspan="6"  class="tablehead">OnDuty
		- Month View
	</tr>
	<tr>

		<td width="15%" height="31" align="center" valign="middle"
			bgcolor="6E8FBC" class="tablehead">Emp ID</td>
		<td width="25%" height="31" align="center" valign="middle"
			bgcolor="6E8FBC" class="tablehead">Name</td>
		<td width="20%" height="31" align="center" valign="middle"
			bgcolor="6E8FBC" class="tablehead">Date</td>
		<td width="15%" height="31" align="center" valign="middle"
			bgcolor="6E8FBC" class="tablehead">Place</td>
		<td width="17%" height="31" align="center" valign="middle"
			bgcolor="6E8FBC" class="tablehead">Reason</td>
		<td width="13%" height="31" align="center" valign="middle"
			bgcolor="6E8FBC" class="tablehead">Authorized</td>
	</tr>
	<%
	
	try
	{
		con=conbean.getConnection();
	   	st=con.createStatement();
		sql="select  a.chr_staffname,b.* from  com_m_staff  a,att_t_onduty b where ";
		sql=sql+"a.chr_empid=b.chr_empid and b.chr_month='"+mth+"'";
		sql=sql+"and b.int_year="+yr;
		//System.out.println(sql);
		rs = st.executeQuery(sql);
  	while(rs.next())
		{
	%>
	<tr>
		<td width="15%" height="19"><span class="style54"> <% out.println(rs.getString("CHR_EMPID")); %>
		</span></td>
		<td width="25%" height="19"><span class="style54"> <% out.println(rs.getString("chr_staffname")); %>
		</span></td>
		<td width="20%" height="19"><span class="style54"> <% out.println(rs.getString("dt_oddate")); %>
		</span></td>
		<td width="15%" height="19"><span class="style54"> <% out.println(rs.getString("chr_place")); %>
		</span></td>
		<td width="17%" height="19"><span class="style54"> <% out.println(rs.getString("chr_reason")); %>
		</span></td>
		<td width="13%" height="19"><span class="style54"> <% out.println(rs.getString("CHR_AUTHNAME")); %>
		</span></td>
	</tr>
	<%
		}
		rs.close();
	 
}
	
	catch(Exception npe)
	{
		//System.out.println(npe);
	} %>
</table>
</center>
<br>
<br>
<br>
<br>
<center>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
</td>
</center>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<%@ include file="../footer.jsp"%>
</body>
</html>
