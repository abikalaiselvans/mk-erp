<%@ page language="java" import="java.sql.*,com.my.org.erp.common.*"
	errorPage="../error/index.jsp"%>


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
  		var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		var f ="CashSalePrintout.jsp?itemId="+query;
		newWindow = window.open(f,"subWind",styleStr);
		newWindow.focus( );
	}
	
</script>
</head>
<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm">
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
						String sql = "select  CHR_SALESNO,DAT_SALESDATE,INT_PAYMENTTERMID,INT_CUSTOMERID,CHR_DES,";
						sql = sql +" CHR_REF,DOU_AMOUNT,DOU_DISCOUNT,INT_TAXID,DOU_TAXAMOUNT,DOU_TOTALAMOUNT,INT_SALESSTATUS,";
						sql = sql +" CHR_PAYMENTSTATUS from inv_t_cashsales WHERE CHR_SALESNO ='"+salesid+"'";
						String cashdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						// out.print("select * from inv_t_cashsales WHERE CHR_SALESNO ='"+salesid+"'");
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
									<div align="left"><%=cashdata[0][0]%> <input
										type="hidden" name="cashSaleNo" value="<%=cashdata[0][0]%>">
									</div>
									</td>
									<td width="107" class="boldEleven">Sale Date</td>
									<td width="201" class="boldEleven"><%=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(cashdata[0][1])%>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">CustomerName</div>
									</td>
									<td class="boldEleven">
									<%
							String customerid =cashdata[0][3];
							sql = " SELECT CHR_CUSTOMERNAME,CHR_ADDRESS1,CHR_ADDRESS2,CHR_ADDRESS3,INT_PINCODE FROM inv_m_customerinfo WHERE INT_CUSTOMERID ="+customerid;
							String custdatas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							out.print( custdatas[0][0]);
						%>
									</td>
									<td class="boldEleven">Payment Terms</td>
									<td class="boldEleven">
									<%
			
			String paymentids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms");
			String pid = cashdata[0][2].trim();
			
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
									<td class="boldEleven"><%=custdatas[0][0]%></td>
									<td class="boldEleven">&nbsp;</td>
									<td class="boldEleven">&nbsp;</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<table width="100%" border="1" cellpadding="1" cellspacing="1">
								<tr>
									<td class="boldEleven"><b>Type</b></td>
									<td class="boldEleven"><b>Item / Product</b></td>
									<td class="boldEleven"><b>Description</b></td>

									<td class="boldEleven"><b>Quantity</b>
									<td class="boldEleven"><b>Unit Price</b>
									<td class="boldEleven"><b>Discount(%)</b>
									<td class="boldEleven"><b>Unit Discount</b>
									<td class="boldEleven"><b>Total</b>
								</tr>
								<%
		sql ="SELECT CHR_ITEMID,CHR_TYPE,CHR_DESC,INT_QUANTITY,DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL FROM inv_t_cashsalesitem WHERE CHR_SALESNO='"+salesid+"'";
		
		String itemDatas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		String i0,i1,i2,i3,i4,i5,i6,i7,i8,i9,vf1,vf2,vf3,vf4,vf5;
		i0="stock";
		i1 ="qty";
		i2 ="uprice";
		i3 ="discount";
		i4 ="unitdiscount";
		i5 ="total";
		i6="item";
		i7="desc";
		i8="pstock";
		i9="itype";
		String iname="";
		String itemname="";
		int lens = itemDatas.length;
		String stockinhand="";
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
			i9 ="itype"+(u+1);
			vf1 = "onKeyPress=\"numericValue('"+i1+"','5')\"";
			vf2 = "onKeyPress=\"numericValue('"+i2+"','5')\"";
			vf3 = "onKeyPress=\"numericValue('"+i3+"','5')\"";
			vf4 = "onKeyPress=\"numericValue('"+i4+"','5')\"";
			vf5 = "onKeyPress=\"numericValue('"+i5+"','10')\"";
			if(itemDatas[u][1].equals("I")  )
			{
				iname="Item";
				sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+itemDatas[u][0]+"'";
				itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
				sql = "SELECT INT_STOCKINHAND FROM inv_t_stock WHERE CHR_TYPE='I' AND  CHR_ITEMID='"+itemDatas[u][0]+"'";
				String stockdata[][] =CommonInfo.RecordSetArray(sql);
				stockinhand =stockdata[0][0];
				
			}	
			if(itemDatas[u][1].equals("P")  )
			{
			  iname="Product";
			  sql= "SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+itemDatas[u][0]+"'";
			  itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
			  sql = "SELECT  INT_STOCKINHAND FROM inv_t_stock WHERE  CHR_TYPE='P' AND   CHR_ITEMID='"+itemDatas[u][0]+"'";
			  String stockdata[][] =CommonInfo.RecordSetArray(sql);
			  stockinhand =stockdata[0][0];
			}	
			out.println("<tr><td   class='boldEleven' >"+iname+"</td>");
			out.println("<td  class='boldEleven' >"+itemname+"</td>");
			out.println("<td  class='boldEleven' >"+itemDatas[u][2]+"</td>");
			out.print("<td  class='boldEleven'>"+itemDatas[u][3]+" </td>");
            out.print("<td  class='boldEleven'>"+itemDatas[u][4]+"</td>");
			out.print("<td  class='boldEleven'>"+itemDatas[u][5]+"</td>");
			out.print("<td  class='boldEleven'>"+itemDatas[u][6]+"</td>");
			out.print("<td  class='boldEleven'>"+itemDatas[u][7]+"</td>");
			
            
			
			
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
									<div align="left"><%=cashdata[0][4]%></div>
									</td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left">Total</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">
									<div align="right"><%=cashdata[0][6]%></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Total Discount (%)</div>
									</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1">
									<div align="right"><%=cashdata[0][7]%></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Tax Group</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="tax1">

									<div align="left">
									<%
	String taxids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME ,DOU_VALUE from inv_m_tax");
		String tid =  cashdata[0][8];
		for(int u=0; u<taxids.length; u++)
		{
			if(tid.trim().equals(taxids[u][0]))
				out.print( taxids[u][1] );
			 
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
									<div align="right">
									<%
  sql="Select DOU_VALUE from inv_m_tax WHERE INT_TAXID ="+tid;
  //System.out.println("TESTCASH :"+sql);
  String taxs[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
  out.print(taxs[0][0]);
  %>
									</div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Reference <input name="filename"
										type="hidden" value="CashSale" /> <input name="actionS"
										type="hidden" value="INVCashSaleUpdate" /> <input
										name="param" type="hidden" id="param" value='<%=lens%>'>
									</div>
									</td>
									<td class="boldEleven">
									<div align="left"><%=cashdata[0][5]%></div>
									</td>
									<td class="boldEleven">
									<div align="left">Sales Tax Amount</div>
									</td>
									<td width="169" class="boldEleven" id="salestaxamount1">
									<div align="right"><%=cashdata[0][9]%></div>
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
									<td width="169" class="boldEleven" id="nettotal1">
									<div align="right"><%=cashdata[0][10]%></div>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<table border="0" align="center" cellpadding="0"
										cellspacing="0">
										<tr>
											<td width="56"><input name="Submit" type="button"
												class="tMLAscreenHead" value="Print"
												onClick="javascript:SalesOrderPrint('<%=salesid%>')" /></td>

											<td width="56"><input name="Submit2" type="button"
												class="tMLAscreenHead" value="  Close  "
												onClick="redirect('Cash Sale.jsp')" /></td>
										</tr>
									</table>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<div align="center">&nbsp;&nbsp;</div>
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
<script language="javascript">
			function calculateValues(qty)
			{
  					
  					var qtyposition = (qty.name.replace("qty",""));	
  					var quantity = qty.value;
					var stockqty = parseInt(document.getElementById('stock'+qtyposition).value);
					if(parseInt(quantity) >0)
					{
						if(stockqty < parseInt(quantity))
						{
							alert("Stock not available ...");
							qty.value = document.getElementById('pstock'+qtyposition).value;
							qty.focus();
						}	
						else
						{	
							var uprice = document.getElementById('uprice'+qtyposition).value;
							var discount =document.getElementById('discount'+qtyposition).value;
							var udiscount = document.getElementById('unitdiscount'+qtyposition).value;
							udiscount =(discount/100)*uprice;
							var total = ((quantity * uprice) - (udiscount*quantity));
							document.getElementById('total'+qtyposition).value = total;
							assignGrandTotal();
						}	
				}
				else
				{
							alert("Stock not available ...");
							qty.value = document.getElementById('pstock'+qtyposition).value;
							qty.focus();
				
				}		
			}
			function assignGrandTotal()
			{
				var noofcontrols = "<%=itemDatas.length%>";
				var tvs =0.0;
				var svalue="";
   				for(u=1; u<=noofcontrols;u++)
					tvs= tvs+parseFloat(document.getElementById('total'+u).value);
				document.getElementById("totals").value=tvs;
							
				var tot = parseFloat(document.getElementById("totals").value);
				var discount = parseFloat(document.getElementById("totaldiscount").value);
				var discountamount=0.0;
				if(discount>0)
					discountamount= (discount/100)*tot;
				else
					discountamount	=0.0;
				var salestax = parseFloat(document.getElementById("salestax").value);
				var salestaxamount = parseFloat((salestax/100)*tot);
				document.getElementById("salestaxamount").value = salestaxamount;
				var grandtotal = (tot+salestaxamount);
				document.getElementById("nettotal").value=(grandtotal-discountamount);
			 
			}
			
			<%
			String scrpttaxid[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME,DOU_VALUE from inv_m_tax");
			String tvalue="";
			for(int x=0; x<scrpttaxid.length;x++)
			{	
				for(int y=0; y<3;y++)
					tvalue = tvalue+scrpttaxid[x][y]+",";
			
				tvalue = tvalue+"~";	
			}
			%>
			var taxvalue1 = "<%=tvalue%>".split("~");
			function assignTotals(taxs)
			{
				var taxid = taxs.value;
				var nettotal=0.0;
				for(i=0; i<taxvalue1.length-1; i++)
 				{
   					var rowvalue = taxvalue1[i].split(",")
   					if(rowvalue[0]=== taxid)
						document.getElementById("salestax").value = rowvalue[2];
				}
				assignGrandTotal();
   			}
			
			
		function valid()
		{
   				
			var svalue="";
			for(u=1; u<="<%=lens%>";u++)
				svalue =svalue+"qty"+u+","+"uprice"+u+","+"discount"+u+","+"unitdiscount"+u+","+"total"+u+",";
			var s = "cashSaleNo,customerId,saleDate,payment,";
					s = s+svalue+"memo,ref,totals,totaldiscount,tax,salestax,salestaxamount,nettotal,";
			var v = s.split(",");
			for( i=0; i<v.length-1; i++)
			{
				var ck = "Data not found ..."+v[i];
				if(checkNull(v[i],ck))
					d=1;
				else
					return false;	
			}
		}
 </script></form>
<%@ include file="../footer.jsp"%>

</body>
</html>
