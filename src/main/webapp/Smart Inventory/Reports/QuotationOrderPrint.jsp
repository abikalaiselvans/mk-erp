<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage=""%>
<%@page import="com.my.org.erp.common.CommonFunctions"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../../JavaScript/comfunction.js"></script>
<style type="text/css">
<!--
.style3 {font-weight: bold}
-->
</style>
</head>
<%
	try{
	 String poId=request.getParameter("itemId");
	String sql="SELECT INT_QUOTATIONID,CHR_QUOTATIONNO,INT_CUSTOMERID,"+
				" DAT_QUOTATIONDATE,DAT_REQUESTDATE,INT_ONHOLD,INT_CONDITIONID,"+
				" CHR_DES,CHR_REF,INT_TAXID,DOU_DISCOUNT,DOU_TAXAMOUNT,"+
				" DOU_TOTALAMOUNT,INT_QUOTATIONSTATUS,DOU_AMOUNT "+
				" from  inv_t_customerquotation  where INT_QUOTATIONID="+poId;
	String purchaseInfo[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	

	sql="Select CHR_CUSTOMERNAME from inv_m_customerinfo where INT_CUSTOMERID="+purchaseInfo[0][2];
	String customerInfo[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
	 
%>
<body >
<table width="65%" border="0" align="center" cellpadding="5"
	cellspacing="5">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
			align="left" border="0">
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
					<table width="600" border="0" align="center" cellpadding="1"
						cellspacing="1">
						<tr>
							<td width="650"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>
							<table width="600" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="123" class="boldEleven">
									<div align="left">Quo.No</div>
									</td>
									<td width="229" class="boldEleven">
									<div align="left"><%=purchaseInfo[0][1]%></div>
									</td>
									<td width="107" class="boldEleven">
									<div align="left"><strong>On Hold </strong></div>
									</td>
									<td width="201" class="boldEleven">
									<div align="left">
									<%
                        	if(purchaseInfo[0][1].equals("1"))
                        		out.println("Yes");
                        	else
                        		out.println("No");
                        %>
									</div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Customer Id / Name</div>
									</td>
									<td class="boldEleven">
									<div align="left"><%=purchaseInfo[0][2]%> / <%=customerInfo[0][0]%>
									</div>
									</td>
									<td class="boldEleven">
									<div align="left"><strong>Payment Terms </strong></div>
									</td>
									<td class="boldEleven">
									<div align="left">
									<%
							String paymentids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms where INT_PAYMENTTERMID="+purchaseInfo[0][6]);
									 out.print(paymentids[0][1]);
							%>
									</div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Quo Date</div>
									</td>
									<td class="boldEleven">
									<div align="left"><%=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(purchaseInfo[0][3]) %>
									</div>
									</td>
									<td class="boldEleven"><strong>Request Date </strong></td>
									<td class="boldEleven">
									<div align="left"><%=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(purchaseInfo[0][4]) %></div>
									</td>
								</tr>
								<tr>
									<td height="22" class="boldEleven">
									<div align="left"></div>
									</td>
									<td class="boldEleven">
									<div align="left"></div>
									</td>
									<td class="boldEleven">
									<div align="left"></div>
									</td>
									<td class="boldEleven">
									<div align="left"></div>
									</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<%
					    out.println("<table width='100%'  border='1' >");
						out.println("<tr><td  class='boldEleven'><b>Type</b></td>");
						out.println("<td  class='boldEleven'><b>Item / Product</b></td>");
						out.println("<td  class='boldEleven'><b>Description</b></td>");
						out.println("<td  class='boldEleven'><b>Quantity</b></td>");
						out.println("<td  class='boldEleven'><b>Unit Price</b></td>");
						out.println("<td  class='boldEleven'><b>Discount(%)</b></td>");
						out.println("<td  class='boldEleven'><b>Unit Discount</b></td>");
						out.println("<td  class='boldEleven'><b>Total</b></td></tr>");
						sql = " SELECT CHR_TYPE,CHR_ITEMID ,CHR_DESC,INT_QUANTITY,DOU_UNITPRICE,DOU_DISCOUNT,";
						sql = sql +" DOU_UNITDISCOUNT,DOU_TOTAL from inv_t_customerquotationitem ";
						sql = sql +" where  INT_QUOTATIONID= "+poId;
						String purchaseItem[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
						String iname="";
						String itemname="";
						for(int i=0;i<purchaseItem.length;i++){
							out.println("<tr>");
								
							if(purchaseItem[i][0].equals("I"))
							{
								iname="Item";
								sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+purchaseItem[i][1]+"'";
								itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
							}	
							if(purchaseItem[i][0].equals("P"))
							{
								iname="Product";
								sql = "SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+purchaseItem[i][1]+"'";
								itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
							}	
									
								
							out.println(" <td class='boldEleven'>&nbsp;"+iname);	
							out.println(" <td class='boldEleven'>&nbsp;"+itemname);
							out.println("<td class='boldEleven'>&nbsp;"+purchaseItem[i][2]);
							out.println("<td class='boldEleven'>&nbsp;"+purchaseItem[i][3]);
							out.println("<td class='boldEleven' align='right'>&nbsp;"+purchaseItem[i][4]);
							out.println("<td class='boldEleven' align='right'>&nbsp;"+purchaseItem[i][5]);
							out.println("<td class='boldEleven' align='right'>&nbsp;"+purchaseItem[i][6]);
							out.println("<td class='boldEleven' align='right'>&nbsp;"+purchaseItem[i][7]);
						}
						out.println("</table>");
					%>
							</td>
						</tr>
						<tr>
							<td>
							<div align="left"></div>
							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<table width="600" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="114" rowspan="4" valign="top" class="boldEleven">&nbsp;</td>
									<td width="197" rowspan="4" valign="top" class="boldEleven">&nbsp;</td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left"><strong>Total</strong></div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">
									<div align="right"><%=purchaseInfo[0][14]%></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left"><strong>Total Discount </strong></div>
									</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1">
									<div align="right"><%=purchaseInfo[0][10]%></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left"><strong>Tax Group </strong></div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="tax1">
									<div align="left">
									<%
								String taxids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME,DOU_VALUE from inv_m_tax where INT_TAXID="+purchaseInfo[0][9]);
                              	String taxVal=taxVal=taxids[0][2];
								out.print(taxids[0][1]);	
							 %>
									</div>
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
									<div align="left"><strong>Reference <input
										name="quotationId" type="hidden" value="<%=poId %>" /> </strong></div>
									</td>
									<td class="boldEleven">
									<div align="left"><%=purchaseInfo[0][8] %></div>
									</td>
									<td class="boldEleven">
									<div align="left"><strong>Sales Tax Amount </strong></div>
									</td>
									<td class="boldEleven" id="salestaxamount1">
									<div align="right"><%=purchaseInfo[0][11] %></div>
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
									<td class="boldEleven" id="nettotal1">
									<div align="right"><%=purchaseInfo[0][12] %></div>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<hr width="98%" size="1" />
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">
									<div align="left"><strong>Description :: </strong></div>
									</div>
									</td>
									<td colspan="3" valign="top" class="boldEleven">
									<div align="left"><%=purchaseInfo[0][7] %></div>
									<div align="justify"></div>
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
		<div align="center"><a href='javascript:window.print()'>Print</a></div>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
 

</body>
<%
	}catch(Exception e){
		//System.out.println(e);
	}
%>
 
