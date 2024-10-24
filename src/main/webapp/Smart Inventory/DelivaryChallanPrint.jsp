<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage="../error/index.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 1.5in;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
</head>
<%
	try{
	String poId=request.getParameter("itemId");
	String sql="SELECT INT_QUOTATIONID,INT_SALESORDERID,CHR_SALESORDERNO,"+
	" INT_CUSTOMERID,CHR_ORDERBY,DAT_ORDERDATE,CHR_BILLINGADDRESS,"+
	" CHR_SHIPINGADDRESS,INT_CONDITIONID,INT_PAYMENTTERMID,CHR_DES,CHR_REF,"+
	" INT_TAXID,DOU_AMOUNT,DOU_DISCOUNT,DOU_TAXAMOUNT,"+
	" DOU_TOTALAMOUNT,INT_ORDERSTATUS,CHR_PAYMENTSTATUS "+
	" from  inv_t_customersalesorder   where INT_SALESORDERID="+poId;
	String salesOrder[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);		
	
	sql="SELECT CHR_QUOTATIONNO,DAT_QUOTATIONDATE,INT_CUSTOMERID "+
	" from  inv_t_customerquotation  where INT_QUOTATIONID="+salesOrder[0][0];
	String purchaseInfo[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
	
	sql="Select CHR_CUSTOMERNAME from inv_m_customerinfo where INT_CUSTOMERID="+purchaseInfo[0][2];
	String customerInfo[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	
	sql="Select INT_DELIVARYID,CHR_DELIVARYNO,CHR_RECIVEDBY,DAT_DELIVARYDATE "+
	" from inv_t_delivary where INT_SALESORDERID="+poId;
	String delivaryInfo[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
%>

<br>
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
					<div align="center"><strong>Delivary Challan </strong></div>
					</td>
				</tr>
				<tr>
					<td>
					<table width="673" border="0" align="center" cellpadding="1"
						cellspacing="1">
						<tr>
							<td width="123" class="boldEleven">
							<div align="left">Quo.No</div>
							</td>
							<td width="229" class="boldEleven">
							<div align="left"><%=purchaseInfo[0][0]%></div>
							</td>
							<td width="107" class="boldEleven">
							<div align="left">Quo Date</div>
							</td>
							<td width="201" class="boldEleven">
							<div align="left"><%=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(purchaseInfo[0][1]) %></div>
							</td>
						</tr>
						<tr>
							<td class="boldEleven">
							<div align="left">Purchase Order No</div>
							</td>
							<td class="boldEleven">
							<div align="left"><%=salesOrder[0][2] %></div>
							</td>
							<td class="boldEleven">
							<div align="left">Order Date</div>
							</td>
							<td class="boldEleven">
							<div align="left"><%=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(salesOrder[0][5]) %></div>
							</td>
						</tr>
						<tr>
							<td class="boldEleven">Delivary No</td>
							<td class="boldEleven"><%=delivaryInfo[0][1] %></td>
							<td class="boldEleven">Delivary Date</td>
							<td class="boldEleven"><%=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(delivaryInfo[0][3]) %></td>
						</tr>
						<tr>
							<td class="boldEleven">
							<div align="left">Customer Id / Name</div>
							</td>
							<td class="boldEleven">
							<div align="left"><%=purchaseInfo[0][2]%> / <%=customerInfo[0][0]%>
							</div>
							</td>
							<td class="boldEleven">On Hold</td>
							<td class="boldEleven">
							<%
                        	if(purchaseInfo[0][1].equals("1"))
                        		out.println("Yes");
                        	else
                        		out.println("No");
                        %>
							</td>
						</tr>
						<tr>
							<td height="22" class="boldEleven">
							<div align="left">Recived By</div>
							</td>
							<td class="boldEleven">
							<div align="left"><%=delivaryInfo[0][2]%></div>
							</td>
							<td class="boldEleven">
							<div align="left">Payment Terms</div>
							</td>
							<td class="boldEleven">
							<div align="left">
							<div align="left">
							<%
							String paymentids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms where INT_PAYMENTTERMID="+salesOrder[0][9]);
									 out.print(paymentids[0][1]);
							%>
							</div>
							</div>
							</td>
						</tr>
					</table>
					</td>
				</tr>
				<tr>
					<td>
					<%
					    out.println("<table   border=1  cellpadding='1' cellspacing='1'>");
						out.println("<tr><td width='200px' class='boldEleven'><b>Item</b></td>");
						out.println("<td width='150px' class='boldEleven'><b>Description</b></td>");
						out.println("<td width='75px' class='boldEleven'><b>Order Quantity</b></td>");
						out.println("<td width='75px' class='boldEleven'><b>Deliv. Quantity</b></td>");
						out.println("<td width='75px' class='boldEleven'><b>Unit Price</b></td>");
						out.println("<td width='100px' class='boldEleven'><b>Discount(%)</b></td>");
						out.println("<td width='100px' class='boldEleven'><b>Unit Discount</b></td>");
						out.println("<td width='54px' class='boldEleven'><b>Total</b></td></tr>");
						sql="SELECT b.CHR_ITEMNAME,a.CHR_DESC,a.INT_QUANTITY,"+
						" a.INT_SALESQUANTITY,a.DOU_UNITPRICE,a.DOU_DISCOUNT,a.DOU_UNITDISCOUNT,a.DOU_TOTAL "+
						" from inv_t_delivaryitem a,inv_m_item b where "+
						" a.CHR_ITEMID=b.CHR_ITEMID ";
						//and a.INT_DELIVARYID="+delivaryInfo[0][0];
						
						String purchaseItem[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
						for(int i=0;i<purchaseItem.length;i++){
							out.println("<tr><td class='boldEleven'>"+purchaseItem[i][0]);
							out.println("<td class='boldEleven'>"+purchaseItem[i][1]);
							out.println("<td class='boldEleven'>"+purchaseItem[i][2]);
							out.println("<td class='boldEleven'>"+purchaseItem[i][3]);
							out.println("<td class='boldEleven'>"+purchaseItem[i][4]);
							out.println("<td class='boldEleven'>"+purchaseItem[i][5]);
							out.println("<td class='boldEleven'>"+purchaseItem[i][6]);
							out.println("<td class='boldEleven' align='right'>"+purchaseItem[i][7]);
						}
						out.println("</table>");
						
					%>
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
							<div align="left">Memo</div>
							</td>
							<td width="197" rowspan="4" valign="top" class="boldEleven">
							<div align="left"><%=salesOrder[0][10] %></div>
							</td>
							<td width="107" valign="top" class="boldEleven">
							<div align="left">Total</div>
							</td>
							<td width="169" valign="top" class="boldEleven" id="totals1">
							<div align="right"><%=salesOrder[0][13]%></div>
							</td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<div align="left">Total Discount</div>
							</td>
							<td width="169" valign="top" class="boldEleven"
								id="totaldiscount1">
							<div align="right"><%=salesOrder[0][14]%></div>
							</td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<div align="left">Tax Group</div>
							</td>
							<td width="169" valign="top" class="boldEleven" id="tax1">
							<div align="left">
							<%
								String taxids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME,DOU_VALUE from inv_m_tax where INT_TAXID="+salesOrder[0][12]);
                              	String taxVal=taxVal=taxids[0][2];
								out.print("<b>"+taxids[0][1]+"</b>");	
							 %>
							</div>
							</td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<div align="left">Sales Tax (%)</div>
							</td>
							<td width="169" valign="top" class="boldEleven" id="salestax1">
							<div align="right"><%=taxVal%></div>
							</td>
						</tr>
						<tr>
							<td class="boldEleven">
							<div align="left">Reference</div>
							</td>
							<td class="boldEleven">
							<div align="left"><%=salesOrder[0][11] %></div>
							</td>
							<td class="boldEleven">
							<div align="left">Sales Tax Amount</div>
							</td>
							<td width="169" class="boldEleven" id="salestaxamount1">
							<div align="right"><%=salesOrder[0][15] %></div>
							</td>
						</tr>
						<tr>
							<td class="boldEleven">
							<div align="left"></div>
							</td>
							<td class="boldEleven">
							<div align="left"></div>
							</td>
							<td class="boldEleven">
							<div align="left">
							<div align="left">Net Total</div>
							</div>
							</td>
							<td width="169" class="boldEleven" id="nettotal1">
							<div align="right"><%=salesOrder[0][16] %></div>
							</td>
						</tr>
						<tr>
							<td colspan="4" class="boldEleven">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="4" class="boldEleven"></td>
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
<%
	}catch(Exception e){
		//System.out.println(e);
	}
%>
</html>
