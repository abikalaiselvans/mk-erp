<html>
<head>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script src="../JavaScript/common/StaffloadAjax.js"></script>
 
<title> :: UTILITY :: </title>

<%@include file="Redirect.jsp" %>
 
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

 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
function valid()
{
	if(checkNull('ename',"SELECT STAFF") && checkNull('desc',"ENTER DESCRIPTION") && checkNull('subject',"ENTER Subject")  )
		return true;
	else
		return false;
}
</script>
<body  onpaste="return false;" onLoad="init()">
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<form name="a" method="post" action="../SmartLoginAuth" onSubmit=" return valid()">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td> </td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>

		<table width="42%" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="10" colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="405" valign="top">
					<table width="384" height="172" border="0" align="center"
						 >
						<!--DWLayoutTable-->
						<tr>
							<td height="30" colspan="3" align="center" valign="middle" class="BackGround">SIMPLE MAIL</td>
						</tr>
						<tr>
							<td height="32" colspan="2" class="tabledata"><%@ include
								file="../JavaScript/ajax.jsp"%></td>
						</tr>
						<tr>
						  <td valign="top" class="boldEleven">Subject</td>
						  <td><input name="subject" type="text" class="formText135" id="subject" maxlength="300"></td>
					  </tr>
						<tr>
							<td width="179" valign="top" class="boldEleven">Content</td>
							<td width="189"><textarea name="desc" cols="25" rows="5" id="desc"></textarea></td>
						</tr>
						<tr>
							<td class="tabledata"><!--DWLayoutEmptyCell-->&nbsp;</td>
							<td><input name="filename" 	type="hidden" value="Mail" />
                              <input name="actionS" 	type="hidden" value="UTIMail" /></td>
						</tr>
						<tr>
							<td colspan="2" class="tabledata">
							<table align="center">
								<tr>
									<td width="56"><input name="Submit" type="Submit"
										class="buttonbold" value="Submit"   accesskey="s"    onClick="validate()"></td>
									<td width="56"><input class="buttonbold" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="redirect('Userframe.jsp')"></td>
								</tr>
							</table>							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="6"><spacer height="1" width="1"
						type="block" /></td>
					<td width="1" class="BorderLine"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2" valign="bottom">
					<div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div>
					</td>
				</tr>
				<tr>
					<td class="BorderLine" height="1"></td>
				</tr>
			</tbody>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="106">&nbsp;</td>
	</tr>
	<tr>
		<td> </td>
	</tr>
</table>

</form>
</body>
</html>
