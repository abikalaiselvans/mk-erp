<%@ page   language="java"	import="java.sql.*" errorPage="../error/index.jsp"%>
<html>
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
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
</head>
<%
try{
	String goodsRecNo=""+request.getParameter("gdreceiveno");
	out.print(goodsRecNo);
	if("null".equals(goodsRecNo))
		response.sendRedirect("GoodsRecived.jsp");
	String sql="SELECT CHR_PURCHASEORDERNO,CHR_RECIVEDID,DAT_RECIVEDDATE,CHR_RECIVEDBY,CHR_DELIVARYNO,CHR_INVOICENO ";
	sql=sql+" FROM inv_t_vendorgoodsreceived where CHR_RECIVEDID='"+goodsRecNo+"'";
	String goodsRecValue[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

	sql=" SELECT a.CHR_PURCHASEORDERNO,b.CHR_VENDORNAME,a.DAT_ORDERDATE,";
	sql = sql +" a.INT_ADDRESSID1,a.INT_ADDRESSID2,a.INT_ONHOLD,";
	sql = sql +" a.INT_CONDITIONID,a.INT_PAYMENTTERMID,a.CHR_DES,a.INT_PURCHASESTATUS ";
	sql = sql +" from  inv_t_vendorpurchaseorder  a , inv_m_vendorsinformation  b ";
	sql = sql +" where a.CHR_PURCHASEORDERNO='"+goodsRecValue[0][0]+"'  AND a.INT_VENDORID=b.INT_VENDORID";
	String SalenoInfo[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql); 
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
							<div align="center">VENDOR PURCHASE GOODS RECEIVED </div>
							</td>
						</tr>
						<tr>
							<td>
							<table width="673" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="123" class="boldEleven">
									<div align="left">Goods Receive No</div>
									</td>
									<td width="229" class="boldEleven">
									<div align="left"><%=goodsRecNo %> <input name="salno"
										type="hidden" id="salno" value="<%=goodsRecNo%>"></div>
									</td>
									<td width="107" class="boldEleven">
									<div align="left">Delivary No</div>
									</td>
									<td width="201" class="boldEleven"><%=goodsRecValue[0][4] %></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Vendor Id / Name</div>
									</td>
									<td class="boldEleven"><%=SalenoInfo[0][1] %></td>
									<td class="boldEleven">Order From</td>
									<td class="boldEleven">
									<%
								sql="Select INT_BRANCHID,CHR_BRANCHNAME from  com_m_branch WHERE INT_BRANCHID="+SalenoInfo[0][3];
                         		String branchids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
								out.print(branchids[0][1]);
						 %>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">Purchase Order No</td>
									<td class="boldEleven"><%=SalenoInfo[0][0] %></td>
									<td class="boldEleven">ShippingTo</td>
									<td class="boldEleven">
									<%
							sql="Select INT_BRANCHID,CHR_BRANCHNAME from  com_m_branch WHERE INT_BRANCHID="+SalenoInfo[0][4];
	                 		String shipids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							out.print(shipids[0][1]);
						%>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">PO Date</td>
									<td class="boldEleven"><%=SalenoInfo[0][2] %></td>
									<td class="boldEleven">Received Date</td>
									<td class="boldEleven"><%=goodsRecValue[0][2] %></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Received By</div>
									</td>
									<td class="boldEleven"><%=goodsRecValue[0][3] %></td>
									<td class="boldEleven">Received Status</td>
									<td class="boldEleven">
									<%
                        	if(SalenoInfo[0][9].equals("1"))
                        		 out.print("Received");
                        	else if(SalenoInfo[0][9].equals("-1"))
	                       		 out.print("Partilly Received");
                        %>
									</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<table width='100%' border="0" align="center" cellpadding="1"
								cellspacing="1" bordercolor="#ECACEF">
								<td width="10%" class="boldEleven"><b>S.No</b></td>
								<td width="10%" class="boldEleven"><b>Type</b></td>
								<td width="21%" class="boldEleven"><b>Item / Product</b></td>
								<td width="15%" class="boldEleven"><b>Order Qty</b></td>
								<td width="20%" class="boldEleven"><b>Received Qty</b></td>
								<!--<td width="17%"  class="boldEleven"><b>Remin Qty</b></td>-->
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<%
							
							sql =" SELECT CHR_TYPE,CHR_ITEMID,INT_QUANTITY ";
							sql = sql +" From  inv_t_vendorpurchaseorderitem  ";
							sql = sql +" WHERE CHR_PURCHASEORDERNO ='"+SalenoInfo[0][0]+"'";
							//goodsRecNo
							String saledata[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
							String iname="";
							String itemname="";
							String itemcolor="";
							String iitype="";
							out.println("<table width='100%'  border='0' align='center' cellpadding='2' cellspacing='2' >");
							for(int u=0; u<saledata.length;u++)
							{
								
								if(saledata[u][0].equals("I") || saledata[u][0].equals("1"))
								{
									iname="Item";
									sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+saledata[u][1]+"'";
									itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
									itemcolor="MRow1";
									iitype="I";
								}	
								if(saledata[u][0].equals("P") || saledata[u][0].equals("2"))
								{
									iname="Product";
									sql = "SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+saledata[u][1]+"'";
									itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
									itemcolor="MRow2";
									iitype="P";
								}	
								sql = sql =" Select count(*)  FROM inv_t_vendorgoodsreceived WHERE  ";
								sql = sql +" CHR_PURCHASEORDERNO = '"+SalenoInfo[0][0]+"' ";
								sql = sql +" and CHR_RECIVEDID='"+goodsRecNo+"'  and CHR_TYPE='"+iitype+"'";
								sql = sql +" and CHR_ITEMID='"+saledata[u][1]+"'";
								
								int orderquty =Integer.parseInt(saledata[u][2]);
								int recedqty = com.my.org.erp.common.CommonFunction.intRecordCount(sql);
								out.println("<tr class='"+itemcolor+"'  ><td width='10%' class='boldEleven' >"+(u+1)+"</td>");
								out.println("<td width='10%' class='boldEleven'>"+iname+"</td>");
								out.println("<td width='21%'  class='boldEleven'>"+itemname+"</td>");
								out.println("<td width='15%'  class='boldEleven' align='right'>"+saledata[u][2]+"</td>");
								out.println("<td width='20%' class='boldEleven' align='right'>"+recedqty+"</td>");
								//out.println("<td width='17%' class='boldEleven' align='right'>"+(orderquty-recedqty)+"</td>");
								
							}
							out.println("</table>");
					%>
							</td>
						</tr>
						<tr>
							<td>
							<%
					  	
						sql = " select CHR_TYPE , CHR_ITEMID ,CHR_SERIALNO, CHR_WARRANTY ,INT_ID from inv_t_vendorgoodsreceived ";
						sql = sql +" WHERE CHR_PURCHASEORDERNO = '"+SalenoInfo[0][0]+"' ";
						sql = sql +" and CHR_RECIVEDID='"+goodsRecNo+"'";
						itemcolor="";
						String stockdata[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
						out.println("<table width='686'  border='0' bordercolor='Beige' cellspacing=2 cellpadding=2 >");
						out.println("<tr><td class='boldEleven'><b>S.No</b><td class='boldEleven'><b>Type<td class='boldEleven'><b>Item Name<td class='boldEleven'><b>Serial Number<td  class='boldEleven'><b>Waranty<td  class='boldEleven'><b>&nbsp;");
						for(int u=0; u<stockdata.length;u++)
						{
							
							if(stockdata[u][0].equals("I"))
							{
								iname="Item";
								sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+stockdata[u][1]+"'";
								itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
								itemcolor="MRow3";
							}	
							if(stockdata[u][0].equals("P"))
							{
								iname="Product";
								sql = "SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+stockdata[u][1]+"'";
								itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
								itemcolor="MRow4";
							}	
							out.println("<tr class='"+itemcolor+"'>");
							out.println("<td class='boldEleven'>"+(u+1)+"</td>");
							out.println("<td class='boldEleven'>"+iname+"</td>");
							out.println("<td class='boldEleven'>"+itemname+"</td>");
							out.println("<td class='boldEleven'>"+stockdata[u][2]);
							out.println("<td class='boldEleven'>"+stockdata[u][3]+" - Years");
							String link="";
							link = "Serialnumberupdate.jsp?rowid="+stockdata[u][4];
							link=link+"&itype="+stockdata[u][0]+"&itemid="+stockdata[u][1]+"&refno="+SalenoInfo[0][0];
							out.println("<td class='boldEleven'><a href='"+link+"'><font class='boldgreen'>Update</font>");
							
							 
						}	
						out.println("</table>");
					  %> <input name="seriallength" type="hidden" id="seriallength"
								value="<%=stockdata.length%>"></td>
						</tr>
						<tr>
							<td><input name="filename" type="hidden"
								value="DelivaryChallan" /> <input name="actionS" type="hidden"
								value="INVDelivaryChallanAddSerial" /></td>
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
							<table width="100" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td><input name="Button" type="button"
										class="tMLAscreenHead" value="Print"
										onClick="javascript:window.print()" /></td>
									<td><input name="Submit2" type="button"
										class="tMLAscreenHead" value="  Close  "
										onClick="redirect('GoodsReceivedList.jsp?ponumber=<%=SalenoInfo[0][0]%>')" /></td>
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
<%@ page import="com.my.org.erp.common.CommonInfo"%>
</html>
<%
}
catch(Exception e){
	//System.out.println("Error :"+e.getMessage());
}
%>
