
<%@ include file="index.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
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

<script language="javascript">
function mainPage()
	{
	    document.a.action="AttendanceMain.jsp";
		document.a.submit();
		return true;
    }	
</script>

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
.style9 {
	color: #000066;
	font-size: 14px;
}
-->
</style>
</head>
<form  AUTOCOMPLETE = "off"   name="a">
<body  onpaste='return false;'>
<p class="style8">&nbsp;</p>
<p class="style8"><br>
</p>
<table width="100%" height="40%" border="0" cellpadding="0"
	cellspacing="0">
	<tr>
		<td height="205" valign="bottom">

		<table class="BackGround" cellspacing="0" cellpadding="0" width="310"
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

					<table width="308" border="0" align="center" cellpadding="2"
						cellspacing="2"  >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="29" colspan="2" 
								class="BackGround style9">Late Comers Details</td>
						</tr>
						<tr></tr>
						<tr></tr>
						<tr>
							<td width="38" height="24" valign="middle">
							<div align="center"><img src="../Images/dot.gif" width="10"
								height="10"></div>
							</td>
							<td width="248" valign="middle"><span class="style8"><a
								href="LateComersDate.jsp" class="tabledata">Datewise</a></span></td>
						</tr>
						<tr>
							<td height="24">
							<div align="center"><img src="../Images/dot.gif" width="10"
								height="10"></div>
							</td>
							<td valign="middle"><span class="style8"><a
								href="LateComersMonth.jsp" class="tabledata">Month wise</a></span></td>
						</tr>
						<tr>
							<td height="25" valign="middle">
							<div align="center"><img src="../Images/dot.gif" width="10"
								height="10"></div>
							</td>
							<td valign="middle"><span class="style8"> <a
								href="LateComersIndividual.jsp" class="tabledata">Individual</a>
							</span></td>
						</tr>
						<tr>
							<td height="25" valign="middle">
							<div align="center"><img src="../Images/dot.gif" width="10"
								height="10"></div>
							</td>
							<td valign="middle"><a href="LateComersDesign.jsp"
								class="tabledata"> Designationwise</a></td>
						</tr>
						<tr>
							<td height="24">
							<div align="center"><img src="../Images/dot.gif" width="10"
								height="10"></div>
							</td>
							<td valign="middle"><span class="style8"><a
								href="LateComersDept.jsp" class="tabledata">Departmentwise</a></span></td>
						</tr>
						<tr>
							<td colspan="2">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input class="buttonbold" type="button"
										name="Submit2"  value="Close"   accesskey="c"  onClick="mainPage()"></td>
								</tr>
							</table>
							</td>
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
</table>
<br>
<br>
                                                       
<%@ include file="../footer.jsp"%>
</body>
</form>
</html>
