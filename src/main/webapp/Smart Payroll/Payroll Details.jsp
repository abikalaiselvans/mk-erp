<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language="javascript">
function validate()
{
	
return true;				
}
function mainPage()
	{
	    document.payslipfrm.action="Payrollmain.jsp";
		document.payslipfrm.submit();
		return true;
    }	
</script>

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
.style8 {font-family: Verdana;
	font-size: 12px;
}
.style11 {
	color: #000066;
	font-size: 14px;
}
-->
</style>
</head>
<form  AUTOCOMPLETE = "off"   name="payslipfrm" method="post" action="PaySlipView.jsp"
	onSubmit="return validate()">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%@ include file="index.jsp"%>
<table width="100%" border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td height="106">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="390"
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

					<table width="390" border="0" align="center"  >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="28" colspan="2"><span class="style11">PaySlip
							Details</span></td>
						</tr>
						<tr>
							<td width="42" height="25" valign="middle">
							<div align="center"><img src="../Images/dot.gif" width="10"
								height="10" /></div>
							</td>
							<td width="338" valign="middle"><span class="style8">
							<a href="PaySlipMonth.jsp" class="tabledata">Monthwise</a> </span></td>
						</tr>
						<tr>
							<td height="25" valign="middle">
							<div align="center"><img src="../Images/dot.gif" width="10"
								height="10" /></div>
							</td>
							<td valign="middle"><span class="style8"> <!--         <a href="AttendanceIndividual.jsp" class="tabledata">Individual</a> -->
							<a href="PayrollIndividual.jsp" class="tabledata">Individual</a>
							</span></td>
						</tr>
						<tr>
							<td height="0"></td>
							<td></td>
						</tr>
						<tr>
							<td height="25" valign="middle">
							<div align="center"><img src="../Images/dot.gif" width="10"
								height="10" /></div>
							</td>
							<td valign="middle"><a href="PaySlipDesign.jsp"
								class="tabledata"> Designationwise</a></td>
						</tr>
						<tr>
							<td height="28" valign="middle">
							<div align="center"><img src="../Images/dot.gif" width="10"
								height="10" /></div>
							</td>
							<td valign="middle"><span class="style8"> <a
								href="PaySlipDept.jsp" class="tabledata">Departmentwise</a></span></td>
						</tr>
						<tr>
							<td height="28" colspan="2" valign="middle">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input class="buttonbold14" type="button"
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
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="49">&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</form>
</html>
