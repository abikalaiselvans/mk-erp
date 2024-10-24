<%@ page import="java.io.*,java.util.*" errorPage="../error/index.jsp"%>
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

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>

<script language="JavaScript">

function valid()
{   
	 	
	if(
		checkNull("bankName","Enter Bank Name") 
		&& checkNull("branchName","Enter Branch Name")
		&& chkemail1("email",'Entert the correct E-mail Address...')
		) 
	{
		return true;
	}
	else
		return false;	
	 	
} 

 
 	
</script>

<body    onLoad="document.getElementById('name').focus()">
<%@ include file="indexinv.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#FFFFFF">
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
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
					<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm">
					<table cellspacing="2" cellpadding="2" width="388" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Bank Information</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>

							<tr>
								<td height="17" class="boldEleven">Bank Name <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="bankName"
									type="text" class="formText135" id="bankName"
									onBlur="upperMe(this), CheckUnique(this,'divunitname','com_m_bank','CHR_BANKNAME')"  onKeyUp="upperMe(this),CheckUnique(this,'divunitname','com_m_bank','CHR_BANKNAME') "maxlength="50" size="40">
									<div id='divunitname'></div>
									</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Branch Name <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="branchName"
									type="text" class="formText135" id="branchName" maxlength="50"
									size="40"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Address1</td>
								<td colspan="2" align="left"><input name="TxtAdd1"
									type="text" class="formText135" id="TxtAdd1" maxlength="50"
									size="40"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Address2</td>
								<td colspan="2" align="left"><input name="TxtAdd2"
									type="text" class="formText135" id="TxtAdd2" maxlength="50"
									size="40"></td>
							</tr>

							<tr>
								<td height="17" class="boldEleven">City</td>
								<td colspan="2" align="left"><input name="city" type="text"
									class="formText135" id="city" maxlength="50" size="40"
									onKeyPress="charOnly('city','50')"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">State</td>
								<td colspan="2" align="left"><input name="state"
									type="text" class="formText135" id="state" maxlength="50"
									size="40" onKeyPress="charOnly('state','50')"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Pin Code</td>
								<td colspan="2" align="left"><input name="pin" type="text"
									class="formText135" id="pin" size="40" maxlength="6"
									onKeyPress="numericValue('pin','6')"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven" valign="top">Phone</td>
								<td colspan="2" align="left"><input type="text" size="40"
									name="phone" id="phone" class="formText135" maxlength="50"
									onKeyPress="phoneValue('phone','50')" /></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Fax</td>
								<td colspan="2" align="left"><input name="fax" type="text"
									class="formText135" id="fax" size="40" maxlength="30"
									onKeyPress="numericValue('fax','50')"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Email</td>
								<td colspan="2" align="left"><input name="email"
									type="text" class="formText135" id="email" size="40"
									maxlength="30" onBlur="isEmailID('email','50')"></td>
							</tr>

							<tr>
								<td height="17" class="boldEleven">Website</td>
								<td colspan="2" align="left"><input name="website"
									type="text" class="formText135" size="40" maxlength="30"
									onKeyPress="isEmailID('website','25')"></td>
							</tr>

							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><input name="filename"
									type="hidden" value="BankInfo" /> <input name="actionS"
									type="hidden" value="INVbankInfoAdd" /></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input id="Submit"  name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"    onClick="return valid()"></td>
										<td><input name="Close"  id="Close" type="submit"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											 onClick="redire('BankInfo.jsp')"></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
						</tbody>
						<input type="hidden" name="mobileBookingOption" />
					</table>
					</form>
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
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>
