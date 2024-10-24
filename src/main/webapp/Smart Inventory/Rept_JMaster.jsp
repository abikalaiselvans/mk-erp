<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>

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
 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<body >
<%@ include file="indexinv.jsp"%>

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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="300"
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
					<table cellspacing="2" cellpadding="2" width="303" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							
							
							
							<tr>
							  <td height="17" class="boldEleven"><table width="98%" border="0" align="center" cellpadding="5" cellspacing="0">
                                
                                <tr>
                                  <td colspan="4" class="copyright"><div align="center">JASPER REPORT</div></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">1.</td>
                                  <td class="boldEleven"><a href="Rept_JBankInfo.jsp" target="_blank">Bank Information </a></td>
                                  <td class="boldEleven">2.</td>
                                  <td class="boldEleven"><a href="Rept_JColor.jsp" target="_blank">Color</a></td>
                                </tr>
                                <tr>
                                <td class="boldEleven">3.</td>
                                  <td class="boldEleven"><a href="Rept_JCourier.jsp" target="_blank">Courier </a></td>
                                  <td class="boldEleven">4.</td>
                                  <td class="boldEleven"><a href="Rept_JMasterCustomerGroup.jsp" target="_blank">Customer Group </a></td>
                                 </tr>
                                <tr>
                                <td class="boldEleven">5.</td>
                                  <td class="boldEleven"><a href="Rept_JMasterCustomerInfo.jsp" target="_blank">Customer Information</a></td>
                                  <td class="boldEleven">6.</td>
                                  <td class="boldEleven"><a href="Rept_JDivision.jsp" target="_blank">Division</a></td>
                                 </tr>
                                <tr>
                                <td class="boldEleven">7.</td>
                                  <td class="boldEleven"><a href="Rept_JModel.jsp" target="_blank">Model</a></td>
                                  <td class="boldEleven">8.</td>
                                  <td class="boldEleven"><a href="Rept_JMasterItem.jsp" target="_blank">Item</a></td>
                                </tr>
                                <tr>
                                <td class="boldEleven">9.</td>
                                  <td class="boldEleven"><a href="Rept_JMasterItemGroup.jsp" target="_blank">Item Group</a></td>
                                  <td class="boldEleven">10.</td>
                                  <td class="boldEleven"><a href="Rept_JPaymentCondition.jsp" target="_blank">Payment Condition</a></td>
                                 </tr>
                                <tr>
                                   <td class="boldEleven">11.</td>
                                  <td class="boldEleven"><a href="Rept_JPaymentTerm.jsp" target="_blank">Payment Term</a></td>
                                  <td class="boldEleven">12.</td>
                                  <td class="boldEleven"><a href="Rept_JProduct.jsp" target="_blank">Product</a></td>
                                 </tr>
                                <tr>
                                 <td class="boldEleven">13.</td>
                                  <td class="boldEleven"><a href="Rept_JProductGroup.jsp" target="_blank">Product Group</a></td>
                                  <td class="boldEleven">14.</td>
                                  <td class="boldEleven"><a href="Rept_JTax.jsp" target="_blank">Tax</a></td>
                                 </tr>
                                <tr>
                                <td class="boldEleven">15.</td>
                                  <td class="boldEleven"><a href="Rept_JTermsAndCondition.jsp" target="_blank">Terms & Condition</a></td>
                                  <td class="boldEleven">16.</td>
                                  <td class="boldEleven"><a href="Rept_JVendor.jsp" target="_blank">Vendor</a></td>
                                </tr>
                                <tr>
                                <td class="boldEleven">17.</td>
                                  <td class="boldEleven"><a href="Rept_JVendorGroup.jsp" target="_blank">Vendor Group</a></td>
                                </tr>
                              </table></td>
							</tr>
						</tbody>
						<input type="hidden" name="mobileBookingOption" />
					</table>					</td>
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
		</table>	  </td>
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
</html>
