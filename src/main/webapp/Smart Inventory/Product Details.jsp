<%@ include file="indexinv.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
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

<script language="javascript">
function mainPage()
	{
	    document.a.action="InventoryMain.jsp";
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
.style9 {font-size: 14px}
-->
</style>
</head>
<form  AUTOCOMPLETE = "off"   method="post" name="a">
<body >
<table width="100%" height="59%" border="0" cellpadding="0"
	cellspacing="0">
	<tr>
		<td>
		<table bgcolor="#FDF2FD" cellspacing="0" cellpadding="0" width="400"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/Tleft1.gif" width="7" /></td>
					<td class="BorderLine3" height="0"><spacer height="1"
						width="1" type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/Tright1.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine3" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">
					<table width="400" height="87" border="0" align="center"
						cellpadding="2" cellspacing="2"  >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="30" colspan="2" bgcolor="#FDF2FD"
								class="tablehead style9">Product - Details</td>
						</tr>

						<tr>
							<td width="38" height="24" valign="middle"><img
								src="../Images/dot.gif" width="10" height="10"></td>
							<td width="248" valign="middle"><span class="style8"><a
								href="ProductReport.jsp" class="tabledata">Product wise </a></span></td>
						</tr>
						<tr>
							<td height="24"><img src="../Images/dot.gif" width="10"
								height="10"></td>
							<td valign="middle"><span class="style8"><a
								href="StockDatewise.jsp" class="tabledata">Date wise</a></span></td>
						</tr>
						<tr>
							<td height="24" colspan="2">
							<table border="0" align="center" cellpadding="0" cellspacing="0">
								<tr>
									<td width="56"><input name="Submit" type="submit"
										class="buttonbold13"  value="Close"   accesskey="c"  onClick="redirect( 'InventoryMains.jsp')"></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine3" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/Bleft1.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/Bright1.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine3" height="0"><spacer height="1"
						width="1" type="block" /></td>
				</tr>
			</tbody>
		</table>
		</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</form>
</html>
