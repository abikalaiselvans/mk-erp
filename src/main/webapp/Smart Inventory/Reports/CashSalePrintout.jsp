<%@ page language="java" import="java.sql.*,com.my.org.erp.common.*"%>
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
<form  AUTOCOMPLETE = "off"   action="" method="post" name="frm" id="frm">

<div align="center"><br />
<table width="80%" border="0" align="left" cellpadding="1"
	cellspacing="1">
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
							<td>
							<%
						sql = "SELECT CHR_TYPE,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY FROM inv_t_cashserialno WHERE CHR_SALESNO ='"
						+ salesid + "' ORDER By INT_ID";
						 
						String recdData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
						out.print(" <table width='100%'  border='0' cellpadding='2' cellspacing='2' >");
						out.print("<tr><td  width='200' class='boldEleven'><b>Type</b></td>");
						out.print("<td  width='200' class='boldEleven'><b>Item /P roduct</b></td>");
						out.print("<td  width='200' class='boldEleven'><b>Serial No</b></td>");
						out.print("<td  width='200' class='boldEleven'><b>Warranty</b></td></tr>");
						int row = 1;
						String iname1="";
						String itemname1="";
						for (int v = 0; v < recdData.length; v++) 
						{
							if(v%2==0)
								out.print("<tr class='MRow1'>");
							else
								out.print("<tr class='MRow2'>");
							
							if(recdData[v][0].equals("I"))
							{
								iname1="Item";
								sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+recdData[v][1]+"'";
								itemname1 = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
							}	
							if(recdData[v][0].equals("P"))
							{
						 		iname1="Product";
						 		sql= "SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+recdData[v][1]+"'";
						 		itemname1=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
							}	
							out.println("<td width='200'  class='boldEleven' >"+iname1+"</td>");
							out.println("<td width='200'class='boldEleven' >"+itemname1+"</td>");
							out.print("<td  width='200'class='boldEleven'>"+recdData[v][2]+"</td>");
							out.print("<td  width='200'class='boldEleven'>"+recdData[v][3]+"</td>");
						}
						out.print("</table> ");
						out.print("</div> ");
						
							%>
							</td>
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
									<td colspan="4" class="boldEleven">&nbsp;</td>
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
		<td>
		<div align="center"><a href="javascript:window.print()">Print</a>
		</p>
		</div>
		<p>&nbsp;</p>
		</td>
	</tr>
</table>
</div>
</form>
<%
 }
 catch(Exception e)
 {
 }
%>
</body>
</html>
