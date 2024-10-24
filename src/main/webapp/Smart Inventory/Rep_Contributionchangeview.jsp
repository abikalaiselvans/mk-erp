<%@ page import="java.io.*,java.util.*"%>

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
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/SearchAJAXFunction.js"></script>
<script language="javascript">
function valid()
{
	if(	
		checkNullSelect("type","Select sales type",'0')
		&&checkNull("invno","Select invoice number")
		&&checkNull("A11","Enter Amount")
		&&checkNull("A12","Enter Amount")
		&&checkNull("A13","Enter Amount")
		&&checkNull("A14","Enter Amount")
		&&checkNull("A15","Enter Amount")
		
		)
		{
		return true;	
		}
	else
		return false;			
}
</script>
<body    onLoad="init()">
<%@ include file="indexinv.jsp"%>
<form action="../SmartLoginAuth" method="post"   name="frm"  AUTOCOMPLETE = "off" onSubmit="return valid()" >
<table width="100%" border="0" cellspacing="1" cellpadding="1">
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
		<td>
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
					<table cellspacing="2" cellpadding="2" width="500" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Contribution  Change </td>
							</tr>

							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							
							
							<tr>
							  <td height="17" class="boldEleven">Sales Type </td>
							  <td colspan="2" align="left"><span class="boldEleven">
							    <select name="type"  >
                                  <option value="0">Select
								  <option value="1"  selected="selected" >Direct Sales
                                 <!-- <option value="2">Direct Billing-->
                              </select>
							  </span></td>
						  </tr>
							<tr>
							  <td height="17" colspan="3" valign="top" class="boldEleven"><jsp:include page="../JavaScript/Invoicesearch.jsp" flush="true" /></td>
						  </tr>
							<tr>
							  <td  colspan="3" valign="top" class="boldEleven">							  </td>
						  </tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Invoice Number </td>
								<td colspan="2" align="left" valign="top"><span class="boldEleven">
							    
								</span></td>
							</tr>
							<tr>
							  <td height="17" colspan="3" class="boldEleven"><table width="100%" border="0" cellspacing="2" cellpadding="2">
                                <tr>
                                  <td class="boldEleven">Additional Warranty </td>
                                  <td class="boldEleven"><input name="A11" type="text" class="formText135" id="A1" style='text-align:right' onKeyPress="doubleValue('A11','12')" value="0" size="15" ></td>
                                  <td class="boldEleven">Transport charge </td>
                                  <td class="boldEleven"><input name="A12"  type="text" class="formText135" id="A12" style='text-align:right' onKeyPress="doubleValue('A12','12')" value="0" size="15" > </td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Backend</td>
                                  <td class="boldEleven"><input name="A13"  type="text" class="formText135" id="A13" style='text-align:right' onKeyPress="doubleValue('A13','12')" value="0" size="15"  ></td>
                                  <td class="boldEleven">Installation Charges </td>
                                  <td class="boldEleven"><input name="A14"  type="text" class="formText135" id="A14" style='text-align:right' onKeyPress="doubleValue('A14','12')" value="0" size="15" ></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">Others</td>
                                  <td class="boldEleven"><input name="A15"  type="text" class="formText135" id="A15" style='text-align:right' onKeyPress="doubleValue('A15','12')" value="0" size="15" ></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                </tr>
                              </table></td>
						  </tr>
							 
							<tr>
							  <td height="17"  bgcolor="#E2E2E2" colspan="3" class="boldEleven"><div id="invoicedescription" style="OVERFLOW:auto;width:100%;height:350px" class="boldEleven"/>	</td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="2" align="left"><input name="filename"
									type="hidden" value="Contribution" />
                                <input name="actionS"
									type="hidden" value="INVContributionAdd" /></td>
						  </tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
										<td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('Rept_Contribution.jsp')"></td>
									</tr>
								</table>								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
						</tbody>
						<input type="hidden" name="mobileBookingOption" />
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
</table>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
