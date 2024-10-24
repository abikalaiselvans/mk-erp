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
		<table width="90%" border="0"
			align="center" cellpadding="0" cellspacing="0" class="BackGround1">
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
					<table cellspacing="2" cellpadding="2" width="900" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							
							
							
							<tr>
							  <td height="17" class="boldEleven"><table width="100%" border="0" align="center" cellpadding="5" cellspacing="0">
                                
                                <tr>
                                  <td colspan="11" class="copyright"><div align="center">REPORT</div></td>
                                </tr>
                                <tr>
                                  <td colspan="2" class="boldEleven"><div align="center" class="bold1">PURCHASE   </div></td>
                                  <td width="1%" class="boldEleven">&nbsp;</td>
                                  <td colspan="2" class="boldEleven"><div align="center" class="bold1">SALES  </div></td>
                                  <td width="1%" class="boldEleven">&nbsp;</td>
                                  <td colspan="2" class="boldEleven"><div align="center" class="bold1">STOCK</div></td>
                                  <td colspan="3" class="boldEleven"><div align="center" class="bold1">PAYMENT</div></td>
                                </tr>
                                <tr>
                                  <td width="2%" class="boldEleven">1.</td>
                                  <td width="16%" class="boldEleven"><a href="Rept_DailyPurchaseReport.jsp" target="_blank">Purchase</a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td width="3%" class="boldEleven">1.</td>
                                  <td width="20%" class="boldEleven"><div align="left"><a href="Rept_DailySalesReport.jsp" target="_blank">Sales Report</a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td width="3%" class="boldEleven"><div align="left">1.</div></td>
                                  <td width="28%" class="boldEleven"><div align="left"><a href="Rept_DailyStock.jsp" target="_blank">Division Wise</a></div></td>
                                  <td width="2%" class="boldEleven">&nbsp;</td>
                                  <td width="4%" class="boldEleven"><div align="left">1.</div></td>
                                  <td width="20%" align="right" valign="top"><div align="left"><span class="boldEleven"> <a href="Rept_PaymentCommitment.jsp" target="_blank">Payment Commitment</a></span></div></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">2</td>
                                  <td class="boldEleven"><a href="Rept_ProductwisePurchaseReport.jsp" target="_blank">Product-wise Purchase</a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">2.</td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_CustomerSalesReport.jsp" target="_blank">Employee wise </a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">2.</div></td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_StockSerialReport.jsp" target="_blank">Serialnumber Wise</a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">2.</div></td>
                                  <td align="right" valign="top"><div align="left" class="boldEleven"> <a href="PaymentCollection.jsp" target="_blank">Payment Collection </a></div></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">3.</td>
                                  <td class="boldEleven"><a href="Rept_CancelpurchaseInvoice.jsp" target="_blank">Cancelled</a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">3.</td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_DailySalesAllEmployee.jsp" target="_blank">All</a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">3.</div></td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_Stocks.jsp" target="_blank">Qty Stock of Item and Product </a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">3.</div></td>
                                  <td align="right" valign="top"><div align="left"><span class="boldEleven"> <a href="PaymentPending.jsp" target="_blank">Payment Pending </a></span></div></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">4.</td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_WarrantyChange.jsp" target="_blank">Change Warranty</a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">4.</div></td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_SerialStocks.jsp" target="_blank">Serial number  Stock of Item and Product </a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">4.</div></td>
                                  <td align="right" valign="top"><div align="left"><span class="boldEleven"> <a href="Rept_PaymentHonouredCollection.jsp" target="_blank">Payment Honoured Collection</a></span></div></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">5.</td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_WarrantyChangeinSaleWise.jsp" target="_blank">Change Warranty Date Wise</a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">5.</div></td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_ConsumablesStocks.jsp" target="_blank">Consumables Stock</a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">5.</div></td>
                                  <td align="right" valign="top"><div align="left"><span class="boldEleven"> <a href="SalesAnalysisReport.jsp" target="_blank">Sales Analysis</a></span></div></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">6.</td>
                                  <td class="boldEleven"><div align="left"><a href='Rept_ProductwiseSalesReport.jsp' target="_blank">Productwise Split Sales Report </a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">6.</div></td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_ConsumablesStocksAnalysis.jsp" target="_blank">Consumables Stock Analysis</a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">6.</div></td>
                                  <td align="right" valign="top"><div align="left"><span class="boldEleven"> <a href="Rept_ChequeBounds.jsp" target="_blank">Cheque Bounds</a></span></div></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">7.</td>
                                  <td class="boldEleven"><div align="left"><a href='Rept_ProductwiseSalesReportAll.jsp' target="_blank">Productwise All Sales Report </a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">7.</div></td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_StockAge.jsp"  target="_blank">Stock Age individual</a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">7.</div></td>
                                  <td align="right" valign="top"><div align="left"><span class="boldEleven"> <a href="SalesInvoiceAmount.jsp" target="_blank">Amount</a></span></div></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">8.</td>
                                  <td class="boldEleven"><div align="left"><a href='Rept_ProductwiseSalesReportAll.jsp' target="_blank">Customerwise  Sales Report </a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">8.</td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_Stockin.jsp"  target="_blank">Stock Age </a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">8.</td>
                                  <td class="boldEleven"><a href="Rept_Customer_NoofSales.jsp" target="_blank">Customer Wise </a></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">9.</td>
                                  <td class="boldEleven"><div align="left"><a href='RRept_DailySalesReport.jsp' target="_blank">Daily   Report </a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">9.</div></td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_DailyZeroStockPrint.jsp"  target="_blank">Zero Stock</a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">9.</div></td>
                                  <td class="boldEleven"><a href="Rept_Customer_NoofSaleswithRef.jsp" target="_blank">Customer Wise with Ref </a></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">10.</td>
                                  <td class="boldEleven"><div align="left"><a href='TargetAchieveAvgCollection.jsp' target="_blank">Average Collection </a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">10.</td>
                                  <td class="boldEleven"><a href="Rept_QuantityStockin.jsp"  target="_blank">Quantity Stock</a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">10.</td>
                                  <td class="boldEleven"><a href="Rept_DetailedSales.jsp" target="_blank">Detailed Sales Report </a></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">11.</td>
                                  <td class="boldEleven"><a href="Rept_SalesDelivery.jsp" target="_blank">Delivery Information </a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">11.</div></td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_Stockinout.jsp"  target="_blank">Stock In & Out</a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">12.</td>
                                  <td class="boldEleven"><a href="Rept_BlockedInvoice.jsp" target="_blank">Blocked Invoice</a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">12.</div></td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_StockTransferallmonth.jsp"  target="_blank">Stock Transfer </a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">13.</td>
                                  <td class="boldEleven"><a href="Rept_CancelInvoice.jsp" target="_blank">Cancelled</a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">13.</div></td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_StockTransferBranchwise.jsp"  target="_blank">Stock Transfer Branch wise </a></div></td>
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
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">14.</td>
                                  <td class="boldEleven"><a href="Rept_StockBookDateView.jsp" target="_blank">Stock Book View Date wise </a></td>
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
                                  <td class="boldEleven">&nbsp;</td>
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
