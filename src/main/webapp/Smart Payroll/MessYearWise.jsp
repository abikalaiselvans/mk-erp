<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<title> :: PAYROLL ::</title>


 
 
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
<script language="JavaScript">
function mainPage()
	{
	    
	    document.mess.action="Payrollmain.jsp";
		document.mess.submit();
		return true;
    }
</script>
</head>
<form  AUTOCOMPLETE = "off"   name="mess" method="post" action="../SmartLoginAuth">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<br>
<br>
<br>
<br>
<br>
<table width="1002">
	<!--DWLayoutTable-->
	<tr>
		<td width="254" height="16">
		<td width="145">
		<td width="55">
		<td width="51">
		<td width="235">
		<td width="237">
	<tr>
		<td height="87">
		<td colspan="4" valign="top">
		<table align="center" border="1"  >
			<!--DWLayoutTable-->
			<tr align="center">
				<td height="26" colspan="2" valign="top" 
					class="tablehead">Mess Details - YearWise</td>
			</tr>
			<tr>
				<td width="188" height="32" align="center" valign="middle"
					class="bolddeepblue">Select Year</td>
				<td width="263" valign="top"><select name="year">
					<option value="Select">Select</option>
					<option value="1991">1991</option>
					<option value="1992">1992</option>
					<option value="1993">1993</option>
					<option value="1994">1994</option>
					<option value="1995">1995</option>
					<option value="1996">1996</option>
					<option value="1997">1997</option>
					<option value="1998">1998</option>
					<option value="1999">1999</option>
					<option value="2000">2000</option>
					<option value="2001">2001</option>
					<option value="2002">2002</option>
					<option value="2003">2003</option>
					<option value="2004">2004</option>
					<option value="2005">2005</option>
					<option value="2006">2006</option>
					<option value="2007">2007</option>
					<option value="2008">2008</option>
					<option value="2009">2009</option>
					<option value="2010">2010</option>
					<option value="2011">2011</option>
					<option value="2012">2012</option>
					<option value="2013">3013</option>
					<option value="2014">2014</option>
					<option value="2015">2015</option>
					<option value="2016">2016</option>
					<option value="2017">2017</option>
					<option value="2018">2018</option>
					<option value="2019">2019</option>
					<option value="2020">2020</option>
				</select></td>
			</tr>
		</table>
		<input type="hidden" name="filename" value="MessBill"> <input
			type="hidden" name="actionS" value="PAYMessBillYearView"> <input
			type="hidden" name="view" value="MessBill">
		<td>
	<tr>
		<td height="26">
		<td>
		<td valign="top"><input class="buttonbold" type="submit"
			name="Submit" value="Submit"   accesskey="s"   >
		<td valign="top"><input class="buttonbold" type="submit"
			name="Submit"  value="Close"   accesskey="c"  onclick="mainPage()">
		<td>
		<td>&nbsp;</td>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
<a href="SmartAttendanceImg.htm"> <br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br>
<br></br>
<%@ include file="../footer.jsp"%>
</body>
</form>
</html>
