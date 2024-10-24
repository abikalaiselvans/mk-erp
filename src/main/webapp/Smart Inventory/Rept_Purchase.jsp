<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>  
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
					<table cellspacing="2" cellpadding="2" width="500" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							
							
							
							<tr>
							  <td height="17" class="boldEleven"><table width="98%" border="0" align="center" cellpadding="5" cellspacing="0">
                                <tr>
                                  <td width="5%" class="copyright">&nbsp;</td>
                                  <td width="39%" class="copyright"><div align="center">PURCHASE  REPORT </div></td>
                                  <td width="13%" class="copyright">&nbsp;</td>
                                  <td colspan="2" class="copyright"><div align="center">PURCHASE ORDER REPORT </div></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td width="4%" class="boldEleven">&nbsp;</td>
                                  <td width="39%" class="boldEleven">&nbsp;</td>
                                </tr>
                                 
                                <tr>
                                  <td class="boldEleven">1.</td>
                                  <td class="boldEleven"><a href="Rept_DailyPurchaseReport.jsp" target="_blank">Purchase Report </a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">1.</td>
                                  <td class="boldEleven"><a href="Rept_VendorPurchaseOrderReport.jsp" target="_blank">Purchase Order Report </a></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">2</td>
                                  <td class="boldEleven"><a href="Rept_ProductwisePurchaseReport.jsp" target="_blank">Product-wise Purchase Report </a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">2.</td>
                                  <td class="boldEleven"><a href="Rept_ProductwiseAll_PurchaseOrderReport.jsp" target="_blank">Product-wise ALL </a></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">3.</td>
                                  <td class="boldEleven"><a href="Rept_CancelpurchaseInvoice.jsp" target="_blank">Cancelled Invoice</a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">3.</td>
                                  <td class="boldEleven"><a href="Rept_Edd.jsp" target="_blank">Expect Date of Delivery</a></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">4.</td>
                                  <td class="boldEleven"><a href="Rept_ProductwiseAll_PurchaseReport.jsp" target="_blank">Product-wise ALL  </a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">4.</td>
                                  <td class="boldEleven"><a href="Rept_Purchase_Turnover.jsp" target="_blank">Purchase Yearwise </a></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">5.</td>
                                  <td class="boldEleven"><a href="FreightCharg.jsp" target="_blank"> Freight Charge</a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">5.</td>
                                  <td class="boldEleven"><a href="Rept_PurchaseTurnoverQuarter.jsp" target="_blank">Purchase  Quarter wise </a></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">5.</td>
                                  <td class="boldEleven"><a href="PODetailsAgainstPR.jsp" target="_blank">PO details Against purchase order</a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
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
