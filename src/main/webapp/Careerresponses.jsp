<%@ page language="java" import="java.sql.*,java.util.*,java.io.*,java.text.*" 	errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<link rel="icon" type="image/ico" href="images/ERP.ico"></link>
<link rel="shortcut icon" href="images/ERP.ico"></link>
<%
response.setHeader("Cache-Control", "no-cache");
response.setHeader("Pragma", "no-cache");
response.setDateHeader("Expires", -1);
response.setHeader("Cache-Control", "no-store");
response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1.
response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
response.setDateHeader("Expires", 0); // Proxies.
 
%>


<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright"
	content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords"
	content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />
<meta http-equiv="Cache-Control"
	content="no-cache, no-store, must-revalidate">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Expires" content="0">


<link href="Logincss/templatemo_style.css" rel="stylesheet"
	type="text/css" />
<link href="Logincss/jquery.ennui.contentslider.css" rel="stylesheet"
	type="text/css" media="screen,projection" />

<script type="text/javascript">
function Redirect()
{
    window.location="Login.jsp";
}

 setTimeout('Redirect()', 10000);
 </script>
<%
    try
	{  
%>

<title>:: Career Responses ::</title>
</head>
<body>

<div id="templatemo_wrapper_outer" align="center">
<div id="templatemo_wrapper" align="center">

<div id="templatemo_header">
<div id="site_title">
<table width="83%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="tmo_list">&nbsp;</td>
	</tr>
</table>
<h1>&nbsp;</h1>
</div>
<!-- end of site_title -->

<ul id="social_box">
	<li></li>
	<li></li>
	<li></li>
	<li></li>
	<li></li>
</ul>

<div class="cleaner"></div>
</div>

<div id="templatemo_menu">
<table width="40%" border="0" cellspacing="0" cellpadding="0"
	align="right">
	<tr>
		<td width="95%">&nbsp;</td>
	</tr>
	<tr>
		<td class="menu" align="right"><a href="index.html">Home</a>&nbsp;&nbsp;|
		<a href="career.html">Career</a>&nbsp;&nbsp;|<a
			href="verification.html" target="_self"> Verification </a>&nbsp;|<a
			href="contact.html" target="_self">&nbsp;Contact</a></td>
		<td width="0%"></td>
		<td width="5%"></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

</div>
<!-- end of templatemo_menu -->

<div id="templatemo_slider_wrapper">



<table width="80%" height="150" align="center" cellpadding="2"
	cellspacing="0">

	<tr>
		<td><font color="#000000"> Your personal informations has
		been sent to our HR Team . Our team will contact you for further
		details.This is your reference number : <b><%=""+session.getAttribute("CAREERID")%></b>
		Thank you If you have any queries please mail to hr@careind.net or
		call us at 044-24340906 Extn 26.</b> </font></td>
	</tr>
</table>
<%
 session.removeAttribute("CAREERID");
 session.removeAttribute("CAREERID");
 session.removeAttribute("CAREERID");
 session.removeAttribute("CAREERID");
 
 %>
</div>

<div id="templatemo_content_wrapper_bottm"></div>

<div id="templatemo_footer">Copyright &copy; 2013 Care IT Solution
Pvt Ltd</div>

</div>
<!-- end of wrapper --></div>
<!-- end of wrapper_outer -->

<%
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>

</body>
</html>