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
					<table cellspacing="2" cellpadding="2" width="600" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							
							
							
							<tr>
							  <td height="17" class="boldEleven"><table width="98%" border="0" align="center" cellpadding="5" cellspacing="0">
                                <tr>
                                  <td colspan="5" class="copyright"><div align="center"> REPORT </div></td>
                                </tr>
                                <tr>
                                  <td width="6%" class="boldEleven">1.</td>
                                  <td width="44%" class="boldEleven"><a href="Rept_termsandconditions.jsp" target="_blank">Terms & Condition </a></td>
                                  <td width="5%" class="boldEleven">2.</td>
                                  <td width="40%" class="boldEleven"><a href="Rept_itemGroup.jsp" target="_blank">Item Group </a></td>
                                  <td width="5%" class="boldEleven">&nbsp;</td>
                                </tr>
                                <tr> 
                                  <td class="boldEleven">3.</td>
                                  <td class="boldEleven"><a href="Rept_paymentTerms.jsp" target="_blank">Payment Terms </a></td>
                                  <td class="boldEleven">4.</td>
                                  <td class="boldEleven"><a href="Rept_item.jsp" target="_blank">Item</a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">5.</td>
                                  <td class="boldEleven"><a href="Rept_Tax.jsp" target="_blank">Tax</a></td>
                                  <td class="boldEleven">6.</td>
                                  <td class="boldEleven"><a href="Rept_ProductGroup.jsp" target="_blank">Product Group </a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">7.</td>
                                  <td class="boldEleven"><a href="Rept_PaymentCondition.jsp" target="_blank">Payment Conditions</a></td>
                                  <td class="boldEleven">8.</td>
                                  <td class="boldEleven"><a href="Rept_Product.jsp" target="_blank">Product</a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">9.</td>
                                  <td class="boldEleven"><a href="Rept_BankInformations.jsp" target="_blank"><a href="Rept_Model.jsp" target="_blank">Model</a>  </td>
                                  <td class="boldEleven">10.</td>
                                  <td class="boldEleven"><a href="Rept_customerGroup.jsp" target="_blank">Customer Group </a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                </tr>
                                <tr> 
                                  <td class="boldEleven">11.</td>
                                  <td class="boldEleven"><a href="Rept_Color.jsp" target="_blank">Color</a></td>
                                  <td class="boldEleven">12.</td>
                                  <td class="boldEleven"><a href="Rept_Customerinfo.jsp" target="_blank">Customer</a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">13.</td>
                                  <td class="boldEleven"><a href="Rept_Division.jsp" target="_blank">Division</a></td>
                                  <td class="boldEleven">14.</td>
                                  <td class="boldEleven"><a href="Rept_VendorGroup.jsp" target="_blank">Vendor Group </a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">15.</td>
                                  <td class="boldEleven"><a href="Rept_Customergroupwise.jsp" target="_blank">Customergroup Wise </a></td>
                                  <td class="boldEleven">16.</td>
                                  <td class="boldEleven"><a href="Rept_Vendor.jsp" target="_blank">Vendor</a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">17.</td>
                                  <td class="boldEleven"><a href="Rept_Customer_NoofSales.jsp" target="_blank">Customer Wise </a></td>
                                  <td class="boldEleven">18.</td>
                                  <td class="boldEleven"><a href="CheckSerialnumber.jsp" target="_blank">Check Serial Number</a> </td>
                                  <td class="boldEleven">&nbsp;</td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">19.</td>
                                  <td class="boldEleven"><a href="Rept_Customer_NoofSaleswithRef.jsp" target="_blank">Customer Wise with Ref </a></td>
                                  <td class="boldEleven">20.</td>
                                  <td class="boldEleven"><a href="Rept_DetailedSales.jsp" target="_blank">Detailed Sales Report </a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">21.</td>
                                  <td class="boldEleven"><a href="emd_reports.jsp" target="_blank">EMD</a></td>
                                  <td class="boldEleven">22.</td>
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
                                <tr>
                                  <td colspan="5" class="boldEleven"><div align="center" class="copyright">Sales Report </div></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">1.</td>
                                  <td class="boldEleven"><a href="Rept_Purchasedetails.jsp">Purchase Report</a></td>
                                  <td class="boldEleven">1.</td>
                                  <td class="boldEleven"><a href="Rept_Salessetails.jsp">Sales Report</a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
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
                                <tr>
                                  <td colspan="5" class="boldEleven"><div align="center" class="copyright">Tally Integration </div></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">1.</td>
                                  <td class="boldEleven"><a href="Rept_Purchase_ExportWithStockTally.jsp" target="_blank">Export with stock to Tally[ Purchae ] </a></td>
                                  <td class="boldEleven">1.</td>
                                  <td class="paracopyright"><a href="Rept_Purchase_ExportTally.jsp" target="_blank" class="m0l1iover">Export to Tally-2 [ Purchae ] </a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">2.</td>
                                  <td class="boldEleven"><a href="Rept_Sales_ExportwithstockTally.jsp" target="_blank">Export with stock to Tally [ Sales ] </a></td>
                                  <td class="boldEleven">2.</td>
                                  <td class="paracopyright"><a href="Rept_ExportTally.jsp" target="_blank" class="m0l1iover">Export to Tally-1 [ Sales ] </a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">3.</td>
                                  <td class="boldEleven"><a href="Rept_PurchasePayments_ExportTally.jsp">Export Purchase Payments </a></td>
                                  <td class="boldEleven">3.</td>
                                  <td class="paracopyright"><a href="Rept_ledger_ExportTally.jsp" target="_blank" class="m0l1iover">Export to ledger </a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">4.</td>
                                  <td class="boldEleven"><a href="Rept_SalesPayments_ExportTally.jsp">Export Sales Payments </a></td>
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
                                <tr>
                                  <td colspan="5" class="boldEleven">
                                  <table width="56" border="0" align="center" cellpadding="1"
									cellspacing="1">
        <tr>
          <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('InventoryMains.jsp')"></td>
        </tr>
      </table>                                  </td>
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
