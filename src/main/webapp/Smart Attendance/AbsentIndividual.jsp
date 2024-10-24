
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<html>
<head>


<title> :: ATTENDANCE ::</title>


 
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>


<script language="JavaScript">
  function Validate()
  {
  	if(checkNull("ename","Select Staff")&& checkNullSelect("Month","Select Month","0")&&(checkNullSelect("Year","Select Year","0"))){
		document.frmState.action="../SmartLoginAuth";
		document.frmState.submit();
		return true;
	}
	return false;
  }
  
  
 function mainPage()
  {
	    document.ATT_Indidual_Rep.action="AttendanceMain.jsp";
		document.ATT_Indidual_Rep.submit();
		return true;
  }
</script>
 

<title> :: ATTENDANCE ::</title>


<style type="text/css">
<!--
.style16 {	font-size: 24px;
	color: #666666;
}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}


-->
</style>


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
<body  onpaste="return false;" onLoad="init()">

<form  AUTOCOMPLETE = "off"   name="frmState" action="../SmartLoginAuth" name="ATT_Indidual_Rep"
	id="ATT_Indidual_Rep" onSubmit="return Validate()">
<table width="103%" border="0" cellspacing="2" cellpadding="2">
	<tr>
		<td><%@ include file="index.jsp"%></td>
	</tr>
	<tr>
		<td height="85">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="400" height="166" border="1" align="center"
			  class="bolddeepblue">
			<!--DWLayoutTable-->
			<tr align="center" valign="middle">
				<td height="28" colspan="4" align="center" valign="middle"
					class="tabledata"><%@ include file="../JavaScript/ajax.jsp"%>
				</td>
			</tr>
			<tr align="center" valign="middle">
				<td height="29" colspan="4" valign="top" class="BackGround"
					 >Absent Details Individual</td>
			</tr>
			<tr valign="top">
				<td height="18" colspan="4" class="tabledata" align="center"><!--DWLayoutEmptyCell-->&nbsp;</td>
			</tr>
			<tr valign="top">
				<td height="18" colspan="4" class="tabledata" align="center">
				<table width="162" border="0" cellspacing="0" cellpadding="0">
					<tr class="bolddeepblue">
						<td width="36" valign="middle"><input name="Report"
							type="radio" value="Month" checked></td>
						<td width="60" valign="middle" class="tabledata">Month</td>
						<td width="1" valign="middle"><input type="radio"
							name="Report" value="Date"></td>
						<td width="65" valign="middle" class="tabledata">Date</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td width="56" height="28" valign="middle" class="bolddeepblue"><span
					class="style13">Month</span></td>
				<td width="97" valign="middle"><%@ include
					file="../JavaScript/month.jsp"%></td>
				<td width="43" class="bolddeepblue">From</td>
				<td width="150" valign="middle"><font size="1"><strong><font
					color="#000000"><font size="1"> <input name="fromdt"
					type="text" class="bolddeepblue" id="fromdt" value="" size="15">
				<a href="javascript:cal1.popup();"><img
					src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
					alt="Click Here to Pick up the date"></a> </font></font></strong></font> <font size="1"><strong><font
					color="#000000"><font size="1"> </font></font></strong></font></td>
			</tr>
			<tr>
				<td height="29" valign="middle" class="bolddeepblue"><span
					class="style13">Year</span></td>
				<td valign="middle"><span class="style11" width="97"> <%@ include
					file="../JavaScript/year.jsp"%> </span></td>
				<td valign="top" class="bolddeepblue">TO</td>
				<td valign="middle"><font size="1"><strong><font
					color="#000000"> <font size="1"> <input name="todt"
					type="text" class="boldEleven" id="todt" value="" size="15">
				<a href="javascript:cal2.popup();"><img
					src="../JavaScript/img/cal.gif" width="16" height="16" border="0"
					alt="Click Here to Pick up the date"></a> <input type="hidden"
					name="filename" value="Absent"> <input type="hidden"
					name="actionS" value="ATTAbsentIndidualList"> </font></font></strong></font></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100" border="0" align="center" cellpadding="1"
			cellspacing="1">
			<tr>
				<td width="56"><input name="Submit" type="submit"
					class="buttonbold" value="Submit"   accesskey="s"   ></td>
				<td width="56"><input name="Button" type="Button"
					class="buttonbold"  value="Close"   accesskey="c" 
					onClick="javascript:history.back();"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<script language='JavaScript'>
		<!--
			var cal1 = new calendar1(document.forms['ATT_Indidual_Rep'].elements['fromdt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			var cal2 = new calendar1(document.forms['ATT_Indidual_Rep'].elements['todt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;				
			setCurrentDate('fromdt');
			setCurrentDate('todt');			
	
		//-->
	</script> <%@ include file="../footer.jsp"%></form>
</body>
</html>
