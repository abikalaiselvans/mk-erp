<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*,com.my.org.erp.common.*" errorPage="../error/index.jsp"%>
<%
	try
	{
		String salesid = request.getParameter("itemId");
		String branchid = session.getAttribute("BRANCHID").toString();
		String sql ="select INT_COMPANYID,INT_BRANCHID,CHR_SALESNO,INT_CUSTOMERID,DAT_SALESDATE,INT_PAYMENTTERMID ";
		sql = sql +",CHR_DES,CHR_REF,DOU_AMOUNT,DOU_DISCOUNT,INT_TAXID,DOU_TAXAMOUNT,DOU_TOTALAMOUNT, ";
		sql = sql +" INT_SALESSTATUS,CHR_PAYMENTSTATUS from inv_t_directsales WHERE CHR_SALESNO ='"+salesid+"'";
		String cashdata[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		String companyId=cashdata[0][0]; 
		String branchId=cashdata[0][1]; 
		String custId=cashdata[0][6]; 
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript"
	src="../JavaScript/Inventory/InvenCustomerAJAX.js"></script>
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
							<div align="center"><strong> Direct Sale Edit </strong></div>
							</td>
						</tr>


						<tr>
							<td>
							<table width="673" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>


									<td width="150" class="boldEleven">
									<div align="left">Direct Sale No.</div>
									</td>
									<td width="229" class="boldEleven">
									<div align="left"><%=cashdata[0][2]%> <input
										type="hidden" name="cashSaleNo" value="<%=cashdata[0][2]%>">
									</div>
									</td>
									<td width="150" class="boldEleven">Sale Date</td>
									<td width="217" class="boldEleven"><input tabindex="2"
										name="saleDate" type="text"
										value="<%=com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(cashdata[0][4])%>"
										class="formText135" id="saleDate" size="15"
										readonly="readonly" /> <a href="javascript:cal2.popup();">
									<img src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" /> </a> <script language='JavaScript'
										type="text/javascript">
		<!--			
				var cal2 = new calendar1(document.forms['frm'].elements['saleDate']);
				cal2.year_scroll = true;
				cal2.time_comp = false;
				//setCurrentDate('saleDate'); 
		//-->
                          </script></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">CustomerName</div>
									</td>
									<td class="boldEleven">
									<%
						sql = " SELECT CHR_CUSTOMERNAME ,CHR_CUSTOMERNAME,CHR_ADDRESS1,CHR_ADDRESS2,CHR_ADDRESS3 FROM inv_m_customerinfo WHERE INT_CUSTOMERID="+Integer.parseInt(cashdata[0][3]); 
						 
						String vendor[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						 
						
						out.println(vendor[0][0]+",<br>");
						if(!"-".equals(vendor[0][1]))
							out.println(vendor[0][1]+",<br>");
						if(!"-".equals(vendor[0][2]))	
							out.println(vendor[0][2]+",<br>");
						if(!"-".equals(vendor[0][3]))
							out.println(vendor[0][3]+".");
						
						%>
									</td>
									<td class="boldEleven">Payment Terms</td>
									<td class="boldEleven"><select name="payment"
										class="formText135" id="payment" tabindex="3">
										<option>Select</option>
										<%
				String paymentids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_PAYMENTTERMID,CHR_PAYMENTNAME from inv_m_paymentterms");
				String pid = cashdata[0][5].trim();			
				for(int u=0; u<paymentids.length; u++)
				{
					if(pid.equals(paymentids[u][0]))
						out.print("<option selected='selected' value='"+paymentids[u][0]+"'>"+paymentids[u][1]+"</option>");
					else
						out.print("<option value='"+paymentids[u][0]+"'>"+paymentids[u][1]+"</option>");							
				}	
			%>
									</select></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">&nbsp;</td>
									<td class="boldEleven">&nbsp;</td>
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
									<td class="boldEleven"><b><strong>Stock in
									hand </strong></td>
									<td class="boldEleven"><b>Quantity</b></td>
									<td class="boldEleven"><b>Unit Price</b></td>
									<td class="boldEleven"><b>Discount(%)</b></td>
									<td class="boldEleven"><b>Unit Discount</b></td>
									<td class="boldEleven"><b>Total</b></td>
									<%
		 sql ="SELECT CHR_SALESNO,CHR_ITEMID,CHR_TYPE,CHR_DESC,INT_QUANTITY,DOU_UNITPRICE,DOU_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL FROM inv_t_directsalesitem WHERE CHR_SALESNO='"+salesid+"'";
		 
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
			vf2 = "onKeyPress=\"numericValue('"+i2+"','9')\"";
			vf3 = "onKeyPress=\"numericValue('"+i3+"','5')\"";
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
			  stock = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "INT_STOCKINHAND");
			}	
			out.println(" <td   class='boldEleven' >"+iname+"</td>");
			out.println("<td  class='boldEleven' >"+itemname);
				
			
			out.print("<input  type='hidden'  name='"+i6+"' id='"+i6+"' value ='"+itemDatas[u][1]+"'/>");
			out.print("<input  type='hidden'  name='"+i9+"' id='"+i9+"' value ='"+itemDatas[u][2]+"'/>");
			
			out.print("<td  class='boldEleven'>"+itemDatas[u][3]);
			out.print("<input  type='hidden'  name='"+i7+"' id='"+i7+"' value ='"+itemDatas[u][3]+"'/>");
			out.print("<td  class='boldEleven'>"+stock);
			out.print("<input  type='hidden'  name='"+i0+"' id='"+i0+"' value ='"+stock+"'/>");
            out.print("<input  type='hidden'  name='"+i8+"' id='"+i8+"' value ='"+itemDatas[u][4]+"'/>");
            out.print("<td  class='boldEleven'><input class='formText135' type='text' size ='10' name='"+i1+"' id='"+i1+"' value ='"+itemDatas[u][4]+"' "+vf1+" onblur='calculateValues(this)'></td>");
            out.print("<td  class='boldEleven'><input class='formText135' type=text size =10 name='"+i2+"' id='"+i2+"' value ='"+itemDatas[u][5]+"' "+vf2+" readonly='readonly' ></td>");
            out.print("<td  class='boldEleven'><input class='formText135' type=text size =10 name='"+i3+"' id='"+i3+"' value ='"+itemDatas[u][6]+"' "+vf3+" readonly='readonly' ></td>");
            out.print("<td  class='boldEleven'><input class='formText135' type=text size =10 name='"+i4+"' id='"+i4+"' value ='"+itemDatas[u][7]+"' "+vf4+" readonly='readonly' ></td>");
            out.print("<td  class='boldEleven'><input class='formText135'type=text size =10 name='"+i5+"' id='"+i5+"' value ='"+itemDatas[u][8]+"' "+vf5+" readonly='readonly' ></td>");
				
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
									<div align="left"><textarea name="memo" cols="25"
										rows="5" class="formText135" id="memo" tabindex="9"><%=cashdata[0][6]%></textarea>
									</div>
									</td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left">Total</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">

									<div align="left"><input tabindex="11" name="totals"
										onKeyPress="numericValue('totals','12')" type="text"
										class="formText135" id="totals" readonly="readonly"
										value="<%=cashdata[0][8]%>" /></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Total Discount (%)</div>
									</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1">
									<div align="left"><input tabindex="12"
										name="totaldiscount" type="text" class="formText135"
										id="totaldiscount" onblur="assignGrandTotal()"
										value="<%=cashdata[0][9]%>"></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Tax Group</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="tax1">
									<div align="left"><select name="tax" class="formText135"
										id="tax1" onChange="assignTotals(this)" tabindex="13">
										<option value="Select">Select</option>
										<%
	String taxids[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_TAXID,CHR_TAXNAME ,DOU_VALUE from inv_m_tax");
		String tid =  cashdata[0][10];
		for(int u=0; u<taxids.length; u++)
		{
			if(tid.trim().equals(taxids[u][0]))
				out.print("<option selected='selected' value='"+taxids[u][0]+"'>"+taxids[u][1]+"</option>");
			else
				out.print("<option selected='selected' value='"+taxids[u][0]+"'>"+taxids[u][1]+"</option>");
		}		
	%>
									</select></div>
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
  %> <input value="<%=taxs[0][0]%>" name="salestax" type="text"
										class="formText135" id="salestax" readonly="readonly"
										tabindex="14" /></div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Reference <input name="filename"
										type="hidden" value="DirectSale" /> <input name="actionS"
										type="hidden" value="INVDirectSaleUpdate" /> <input
										name="param" type="hidden" id="param" value='<%=lens%>'>
									</div>
									</td>
									<td class="boldEleven">
									<div align="left"><input name="ref" type="text"
										class="formText135" id="ref" size="25" maxlength="50"
										tabindex="10" value="<%=cashdata[0][7]%>" /></div>
									</td>
									<td class="boldEleven">
									<div align="left">Sales Tax Amount</div>
									</td>
									<td class="boldEleven" id="salestaxamount1">
									<div align="left"><input name="salestaxamount"
										value="<%=cashdata[0][11]%>" type="text" class="formText135"
										id="salestaxamount" readonly="readonly" tabindex="14" /></div>
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
									<div align="left"><input name="nettotal" type="text"
										class="formText135" id="nettotal" tabindex="15"
										value="<%=cashdata[0][12]%>" /></div>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<div align="center"><input name="Submit" type="submit"
										class="tMLAscreenHead" value="Update" onClick="return valid()" />
									&nbsp;&nbsp; <input name="Submit2" type="button"
										class="tMLAscreenHead" value="  Close  "
										onClick="redirect('Direct Sale.jsp')" /></div>
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
		//loadCustomer();
 </script></form>
<%@ include file="../footer.jsp"%>
<%
 }
 catch(Exception e)
 {
 }
%>
</body>
</html>
