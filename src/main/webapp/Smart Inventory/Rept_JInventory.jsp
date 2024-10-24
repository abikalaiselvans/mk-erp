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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="900"
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
					<table cellspacing="2" cellpadding="2" width="900" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							
							
							
							<tr>
							  <td height="17" class="boldEleven"><table width="98%" border="0" align="center" cellpadding="5" cellspacing="0">
                                
                                <tr>
                                  <td colspan="13" class="copyright"><div align="center">JASPER REPORT</div></td>
                                </tr>
                                <tr>
                                  <td colspan="2" class="boldEleven" align="center"><div align="center" class="bold1">PURCHASE   </div></td>
                                  <td width="2%" class="boldEleven">&nbsp;</td>
                                  <td colspan="2" class="boldEleven" align="center"><div align="center" class="bold1">SALES  </div></td>
                                  <td width="1%" class="boldEleven">&nbsp;</td>
                                  <td colspan="2" class="boldEleven" align="center"><div align="center" class="bold1">STOCK</div></td>
                                  <td colspan="3" class="boldEleven" align="center"><div align="center" class="bold1">PAYMENT</div></td>
                                  <td colspan="2" align="center" class="boldEleven"><div align="center" class="bold1">TRANSACTION</div></td>
                                </tr>
                                <tr>
                                  <td width="2%" class="boldEleven">1.</td>
                                  <td width="9%" class="boldEleven"><a href="Rept_JDailyPurchaseReport.jsp" target="_blank">Purchase</a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td width="2%" class="boldEleven">1.</td>
                                  <td width="14%" class="boldEleven"><a href="Rept_JDailySaleReport.jsp" target="_blank">Sales Report</a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td width="2%" class="boldEleven"><div align="left">1.</div></td>
                                  <td width="14%" class="boldEleven"><div align="left"><a href="Rept_JdivisionwiseStockDetail.jsp" target="_blank"> Stock Quantity </a></div></td>
                                  <td width="1%" class="boldEleven">&nbsp;</td>
                                  <td width="3%" class="boldEleven"><div align="left">1.</div></td>
                                  <td width="27%" align="right" valign="top" class="boldEleven"><div align="left"><a href="Rept_JPaymentCommitment.jsp" target="_blank"> Payment Commitment </a></div></td>
                                  <td class="boldEleven">1.</td>
                                  <td class="boldEleven"><a href="Rept_JPurchase.jsp" target="_blank"> Purchase Report </a> </td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">2.</td>
                                  <td class="boldEleven"><a href="Rept_JProductwisePurchaseReport.jsp" target="_blank">Product-wise Purchase</a> </td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">2.</td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_JEmployeewiseSaleReport.jsp" target="_blank">Employee wise</a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">2.</div></td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_JProductwiseStockSerialNoDetail.jsp" target="_blank">Stock Serial Number </a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">2.</div></td>
                                  <td align="right" valign="top"><div align="left" class="boldEleven"><a href="Rept_JSalePaymentCollection.jsp" target="_blank"> Payment Collection </a></div></td>
                                  <td class="boldEleven">2.</td>
                                  <td class="boldEleven"><a href="Rept_JDailySales.jsp" target="_blank">Sale Report </a></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">3.</td>
                                  <td class="boldEleven"><a href="Rept_JPurchaseCanceledList.jsp" target="_blank">Cancelled</a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">3.</td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_JAllEmployersSaleReport.jsp" target="_blank">All</a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">3.</div></td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_JConsumableStockCountDetail.jsp" target="_blank">Consumables Stock</a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">3.</div></td>
                                  <td align="right" valign="top"><div align="left"><span class="boldEleven"> <a href="Rept_JPaymentPending.jsp" target="_blank">Payment Pending</a> </span></div></td>
                                  <td class="boldEleven">3.</td>
                                  <td class="boldEleven"><a href="../SmartLoginAuth?filename=Rept_JDailyPaymentCollection&actionS=INVRept_JDailyPaymentCollection&rptfilename=dailyCollectionReport&reportType=pdf" target="_blank">Daily Collection Report </a></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">4.</td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_JWarrantyChangingSaleWise.jsp" target="_blank">Change Warranty Date Wise</a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">4.</div></td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_JConsumableStockAnalysis.jsp" target="_blank">Consumables Stock Analysis</a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">4.</div></td>
                                  <td align="right" valign="top"><div align="left"><span class="boldEleven"> <a href="Rept_JPaymentHonouredCollection.jsp" target="_blank">Payment Honoured Collection</a></span></div></td>
                                  <td class="boldEleven">4.</td>
                                  <td class="boldEleven"><a href="../SmartLoginAuth?filename=Rept_JPurchaseInvoicePendingList&actionS=INVRept_JPurchaseInvoicePendingList&rptfilename=purchaseInvoicePendingList&reportType=pdf" target="_blank">Purchase Invoice Pending List </a></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">5.</td>
                                  <td class="boldEleven"><div align="left">
                                    <div align="left"><a href="Rept_JProductwiseSalesReport.jsp" target="_blank">Productwise Split Sales Report </a></div>
                                  </div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">5.</div></td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_JStockAgeInDays.jsp" target="_blank">Stock Age </a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">5.</div></td>
                                  <td align="right" valign="top"><div align="left"><span class="boldEleven"> <a href="Rept_JSaleAnalysis.jsp" target="_blank">Sales Analysis</a></span></div></td>
                                  <td class="boldEleven">5.</td>
                                  <td class="boldEleven"><a href="../SmartLoginAuth?filename=Rept_JPaymentBalanceList&actionS=INVRept_JPaymentBalanceList&rptfilename=paymentBalanceInfo&reportType=pdf" target="_blank">Payment Balance Detail </a></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">6.</td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_JProductwiseSalesReportAll.jsp" target="_blank">Productwise All Sales Report </a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">6.</div></td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_JStockTransfer.jsp" target="_blank">Stock Transfer </a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">6.</div></td>
                                  <td class="boldEleven"><div align="left"> <a href="Rept_JSaleInvoiceAmount_yearwise.jsp" target="_blank">Amount</a></div></td>
                                  <td class="boldEleven">6.</td>
                                  <td class="boldEleven"><a href="../SmartLoginAuth?filename=Rept_JPaymentCommitmentDetail&actionS=INVRept_JPaymentCommitmentDetail&rptfilename=paymentCommitmentInfo&reportType=pdf" target="_blank">Payment Commitment Detail </a></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">7.</td>
                                  <td class="boldEleven"><a href="Rept_JSaleDelivery.jsp" target="_blank">Delivery Information </a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp; </td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_JStockInAndOut.jsp" target="_blank">Stock IN &amp; Out </a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left">7.</div></td>
                                  <td class="boldEleven"><a href="Rept_JCustomer_NoofSales.jsp" target="_blank">Customer Wise </a></td>
                                  <td class="boldEleven">7.</td>
                                  <td class="boldEleven"><a href="Rept_JStaffProductAsset.jsp">Staff Product Asset </a></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">8.</td>
                                  <td class="boldEleven"><a href="Rept_JBlockedSaleInvoiceDtl.jsp" target="_blank">Blocked Invoice</a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven"><div align="left"><a href="Rept_JZeroStock.jsp" target="_blank">Zero Stock  </a></div></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">8.</td>
                                  <td class="boldEleven"><a href="Rept_JCustomerwise_SaleDetailwithRef.jsp" target="_blank">Customer Wise with Ref</a></td>
                                  <td class="boldEleven">8.</td>
                                  <td class="boldEleven"><a href="../SmartLoginAuth?filename=Rept_JDailyStockDetail&actionS=INVRept_JDailyStockDetail&rptfilename=dailyStock&reportType=pdf">Daily Stock </a></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">9.</td>
                                  <td class="boldEleven"><a href="Rept_JCanceledSaleInvoiceDtl.jsp" target="_blank">Cancelled</a></td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">&nbsp; </td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">9. </td>
                                  <td class="boldEleven"><a href="Rept_JStaffProductAsset.jsp" target="_blank">Detailed Sales Report</a></td>
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
                                  <td class="boldEleven">&nbsp; </td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">10 </td>
                                  <td class="boldEleven"><a href="Rept_EMD.jsp" target="_blank">EMD</a> </td>
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
                                  <td class="boldEleven">&nbsp; </td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">11</td>
                                  <td class="boldEleven"><a href="Rept_JCustomerBillAccumulatedDetail.jsp" target="_blank">Customer Bill Accumulated</a></td>
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
                                  <td class="boldEleven">12</td>
                                  <td class="boldEleven"><a href="Rept_JCustomerBillCountMonthwiseDetail.jsp" target="_blank">Customer Bill Count Monthwise</a></td>
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
                                  <td class="boldEleven">13</td>
                                  <td class="boldEleven"><a href="Rept_JServiceBillAccumulatedDetail.jsp" target="_blank">Service Bill Accumulated</a></td>
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
                                  <td class="boldEleven">&nbsp; </td>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td class="boldEleven">14</td>
                                  <td class="boldEleven"><a href="Rept_JServiceBillCountMonthwiseDetail.jsp" target="_blank">Monthwise Service Bill Count</a></td>
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
