<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
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

<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   method="post" action="SupplierAdd.jsp">
<p align="center"><strong><u>Supplier Master</u></strong></p>

<table width="870" border=0>
	<tr>
		<td width="216" rowspan="3" valign="top" background="../if">
		<div align="center"></div>
		</td>
		<td width="274" colspan="3" valign="top" background="../if">
		<table width="256" border="1" cellspacing="2" cellpadding="2">
			<tr>
				<td width="106">Supplier Name</td>
				<td width="144"><input type="text" name="sname"></td>
			</tr>
			<tr>
				<td colspan="2">
				<div align="center">Contact Details</div>
				</td>
			</tr>
			<tr>
				<td>Contact Person</td>
				<td><input type="text" name="cont"></td>
			</tr>
			<tr>
				<td>Phone Number</td>
				<td><input type="text" name="phno"></td>
			</tr>
			<tr>
				<td>Cell Number</td>
				<td><input type="text" name="cellno"></td>
			</tr>
			<tr>
				<td>Fax Number</td>
				<td><input type="text" name="faxno"></td>
			</tr>
			<tr>
				<td height="11">Web Site</td>
				<td><input type="text" name="web"></td>
			</tr>
			<tr>
				<td height="4">E-Mail</td>
				<td><input type="text" name="mail"></td>
			</tr>
			<tr>
				<td height="2" colspan="2">
				<div align="center">Address Details</div>
				</td>
			</tr>
			<tr>
				<td height="0">Address1</td>
				<td height="0"><input type="text" name="add1"></td>
			</tr>
			<tr>
				<td height="-1">Address2</td>
				<td height="-1"><input type="text" name="add2"></td>
			</tr>
			<tr>
				<td height="-2">City</td>
				<td height="-2"><input type="text" name="city"></td>
			</tr>
			<tr>
				<td height="-2">State</td>
				<td height="-2"><select name="st">
					<option>TamilNadu
					<option>Kerala
					<option>karnataka</option>

				</select></td>
			</tr>
			<tr>
				<td height="-1">PinCode</td>
				<td height="-1"><input type="text" name="pin"></td>
			</tr>
		</table>
		</td>
		<td width="10" valign="top" background="../if">
		<div align="right"></div>
		</td>
	</tr>
	<tr>
		<td width="67" rowspan="2" valign="top" background="../if">&nbsp;</td>
		<td width="67" valign="top" background="../if"><input
			type="submit" name="Submit" value="Submit"   accesskey="s"   ></td>
		<td width="136" rowspan="2" valign="top" background="../if">&nbsp;</td>
		<td rowspan="2" valign="top" background="../if">&nbsp;</td>
	</tr>
	<tr>
		<td valign="top" background="../if">&nbsp;</td>
	</tr>
</table>

<table width="870" border=0>
	<!--DWLayoutTable-->
	<tr>
		<td width="345" height="72">&nbsp;</td>
		<td width="93" valign="top" background="../if"><a
			href="../Smart%20Attendance/Mainscreen.htm"><img
			src="../Image/Home.gif" width="93" height="70" border="0"></a></td>
		<td width="96">&nbsp;</td>
		<td width="92" valign="top" background="../if"><a
			href="InventoryMain.jsp"><img src="../Image/Back.gif" width="92"
			height="69" border="0"></a></td>
		<td width="222">&nbsp;</td>
	</tr>
</table>
<br>
<br>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>
