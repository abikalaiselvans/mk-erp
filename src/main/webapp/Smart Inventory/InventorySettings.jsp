<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage="../error/index.jsp"%>
<%
try {
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript"
	src="../JavaScript/Inventory/InvenCustomerAJAX.js"></script>
<script language="javascript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
</head>
<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm">
<div align="center"><br />
<br>
<br>
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
			<table width="663" border="0" align="center" cellpadding="1"
				cellspacing="1">
				<tr>
					<td width="650"></td>
				</tr>
				<tr>
					<td>
					<div align="center"><strong>Inventory Basic Setting
					 </strong></div>
					</td>
				</tr>
				<tr>
					<td>
					<table width="673" border="0" align="center" cellpadding="1"
						cellspacing="1">
						<tr>
							<td colspan="4">
							<table>
								<tr>
									<td width="92" class="boldEleven">
									<div align="right">Company::</div>
									</td>
									<td width="156" class="boldEleven">
									<div align="left"><select name="company" id="company"
										onChange="loadBranchValues('')">
										<option>Select</option>
										<%
										String sql = "SELECT * FROM  com_m_company ";
										String company[][] = com.my.org.erp.common.CommonInfo
										.getTableAllValuesArray(sql);
										for (int i = 0; i < company.length; i++)
											out.println("<option value='" + company[i][0] + "'>"
											+ company[i][1] + "</option>");
								%>
									</select></div>
									</td>
									<td width="118" class="boldEleven">
									<div align="right">Branch::</div>
									</td>
									<td width="130">
									<div align="left">
									<div id="description"></div>
									<select name="branchId" id="branchId">
									</select></div>
									</td>
									<td width="39" class="boldEleven" align="right]">Year::</td>
									<td width="106" class="boldEleven"><jsp:include
										page="../JavaScript/year.jsp" flush="true" /></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td colspan="4">
							<hr>
							</td>
						</tr>
						<tr>
							<td class="boldEleven">Purchase Order Code</td>
							<td class="boldEleven"><input type="text" class="boldEleven"
								size="20" maxlength="15" name="purchaseCode" id="purchaseCode">
							</td>
							<td class="boldEleven">Purchase Order No</td>
							<td class="boldEleven"><input type="text" class="boldEleven"
								size="20" maxlength="15" name="purchaseNo" id="purchaseNo">
							</td>
						</tr>
						<tr>
							<td class="boldEleven">Goods Received Code</td>
							<td class="boldEleven"><input type="text" class="boldEleven"
								size="20" maxlength="15" name="goodsReceiveCode"
								id="goodsReceiveCode"></td>
							<td class="boldEleven">Goods Received No</td>
							<td class="boldEleven"><input type="text" class="boldEleven"
								size="20" maxlength="15" name="goodsReceiveNo"
								id="goodsReceiveNo"></td>
						</tr>
						<tr>
							<td class="boldEleven">Goods Return Code</td>
							<td class="boldEleven"><input type="text" class="boldEleven"
								size="20" maxlength="15" name="goodsReturnCode"
								id="goodsReturnCode"></td>
							<td class="boldEleven">Goods Return No</td>
							<td class="boldEleven"><input type="text" class="boldEleven"
								size="20" maxlength="15" name="goodsReturnNo" id="goodsReturnNo"></td>
						</tr>
						<tr>
							<td class="boldEleven">Quotation Code</td>
							<td class="boldEleven"><input type="text" class="boldEleven"
								size="20" maxlength="15" name="quotationCode" id="quotationCode"></td>
							<td class="boldEleven">Quotation No</td>
							<td class="boldEleven"><input type="text" class="boldEleven"
								size="20" maxlength="15" name="quotationNo" id="quotationNo"></td>
						</tr>
						<tr>
							<td class="boldEleven">Sales Order Code</td>
							<td class="boldEleven"><input type="text" class="boldEleven"
								size="20" maxlength="15" name="salesOrderCode"
								id="salesOrderCode"></td>
							<td class="boldEleven">Sales Order No</td>
							<td class="boldEleven"><input type="text" class="boldEleven"
								size="20" maxlength="15" name="salesOrderNo" id="salesOrderNo"></td>
						</tr>
						<tr>
							<td class="boldEleven">Delivery Challan Code</td>
							<td class="boldEleven"><input type="text" class="boldEleven"
								size="20" maxlength="15" name="deliveryChallanCode"
								id="deliveryChallanCode"></td>
							<td class="boldEleven">Delivery Challan No</td>
							<td class="boldEleven"><input type="text" class="boldEleven"
								size="20" maxlength="15" name="deliveryChallanNo"
								id="deliveryChallanNo"></td>
						</tr>
						<tr>
							<td class="boldEleven">Invoice Code</td>
							<td class="boldEleven"><input type="text" class="boldEleven"
								size="20" maxlength="15" name="invoiceCode" id="invoiceCode"></td>
							<td class="boldEleven">Invoice No</td>
							<td class="boldEleven"><input type="text" class="boldEleven"
								size="20" maxlength="15" name="invoiceNo" id="invoiceNo"></td>
						</tr>
						<tr>
							<td class="boldEleven">Cash Sale Code</td>
							<td class="boldEleven"><input type="text" class="boldEleven"
								size="20" maxlength="15" name="cashSaleCode" id="cashSaleCode"></td>
							<td class="boldEleven">Cash Sale No</td>
							<td class="boldEleven"><input type="text" class="boldEleven"
								size="20" maxlength="15" name="cashSaleNo" id="cashSaleNo"></td>
						</tr>
						<tr>
							<td class="boldEleven">Sales Return Code</td>
							<td class="boldEleven"><input type="text" class="boldEleven"
								size="20" maxlength="15" name="salesReturnCode"
								id="salesReturnCode"></td>
							<td class="boldEleven">Sales Return No</td>
							<td class="boldEleven"><input type="text" class="boldEleven"
								size="20" maxlength="15" name="salesReturnNo" id="salesReturnNo"></td>
						</tr>
						<tr>
							<td class="boldEleven">Direct Ventor Purchase Code</td>
							<td class="boldEleven"><input type="text" class="boldEleven"
								size="20" maxlength="15" name="directPurchaseCode"
								id="directPurchaseCode"></td>
							<td class="boldEleven">Direct Ventor Purchase No</td>
							<td class="boldEleven"><input type="text" class="boldEleven"
								size="20" maxlength="15" name="directPurchaseNo"
								id="directPurchaseNo"></td>
						</tr>
						<tr>
							<td class="boldEleven">Direct Cust Sales Code</td>
							<td class="boldEleven"><input type="text" class="boldEleven"
								size="20" maxlength="15" name="directSalesCode"
								id="directSalesCode"></td>
							<td class="boldEleven">Direct Cust Sales No</td>
							<td class="boldEleven"><input type="text" class="boldEleven"
								size="20" maxlength="15" name="directSalesNo" id="directSalesNo"></td>
						</tr>
						<tr>
							<td class="boldEleven" colspan="4">
							<div id="results"></div>
							</td>
						</tr>
						<tr>
							<td class="boldEleven"><input name="filename" type="hidden"
								value="InventorySetting" /> <input name="actionS" type="hidden"
								value="INVbasicSetting" /></td>
							<td colspan="2" class="boldEleven">
							<table width="112" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td><input name="Submit" type="submit"
										class="buttonbold13" value="Submit"   accesskey="s"    onClick="return valid()"></td>
									<td><input name="Close" type="button" class="buttonbold13"
										id="Close"  value="Close"   accesskey="c" 
										onClick="redirect( 'InventoryMains.jsp')"></td>
								</tr>
							</table>
							</td>
							<td class="boldEleven">&nbsp;</td>
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
</div>
</form>
<br>
<%@ include file="../footer.jsp"%>
<%
	} catch (Exception e) {
	}
%>
</body>
</html>
