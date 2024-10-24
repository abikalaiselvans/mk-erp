<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage="../error/index.jsp"%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<script language="javascript">
function valid()
	{
   		 	
   		if(
		checkNull('dcnumber',"Enter Delivery Challan number ...")
		&& checkNull('delDate',"Enter Delivery date ...")
		)
			return true;
		else
			return false
			
		
	}
</script>
</head>
<%
	String Saleno=request.getParameter("saleno");
	String sql=" SELECT a.CHR_QUOTATIONNO,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.CHR_CUSTPURCHASENO,a.CHR_SALESORDERNO,a.CHR_SALEBY,a.DAT_SALEDATE,";
	sql = sql +" a.CHR_DELIVERYSTATUS,a.CHR_BILLINGADDRESS,a.CHR_SHIPINGADDRESS,a.INT_ONHOLD,";
	sql = sql +" a.INT_CONDITIONID,a.INT_PAYMENTTERMID,a.CHR_DES,a.CHR_REF,a.INT_TAXID,a.DOU_AMOUNT,a.DOU_DISCOUNT,";
	sql = sql +" a.DOU_TAXAMOUNT,a.DOU_TOTALAMOUNT,a.CHR_PAYMENTSTATUS from  inv_t_customersalesorder   a ,inv_m_customerinfo b ";
	sql = sql +" where a.CHR_SALESORDERNO='"+Saleno+"' AND a.INT_CUSTOMERID =b.INT_CUSTOMERID order by a.DAT_SALEDATE";
	String SalenoInfo[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
	String branchId=""+session.getAttribute("BRANCHID");
	 String dcnumber = request.getParameter("dcnumber");
%>
<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   action="" method="post" name="frm" id="frm">
<div align="center"><br />
<table width="100%" border="0" cellspacing="1" cellpadding="1">
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
							<td align="center" class="bolddeeplogin">
							<div align="center">Delivery</div>
							</td>
						</tr>
						<tr>
							<td>
							<table width="673" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="123" class="boldEleven">
									<div align="left">Quotaion Ref No</div>
									</td>
									<td width="229" class="boldEleven">
									<div align="left"><%=SalenoInfo[0][0] %> <input
										name="salno" type="hidden" id="salno" value="<%=Saleno%>">
									</div>
									</td>
									<td width="107" class="boldEleven">
									<div align="left">On Hold</div>
									</td>
									<td width="201" class="boldEleven">
									<%
                        	if(SalenoInfo[0][9].equals("1"))
                        		out.println("<input name='hold' type='checkbox' checked='checked' id='hold' value='checkbox'  tabindex='4'/>");
                        	else
                        		out.println("<input name='hold' type='checkbox' id='hold' value='checkbox'  tabindex='4'/>");
                        %>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Customer Id / Name</div>
									</td>
									<td class="boldEleven"><%=SalenoInfo[0][1] %></td>
									<td class="boldEleven">Billing To</td>
									<td class="boldEleven">
									<%
								String branchids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_BRANCHID,CHR_BRANCHNAME from  com_m_branch ");
								for(int u=0; u<branchids.length; u++)
									if(SalenoInfo[0][7].equals(branchids[u][0]))
										out.print( branchids[u][1] );
									 
							%>
									<div align="left"></div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">Cust Purchase No</td>
									<td class="boldEleven"><%=SalenoInfo[0][2] %></td>
									<td class="boldEleven">Shipping To</td>
									<td class="boldEleven">
									<%
								String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_BRANCHID,CHR_BRANCHNAME from  com_m_branch ");
								for(int u=0; u<shipids.length; u++)
									if(SalenoInfo[0][8].equals(shipids[u][0]))
										   out.print(shipids[u][1]);									
								
							%>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">Sale Order No</td>
									<td class="boldEleven"><%=SalenoInfo[0][3] %></td>
									<td class="boldEleven">Payment Terms</td>
									<td class="boldEleven">
									<%
		String paymentids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms");
		String pid="";
			for(int u=0; u<paymentids.length; u++){
				if(paymentids[u][0].equals(SalenoInfo[0][11]))
				{
				 out.print(paymentids[u][1]);
				 pid = paymentids[u][0];
				}				
			}
		%>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Sale By</div>
									</td>
									<td class="boldEleven"><%=SalenoInfo[0][4] %></td>
									<td class="boldEleven">Delivery No</td>
									<td class="boldEleven">
									<%
						String dcno = request.getParameter("dcnumber");
						out.print(dcno);
						%>
									</td>
								</tr>
								<tr>
									<td height="22" class="boldEleven">
									<div align="left">Sale Date</div>
									</td>
									<td class="boldEleven"><%=SalenoInfo[0][5] %></td>
									<td class="boldEleven">Delivery Date</td>
									<td class="boldEleven">
									<%
							sql ="select DT_DELIVERYDATE  from  inv_t_customersalesorderitemserial   WHERE CHR_SALESORDERNO='"+Saleno+"' ";
							sql = sql +" AND CHR_DELIVERYNO='"+dcno+"' group by CHR_DELIVERYNO";
							String ta[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							out.println(ta[0][0]);
						%>
									</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<%
					  
					sql = " select CHR_TYPE,CHR_ITEMID, count(*) from  inv_t_customersalesorderitemserial ";
					sql = sql + " WHERE CHR_SALESORDERNO = '"+Saleno+"'  ";
					sql = sql + " AND CHR_DELIVERYNO ='"+dcnumber+"' group by CHR_TYPE ";
					String saledata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					String iname="";
					String itemname="";
					out.println("<table width='100%'  border='1' cellspacing=0 cellpadding=0 >");
					out.println("<td   class='boldEleven'><b>Type</b></td>");
					out.println("<td   class='boldEleven'><b>Item / Product</b></td>");
					out.println("<td   class='boldEleven'><b>Order Qty</b></td>");
					out.println("<td   class='boldEleven'><b>Delivery Qty </b></td>");
					
					for(int u=0; u<saledata.length;u++)
					{
						if(saledata[u][0].equals("I"))
						{
							iname="Item";
							sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+saledata[u][1]+"'";
							itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
						}	
						if(saledata[u][0].equals("P"))
						{
						  iname="Product";
						  sql= "SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+saledata[u][1]+"'";
						  itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
						}	
						out.println("<tr><td   class='boldEleven' >"+iname+"</td>");
						out.println("<td  class='boldEleven' >"+itemname+"</td>");
						
						
						sql = " select count(*) from  inv_t_customersalesorderitemserial  ";
						sql = sql +" WHERE CHR_SALESORDERNO = '"+Saleno+"'  AND  CHR_ITEMID = '"+saledata[u][1]+"' ";
						int Ordqty = com.my.org.erp.common.CommonFunction.intRecordCount(sql);
						

						out.println("<td  class='boldEleven' >"+Ordqty+"</td>");
						out.println("<td  class='boldEleven' >"+saledata[0][2]+"</td>");
						
						 
					}	
					out.println("</table>");
					
						%>
							</td>
						</tr>
						<tr>
							<td>
							<%
						sql = " select CHR_TYPE,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY ,INT_ID from  inv_t_customersalesorderitemserial  WHERE CHR_SALESORDERNO = '"+Saleno+"'  AND CHR_DELIVERYNO ='"+dcnumber+"' order by CHR_ITEMID ";
						String serialdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						out.print("<table border=0 cellspacing=3 cellpadding=3 width='100%'>");
						out.println("<tr><td class='boldEleven'><b>S.No. </b></td><td   class='boldEleven'><b>Type</b></td>");
						out.println("<td   class='boldEleven'><b>Item / Product</b></td>");
						out.println("<td   class='boldEleven'><b>Serial Number</b></td>");
						out.println("<td   class='boldEleven'><b>Warranty</b></td>");
						for(int u=0; u<serialdata.length;u++)
						{
							if(u%2 == 0)
								out.println("<tr class='MRow1'>");
							else
								out.println("<tr class='MRow2'>");
							
							 	
							if(serialdata[u][0].equals("I"))
							{
								iname="Item";
								sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+serialdata[u][1]+"'";
								itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
							}	
							if(serialdata[u][0].equals("P"))
							{
							  iname="Product";
							  sql= "SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+serialdata[u][1]+"'";
							  itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
							}	
							out.println("<td   class='boldEleven' >"+(u+1)+"</td>");
							out.println("<td   class='boldEleven' >"+iname+"</td>");
							out.println("<td class='boldEleven' >"+itemname);
							out.println("<td class='boldEleven' >"+serialdata[u][2]+"</td>");
							out.println("<td class='boldEleven' >"+serialdata[u][3]+"</td>");
						}
						out.print("</table>");
					  %>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td></td>
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
									<div align="left"><%=SalenoInfo[0][12] %></div>
									</td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left">Total</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">
									<div align="right"><%=SalenoInfo[0][15] %></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Total Discount</div>
									</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1">
									<div align="right"><%=SalenoInfo[0][16] %></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Tax Group</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="tax1">
									<%
								String taxids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME,DOU_VALUE from inv_m_tax");
                              	String taxVal="";
								String tid="";
								for(int u=0; u<taxids.length; u++){
									if(taxids[u][0].equals(SalenoInfo[0][14])){
										out.print("<b>"+taxids[u][1]+"</b>");	
										taxVal=taxids[u][2];
										tid=taxids[u][0];
									}
														
								}									
							 %>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Sales Tax (%)</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="salestax1">
									<div align="right"><%=taxVal %></div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Reference</div>
									</td>
									<td class="boldEleven"><%=SalenoInfo[0][13] %></td>
									<td class="boldEleven">
									<div align="left">Sales Tax Amount</div>
									</td>
									<td width="169" class="boldEleven" id="salestaxamount1">
									<div align="right"><%=SalenoInfo[0][17] %></div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left"><input name="filename" type="hidden"
										value="DelivaryChallan" /> <input name="actionS"
										type="hidden" value="INVDelivaryChallanAddSerial" /></div>
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
									<div align="right"><%=SalenoInfo[0][18] %></div>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<table width="100" border="0" align="center" cellpadding="3"
										cellspacing="3">
										<tr>
											<td><input name="Button" type="button"
												class="tMLAscreenHead" value="Print"
												onClick="javascript:window.print()" /></td>
											<td><input name="Submit2" type="button"
												class="tMLAscreenHead" value="  Close  "
												onClick="redirect('Delivary Challan.jsp')" /></td>
										</tr>
									</table>
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
		<td>&nbsp;</td>
	</tr>
</table>
</div>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>

