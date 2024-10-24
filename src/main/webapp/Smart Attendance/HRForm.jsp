<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.bean.Attendance.*"%>
 <%
try
{
%>

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
.style3 {color: #000000}
-->
</style>
<script language="JavaScript" src="../JavaScript/comfunction.js"> </script>
<script language="JavaScript" src="../JavaScript/Attendance/CommonHolidayAjax.js"></script>

<script language="javascript">
function hrFormUpload()
{
	var f ="HRFormUpload.jsp";
	newWindow = window.open(f,"subWind",",,height=250,width=325,top=0,left=0");
	newWindow.focus( );
}
 </script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
 <%@ include file="index.jsp"%>

<table width="100%" height="285" align="center">
	<tr>
		<td height="151" align="center" class="boldEleven"><a href="javascript:hrFormUpload()">Upload Forms</a> </td>
	</tr>
	<tr>
		<td height="17">&nbsp;  </td>
	</tr>
	<tr>
		<td height="17" align="center">
		 
		<tr>
		<td height="20"></td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
<%
}
catch(Exception e)
{
}
%>
