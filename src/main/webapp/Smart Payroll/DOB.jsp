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
    if(checkNullSelect("OptType","Select Type","select") 
    && checkNullSelect("Month","Select Month ",'0')){
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
 
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<form  AUTOCOMPLETE = "off"   name="frmAtten" action="DOBView.jsp">
<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<p><br>
</p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
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
					<table width="400" align="center" border="0"  >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="25" colspan="2" class="BackGround" >DOB &amp; WEDDING </td>
						</tr>
						<td width="160" height="32" valign="middle" class="bolddeepblue"><span
							class="style8">Type</span></td>
						<td width="318" align="left" valign="middle"><select
							name="OptType" id="OptType" class="bolddeepblue">
							<option value="select">Select</option>
							<option value="D">Date of Birth</option>
							<option value="M">Wedding Date</option>
						</select></td>
						<tr>
							<td height="32" valign="middle" class="bolddeepblue"><span
								class="style8">Month</span></td>
							<td align="left" valign="middle"><font color="#000000"
								size="1"> <%@ include file="../JavaScript/month.jsp"%>
							</font></td>
						</tr>
						<tr>
							<td height="32" colspan="2" valign="middle" class="bolddeepblue">
							<table width="132" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="54"><input name="Submit"  id="Submit" type="submit"
										class="buttonbold14" value="Submit"   accesskey="s"   
										onClick="return Validate()"></td>
									<td width="57"><input name="Button"  id="Button" type="Button"
										class="buttonbold14"  value="Close"   accesskey="c"  onClick="mainPage()"></td>
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
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
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
</form>
</html>

