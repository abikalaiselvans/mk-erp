<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*,com.my.org.erp.common.*" errorPage="../error/index.jsp"%>
<%
	try
	{
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript"
	src="../JavaScript/Inventory/InvenCustomerAJAX.js"></script>
<script language="javascript">
 function SalesOrderPrint(query)
	{
		var width="800", height="400";
  		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
  		var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbar=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		var f ="CashSalePrintout.jsp?itemId="+query;
		newWindow = window.open(f,"subWind",styleStr);
		newWindow.focus( );
	}
	
</script>
</head>
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
							<td>
							<div align="center"><strong> Cash Sale Edit <%
						String salesid = request.getParameter("itemId");
						String cashdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("select * from inv_t_directsales WHERE CHR_SALESNO ='"+salesid+"'");
						
						
						
						 
					%> </strong></div>
							</td>
						</tr>
						<tr>
							<td>
							<table width="673" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="123" class="boldEleven">
									<div align="left">Cash Sale .No</div>
									</td>
									<td width="229" class="boldEleven">
									<div align="left"><%=cashdata[0][2]%> <input
										type="hidden" name="cashSaleNo" value="<%=cashdata[0][2]%>">
									</div>
									</td>
									<td width="107" class="boldEleven">Sale Date</td>
									<td width="201" class="boldEleven"><%=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(cashdata[0][3])%>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">CustomerName</div>
									</td>
									<td class="boldEleven"><%=cashdata[0][5]%></td>
									<td class="boldEleven">Payment Terms</td>
									<td class="boldEleven">
									<%
			
			String paymentids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms");
			String pid = cashdata[0][4].trim();
			
			for(int u=0; u<paymentids.length; u++)
			{
				if(pid.equals(paymentids[u][0]))
					out.print(paymentids[u][1]);
				
			}	
			%>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">Customer Address</td>
									<td class="boldEleven"><%=cashdata[0][6]%></td>
									<td class="boldEleven">&nbsp;</td>
									<td class="boldEleven">&nbsp;</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<table width="732" border="1" cellpadding="1" cellspacing="1">
								<tr>
									<td width="129" height="23" class="boldEleven"><b>Item</b></td>
									<td width="134" class="boldEleven"><b>Description</b></td>
									<td width="106" class="boldEleven"><b>Quantity</b></td>
									<td width="71" class="boldEleven"><b>Unit Price</b></td>
									<td width="101" class="boldEleven"><b>Discount(%)</b></td>
									<td width="97" class="boldEleven"><b>Unit Discount</b></td>
									<td width="56" class="boldEleven"><b>Total</b></td>

									<%
		String sql ="SELECT * FROM inv_t_cashsalesitem WHERE CHR_SALESNO='"+salesid+"'";
		String itemDatas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		String i0,i1,i2,i3,i4,i5,i6,i7,i8,vf1,vf2,vf3,vf4,vf5;
		i0="stock";
		i1 ="qty";
		i2 ="uprice";
		i3 ="discount";
		i4 ="unitdiscount";
		i5 ="total";
		i6="item";
		i7="desc";
		i8="pstock";
		int lens = itemDatas.length;
		for(int u=0;u<itemDatas.length;u++)
		{
			i0 ="stock"+(u+1);
			i1 ="qty"+(u+1);
			i2 ="uprice"+(u+1);
			i3 ="discount"+(u+1);
			i4 ="unitdiscount"+(u+1);
			i5 ="total"+(u+1);
			i6 ="item"+(u+1);
			i7 ="desc"+(u+1);
			i8 ="pstock"+(u+1);
			vf1 = "onKeyPress=\"numericValue('"+i1+"','5')\"";
			vf2 = "onKeyPress=\"numericValue('"+i2+"','5')\"";
			vf3 = "onKeyPress=\"numericValue('"+i3+"','5')\"";
			vf4 = "onKeyPress=\"numericValue('"+i4+"','5')\"";
			vf5 = "onKeyPress=\"numericValue('"+i5+"','10')\"";
			out.print("<tr><td width='134' class='boldEleven'>");
			sql = "SELECT CHR_ITEMNAME ,INT_STOCKINHAND FROM inv_m_item WHERE CHR_ITEMID='"+itemDatas[u][3]+"'";
			String stockdata[][] =CommonInfo.RecordSetArray(sql);
			out.println(CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME"));
			out.print("<input  type='hidden'  name='"+i6+"' id='"+i6+"' value ='"+itemDatas[u][3]+"'/>");
			out.print("<td width='118' class='boldEleven'>"+itemDatas[u][4]);
			out.print("<td width='83' 	class='boldEleven'>"+itemDatas[u][5]+"</td>");
            out.print("<td width='98' 	class='boldEleven'>"+itemDatas[u][6]+"</td>");
            out.print("<td width='123' 	class='boldEleven'>"+itemDatas[u][7]+"</td>");
            out.print("<td width='133' 	class='boldEleven'>"+itemDatas[u][8]+"</td>");
            out.print("<td width='54' 	class='boldEleven'>"+itemDatas[u][9]+"</td>");
		}
		
	%>
								
							</table>

							</td>
						</tr>
						<tr>
							<td height="9"></td>
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
									<div align="left"><%=cashdata[0][7]%></div>
									</td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left">Total</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">

									<div align="left"><%=cashdata[0][10]%></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Total Discount (%)</div>
									</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1">
									<div align="left"><%=cashdata[0][11]%></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Tax Group</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="tax1">
									<div align="left">
									<%
		String taxids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME from inv_m_tax");
		String tid =  cashdata[0][11];
		 
		for(int u=0; u<taxids.length; u++)
		{
			if(tid.trim().equals(taxids[u][0]))
				out.print(taxids[u][1]);
			
		}		
	%>
									</div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Sales Tax (%)</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="salestax1">
									<div align="left"><%=cashdata[0][11]%></div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Reference</div>
									</td>
									<td class="boldEleven">
									<div align="left"><%=cashdata[0][8]%></div>
									</td>
									<td class="boldEleven">
									<div align="left">Sales Tax Amount</div>
									</td>
									<td class="boldEleven" id="salestaxamount1">
									<div align="left"><%=cashdata[0][12]%></div>
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
									<div align="left">Net Total</div>
									</td>
									<td class="boldEleven" id="nettotal1">
									<div align="left"><%=cashdata[0][13]%></div>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<table width="100" border="0" align="center" cellpadding="3"
										cellspacing="3">
										<tr>
											<td><input name="Submit" type="button"
												class="tMLAscreenHead" value="Print"
												onClick="SalesOrderPrint('<%=salesid%>')" /></td>
											<td><input name="Submit2" type="button"
												class="tMLAscreenHead" value="  Close  "
												onClick="redirect('Cash Sale.jsp')" /></td>
										</tr>
									</table>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">&nbsp;</td>
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
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</div>

</form>
<%@ include file="../footer.jsp"%>
<%
 }
 catch(Exception e)
 {
 }
%>
</body>
</html>
