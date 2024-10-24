<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<html>
<head>
<title>:: INVENTORY ::</title> <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="600"
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
				    <td><table width="100%" border="0" cellpadding="3" cellspacing="3" class="boldEleven">
                      <tr>
                        <td class="boldEleven">1.</td>
                        <td class="boldEleven"><div align="left"><a href="Rept_DailyStock.jsp" target="_blank">Division Wise</a></div></td>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">2.</td>
                        <td class="boldEleven"><div align="left"><a href="Rept_StockSerialReport.jsp" target="_blank">Serialnumber Wise</a></div></td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td class="boldEleven">3.</td>
                        <td class="boldEleven"><div align="left"><a href="Rept_Stocks.jsp" target="_blank">Quantity Stock of Item and Product </a></div></td>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">4.</td>
                        <td class="boldEleven"><div align="left"><a href="Rept_SerialStocks.jsp" target="_blank">Serial number  Stock of Item and Product </a></div></td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td class="boldEleven">5.</td>
                        <td class="boldEleven"><div align="left"><a href="Rept_ConsumablesStocks.jsp" target="_blank">Consumables Stock</a></div></td>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">6.</td>
                        <td class="boldEleven"><div align="left"><a href="Rept_ConsumablesStocksAnalysis.jsp" target="_blank">Consumables Stock Analysis</a></div></td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td class="boldEleven">7.</td>
                        <td class="boldEleven"><div align="left"><a href="Rept_StockAge.jsp"  target="_blank">Stock Age individual</a></div></td>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">8.</td>
                        <td class="boldEleven"><div align="left"><a href="Rept_Stockin.jsp"  target="_blank">Stock Age </a></div></td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td class="boldEleven">9.</td>
                        <td class="boldEleven"><div align="left"><a href="Rept_StockAgeAnalysis.jsp"  target="_blank">Stock Age Analysis </a></div></td>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">10.</td>
                        <td class="boldEleven"><div align="left"><a href="Rept_StockDateAnalysis.jsp"  target="_blank">Stock Date Analysis </a></div></td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td class="boldEleven">11.</td>
                        <td class="boldEleven"><div align="left"><a href="Rept_DailyZeroStockPrint.jsp"  target="_blank">Zero Stock</a></div></td>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">12.</td>
                        <td class="boldEleven"><a href="Rept_QuantityStockin.jsp"  target="_blank">Quantity Stock</a></td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td class="boldEleven">13.</td>
                        <td class="boldEleven"><a href="Dcstock.jsp" target="_blank">DC Stock Product wise </a></td>
                        <td class="boldEleven">&nbsp;</td>
                        <td>14.</td>
                        <td class="boldEleven"><a href="Rept_newDC.jsp" target="_blank">DC Report </a></td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>15.</td>
                        <td class="boldEleven"><a href="Assetstock.jsp" target="_blank">Asset Stock </a></td>
                        <td class="boldEleven">&nbsp;</td>
                        <td>16.</td>
                        <td class="boldEleven"><a href="Sparestock.jsp" target="_blank">Spare Stock </a></td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>17.</td>
                        <td class="boldEleven"><a href="Blockstock.jsp" target="_blank">Blocked Stock </a></td>
                        <td class="boldEleven">&nbsp;</td>
                        <td>18.</td>
                        <td class="boldEleven"><div align="left"><a href="StockInandOut.jsp"  target="_blank">Stock In &amp; Out</a></div></td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>19.</td>
                        <td class="boldEleven"><a href="Stockadjustmentstock.jsp" target="_blank">Stock Adjusment Stock </a></td>
                        <td class="boldEleven">&nbsp;</td>
                        <td>20.</td>
                        <td class="boldEleven"><a href="Rept_StockBookDateView.jsp" target="_blank">Stock Book View Date wise </a></td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>21.</td>
                        <td class="boldEleven"><a href="PurchaseQuantity.jsp" target="_blank">Purchase Quantity </a></td>
                        <td class="boldEleven">&nbsp;</td>
                        <td>22.</td>
                        <td class="boldEleven"><a href="SalesQuantity.jsp" target="_blank">Sales Quantity </a></td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>23.</td>
                        <td class="boldEleven"><a href="PurchaseandSalesQuantity.jsp" target="_blank">Purchase &amp; Sales Quantity </a></td>
                        <td class="boldEleven">&nbsp;</td>
                        <td>24.</td>
                        <td class="boldEleven"><a href="Stocktransferstock.jsp" target="_blank">Stock Transfer Stock </a></td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>25.</td>
                        <td class="boldEleven"><div align="left"><a href="Rept_StockTransferBranchwise.jsp"  target="_blank">Stock Transfer Branch wise </a></div></td>
                        <td class="boldEleven">&nbsp;</td>
                        <td>26.</td>
                        <td class="boldEleven"><div align="left"><a href="Rept_StockTransferallmonth.jsp"  target="_blank">Stock Transfer </a></div></td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td>27.</td>
                        <td class="boldEleven"><a href="Rept_SoldbutnotinStock.jsp" target="_blank">Sold Serial number but not in stock </a></td>
                        <td class="boldEleven">&nbsp;</td>
                        <td>28.</td>
                        <td class="boldEleven"><a href="Rept_SoldbutavailableinStock.jsp" target="_blank">Sold Serial number but  in stock </a></td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td class="boldEleven">29. </td>
                        <td class="boldEleven"><div align="left"><a href="Rept_BuybackStock.jsp"  target="_blank">Buy Back Stock</a></div></td>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">30.</td>
                        <td class="boldEleven"><a href="Rept_goodsreturnserialNumber.jsp" target="_blank">Goods Return Serialnumber</a></td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td class="boldEleven">31.</td>
                        <td class="boldEleven"><a href="Rept_DCStockSerialNumber.jsp" target="_blank">DC Stock all</a></td>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                      <tr>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">&nbsp;</td>
                        <td>&nbsp;</td>
                      </tr>
                    </table></td>
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
	  <td><table width="56" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><input type='button' class='ButtonHead' name='Button' value='Close' onClick="redirect( 'InventoryMains.jsp')" /></td>
        </tr>
      </table></td>
  </tr>
  <tr>
	  <td><%
	 /* String data2[][] =CommonFunctions.QueryExecute(" CALL FUN_INV_GET_STOCK_SERIALNUMBER(20,1,'I','000018')");
	  if(data2.length>0)
	  	for(int u=0;u<data2.length;u++)
			out.println(data2[u][0]+"<br>");*/
	  %></td>
  </tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>
