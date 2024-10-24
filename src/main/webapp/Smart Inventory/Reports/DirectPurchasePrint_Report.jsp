<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*,com.my.org.erp.common.*"%>
<%
	try
	{
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../../JavaScript/comfunction.js"></script>
<script language="javascript" src="../../JavaScript/calendar1.js"></script>
<script language="JavaScript"
	src="../../JavaScript/Inventory/InvenCustomerAJAX.js"></script>
</head>
<body >

<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm">
<div align="center"><br />
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2">
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
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
							<div align="center"><strong> Direct Purchase <%
		String salesid = request.getParameter("itemId");
		String sql ="select INT_COMPANYID,INT_BRANCHID,CHR_PURCHASEORDERNO,INT_VENDORID,DAT_ORDERDATE,INT_PAYMENTTERMID ";
		sql = sql +",CHR_DES,CHR_REF,DOU_AMOUNT,DOU_DISCOUNT,INT_TAXID,DOU_TAXAMOUNT,DOU_TOTALAMOUNT, ";
		sql = sql +" DOU_PAIDAMOUNT,CHR_PAYMENTSTATUS from inv_t_directpurchase WHERE CHR_PURCHASEORDERNO ='"+salesid+"'";
		String branchid = session.getAttribute("BRANCHID").toString();
		String cashdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		String companyId=cashdata[0][0]; 
		String branchId=cashdata[0][1]; 
	%> </strong></div>
							</td>
						</tr>
						<tr>
							<td>
							<table width="673" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="150" height="29" valign="middle" class="boldEleven">Company
									<font color="#ff0000">*</font></td>
									<td width='217' valign='top' class="boldEleven">
									<%
            String sqlCompany="select CHR_COMPANYNAME from com_m_company WHERE INT_COMPANYID="+companyId.trim();
			String query[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sqlCompany);
			out.println(query[0][0]);           	
           %> <input name="company" type="hidden" id="company"
										value="<%=companyId.trim()%>"></td>
									<td width="150" height="29" valign="middle" class="boldEleven">Branch
									<font color="#ff0000">*</font></td>
									<td width='217' valign='top' class="boldEleven">
									<%
			 
            String sql1="select CHR_BRANCHNAME from com_m_branch where int_companyid="+Integer.parseInt(companyId);            sql1 = sql1 + " AND INT_BRANCHID = " +branchId.trim();
            String query1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql1);
            out.println(query1[0][0]);                    
                        	
           %> <input name="branch" type="hidden" id="branch"
										value="<%=branchId.trim()%>"></td>
								</tr>
								<tr>
									<td width="123" class="boldEleven">
									<div align="left">Direct Purchase No.</div>
									</td>
									<td width="229" class="boldEleven">
									<div align="left"><%=cashdata[0][2]%> <input
										type="hidden" name="cashSaleNo" value="<%=cashdata[0][2]%>">
									</div>
									</td>
									<td width="107" class="boldEleven">PurchaseDate</td>
									<td width="201" class="boldEleven"><%=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(cashdata[0][4])%></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">CustomerName</div>
									</td>
									<td class="boldEleven"><%=cashdata[0][3]%><input
										name="custid" type="hidden" id="custid"
										value="<%=cashdata[0][3]%>"></td>
									<td class="boldEleven">Payment Terms</td>
									<td class="boldEleven">
									<%
			
			String paymentids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms");
			String pid = cashdata[0][5].trim();			
			for(int u=0; u<paymentids.length; u++)
			{
				if(pid.equals(paymentids[u][0]))
					out.print(""+paymentids[u][1]+"");
					
			}	
			%>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">Customer Address</td>
									<td class="boldEleven"><%=cashdata[0][7]%></td>
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
									<td height="23" class="boldEleven"><b>Type</b></td>
									<td height="23" class="boldEleven"><b>Item</b></td>
									<td class="boldEleven"><b>Description</b></td>
									<td class="boldEleven"><b>Quantity</b></td>
									<td class="boldEleven"><b>Unit Price</b></td>
									<td class="boldEleven"><b>Discount(%)</b></td>
									<td class="boldEleven"><b>Unit Discount</b></td>
									<td class="boldEleven"><b>Total</b></td>
									<%
		 sql ="SELECT CHR_PURCHASEORDERNO,CHR_ITEMID,CHR_TYPE,CHR_DESC,INT_QUANTITY,DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL FROM inv_t_directpurchaseitem WHERE CHR_PURCHASEORDERNO='"+salesid+"'";
		
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
		int lens = itemDatas.length;
		String iname="";
		String itemname="";
		String stock="";
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
			
			vf1 = "onKeyPress=\"numericValue('"+i1+"','3')\"";
			vf2 = "onKeyPress=\"numericValue('"+i2+"','5')\"";
			vf3 = "onKeyPress=\"numericValue('"+i3+"','3')\"";
			vf4 = "onKeyPress=\"numericValue('"+i4+"','5')\"";
			vf5 = "onKeyPress=\"numericValue('"+i5+"','10')\"";
			out.print("<tr>");
			
			if(itemDatas[u][2].equals("I"))
			{
				iname="Item";
				sql = "SELECT CHR_ITEMNAME ,INT_STOCKINHAND FROM inv_m_item WHERE CHR_ITEMID='"+itemDatas[u][1]+"'";
				itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
				sql ="SELECT INT_STOCKINHAND FROM inv_t_stock WHERE CHR_ITEMID  = '"+itemDatas[u][1]+"' AND CHR_TYPE='I' AND INT_BRANCHID="+branchid;					
				 
				stock = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "INT_STOCKINHAND");
			}	
			if(itemDatas[u][2].equals("P"))
			{
			  iname="Product";
			  sql= "SELECT CHR_PRODUCTCODE ,INT_STOCKINHAND FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+itemDatas[u][1]+"'";
			  itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
			  sql ="SELECT INT_STOCKINHAND FROM inv_t_stock WHERE CHR_ITEMID  = '"+itemDatas[u][1]+"' AND CHR_TYPE='P' AND INT_BRANCHID="+branchid;	
			  //out.println(sql);		
			  stock = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "INT_STOCKINHAND");
			}	
			out.println(" <td   class='boldEleven' >"+iname+"</td>");
			out.println("<td  class='boldEleven' >"+itemname);
				
			
			out.print("<input  type='hidden'  name='"+i6+"' id='"+i6+"' value ='"+itemDatas[u][1]+"'/>");
			out.print("<input  type='hidden'  name='"+i9+"' id='"+i9+"' value ='"+itemDatas[u][2]+"'/>");
			
			out.print("<td  class='boldEleven'>"+itemDatas[u][3]);
			out.print("<input  type='hidden'  name='"+i7+"' id='"+i7+"' value ='"+itemDatas[u][3]+"'/>");
			 
			out.print("<input  type='hidden'  name='"+i0+"' id='"+i0+"' value ='"+stock+"'/>");
            out.print("<input  type='hidden'  name='"+i8+"' id='"+i8+"' value ='"+itemDatas[u][4]+"'/>");
            out.print("<td  class='boldEleven'>"+itemDatas[u][4]+"</td>");
            out.print("<td  class='boldEleven'>"+itemDatas[u][5]+"</td>");
            out.print("<td  class='boldEleven'>"+itemDatas[u][6]+"</td>");
            out.print("<td  class='boldEleven'>"+itemDatas[u][7]+"</td>");
            out.print("<td  class='boldEleven'>"+itemDatas[u][8]+"</td>");
				
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
									<div align="left"><%=cashdata[0][6]%></div>
									</td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left">Total</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">

									<div align="left"><%=cashdata[0][8]%></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Total Discount (%)</div>
									</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1">
									<div align="left"><%=cashdata[0][9]%></div>
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
		String tid =  cashdata[0][10];
		for(int u=0; u<taxids.length; u++)
		{
			if(tid.trim().equals(taxids[u][0]))
				out.print(""+taxids[u][1]+"");
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
									<div align="left">
									<%
  String taxs[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select DOU_VALUE from inv_m_tax WHERE INT_TAXID ="+tid);
  %> <%=taxs[0][0]%></div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Reference <input name="filename"
										type="hidden" value="DirectPurchase" /> <input name="actionS"
										type="hidden" value="INVDirectPurchaseUpdate" /> <input
										name="param" type="hidden" id="param" value='<%=lens%>'>
									</div>
									</td>
									<td class="boldEleven">
									<div align="left"><%=cashdata[0][7]%></div>
									</td>
									<td class="boldEleven">
									<div align="left">Sales Tax Amount</div>
									</td>
									<td class="boldEleven" id="salestaxamount1">
									<div align="left"><%=cashdata[0][11]%></div>
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
									<div align="left"><%=cashdata[0][12]%></div>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<div align="Right"></div>
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
						src="../../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
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
		<td width="94%"><a href='javascript:window.print()'>
		<div align="center">PRINT</div></td>
		<td width="6%">&nbsp;</td>
	</tr>
	<tr>
		<td colspan="2">&nbsp;</td>
	</tr>
</table>
</div>
<script language="javascript">
			
			
			function calculateValues(qty)
			{
  					
  					var qtyposition = (qty.name.replace("qty",""));	
  					var quantity = qty.value;
					
					if(parseInt(quantity) >0)
					{
							var uprice = document.getElementById('uprice'+qtyposition).value;
							var discount =document.getElementById('discount'+qtyposition).value;
							var udiscount = document.getElementById('unitdiscount'+qtyposition).value;
							udiscount =(discount/100)*uprice;
							var total = ((quantity * uprice) - (udiscount*quantity));
							document.getElementById('total'+qtyposition).value = total;
							assignGrandTotal();
					}
					else
					{
							alert("Quantity is not zero ...");
							qty.value ="1";
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
			var s = "cashSaleNo,customername,customeraddress,saleDate,payment,";
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

<%
 }
 catch(Exception e)
 {
 }
%>
</body>
</html>
