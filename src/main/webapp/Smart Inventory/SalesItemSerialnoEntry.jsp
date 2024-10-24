<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="../error/index.jsp"%>
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
<%
try
{
	String salesId=request.getParameter("salesId");
	String delivaryId=request.getParameter("delivaryId");
	String sql=" SELECT INT_SALESORDERID,CHR_DELIVARYNO,INT_CUSTOMERID,"+
				" CHR_RECIVEDBY,DAT_DELIVARYDATE,"+
				" CHR_DES,CHR_REF,INT_TAXID,DOU_AMOUNT,DOU_DISCOUNT,DOU_TAXAMOUNT,"+
				" DOU_TOTALAMOUNT,INT_PAYMENTSTATUS "+
				" from inv_t_delivary where INT_DELIVARYID="+delivaryId;
	String purchaseInfo[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);	
	sql="Select CHR_CUSTOMERNAME from inv_m_customerinfo where INT_CUSTOMERID="+purchaseInfo[0][2];
	String customerInfo[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

	sql="Select CHR_SALESORDERNO,INT_PAYMENTTERMID from  inv_t_customersalesorder   where INT_SALESORDERID="+salesId;
	String salesInfo[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

%>
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
					<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm">
					<table width="663" border="0" align="center" cellpadding="1"
						cellspacing="1">
						<tr>
							<td width="650"></td>
						</tr>
						<tr>
							<td>
							<div align="center" class="copyright">Delivary Chalan
							-Serial No Entry</div>
							</td>
						</tr>
						<tr>
							<td valign="bottom">
							<table width="668" border="0" align="center" cellpadding="1"
								cellspacing="1">
								<tr>
									<td width="123" class="boldEleven">
									<div align="left">Delivary Ref No</div>
									</td>
									<td width="198" class="boldEleven"><input type="hidden"
										id="deliveredId" name="deliveredId" value="<%=delivaryId %>">
									<%=purchaseInfo[0][1]%></td>
									<td width="102" class="boldEleven">
									<div align="left">Sales Order No</div>
									</td>
									<td width="237" class="boldEleven"><%=salesInfo[0][0]%></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Customer Id /Name</div>
									</td>
									<td class="boldEleven"><%=purchaseInfo[0][2]%>&nbsp;/&nbsp;<%=customerInfo[0][0]%></td>
									<td class="boldEleven">
									<div align="left">Recived By</div>
									</td>
									<td class="boldEleven"><%=purchaseInfo[0][3] %> <input
										name="receivedby" type="hidden" id="receivedby"
										value="<%=purchaseInfo[0][3] %>"></td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Delivered Date</div>
									</td>
									<td class="boldEleven"><%=purchaseInfo[0][4] %> <input
										name="deliveredDate" type="hidden" id="deliveredDate"
										value="<%=purchaseInfo[0][4] %>"></td>
									<td class="boldEleven">
									<div align="left">Payment Terms</div>
									</td>
									<td class="boldEleven">
									<%
						sql = "SELECT CHR_PAYMENTNAME FROM inv_m_paymentcondition WHERE INT_PAYMENTCONDITIONID="+salesInfo[0][1];
						out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PAYMENTNAME"));
					  %>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">&nbsp;</td>
									<td class="boldEleven">&nbsp;</td>
									<td class="boldEleven">&nbsp;</td>
									<td class="boldEleven">&nbsp;</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td>
							<div align="center">
							<%				 
				sql = "SELECT INT_DELIVARYID,CHR_ITEMID,INT_SALESQUANTITY FROM inv_t_delivaryitem WHERE INT_DELIVARYID ='"+delivaryId+"'";
              	//System.out.println("Twsat :"+sql);   
				String recdData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				out.print("<div align='center' id='divscroll' style='OVERFLOW:auto;width:550px;height:200px' class='boldEleven'>");
				out.print(" <table width=500 border='1' cellpadding='1' cellspacing='1' >");
				out.print("<th width='52' class='boldEleven'><b>Item</b></th>");
                out.print("<th width='123' class='boldEleven'><b>Serial No</b></th>");
                out.print("<th width='133' class='boldEleven'><b>Warranty</b></th>");
				int row=1;
				//System.out.println("Len:"+recdData.length);
				 for(int v=0;v<recdData.length; v++)
				{
					String itemid = recdData[v][1];
					String redqty = recdData[v][2];
					sql = "SELECT * FROM inv_t_delivaryitemserial WHERE INT_DELIVARYID ='"+delivaryId+"'";
					sql = sql +" AND CHR_ITEMID ='"+itemid+"'";
					//System.out.println(sql);
					String itemData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					String serial="serail";
					String warranty="warranty";
					for(int u=0; u<Integer.parseInt(redqty);u++)
					{
						serial = "serail"+(u+1);
						warranty="warranty"+(u+1);
						out.print("<tr>");
						sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+itemData[u][4]+"'";
						out.print("<td width='52' class='boldEleven'>&nbsp;"+com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME")+"</td>");
						out.print("<td><input name='serail"+row+"' value='"+itemData[u][7]+"' class='formText135' maxlength='50' size=20 type='text'  name ='"+serial+"'>");
						out.print("<td><input name='warranty"+row+"' value='"+itemData[u][8]+"'class='formText135' maxlength='50' size=20  type='text'  name ='"+warranty+"'>");
						out.print("<input name='item"+row+"' type='hidden' id='item' value='"+itemid+"'>");
						out.print("<input name='row"+row+"' type='hidden' id='item' value='"+itemData[u][1]+"'>");
						out.print("</tr>");
						row= row+1;
					}
				}
				out.print("</table> ");
				out.print("</div> ");
				out.println("<input type='hidden' name='length' id='length' value='"+row+"'>");
				
			  	/*sql = "SELECT * FROM inv_t_vendorgoodsreceived WHERE CHR_PURCHASEORDERNO ='"+salesId+"'";
				String itemData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				out.print("<center><table  border='1' cellpadding='1' cellspacing='1' >");
				out.print("<th width='52' class='boldEleven'><b>Item</b></th>");
                out.print("<th width='123' class='boldEleven'><b>Serial No</b></th>");
                out.print("<th width='133' class='boldEleven'><b>Warranty</b></th>");
				String serial="serail";
				String warranty="warranty";
                for(int u=0; u<itemData.length;u++)
				{
					serial = "serail"+(u+1);
					warranty="warranty"+(u+1);
					out.print("<tr>");
					sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+itemData[u][3]+"'";
					out.print("<td width='52' class='boldEleven'>&nbsp;"+com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME")+"</td>");
					out.print("<td><input class='formText135' maxlength='50' size=20 type='text'  name ='"+serial+"'>");
					out.print("<td><input class='formText135' maxlength='50' size=20  type='text'  name ='"+warranty+"'>");
                	out.print("</tr>");
				}
				
				out.print("</table></center>");
			  	//out.println("<input type='hidden' name='length' id='length' value='"+itemData.length+"'>");
			  	*/
			  %>
							</div>
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
										class="boldEleven"><%=purchaseInfo[0][5] %></div>
									</td>
									<td width="107" valign="top" class="boldEleven">
									<div align="left">Total</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="totals1">
									<%= purchaseInfo[0][8]%></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Total Discount (%)</div>
									</td>
									<td width="169" valign="top" class="boldEleven"
										id="totaldiscount1"><%=purchaseInfo[0][9]%></td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Tax Group</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="tax1">
									<%
					sql = "SELECT CHR_TAXNAME FROM inv_m_tax WHERE INT_TAXID="+purchaseInfo[0][7];
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_TAXNAME"));
					%>
									</td>
								</tr>
								<tr>
									<td valign="top" class="boldEleven">
									<div align="left">Sales Tax (%)</div>
									</td>
									<td width="169" valign="top" class="boldEleven" id="salestax1">
									<%
					sql = "SELECT DOU_VALUE FROM inv_m_tax WHERE INT_TAXID="+purchaseInfo[0][7];
					out.println(com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "DOU_VALUE"));
					%>
									</td>
								</tr>
								<tr>
									<td class="boldEleven">
									<div align="left">Reference <input name="filename"
										type="hidden" value="DelivaryChallan" /> <input
										name="actionS" type="hidden" value="INVDelivarySerialAdd" />
									<input name="salesId" type="hidden" id="salesId"
										value="<%=salesId %>"></div>
									</td>
									<td class="boldEleven"><%=purchaseInfo[0][6] %></td>
									<td class="boldEleven">
									<div align="left">Sales Tax Amount</div>
									</td>
									<td class="boldEleven" id="salestaxamount1"><%=purchaseInfo[0][10]%>
									</td>
								</tr>
								<tr>
									<td class="boldEleven"><input name="salesId2"
										type="hidden" id="salesId2" value="<%=delivaryId %>"></td>
									<td class="boldEleven"></td>

									<td class="boldEleven">
									<div align="left">Net Total</div>
									</td>
									<td class="boldEleven" id="nettotal1">
									<div align="left"><%=purchaseInfo[0][11]%></div>
									</td>
								</tr>
								<tr>
									<td colspan="4" class="boldEleven">
									<table width="121" border="0" align="center" cellpadding="1"
										cellspacing="1">
										<tr>
											<td width="56"><input name="Submit" type="submit"
												class="buttonbold" value="Received"
												onClick="return Validate()" /></td>
											<td width="56"><input type="button" class="buttonbold"
												onClick="javascript:history.back(2)"  value="Close"   accesskey="c"  /></td>
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
<%
}
catch(Exception e){
 out.println(e.getMessage());
}
%>
</html>
