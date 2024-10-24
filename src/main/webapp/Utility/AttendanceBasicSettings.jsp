<%@ page contentType="text/html; " language="java" import="java.sql.*" 	errorPage="../error/index.jsp"%>

<%@include file="Redirect.jsp" %>	

<%String actionStu="UTIsecurityAdd"; %>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<html>
<head>

<title> :: UTILITY :: </title>


 
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

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<!--  <%@ include file="index.jsp"%> -->
<body  onpaste='return false;'>
<form name="a" action="../SmartLoginAuth">
<table width="1083" border="0" cellpadding="0" cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
		<td width="353" height="226">&nbsp;</td>
		<td width="418" valign="top">
		<table width="100%" border="1" align="center" cellpadding="0"
			cellspacing="0"  >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle">
				<td height="28" colspan="2"  class="tablehead">Institution
				Information</td>
			</tr>
			<tr>
				<td width="137" height="28" valign="middle" class="tabledata">Name</td>
				<td width="275" valign="top"><input type="text" name="TxtName"
					type="text" size="40" onkeypress="charOnly('TxtName','25')">
				</td>
			</tr>
			<tr>
				<td height="28" valign="middle" class="tabledata">Address</td>
				<td valign="top"><input type="text" name="TxtAddress"
					type="text" size="40" onkeypress="charOnly('TxtAddress','25')"></td>
			</tr>
			<tr>
				<td height="28" valign="middle" class="tabledata">City</td>
				<td valign="top"><input type="text" name="TxtCity" size="40"
					type="text" onkeypress="charOnly('TxtCity','25')"></td>
			</tr>
			<tr>
				<td height="28" valign="middle" class="tabledata">State</td>
				<td valign="top"><input type="text" name="TxtState" size="40"
					type="text" onkeypress="charOnly('TxtState','25')"></td>
			</tr>
			<tr>
				<td height="28" valign="middle" class="tabledata">Pin</td>
				<td valign="top"><input type="text" name="TxtPin" size="40"
					type="numericValue" onkeypress="numericValue('TxtPin','6')"></td>
			</tr>
			<tr>
				<td height="28" valign="middle" class="tabledata">Phone</td>
				<td valign="top"><input type="text" name="TxtPhone" size="40"
					type="numericValue" onkeypress="numericValue('TxtPhone','10')"></td>
			</tr>
			<tr>
				<td height="28" valign="middle" class="tabledata">Mail Id</td>
				<td valign="top"><input type="text" name="TxtMail" size="40"
					type="alphaNumeric" onkeypress="alphaNumeric('TxtMail','25')"></td>
			</tr>
		</table>
		</td>
		<td width="1">&nbsp;</td>
		<td width="311">&nbsp;</td>
	</tr>
	<tr>
		<td height="170">&nbsp;</td>
		<td valign="top">
		<table width="100%" border="1" cellpadding="0" cellspacing="0"
			 >
			<!--DWLayoutTable-->
			<tr>
				<td height="28" colspan="2" align="center" valign="middle"
					  class="tablehead">Smart Attendance</td>
			</tr>
			<tr>
				<td width="137" height="28" valign="middle" class="tabledata">OnDuty</td>
				<td width="275" valign="middle" class="tabledata"><input
					type="radio" name="RadioDuty" value="B"> BioMetric <input
					type="radio" name="RadioDuty" value="S"> SmartCard <input
					type="radio" name="RadioDutuy" value="M"> Manual</td>
			</tr>
			<tr>
				<td height="28" valign="middle" class="tabledata">Leave</td>
				<td valign="middle" class="tabledata"><input type="radio"
					name="RadioLeave" value="B"> BioMetric <input type="radio"
					name="RadioLeave" value="S"> SmartCard <input type="radio"
					name="RadioLeave" value="M"> Manual</td>
			</tr>
			<tr>
				<td height="28" valign="middle" class="tabledata">Permission</td>
				<td valign="middle" class="tabledata"><input type="radio"
					name="RadioPermission" value="B"> BioMetric <input
					type="radio" name="RadioPermission" value="S"> SmartCard <input
					type="radio" name="RadioPermission" value="M"> Manual</td>
			</tr>
			<tr>
				<td height="28" valign="middle" class="tabledata">Manual</td>
				<td valign="middle" class="tabledata"><input type="radio"
					name="RadioManual" value="B"> BioMetric <input type="radio"
					name="RadioManual" value="S"> SmartCard <input type="radio"
					name="RadioManual" value="M"> Manual</td>
			</tr>
			<tr>
				<td height="28" valign="middle" class="tabledata">SmartAttendance</td>
				<td valign="middle" class="tabledata"><input type="radio"
					name="RadioSmart" value="B"> BioMetric <input type="radio"
					name="RadioSmart" value="S"> SmartCard <input type="radio"
					name="RadioSmart" value="M"> Manual</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="360">&nbsp;</td>
		<td colspan="2" valign="top">
		<table width="100%" border="1" cellpadding="0" cellspacing="0"
			 >
			<!--DWLayoutTable-->

			<tr align="center" valign="middle">
				<td height="28" colspan="2"  class="tablehead">Time-Setting
				</td>
			</tr>
			<tr>
				<td width="137" height="28" valign="middle" class="tabledata">TimeIN</td>
				<td width="275" valign="top"><input type="text" name="TxtIn"
					type="text" size="40" onkeypress="timeOnly('TxtIn','25')">
				</td>
			</tr>
			<tr>
				<td height="28" valign="middle" class="tabledata">TimeOut</td>
				<td valign="top"><input type="text" name="TxtOut" type="text"
					size="40" onkeypress="timeOnly('TxtOut','25')"></td>
			</tr>
			<tr>
				<td height="28" valign="middle" class="tabledata">LunchIn</td>
				<td valign="top"><input type="text" name="TxtLunchIn" size="40"
					type="text" onkeypress="timeOnly('TxtLunchIn','25')"></td>
			</tr>
			<tr>
				<td height="28" valign="middle" class="tabledata">LunchOut</td>
				<td valign="top"><input type="text" name="TxtLunchOut"
					size="40" type="text" onkeypress="timeOnly('TxtLunchOut','25')"></td>
			</tr>
			<tr>
				<td height="28" valign="middle" class="tabledata">GraceIn</td>
				<td valign="top"><input type="text" name="TxtGraceIn" size="40"
					type="numericValue" onkeypress="numericValue('TxtGraceIn','2')"></td>
			</tr>
			<tr>
				<td height="28" valign="middle" class="tabledata">GraceOut</td>
				<td valign="top"><input type="text" name="TxtGraceOut"
					size="40" type="numericValue"
					onkeypress="numericValue('TxtGraceOut','10')"></td>
			</tr>
			<tr>
				<td height="28" valign="middle" class="tabledata">OT</td>
				<td valign="top"><input type="text" name="TxtOt" size="40"
					onkeypress="numericValue('TxtOt','4')"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<center>
<table>
	<!--DWLayoutTable-->
	<tr align="center">
		<td align="center"><input type="HIDDEN" name="filename"
			value="SecuritySetting"> <input type="HIDDEN" name="actionS"
			value="<%=actionStu %>"> <input type="submit" name="Submit"
			value="Submit"></td>
	</tr>
</table>
</center>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
