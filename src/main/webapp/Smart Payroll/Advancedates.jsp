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

<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript">
  function Validate()
  {
    if(checkNull("fromDate","Enter From Date") && checkNull("toDate","Enter To Date")
    && checkDate("fromDate","toDate")){
  		return true;
	}
	else
	return false;	
  } 
  function mainPage()
  {
	    document.frmAtten.action="Payrollmain.jsp";
		document.frmAtten.submit();
		return true;
  }
</script>
<script type="text/javascript">
</script>
</head>
<form  AUTOCOMPLETE = "off"   name="frmAtten" action="../SmartLoginAuth">
<body  onpaste='return false;'>

<table width="100%" border="0">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td><%@ include file="index.jsp"%></td>
	</tr>
	<tr>
		<td height="125">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table align="center" border="1"  >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle">
				<td height="25" colspan="2"  class="tablehead">Date
				Wise</td>
			</tr>
			<tr>
				<td width="134" height="32" valign="middle" class="bolddeepblue"><span
					class="style8">From</span></td>
				<td width="290" align="left" valign="middle"><font size="1"><strong><font
					color="#000000"><font size="1"> <input type="text"
					name="fromDate" id="fromDate" value="" size="15"
					onKeyPress="dateOnly('fromDate')"> <a
					href="javascript:cal1.popup();"><img
					src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
					alt="Click Here to Pick up the date"></a> </font></font></strong></font> <font size="1"><strong><font
					color="#000000"><font size="1"> </font></font></strong></font> </select></td>
			</tr>
			<tr>
				<td height="28" valign="middle" class="bolddeepblue">
				<p class="style8">To</p>
				</td>
				<td align="left" valign="top"><font size="1"><strong><font
					color="#000000"><font size="1"> <input type="text"
					name="toDate" id="toDate" value="" size="15"
					onKeyPress="dateOnly('toDate')"> <a
					href="javascript:cal2.popup();"><img
					src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
					alt="Click Here to Pick up the date"></a> </font></font></strong></font> <font size="1"><strong><font
					color="#000000"><font size="1"> </font></font></strong></font></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table align="center" cellpadding="1" cellspacing="1">
			<tr>
				<td width="56"><input name="Submit2" type="submit"
					class="buttonbold" value="Submit"   accesskey="s"    onsubmit="return Validate()">
				<td>
				<td width="56"><input name="Button2" type="Button"
					class="buttonbold"  value="Close"   accesskey="c"  onclick="mainPage()"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td><input type="hidden" name="filename" value="Advance">
		<input type="hidden" name="actionS" value="PAYAdvanceView"></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="66">&nbsp;</td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>

<script language='JavaScript'>
		<!--
			var cal1 = new calendar1(document.forms['frmAtten'].elements['fromDate']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			var cal2 = new calendar1(document.forms['frmAtten'].elements['toDate']);
			cal1.year_scroll = true;
			cal1.time_comp = false;		
			setCurrentDate('fromDate');
			setCurrentDate('toDate');
		//-->
	</script>
</body>
</form>
</html>

