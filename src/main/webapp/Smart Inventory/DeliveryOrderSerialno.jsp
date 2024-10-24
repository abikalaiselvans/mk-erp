<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<%@ page import="com.my.org.erp.common.CommonFunction"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>:: INVENTORY ::</title><%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<%
try
	{
%>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<style type="text/css">
<!--
.style3 {font-weight: bold}
-->
</style>
<script language="JavaScript" src="../JavaScript/AJAX.js"></script>

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
	String sql="";
	String Saleno=request.getParameter("saleno");
	String Dcno=request.getParameter("dcnumber");
	String dcnumber = request.getParameter("dcnumber");
	String deldate = request.getParameter("delDate");
	deldate = com.my.org.erp.ServiceLogin.DateUtil.FormateDateSQL(deldate);
	String saleno = request.getParameter("salno");
	String dcparam = request.getParameter("dcparam");
	
	sql=" SELECT a.CHR_QUOTATIONNO,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.CHR_CUSTPURCHASENO,a.CHR_SALESORDERNO,a.CHR_SALEBY,a.DAT_SALEDATE,";
	sql = sql +" a.CHR_DELIVERYSTATUS,a.CHR_BILLINGADDRESS,a.CHR_SHIPINGADDRESS,a.INT_ONHOLD,";
	sql = sql +" a.INT_CONDITIONID,a.INT_PAYMENTTERMID,a.CHR_DES,a.CHR_REF,a.INT_TAXID,a.DOU_AMOUNT,a.DOU_DISCOUNT,";
	sql = sql +" a.DOU_TAXAMOUNT,a.DOU_TOTALAMOUNT,a.CHR_PAYMENTSTATUS from  inv_t_customersalesorder   a ,inv_m_customerinfo b ";
	sql = sql +" where a.CHR_SALESORDERNO='"+Saleno+"' AND a.INT_CUSTOMERID =b.INT_CUSTOMERID order by a.DAT_SALEDATE";
	String SalenoInfo[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
 
%>
<body >
<%@ include file="indexinv.jsp"%>
<%//onsubmit="return validateValues()"%>
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
									<div align="left"><strong> Quotaion Ref No </strong></div>
									</td>
									<td width="229" class="boldEleven">
									<div align="left"><%=SalenoInfo[0][0] %> <input
										name="salno" type="hidden" id="salno" value="<%=Saleno%>">
									</div>
									</td>
									<td width="107" class="boldEleven">
									<div align="left"><strong>On Hold </strong></div>
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
									<div align="left"><strong>Customer Id / Name</strong></div>
									</td>
									<td class="boldEleven"><%=SalenoInfo[0][1] %></td>
									<td class="boldEleven"><strong>Billing To </strong></td>
									<td class="boldEleven">
									<div align="left">
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
									<td class="boldEleven"><strong>Cust Purchase No </strong></td>
									<td class="boldEleven"><%=SalenoInfo[0][2] %></td>
									<td class="boldEleven"><strong>Shipping To </strong></td>
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
									<td class="boldEleven"><strong>Sale Order No </strong></td>
									<td class="boldEleven"><%=SalenoInfo[0][3] %></td>
									<td class="boldEleven"><strong>Payment Terms</strong></td>
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
									<div align="left"><strong>Sale By </strong></div>
									</td>
									<td class="boldEleven"><%=SalenoInfo[0][4] %></td>
									<td class="boldEleven"><strong>Delivery No </strong></td>
									<td class="boldEleven"><%=request.getParameter("dcnumber")%></td>
								</tr>
								<tr>
									<td height="22" class="boldEleven">
									<div align="left"><strong>Sale Date </strong></div>
									</td>
									<td class="boldEleven"><%=SalenoInfo[0][5] %></td>
									<td class="boldEleven"><strong>Delivery Date </strong></td>
									<td class="boldEleven"><%=request.getParameter("delDate")%></td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td>
							<%
					  
					sql = " select CHR_TYPE,CHR_ITEMID, count(*) from  inv_t_customersalesorderitemserial ";
					sql = sql + " WHERE CHR_SALESORDERNO = '"+Saleno+"'  ";
					sql = sql + " AND CHR_DELIVERYNO ='"+dcnumber+"' group by CHR_TYPE ";
					
					String saledata[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
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
						out.println("<tr><td   class='boldEleven' >"+iname+  "</td>");
						out.println("<td  class='boldEleven' align='right'>"+itemname+"</td>");
						
						
						sql = " select count(*) from  inv_t_customersalesorderitemserial  ";
						sql = sql +" WHERE CHR_SALESORDERNO = '"+Saleno+"'  AND  CHR_ITEMID = '"+saledata[u][1]+"' ";
						int Ordqty = com.my.org.erp.common.CommonFunction.intRecordCount(sql);
						

						out.println("<td  class='boldEleven' align='right'>"+Ordqty+"</td>");
						out.println("<td  class='boldEleven' align='right'>"+saledata[0][2]+"</td>");
						
						 
					}	
					out.println("</table>");
					
						%>
							</td>
						</tr>
						<tr>
							<td height="20">&nbsp;</td>
						</tr>
						<tr>
							<td height="20">
							<div align="center" id="error" class="bolddeepred"></div>
							</td>
						</tr>
						<tr>
							<td>
							<%
						sql = " select CHR_TYPE,CHR_ITEMID,CHR_SERIALNO,CHR_WARRANTY ,INT_ID from  inv_t_customersalesorderitemserial  WHERE CHR_SALESORDERNO = '"+Saleno+"'  AND CHR_DELIVERYNO ='"+dcnumber+"' order by CHR_ITEMID ";
						String serialdata[][] = com.my.org.erp.common.CommonInfo.RecordSetArray(sql);
						String serial ="serial";
						String warranty="warranty";
						String rowid="rowid";
						out.print("<div id='divscroll' style='OVERFLOW:auto;width:100%;height:200px'  >");
						out.print("<table border=0 cellspacing=3 cellpadding=3 width='100%'>");
						out.println("<tr><td   class='boldEleven'><b>Type</b></td>");
						out.println("<td   class='boldEleven'><b>Item / Product</b></td>");
						out.println("<td   class='boldEleven'><b>Serial Number</b></td>");
						out.println("<td   class='boldEleven'><b>Warranty</b></td>");
						String h="";
						String h1="";
						for(int u=0; u<serialdata.length;u++)
						{
							h="";h1="";
							
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
							out.println("<td   class='boldEleven' >"+iname+"</td>");
							out.println("<td class='boldEleven' >"+itemname);
							out.println("<input name='"+rowid+(u+1)+"'  type='hidden'  value='"+serialdata[u][4]+"'>");
							
h="onBlur=\"getValues('serial','"+serialdata.length+"' ,'error' , 'Submit')\"";
//h1=" onkeyup=\"LoadUniqueCheckSale('serial"+(u+1)+"','Valid"+(u+1)+"' , 'inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit')\" ";

h1=" onKeyUp=\"upperMe(this),LoadUniqueCheckSales('serial"+(u+1)+"','Valid"+(u+1)+"' , 'inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit','"+serialdata[u][0]+"','"+serialdata[u][1]+"')\" ";


							out.println("<td class='boldEleven' ><input name='"+serial+(u+1)+"'  type='text' class='formText135'  size=10  "+h+"  " +h1+"/><div id='Valid"+(u+1)+"'> </div></td>");
							out.println("<td class='boldEleven' > <div id='Warranty"+(u+1)+"'></DIV></td>");
							
						}
						out.print("</table>");
						out.print("</div>");
						out.print("<input name='serialparam' type='hidden' value='"+serialdata.length+"'>");
						

					  %>
							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td><input type="hidden" name="dcnumber"
								value='<%=dcnumber%>'> <input type="hidden"
								name="delDate" value='<%=deldate%>'> <input
								type="hidden" name="salno" value='<%=saleno%>'> <input
								type="hidden" name="dcparam" value='<%=dcparam%>'> <%
						//onblur='CheckSerialNo(this)' onKeyUp='CheckSerial1(this)'
						
						
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
									<td width="114" rowspan="4" valign="top" class="boldEleven">&nbsp;
									</td>
									<td width="197" rowspan="4" valign="top" class="boldEleven">
									<div align="left"></div>
									</td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left"><strong>Total</strong></div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">
									<div align="right"><%=SalenoInfo[0][15] %></div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left"><strong>Total Discount </strong></div>
									</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1">
									<div align="right"><%=SalenoInfo[0][16] %></div>
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
									<td class="boldEleven"><%=SalenoInfo[0][13] %></td>
									<td class="boldEleven">
									<div align="left"><strong>Sales Tax Amount </strong></div>
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
									<div align="left" class="style3">
									<div align="left">Net Total</div>
									</div>
									</td>
									<td width="169" class="boldEleven" id="nettotal1">
									<div align="right"><%=SalenoInfo[0][18] %></div>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<hr width="100%" />
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven"><strong>Description
									:: </strong></td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<div align="justify"><%=SalenoInfo[0][12] %></div>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<table width="100" border="0" align="center" cellpadding="3"
										cellspacing="3">
										<tr>
											<td><input name="Submit" id="Submit" type="submit"
												class="tMLAscreenHead" value="Delivery" /></td>
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
<%
 }
 catch(Exception e)
 {
 }
 %>

</body>
</html>

