<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" type="text/css" href="styles.css">

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

<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript"
	src="../JavaScript/Attendance/ReportAjax.js"></script>
<script language="JavaScript">
  function Validate()
  {
    if(checkNull("fromdt","Enter From Date") && checkNull("todt","Enter To Date")
    && checkDate("fromdt","todt")){
  		return true;
	}
	else
	return false;	
  } 
  function mainPage()
  {
	    document.frmAtten.action="AttendanceMain.jsp";
		document.frmAtten.submit();
		return true;
  }
</script>

<script type="text/javascript">

</script>

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
<form  AUTOCOMPLETE = "off"   name="frmAtten" action="../SmartLoginAuth"
	onsubmit="return Validate()">
<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td height="104">&nbsp;</td>
	</tr>
	<tr>
		<td height="202" valign="bottom">

		<table class="BackGround" cellspacing="0" cellpadding="0" width="350"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">

					<table width="350" border="0" align="center"  >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="25" colspan="2" class="BackGround" >Date
							Wise</td>
						</tr>
						<tr>
							<td width="162" height="28" valign="middle" class="tabledata">
							Company</td>
							<td width="290"><select name="company" id="company"
								onChange="loadBranch()" class="tabledata" style="width:200px">
								<%                  
     					String queryBranch1="SELECT * FROM  com_m_company ";
     					String	branch1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(queryBranch1);
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
							</select></td>
						</tr>
						<tr>
							<td width="162" height="28" valign="middle" class="tabledata">
							Branch</td>
							<td width="290"><select name="branch" id="branch"
								class="tabledata" style="width:200px">
								<option value="-1">All</option>
							</select></td>
						</tr>
						<tr>
							<td width="162" height="32" valign="middle" class="bolddeepblue"><span
								class="style8">From</span></td>
							<td width="290" align="left" valign="middle"><font size="1"><strong><font
								color="#000000"><font size="1"> <input
								name="fromdt" type="text" class="tabledata" id="fromdt"
								value="" size="15"> <a href="javascript:cal1.popup();"><img
								src="../JavaScript/img/cal.gif" width="16" height="16"
								border="0" alt="Click Here to Pick up the date"></a> </font></font></strong></font> <font
								size="1"><strong><font color="#000000"><font
								size="1"> </font></font></strong></font></td>
						</tr>
						<tr>
							<td height="28" valign="middle" class="bolddeepblue"><span
								class="style8">To</span></td>
							<td align="left" valign="top"><font size="1"><strong><font
								color="#000000"><font size="1"> <input name="todt"
								type="text" class="tabledata" id="todt" value="" size="15">
							<strong><font color="#000000"><font size="1"><a
								href="javascript:cal2.popup();"><img
								src="../JavaScript/img/cal.gif" width="16" height="16"
								border="0" alt="Click Here to Pick up the date"></a><strong><font
								color="#000000"><font size="1"> <input
								type="hidden" name="filename" value="Attendance"> <input
								type="hidden" name="actionS" value="ATTAttendanceDateList">
							</font></font></strong></font> <font size="1"><strong><font color="#000000"><font
								size="1"> </font></font></strong></font> </font></strong></font></font></strong></font></td>
						</tr>
						<tr>
							<td colspan="2" valign="middle" class="bolddeepblue">
							<p class="style8">&nbsp;</p>
							<table border="0" align="center" cellpadding="3" cellspacing="3">
								<tr>
									<td width="56"><input name="Submit" type="submit"
										class="buttonbold" value="Submit"   accesskey="s"   ></td>
									<td width="56"><input name="Button" type="Button"
										class="buttonbold"  value="Close"   accesskey="c" 
										onClick="javascript:history.back();"></td>
								</tr>
							</table>
							<font size="1"><strong><font color="#000000"><font
								size="1"><a href="javascript:cal2.popup();"></a></font></font></strong></font></td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="25">&nbsp;</td>
	</tr>
	<tr>
		<td><script language='JavaScript'>
		<!--
			var cal1 = new calendar1(document.forms['frmAtten'].elements['fromdt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			var cal2 = new calendar1(document.forms['frmAtten'].elements['todt']);
			cal1.year_scroll = true;
			cal1.time_comp = false;		
			setCurrentDate('fromdt');
			setCurrentDate('todt');
		//-->
	</script> <%@ include file="../footer.jsp"%></td>
	</tr>
</table>

</body>
</form>
</html>

