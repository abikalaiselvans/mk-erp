<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 
<title>::Smart Attendance::</title>
<link rel="icon" type="image/ico" href="images/ERP.ico"></link>
<link rel="shortcut icon" href="images/ERP.ico"></link>



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
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
</head>
<%
       	String msg=""+request.getParameter("error");
       	if(msg.equals("null")) msg="";
%>
<body  onpaste="return false;" bgcolor="#b7e9ff"
	background="Image/Smart%20Attendance/loginbackground.jpg">
<form method="post" action="User_Authentication.jsp">
<table width="1000" border=0>
	<!--DWLayoutTable-->
	<tr>
		<td height="2" colspan="5"><embed src="Image/General/college.swf"
			width="1000" height="110"></td>
	</tr>
	<tr>
		<td width="431" height="74">&nbsp;</td>
		<td width="12">&nbsp;</td>
		<td width="170">&nbsp;</td>
		<td width="41">&nbsp;</td>
		<td width="324">&nbsp;</td>
	</tr>
	<tr>
		<td height="40">&nbsp;</td>
		<td colspan="3" valign="top">Error : <%= msg%></td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="114">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="29">&nbsp;</td>
		<td>&nbsp;</td>
		<td align="center" valign="top"><a href="Login.jsp">Login</a></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="46">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>
</form>
</body>
</html>
