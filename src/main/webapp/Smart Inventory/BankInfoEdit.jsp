<%@ page import="java.io.*,java.util.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

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
<script language="javascript" src="../JavaScript/calendar1.js"></script>
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

<body    onLoad="document.getElementById('bankName').select()">
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
					<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm"
						onSubmit="return valid()">
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
								<%				 
				  	int bankid = Integer.parseInt(""+request.getParameter("bankid").trim());
				  	String query ="SELECT * FROM com_m_bank WHERE INT_BANKID =" +bankid;
				  	String tableData[][] =  CommonFunctions.QueryExecute(query);
				  	
				  %>
								<td height="17" class="boldEleven">Bank Name <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="bankName"
									id="bankName" type="text" size="40" class="formText135"
									onKeyUp="UpperCase('bankName')"   maxlength="50"
									value="<%=tableData[0][1]%>"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Branch <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="branchName"
									type="text" size="40" class="formText135" id="branchName"
									value="<%=tableData[0][2]%>" maxlength="50"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Address1</td>
								<td colspan="2" align="left"><input name="TxtAdd1"
									type="text" size="40" class="formText135" id="TxtAdd1"
									value="<%=tableData[0][3]%>" maxlength="50"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Address2</td>
								<td colspan="2" align="left"><input name="TxtAdd2"
									type="text" size="40" class="formText135" id="TxtAdd2"
									value="<%=tableData[0][4]%>" maxlength="50"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">City</td>
								<td colspan="2" align="left"><input name="city" type="text"
									size="40" class="formText135" id="city"
									value="<%=tableData[0][5]%>" maxlength="50"
									onKeyPress="charOnly('city','50')"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">State</td>
								<td colspan="2" align="left"><input name="state"
									type="text" size="40" class="formText135" id="state"
									value="<%=tableData[0][6]%>" maxlength="50"
									onKeyPress="charOnly('state','50')"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Pin Code</td>
								<td colspan="2" align="left">
								<%
				if (tableData[0][7].equals("0"))
					tableData[0][7]="";
			%> <input name="pin" type="text" size="40" class="formText135"
									id="pin" value="<%=tableData[0][7]%>" maxlength="6"
									onKeyPress="numericValue('pin','6')"></td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Phone</td>
								<td colspan="2" align="left"><input type="text"
									name="phone" class="formText135" size="40"
									onKeyPress="phoneValue('phone','50')"
									value="<%=tableData[0][8].trim()%>"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Fax</td>
								<td colspan="2" align="left"><input name="fax" type="text"
									size="40" class="formText135" id="fax"
									value="<%=tableData[0][9]%>"
									onKeyPress="numericValue('fax','30')"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Email <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="email"
									type="text" size="40" class="formText135" id="email"
									value="<%=tableData[0][10]%>" maxlength="30"
									onKeyPress="isEmailID('email','50')"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Website</td>
								<td colspan="2" align="left"><input name="website"
									type="text" size="40" class="formText135" id="website"
									value="<%=tableData[0][11]%>" maxlength="30"
									onKeyPress="isEmailID('website','25')"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><input name="filename"
									type="hidden" value="BankInfo" /> <input name="actionS"
									type="hidden" value="INVbankinfoUpdate" /> <input
									name="bankid" type="hidden" id="bankid" value="<%=bankid%>" /></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" type="submit" class="buttonbold"
											value="Update" onClick=""></td>
										<td><input name="Close" type="submit" class="buttonbold"
											id="Close"  value="Close"   accesskey="c"  onClick="redire('BankInfo.jsp')"></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
						</tbody>

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
