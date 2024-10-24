<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage=""%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
.style3 {font-weight: bold}
-->
</style>
</head>
<%
	try{
	String poId=request.getParameter("itemId");	 
	String sql =" SELECT a.CHR_QUOTATIONNO,a.CHR_SALESORDERNO, a.INT_CUSTOMERID,a.CHR_CUSTPURCHASENO,a.CHR_SALEBY, ";
	sql = sql + " a.DAT_SALEDATE,a.CHR_BILLINGADDRESS, a.CHR_SHIPINGADDRESS,a.INT_CONDITIONID, ";
	sql = sql + " a.INT_PAYMENTTERMID,a.CHR_DES,a.CHR_REF, a.INT_TAXID,a.DOU_AMOUNT,a.DOU_DISCOUNT, ";
	sql = sql + " a.DOU_TAXAMOUNT, a.DOU_TOTALAMOUNT,a.CHR_PAYMENTSTATUS  ";
	sql = sql + " from  inv_t_customersalesorder   a , inv_t_customerquotation  b ";
	sql = sql + " where b.INT_QUOTATIONID= "+poId;
	sql = sql + " AND a.CHR_QUOTATIONNO = b.CHR_QUOTATIONNO ";
	String salesOrder[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);		
	sql="SELECT CHR_QUOTATIONNO,DAT_QUOTATIONDATE,INT_CUSTOMERID "+
	" from  inv_t_customerquotation  where INT_QUOTATIONID="+poId;
	String purchaseInfo[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);		
	sql="Select CHR_CUSTOMERNAME from inv_m_customerinfo where INT_CUSTOMERID="+purchaseInfo[0][2];
	String customerInfo[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
   
%>
<body >

<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm">
<table width="800" border="0" align="left" cellpadding="1"
	cellspacing="1">
	<tr>
		<td width="755"></td>
	</tr>
	<tr>
		<td height="100">
		<%
		%>
		</td>
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
					<table width="663" border="0" align="center" cellpadding="1"
						cellspacing="1">

						<tr>
							<td width="650"></td>
						</tr>
						<tr>
							<td>
							<div align="center"><strong>Customer Purchase </strong></div>
							</td>
						</tr>
						<tr>
							<td>
							<table width="673" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="123" class="boldEleven">
									<div align="left"><strong> Quotaion Ref No </strong></div>
									</td>
									<td width="229" class="boldEleven">
									<div align="left"><%=salesOrder[0][0] %></div>
									</td>
									<td width="107" class="boldEleven">
									<div align="left"><strong>Quotation Date </strong></div>
									</td>
									<td width="201" class="boldEleven">
									<div align="left"><%=purchaseInfo[0][1]%></div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left"><strong>Customer Id / Name</strong></div>
									</td>
									<td class="boldEleven"><%=customerInfo[0][0]%></td>
									<td class="boldEleven"><strong>Billing To </strong></td>
									<td class="boldEleven"><%=salesOrder[0][6] %></td>
								</tr>
								<tr>
									<td class="boldEleven"><strong>Cust Purchase No </strong></td>
									<td class="boldEleven"><%=salesOrder[0][3] %></td>
									<td class="boldEleven"><strong>Shipping To </strong></td>
									<td class="boldEleven"><%=salesOrder[0][7]%></td>
								</tr>
								<tr>
									<td class="boldEleven"><strong>Sale Order No </strong></td>
									<td class="boldEleven"><%=salesOrder[0][1] %></td>
									<td class="boldEleven"><strong>Payment Terms</strong></td>
									<td class="boldEleven">
									<%
	String paymentids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms");
	String pid="";
			for(int u=0; u<paymentids.length; u++){
				if(salesOrder[0][9].equals(paymentids[u][0]))
					out.print(paymentids[u][1]);
				 
			}	
		%>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left"><strong>Sale By </strong></div>
									</td>
									<td class="boldEleven">
									<div align="left"><%=salesOrder[0][4] %></div>
									</td>
									<td class="boldEleven">
									<div align="left"></div>
									</td>
									<td class="boldEleven">&nbsp;</td>
								</tr>
								<tr>
									<td height="22" class="boldEleven">
									<div align="left"><strong>Sale Date </strong></div>
									</td>
									<td class="boldEleven"><%=salesOrder[0][5] %></td>
									<td class="boldEleven">
									<div align="left"></div>
									</td>
									<td class="boldEleven">
									<div align="left">
									<div align="left"></div>
									</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td class='boldEleven'>
							<table width="686" border="0" align="center" cellpadding="1"
								cellspacing="1" bordercolor="#ECACEF">
								<td class="boldEleven"><b>Type</b></td>
								<td class="boldEleven"><b>Item / Product</b></td>
								<td class="boldEleven"><b>Description</b></td>
								<td class="boldEleven"><b>Order Qty</b></td>
								<td class="boldEleven"><b>Unit Price</b></td>
								<td class="boldEleven"><b>Discount(%)</b></td>
								<td class="boldEleven"><b>Unit Discount</b></td>
								<td class="boldEleven"><b>Total</b></td>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<div align="left">
							<%
					  
					   
							sql = "SELECT CHR_TYPE ,CHR_ITEMID,CHR_DESC,INT_QUANTITY, DOU_UNITPRICE,DOU_DISCOUNT,";
							sql = sql+" DOU_UNITDISCOUNT,DOU_TOTAL FROM  inv_t_customersalesorderitem  ";
							sql = sql +" WHERE CHR_SALESORDERNO='"+salesOrder[0][1]+"'";
							String orderdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							String iname="";
							String itemname="";
							
							out.println("<table width='686'  border='1' >");
							for(int u=0; u<orderdata.length;u++)
							{
								if(orderdata[u][0].equals("I"))
								{
									iname="Item";
									sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+orderdata[u][1]+"'";
									itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
								}	
								if(orderdata[u][0].equals("P"))
								{
									iname="Product";
									sql= "SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+orderdata[u][1]+"'";
									itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
								}	
								out.println("<tr><td width='51' class='boldEleven'>"+iname+"</td>");
								out.println("<td width='113' class='boldEleven'>"+itemname+"</td>");
								out.println("<td width='99' class='boldEleven' align='right'>"+orderdata[u][2]+"</td>");
								out.println("<td width='91' class='boldEleven' align='right'>"+orderdata[u][3]+"</td>");
								out.println("<td width='131' class='boldEleven' align='right'>"+orderdata[u][4]+"</td>");
								out.println("<td width='124' class='boldEleven' align='right'>"+orderdata[u][5]+"</td>");
								out.println("<td width='55' class='boldEleven' align='right'>"+orderdata[u][6]+" </td>");
								out.println("<td width='55' class='boldEleven' align='right'>"+orderdata[u][7]+" </td>");
								 
							}	
							out.println("</table>");
							
						%>
							</div>
							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<table width="688" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="114" rowspan="4" valign="top" class="boldEleven">
									<div align="left"></div>
									</td>
									<td width="197" rowspan="4" valign="top" class="boldEleven">
									<div align="left"></div>
									</td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left"><strong>Total</strong></div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">
									<div align="right"><%=salesOrder[0][13] %></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left"><strong>Total Discount </strong></div>
									</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1">
									<div align="right"><%=salesOrder[0][14] %></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left"><strong>Tax Group </strong></div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="tax1">
									<%
								String taxids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME,DOU_VALUE from inv_m_tax");
                              	String taxVal="";
								String tid="";
								for(int u=0; u<taxids.length; u++){
									if(taxids[u][0].equals(salesOrder[0][12])){
										out.print(taxids[u][1]);	
										taxVal=taxids[u][2];
										tid=taxids[u][0];
									}
														
								}									
							 %>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left"><strong>Sales Tax (%) </strong></div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="salestax1">
									<div align="right"><%=taxVal %></div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left"><strong>Reference </strong></div>
									</td>
									<td class="boldEleven">
									<div align="left"><%=salesOrder[0][11] %></div>
									</td>
									<td class="boldEleven">
									<div align="left"><strong>Sales Tax Amount </strong></div>
									</td>
									<td width="169" class="boldEleven" id="salestaxamount1">
									<div align="right"><%=salesOrder[0][15] %></div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">&nbsp;</td>
									<td class="boldEleven">&nbsp;</td>
									<td class="boldEleven">
									<div align="left" class="style3">
									<div align="left">Net Total</div>
									</div>
									</td>
									<td width="169" class="boldEleven" id="nettotal1">
									<div align="right"><%=salesOrder[0][16] %></div>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<hr width="100%">
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">&nbsp;</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left"><strong>Description </strong></div>
									</td>
									<td colspan="3" valign="top" class="boldEleven">
									<div align="justify"><%=salesOrder[0][10] %></div>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<div align="center"></div>
									<div align="left"></div>
									<div align="left"></div>
									</td>
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
					<td height="6"><spacer height="1" width="1" type="block" />
					<div align="center"></div>
					</td>
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
		<td>
		<div align="center"><A href="javascript:window.print()">Print</A></div>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>

	</tr>
</table>
</form>

</body>
<%
	}catch(Exception e){
		//System.out.println(e);
	}
%>
</html>
