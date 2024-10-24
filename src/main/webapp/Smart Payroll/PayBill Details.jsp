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

<script language="javascript">
function mainPage()
	{
	    document.payslipfrm.action="Payrollmain.jsp";
		document.payslipfrm.submit();
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
<form  AUTOCOMPLETE = "off"   method="post" name="payslipfrm" action="AllDesView.jsp">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="61%" border="0" cellpadding="0"
	cellspacing="0">
	<tr>
		<td height="138" valign="middle">
		<table width="100%" border="0" cellspacing="1" cellpadding="1">
			<!--DWLayoutTable-->
			<tr>
				<td width="263" height="83">
				<p>&nbsp;</p>
				<p>&nbsp;</p>
				</td>
				<td width="470">&nbsp;</td>
				<td width="257">&nbsp;</td>
			</tr>
			<tr>
				<td height="195">&nbsp;</td>
				<td valign="top">
				<table class="BackGround" cellspacing="0" cellpadding="0"
					width="390" align="center" border="0">
					<tbody>
						<tr>
							<td colspan="2" rowspan="2" valign="top"><img height="7"
								src="../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
							<td class="BorderLine" height="0"><spacer height="1"
								width="1" type="block" /></td>
							<td colspan="2" rowspan="2" valign="top"><img height="7"
								src="../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
						</tr>
						<tr>
							<td height="6"><spacer height="1" width="1" type="block" /></td>
						</tr>
						<tr>
							<td class="BorderLine" width="1"><spacer height="1"
								width="1" type="block" /></td>
							<td width="6"><spacer height="1" width="1" type="block" /></td>
							<td width="412">

							<table width="407" height="212" border="0" align="center"
								cellpadding="2" cellspacing="2"  >
								<!--DWLayoutTable-->
								<tr align="center" valign="middle">
									<td height="28" colspan="2" 
										class="BackGround style9">Pay Bill Report</td>
								</tr>
								<tr align="left" valign="middle">
									<td width="31" height="28" align="center" valign="middle">
									<div align="center"><img src="/Images/dot.gif" width="10"
										height="10"></div>
									</td>
									<td width="356" height="28" align="left" valign="middle">
									<a
										href="../SmartLoginAuth?filename=Department&actionS=COM_PAYdepartSalRep&view=null">
									All Staff </a></td>
								</tr>
								<tr align="left" valign="middle">
									<td width="31" height="28" align="center" valign="middle">
									<div align="center"><img src="/Images/dot.gif" width="10"
										height="10"></div>
									</td>
									<td width="356" height="28" align="left" valign="middle">
									<a
										href="../SmartLoginAuth?filename=Department&actionS=COM_PAYdepartSalRep&view=PF">
									PF Staff </a></td>
								</tr>
								<tr align="center" valign="middle">
									<td height="28" align="center" valign="middle">
									<div align="center"><img src="/Images/dot.gif" width="10"
										height="10"></div>
									</td>
									<td height="28" align="left" valign="middle"><span
										class="style8"> <a
										href="../SmartLoginAuth?filename=Department&actionS=COM_PAYdepartSalRep&view=ESI">
									ESI Staff </a> </span></td>
								</tr>
								<tr>
									<td height="28" align="center" valign="middle"><img
										src="/Images/dot.gif" alt="Image" width="10" height="10"></td>
									<td height="28" align="left" valign="middle"><a
										href="../SmartLoginAuth?filename=Department&actionS=COM_PAYdepartSalRep&view=PFESI">PF
									&amp; ESI Staff</a></td>
								</tr>
								<tr>
									<td height="28" align="center" valign="middle"><img
										src="/Images/dot.gif" alt="Image" width="10" height="10"></td>
									<td height="28" align="left" valign="middle"><a
										href="../SmartLoginAuth?filename=Department&actionS=COM_PAYdepartSalRep&view=NPFNESI">Non
									PF &amp; Non ESI Staff</a></td>
								</tr>
								<tr>
									<td height="28" colspan="2" align="center" valign="middle">
									<table border="0" align="center" cellpadding="2"
										cellspacing="2">
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
							<td class="BorderLine" width="1"><spacer height="1"
								width="1" type="block" /></td>
						</tr>
						<tr>
							<td colspan="2" rowspan="2"><img height="7"
								src="../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
							<td height="6"><spacer height="1" width="1" type="block" /></td>
							<td colspan="2" rowspan="2"><img height="7"
								src="../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
						</tr>
						<tr>
							<td class="BorderLine" height="0"><spacer height="1"
								width="1" type="block" /></td>
						</tr>
					</tbody>
				</table>

				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td height="67">&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		<%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>
</form>
</html>
