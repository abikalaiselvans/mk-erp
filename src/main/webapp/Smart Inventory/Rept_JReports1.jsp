<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>

<html>
<head>
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='INV' ")[0][0]%></title>
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
 <link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
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
                                  <td colspan="4" class="copyright"><div align="center">Jasper REPORTS1</div></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">1.</td>
                                  <td class="boldEleven"><a href="Rept_JPurchase.jsp">Purchase Report  </a></td>
                                  <td class="boldEleven">2.</td>
                                  <td class="boldEleven"><a href="Rept_JDailySales.jsp">Sale Report </a></td>
                                </tr>
                                <tr>
                                <td class="boldEleven">3.</td>
                                  <td class="boldEleven"><a href="Rept_jStock.jsp" target="_blank">Stock Report  </a></td>
                                  <td class="boldEleven">4.</td>
                                  <td class="boldEleven"><a href="Rept_JStockSerialReport.jsp" target="_blank">Stock Serial No </a></td>
                                </tr>
                                <tr>
                                <td class="boldEleven">5.</td>
                                  <td class="boldEleven"><a href="Rept_JStockAge.jsp" target="_blank">Stock Age </a></td>
                                  <td class="boldEleven">6.</td>
                                  <td class="boldEleven">Zero Stock </td>
                                </tr>
                                <tr>
                                <td class="boldEleven">7.</td>
                                  <td class="boldEleven">Stock In / Out </td>
                                  <td class="boldEleven">8.</td>
                                  <td class="boldEleven"><a href="Rept_JPayment.jsp" target="_blank">Payment</a></td>
                                </tr>
                                <tr>
                                <td class="boldEleven">9.</td>
                                  <td class="boldEleven">Track </td>
                                  <td class="boldEleven">10.</td>
                                  <td class="boldEleven"><a href="Rept_JPurchasePayment.jsp" target="_blank">Purchase Payment </a></td>
                                </tr>
                                <tr>
                                   <td class="boldEleven">11.</td>
                                  <td class="boldEleven"><a href="Rept_JDeletedInvoice.jsp" target="_blank">Deleted Invoice </a></td>
                                  <td class="boldEleven">12.</td>
                                  <td class="boldEleven"><a href="Rept_JCustomer.jsp" target="_blank">Customer Info </a></td>
                                </tr>
                                <tr>
                                 <td class="boldEleven">13.</td>
                                  <td class="boldEleven"><a href="Rept_JStockTransfer.jsp" target="_blank">Stock Transfer </a></td>
                                  <td class="boldEleven">14.</td>
                                  <td class="boldEleven"><a href="Rept_JContribution.jsp" target="_blank">Contribution</a></td>
                                </tr>
                                <tr>
                                <td class="boldEleven">15.</td>
                                  <td class="boldEleven"><a href="Rept_JTermsAndCondition.jsp" target="_blank">Stock Adjustment </a></td>
                                  <td class="boldEleven">16.</td>
                                  <td class="boldEleven"><a href="Rept_JWarrantyExp.jsp" target="_blank">Warranty</a><a href="Rept_JVendor.jsp" target="_blank"></a></td>
                                </tr>
                                <tr>
                                <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><a href="Rept_JWarrantyExp.jsp" target="_blank"></a></td>
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
