<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="./error.jsp"%>
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
<script language="javascript" src="../../JavaScript/comfunction.js"></script>
<script language="javascript" src="../../JavaScript/calendar1.js"></script>
<body >

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
					<%	
		   	try
			{
			  	String purchaseno=request.getParameter("ponumber");
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
							<td width="650"></td>
						</tr>
						<tr>
							<td>
							<div align="center" class="copyright">Purchase Order</div>
							</td>
						</tr>
						<tr>
							<td valign="bottom">
							<table width="668" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="123" class="boldEleven">
									<div align="left">Purchase Order No</div>
									</td>
									<td width="198" class="boldEleven"><%=purchaseno%></td>
									<td width="102" class="boldEleven">
									<div align="left">Payment Mode</div>
									</td>
									<td width="237" class="boldEleven">
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
									<td class="boldEleven">
									<div align="left">Order Date</div>
									</td>
									<td class="boldEleven">
									<%
					sql = "SELECT DAT_ORDERDATE FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "DAT_ORDERDATE"));
					%>
									</td>
									<td class="boldEleven">
									<div align="left">Order From</div>
									</td>
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
									<td class="boldEleven">
									<div align="left">Shipping To</div>
									</td>
									<td class="boldEleven">
									<%
					sql = "SELECT INT_ADDRESSID2 FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					int shipid =com.my.org.erp.common.CommonInfo.intGetAnySelectField(sql, "INT_ADDRESSID2");
					sql = "SELECT CHR_BRANCHNAME FROM  com_m_branch  WHERE INT_BRANCHID="+shipid;
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_BRANCHNAME"));
					%>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">On Hold</div>
									</td>
									<td class="boldEleven">
									<%
					sql = "SELECT INT_ONHOLD FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					if("1".equals(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "INT_ONHOLD").trim()))
						out.println("On Hold");
					else
						out.println("-");
					%>
									</td>
									<td class="boldEleven">&nbsp;</td>
									<td class="boldEleven">&nbsp;</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<%
			  
				sql =" SELECT CHR_TYPE,CHR_ITEMID,CHR_DESC,INT_QUANTITY, DOU_UNITPRICE,CHR_DISCOUNT,DOU_UNITDISCOUNT,DOU_TOTAL ";
				sql = sql +"From  inv_t_vendorpurchaseorderitem  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
				 
				String itemData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				out.print("<table width='100%' border='1' cellpadding='1' cellspacing='1' >");
				out.print("<th  class='boldEleven'><b>Type</b></th>");
				out.print("<th  class='boldEleven'><b>Item / Product</b></th>");
          		out.print("<th  class='boldEleven'><b>Description</b></th>");
                out.print("<th  class='boldEleven'><b>Quantity</b></th>");
                out.print("<th  class='boldEleven'><b>Unit Price</b></th>");
                out.print("<th  class='boldEleven'><b>Discount(%)</b></th>");
                out.print("<th  class='boldEleven'><b>Unit Discount</b></th>");
                out.print("<th  class='boldEleven'><b>Total</b></th>");
				for(int u=0; u<itemData.length;u++)
				{
					out.print("<tr>");
					out.println("<td >&nbsp;");
					if(itemData[u][0].equals("I"))
					{
						out.println("Item");
						sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+itemData[u][1]+"'";
						out.print("<td width='52' class='boldEleven'>&nbsp;"+com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME")+"</td>");
					}
					if(itemData[u][0].equals("P"))
					{
						out.println("Product");
						sql = "SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+itemData[u][1]+"'";
						out.print("<td width='52' class='boldEleven'>&nbsp;"+com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE")+"</td>");
					}	
						
					out.print("<td width='102' class='boldEleven'>&nbsp;"+itemData[u][2]+"</td>");
                	out.print("<td width='83' class='boldEleven'>&nbsp;"+itemData[u][3]+"</td>");
                	out.print("<td width='98' class='boldEleven'>&nbsp;"+itemData[u][4]+"</td>");
                	out.print("<td width='123' class='boldEleven'>&nbsp;"+itemData[u][5]+"</td>");
                	out.print("<td width='133' class='boldEleven'>&nbsp;"+itemData[u][6]+"</td>");
                	out.print("<td width='54' class='boldEleven'>&nbsp;"+itemData[u][7]+"</td>");
				
				}
				
				out.print("</table>");
			  /*
			  <div id="divscroll" style="OVERFLOW:auto;width:750px;height:100px" class="boldEleven">
                  <table width="687" border="0" cellpadding="1" cellspacing="1" id="myTable">
                    	
                              </table>
              </div>
			  */
			  %>
							</td>
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
									<div align="left">Total Discount</div>
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
									<%
					sql = "SELECT INT_TAXID FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO ='"+purchaseno+"'";
					int taxid =com.my.org.erp.common.CommonInfo.intGetAnySelectField(sql, "INT_TAXID");
					sql = "SELECT CHR_TAXNAME FROM inv_m_tax WHERE INT_TAXID="+taxid;
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_TAXNAME"));
					%>
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
									<div align="left"></div>
									</td>
									<td class="boldEleven">&nbsp;</td>
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
									<div align="left">Reference <input name="filename"
										type="hidden" value="PurchaseOrder" /> <input name="actionS"
										type="hidden" value="INVPurchaseOrderView" /> <input
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
									<div align="center"></div>
									</td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</form>
					<%
		  	}
			else
			{
				response.sendRedirect("Purchase Order.jsp");
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
		<td width="94%">
		<div align="right"><a href='javascript:window.print()'>PRINT</div>
		</td>
		<td width="6%">&nbsp;</td>
	</tr>
</table>

</body>
</html>
