<%@ include file="index.jsp"%>
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

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/Validnamecheck.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>


<script language="javascript">
 function Validate()
{
	if(checkNull('Taxname','Enter Tax Name') && checkNull('desc','Enter Description')  )
		return true;
	else
		return false;
}
	
</script>

  
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>

<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form  AUTOCOMPLETE = "off"   name="frm" action="../SmartLoginAuth" onSubmit="return Validate()">


<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height="80">&nbsp;</td>
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

					<table width="300" border="0" align="center" cellpadding="0"
						cellspacing="0"  >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="30" colspan="2" class="BackGround" >Pay Tax </td>
						</tr>
						<tr>
							<td width="162" height="28" valign="middle" class="boldEleven">
							Tax Name <span class="boldred">*</span> </td>
							<td width="178"><input name="Taxname" type="text" class="formText135" id="Taxname" size="30" maxlength="50" onKeyUp="upperMe(this), CheckUnique(this,'soValid','pay_m_tax','CHR_TAXNAME')" onBlur="upperMe(this), CheckUnique(this,'soValid','pay_m_tax','CHR_TAXNAME')">
							
							 
							<div id="soValid"></div>
							</td>
						</tr>
						<tr>
							<td width="162" height="28" align="left" valign="top" class="boldEleven">
							Description<span class="boldred"> *</span></td>
							<td width="178" align="left" valign="top"><textarea name="desc" cols="30" rows="5" class="formText135" id="desc" onKeyPress="textArea('desc','250')"></textarea>
							  <input type="hidden" name="filename" value="PayTax">
                              <input type="hidden" name="actionS" value="PAYPayTaxAdd">
						</tr>
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<div align="center">
							
							<table border="0" cellspacing="3" cellpadding="0">
								<tr>
									<td width="56"><input class="buttonbold14" type="submit" name="Submit"  id="Submit" value="Submit"   accesskey="s"   ></td>
									<td width="56"><input class="buttonbold14" type="Button" name="Submit2"  value="Close"   accesskey="c" 
										onClick="redirect('PayTax.jsp')"></td>
								</tr>
							</table>
							</div>							</td>
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
</table></form>


<%@ include file="../footer.jsp"%>
</body>
</html>
