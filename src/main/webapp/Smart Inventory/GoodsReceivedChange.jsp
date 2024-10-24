<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<body >
<%@ include file="indexinv.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
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
					<%	
		   	try
			{
		   		String goodsRecNo=request.getParameter("gdreceiveno");
			  	String purchaseno=request.getParameter("purchaseno");
			  	String delivaryNo = request.getParameter("delivaryNo");
				String invoiceNo = request.getParameter("invoiceNo");
				String sql = "SELECT * FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
				boolean flag = false;
				flag = com.my.org.erp.common.CommonInfo.RecordExist(sql);
				if(flag)
				{
				String purchaseData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
		  %>
					<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm">
					<table width="663" border="0" align="center" cellpadding="1"
						cellspacing="1">
						<tr>
							<td width="650"><input type="hidden" name="receivedNo"
								value="<%=goodsRecNo %>"></td>
						</tr>
						<tr>
							<td>
							<div align="center" class="copyright">GoodsReceived</div>
							</td>
						</tr>
						<tr>
							<td valign="bottom">
							<table width="668" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="123" class="boldEleven">
									<div align="left">Received Ref.No.</div>
									</td>
									<td width="198" class="boldEleven"><%=goodsRecNo %></td>
									<td width="102" class="boldEleven">
									<div align="left">Delivary No</div>
									</td>
									<td width="237" class="boldEleven"><input type="text"
										class="formText135" name="delivaryNo" value="<%=delivaryNo %>"></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Received Date</div>
									</td>
									<td class="boldEleven"><input name="receddt" type="text"
										class="formText135" id="receddt" tabindex="7" size="15"
										maxlength="11" readonly="readonly" /> <a
										href="javascript:cald.popup();"> <img
										src="../JavaScript/img/cal.gif" width="16" height="16"
										border="0" /> </a> <script language='JavaScript'
										type="text/javascript">
		<!--			
				var cald = new calendar1(document.forms['frm'].elements['receddt']);
				cald.year_scroll = true;
				cald.time_comp = false;
				setCurrentDate('receddt'); 
		//-->
                          </script></td>
									<td class="boldEleven">
									<div align="left">Invoice No</div>
									</td>
									<td class="boldEleven"><input type="text"
										class="formText135" name="invoiceNo" value="<%=invoiceNo %>"></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Purchase Order No</div>
									</td>
									<td class="boldEleven"><%=purchaseno%></td>
									<td class="boldEleven">
									<div align="left">Payment Mode</div>
									</td>
									<td class="boldEleven">
									<%
					sql = "SELECT INT_CONDITIONID FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					int paymentid =com.my.org.erp.common.CommonInfo.intGetAnySelectField(sql, "INT_CONDITIONID");
					sql = "SELECT CHR_PAYMENTNAME FROM inv_m_paymentterms WHERE INT_PAYMENTTERMID="+paymentid;
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PAYMENTNAME"));
					%>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Vendor</div>
									</td>
									<td class="boldEleven">
									<%
					sql = "SELECT INT_VENDORID FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					int vendorid =com.my.org.erp.common.CommonInfo.intGetAnySelectField(sql, "INT_VENDORID");
					sql = "SELECT CHR_VENDORNAME FROM  inv_m_vendorsinformation  WHERE INT_VENDORID="+vendorid;
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_VENDORNAME"));
					%>
									</td>
									<td class="boldEleven">
									<div align="left">Payment Terms</div>
									</td>
									<td class="boldEleven">
									<%
					sql = "SELECT INT_PAYMENTTERMID FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					int paymenttermid =com.my.org.erp.common.CommonInfo.intGetAnySelectField(sql, "INT_PAYMENTTERMID");
					sql = "SELECT CHR_PAYMENTNAME FROM inv_m_paymentcondition WHERE INT_PAYMENTCONDITIONID="+paymenttermid;
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PAYMENTNAME"));
					%>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">Order Date</td>
									<td class="boldEleven">
									<%
					sql = "SELECT DAT_ORDERDATE FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "DAT_ORDERDATE"));
					%>
									</td>
									<td class="boldEleven">Order From</td>
									<td class="boldEleven">
									<%
					sql = "SELECT INT_ADDRESSID1 FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					int orderid =com.my.org.erp.common.CommonInfo.intGetAnySelectField(sql, "INT_ADDRESSID1");
					sql = "SELECT CHR_BRANCHNAME FROM  com_m_branch  WHERE INT_BRANCHID="+orderid;
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_BRANCHNAME"));
					%>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Request Date</div>
									</td>
									<td class="boldEleven">
									<%
					sql = "SELECT DAT_REQUESTDATE FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "DAT_REQUESTDATE"));
					%>
									</td>
									<td class="boldEleven">Shipping To</td>
									<td class="boldEleven">
									<%
					sql = "SELECT INT_ADDRESSID2 FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					int shipid =com.my.org.erp.common.CommonInfo.intGetAnySelectField(sql, "INT_ADDRESSID2");
					sql = "SELECT CHR_BRANCHNAME FROM  com_m_branch  WHERE INT_BRANCHID="+shipid;
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_BRANCHNAME"));
					%>
									</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<%
			  	sql = " SELECT INT_ID,CHR_PURCHASEORDERNO,CHR_ITEMID, CHR_TYPE,CHR_DESC,INT_QUANTITY,DOU_UNITPRICE,CHR_DISCOUNT, ";
				sql = sql +" DOU_UNITDISCOUNT,DOU_TOTAL ,INT_RECIVEDQUANTITY,INT_REMAINQUANTITY FROM inv_t_vendorpurchaseorderitem";
				sql = sql +" WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
				
				String itemData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				out.print("<table  border='1' cellpadding='1' cellspacing='1' >");
				out.print("<th  class='boldEleven'><b>Type</b></th>");
				out.print("<th  class='boldEleven'><b>Item / Product</b></th>");
          		out.print("<th  class='boldEleven'><b>Description</b></th>");
                out.print("<th  class='boldEleven'><b>Order Qty</b></th>");
				out.print("<th  class='boldEleven'><b>Received Qty</b></th>");
				out.print("<th  class='boldEleven'><b>Balance Qty</b></th>");
                out.print("<th  class='boldEleven'><b>Unit Price</b></th>");
                out.print("<th  class='boldEleven'><b>Discount(%)</b></th>");
                out.print("<th  class='boldEleven'><b>Unit Discount</b></th>");
                out.print("<th  class='boldEleven'><b>Total</b></th>");
                String orderqty="";
                String receqty="";
                String idv="";
				String dcidv="";
                String qtyv="";
				String id="";
				String itemid="";
				String itype="";
				String dbreceived="";
                String receivedqty ="receivedqty";
				String chk="";
				String function1="";
				int totItem=0;
				for(int u=0; u<itemData.length;u++)
				{
					out.print("<tr>");
					if(itemData[u][3].equals("I"))
					{
						out.println("<td class='boldEleven' valign='top' >Item");
						sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+itemData[u][2]+"'";
						out.print("<td width='52' class='boldEleven'>&nbsp;"+com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME")+"</td>");
					}
						
					if(itemData[u][3].equals("P"))
					{
						out.println("<td class='boldEleven' valign='top' >Product");
						sql = "SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+itemData[u][2]+"'";
						out.print("<td width='52' class='boldEleven'>&nbsp;"+com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE")+"</td>");
					}	
					
					
					out.print("<td  valign='top' width='102' class='boldEleven'>&nbsp;"+itemData[u][4] +"</td>");
                	orderqty = orderqty+itemData[u][5]+"~";
                	receqty=receqty+(receivedqty+(u+1))+"~";
                	idv="receivedqty"+(u+1);
					dcidv="dcreceivedqty"+(u+1);
                	qtyv="qty"+(u+1);
					id = "rowid"+(u+1);
					itemid = "item"+(u+1);
					itype = "itype"+(u+1);
					dbreceived ="dbreceived"+(u+1);
					int r =Integer.parseInt(itemData[u][5])-Integer.parseInt(itemData[u][10]);
					totItem=totItem+r;
					out.print("<td  valign='top' width='83' class='boldEleven'>&nbsp;<input type='hidden' name='"+qtyv.trim()+"' id='"+qtyv.trim()+"' class='formText135' value='"+r+"'  >"+itemData[u][5]+"</td>");					
					
					//TOTAL RECEIVED QUANTITY itemData[u][10]
					out.print("<td  valign='top'>");
					sql = " select count(*) from inv_t_vendorgoodsreceived   WHERE CHR_PURCHASEORDERNO = '"+purchaseno+"' ";
					sql = sql +" and CHR_RECIVEDID='"+goodsRecNo+"' AND CHR_ITEMID ='"+itemData[u][2]+"' ";
					int recedqty = com.my.org.erp.common.CommonFunction.intRecordCount(sql);
					chk="onKeyPress=\"numericValue('"+dcidv+"',6)\"";
					function1 ="onblur=\"checkDCquantityChange('"+dcidv+"' , '"+(recedqty+r)+"','"+recedqty+"')\"";
					out.print("<input type='text' name='"+dcidv+"' id='"+dcidv.trim()+"' class='formText135' size=10 maxlength='6'   value='"+recedqty+"' style='text-align:right' "+function1+" " + chk+">");

					out.println("<input type='hidden' name='prev"+(u+1)+"' id='prev"+(u+1)+"' value='"+Integer.parseInt(itemData[u][10])+"' >");
					out.print("<td  valign='top' width='83' class='boldEleven'>"+r+"</td>");
	              	out.print("<td  valign='top' width='98' class='boldEleven'>&nbsp;"+itemData[u][6]);
					out.print("<td  valign='top' width='123' class='boldEleven'>&nbsp;"+itemData[u][7]+"</td>");
                	out.print("<td  valign='top' width='133' class='boldEleven'>&nbsp;"+itemData[u][8]+"");
					out.print("<input type='hidden' value='"+itemData[u][0]+"' name ='"+id+"'>");
					out.print("<input type='hidden' value='"+itemData[u][2]+"' name ='"+itemid+"'>");
					out.print("<input type='hidden' value='"+itemData[u][3]+"' name ='"+itype+"'>");
					out.print("<input type='hidden' value='"+itemData[u][10]+"' name ='"+dbreceived+"'>");
                	out.print("</td>");
                	out.print("<td  valign='top' width='54' class='boldEleven'>&nbsp;"+itemData[u][9]+"</td>");
					out.print("</tr>");
				}
				
				out.print("</table>");
			  	out.println("<input type='hidden' name='length' id='length' value='"+itemData.length+"'>");
			  	
			  %>
							</td>
						</tr>
						<tr>
							<td><input type="hidden" name="totItem" id="totItem"
								value="<%=totItem %>"></td>
						</tr>
						<tr>
							<td valign="top" class="boldEleven">
							<table width="688" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="114" rowspan="4" valign="top" class="boldEleven">
									<div align="left">Description</div>
									</td>
									<td width="200" rowspan="4" valign="top" class="boldEleven">
									<div style="OVERFLOW:auto;width:200px;height:100px"
										class="boldEleven">
									<%
					sql = "SELECT CHR_DES FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_DES"));
					%>
									</div>
									</td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left">Total</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">
									<div align="right">
									<%
					sql = "SELECT DOU_AMOUNT FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "DOU_AMOUNT"));
					%>
									</div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Total Discount (%)</div>
									</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1">
									<div align="right">
									<%
					sql = "SELECT CHR_DISCOUNT FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_DISCOUNT"));
					%>
									</div>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Tax Group</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="tax1">
									<div align="right">
									<%
					sql = "SELECT INT_TAXID FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					int taxid =com.my.org.erp.common.CommonInfo.intGetAnySelectField(sql, "INT_TAXID");
					sql = "SELECT CHR_TAXNAME FROM inv_m_tax WHERE INT_TAXID="+taxid;
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_TAXNAME"));
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
					sql = "SELECT INT_TAXID FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					int taxvid =com.my.org.erp.common.CommonInfo.intGetAnySelectField(sql, "INT_TAXID");
					sql = "SELECT DOU_VALUE FROM inv_m_tax WHERE INT_TAXID="+taxvid;
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "DOU_VALUE"));
					%>
									</div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Reference <input name="filename"
										type="hidden" value="GoodsReceived" /> <input name="actionS"
										type="hidden" value="INVGoodsReceivedChange" /> <input
										name="purchaseno" type="hidden" id="ponumber"
										value="<%=purchaseno%>"></div>
									</td>
									<td class="boldEleven">
									<%
					sql = "SELECT CHR_REF FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_REF"));
					%>
									</td>
									<td class="boldEleven">
									<div align="left">Sales Tax Amount</div>
									</td>
									<td width="169" class="boldEleven" id="salestaxamount1">
									<div align="right">
									<%
					sql = "SELECT DOU_TAXAMOUNT FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "DOU_TAXAMOUNT"));
					%>
									</div>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Received By</div>
									</td>
									<td class="boldEleven">
									<%
						sql = "SELECT CHR_RECIVEDBY FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					%> <input name="receivedby" type="text" class="formText135"
										id="receivedby"
										value="<%=""+com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_RECIVEDBY").trim()%>"
										maxlength="25"></td>
									<td class="boldEleven">
									<div align="left">Net Total</div>
									</td>
									<td width="169" class="boldEleven" id="nettotal1">
									<div align="right">
									<%
					sql = "SELECT DOU_TOTALAMOUNT FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "DOU_TOTALAMOUNT"));
					%>
									</div>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<table width="121" border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
											<td width="56"><input name="Submit" type="submit"
												class="buttonbold13" value="Received"
												onClick="return Validate()" /></td>
											<td width="56"><input type="button" class="buttonbold13"
												onClick="redirect('GoodsReceivedList.jsp?ponumber=<%=purchaseno%>')"
												 value="Close"   accesskey="c"  /></td>
										</tr>
									</table>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<div align="center"></div>
									</td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</form>
					<script language="javascript">

function checkDCquantityChange(ctr,val,val2)
{
	var vf1 = parseInt(document.getElementById(ctr).value);
	var vf2 = parseInt(val);
	if(vf1 <1 )
	{
		alert("Enter the proper value");
		document.getElementById(ctr).value =parseInt(val2);
		document.getElementById(ctr).focus();
	}
	if(vf1 >vf2 )
	{
		alert("Enter the proper value");
		document.getElementById(ctr).value=parseInt(val2);
		document.getElementById(ctr).focus();
	}	
}


	function checkReceivedQty(control)
  	{
		var order= "<%=orderqty%>";
		var order1 =order.split("~");
		var position = (control.name.replace("receivedqty",""));
		pqty = parseInt(document.getElementById("qty"+position).value); 
		rqty = parseInt(control.value);
		if(rqty > pqty)
		{
			alert(" Received Quantity should be less than or equal to ordered quantity");
			control.value="0";
			control.focus();
		}		
	}
	function Validate()
  	{
		var reced= "<%=receqty%>";
		reced="received~receddt~receivedby~"+reced;
		var reced1 =reced.split("~");
    	var flag =false;
		for( i=0; i<reced1.length-1; i++)
		{
			var ck = "Enter Data..."+reced1[i];
			//alert(ck);
			if(checkNull(escape(reced1[i]),ck))
				d=1;
			else
				return false;						
		}
	} 
</script> <%
		  	}
			else
			{
				response.sendRedirect("GoodsRecived.jsp");
				out.print("<center><font color='red'> Record not found</font></center>");
			}
		}
		catch(Exception e)
		{
			out.print(e.getMessage());
		}	
		  %>
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
<%@ include file="../footer.jsp"%>
</body>
</html>
