<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%!

	Connection con ;
	Statement st ;
	ResultSet rs;
	String sql;
	String driver;
	String url;
	String desid;
	int i;	
%>
<%
	desid=request.getParameter("Designation");
	
%>
<%
	try
	{
		String profilename="c:/Tomcat 5.0/bin/JDBC.properties";
		InputStream input  = new FileInputStream(profilename);
		Properties jdbc = new Properties();
		jdbc.load(input);
		driver = jdbc.getProperty("Driver");
		url =jdbc.getProperty("UrlCol");
		String struser =jdbc.getProperty("User");
		String strpass =jdbc.getProperty("Passw");
		Class.forName(driver);
		con = DriverManager.getConnection(url,struser,strpass);
	}
	catch(Exception e)
	{
		//System.out.println(e);
	}
		
	try
	{
	   	st=con.createStatement();
		sql="select  a.chr_empid,a.chr_staffname,b.chr_padd1,chr_padd2,chr_pcity,chr_pstate,chr_pphone";
		sql=sql+" from m_staff a,m_staffaddress b where a.int_desigid="+desid+" and a.chr_empid=b.chr_empid";
		rs = st.executeQuery(sql);
	}
	
	catch(Exception npe)
	{
		//System.out.println(npe);
	}
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
.style51 {font-family: Verdana; font-size: 12px; color: #FFFFFF; }
.style52 {font-size: 10px}
.style53 {font-family: Verdana; font-size: 10px; color: #FFFFFF; }
.style55 {font-size: 10px; font-family: Verdana; }
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
<%@ include file="session.jsp"%>

<p class="style8"><u>Address Designation view</p>

<table width="800" border="0" cellpadding="0" cellspacing="1">
	<tr bgcolor="#666666">
		<td width="15%" height="14">
		<div align="center" class="style51 style52">Holder Id</div>
		</td>
		<td width="25%" height="14">
		<div align="center" class="style53">Name</div>
		</td>
		<td width="20%" height="14">
		<div align="center" class="style53">Street</div>
		</td>
		<td width="15%" height="14">
		<div align="center" class="style53">Area</div>
		</td>
		<td width="17%" height="14">
		<div align="center" class="style53">City</div>
		</td>
		<td width="13%" height="14">
		<div align="center" class="style53">State</div>
		</td>
		<td width="13%">
		<div align="center" class="style53">Phone No.</div>
		</td>
	</tr>
	<%
   while(rs.next())
	{
	%>
	<tr bgcolor="#CCCCCC">
		<td width="15%" height="19"><span class="style55"> <% out.println(rs.getString("chr_EMPID")); %>
		</span></td>
		<td width="25%" height="19"><span class="style55"> <% out.println(rs.getString("chr_staffname")); %>
		</span></td>
		<td width="20%" height="19"><span class="style55"> <% out.println(rs.getString("chr_padd1")); %>
		</span></td>
		<td width="15%" height="19"><span class="style55"> <% out.println(rs.getString("chr_padd2")); %>
		</span></td>
		<td width="17%" height="19"><span class="style55"> <% out.println(rs.getString("chr_pcity")); %>
		</span></td>
		<td width="13%" height="19"><span class="style55"> <% out.println(rs.getString("chr_pstate")); %>
		</span></td>
		<td width="13%" bgcolor="#CCCCCC"><span class="style55"> <% out.println(rs.getString("chr_pphone")); %>
		</span></td>
	</tr>
	<%
		}
		rs.close();
	%>
</table>
<br>
<br>
<br>
<br>
<a href="SmartAttendanceImg.htm"><img
	src="../Images/General/Home.gif" width="70" height="22" border="0"></a>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<a href="AddressDesign.jsp"><img src="../Images/General/Back.gif"
	width="70" height="22" border="0"></a>
</body>
</html>
