<%@ page import="java.sql.*,java.util.*,java.io.*"%>
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

</head>
<script language="javascript">
	function LoadWindow()
	{
//		window.open("AttendanceStaffMain.jsp","_blank","channelmode =0,fullscreen = yes,scrollbars = no")		
		window.open("AttendanceStaffMain.jsp")		
	}
</script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onLoad="LoadWindow()">
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	class="body">
<%
	String sesUserName=""+session.getAttribute("USRID"); 
%>
<table width="1000" height="147" border="0" cellpadding="0"
	cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
		<td height="110" colspan="7" valign="top"><embed
			src="../Image/General/college.swf" width="1000" height="110"></td>
	</tr>
	<tr>
		<td width="35" height="14"></td>
		<td width="291"></td>
		<td width="131"></td>
		<td width="160"></td>
		<td width="221"></td>
		<td width="153"></td>
		<td width="9"></td>
	</tr>
	<tr>
		<td height="23">&nbsp;</td>
		<td valign="top" class="logindata" style="filter:shadow()"><font
			color="#FFFF00">Welcome,<%= sesUserName %></font></td>
		<td>&nbsp;</td>
		<td valign="top" class="logindata" style="filter:shadow()"><font
			color="#FFFF00">Smart Attendance</font></td>
		<td>&nbsp;</td>
		<td valign="top">
		<table width="100%" border="1" cellpadding="0" cellspacing="0"
			frame="lhs" bordercolor="#202B78">
			<!--DWLayoutTable-->
			<tr>
				<td width="41" height="19" align="center" valign="middle"><a
					href="mailto:software@yahoo.co.in">Mail</a></td>
				<td width="44" align="center" valign="middle"><a
					href="javascript:LoadWindow()">Home</a></td>
				<td width="56" align="center" valign="middle"><a
					href="../Logout.jsp">Logout</a></td>
				<td></td>
			</tr>
		</table>
		</td>
		<td></td>
	</tr>
</table>
<table width="1000" border="0" cellpadding="0" cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
		<td width="401" height="40">&nbsp;</td>
		<td width="227">&nbsp;</td>
		<td width="372">&nbsp;</td>
	</tr>
	<tr>
		<td height="300">&nbsp;</td>
		<td valign="top"><img
			src="../Image/Smart Attendance/ATTENDANCEMAIN.jpg" width="227"
			height="300"></td>
		<td>&nbsp;</td>
	</tr>
</table>
<br>
<%@ include file="../footer.jsp"%>
</body>
</html>

