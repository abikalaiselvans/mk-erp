<%@ page import="java.io.*,java.util.*" isErrorPage="false"%>
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
<script language="JavaScript">
function Validate()
  {
    /*
	if(checkNull("fromdt","Enter From Date") && checkNull("todt","Enter To Date") && checkDate("fromdt","todt"))
		return true;
	else
		return false;	
	*/	
  } 
</script>
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
					<table cellspacing="2" cellpadding="2" width="900" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td width="779" height="16" align="center" valign="top"
									class="boldThirteen">RETURN DETAILS <%
				  String grtn =request.getParameter("grtno");
				  String sql = "SELECT CHR_GRTNO,INT_BRANCHID,CHR_PURCHASEORDERNO,CHR_ITEMID,CHR_RECIVEDID,DAT_RECIVEDDATE,CHR_SERIALNO,CHR_WARRANTY,CHR_FLAG ,INT_ID,CHR_NEWSERIAL,CHR_NEWWARRANTY ,CHR_TYPE FROM  inv_t_vendorgoodsreturn  WHERE CHR_GRTNO='"+grtn+"'";
				 // out.println(sql);
				  String returnData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				  
				  %>
								</td>
							</tr>
							<tr>
								<td height="19" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">
								<div align="center">
								<%
				  	out.println("<table width='100%' class='boldEleven' id='myTable' cellpadding=2 cellspacing=1 bgcolor='#9900CC'>");
					out.println("<tr class='MRow1'>");
					out.println("<td class='boldEleven'> GRT Number</td>");
					out.println("<td class='boldEleven'> Branch </td>");
					out.println("<td class='boldEleven'> Purchase Number</td>");
					out.println("<td class='boldEleven'> Type</td>");
					out.println("<td class='boldEleven'> Item / Product 12</td>");
					out.println("<td class='boldEleven'> Received Number</td>");
					out.println("<td class='boldEleven'> Received Date</td>");
					out.println("<td class='boldEleven'> Serial Number</td>");
					out.println("<td class='boldEleven'> Warranty</td>");
					out.println("<td class='boldEleven'> Replacement Status</td>");
					out.println("<td class='boldEleven'> New Serial Number</td>");
					out.println("<td class='boldEleven'> Warranty</td>");
					out.println("<td class='boldEleven'> Received Return Item</td>");
					for(int u=0; u<returnData.length;u++)
					{
						 if(u%2==1)
							out.println("<tr class='MRow1'>");
						else
		    				out.println("<tr  class='MRow2'>");		
						out.println("<td class='boldEleven'>"+	returnData[u][0]);
						String branch="";
						sql = "SELECT CHR_BRANCHNAME FROM  com_m_branch  WHERE INT_BRANCHID ="+Integer.parseInt(returnData[u][1]);
						branch = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_BRANCHNAME");
						out.println("<td class='boldEleven'>"+	branch);
						out.println("<td class='boldEleven'>"+	returnData[u][2]);
						String itemname="";
						String type="";
						type = returnData[u][12];
						if(type.equals("I"))
						{
							sql = "SELECT CHR_ITEMNAME FROM inv_m_item WHERE CHR_ITEMID='"+returnData[u][3]+"'";
							itemname = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_ITEMNAME");
							type = "Item";
						}
						 
						if(type.equals("P"))
						{
							sql = "SELECT CHR_PRODUCTCODE FROM inv_m_produtlist WHERE CHR_PRODUCTID='"+returnData[u][3]+"'";
							itemname=com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PRODUCTCODE");
							type = "Product";
						}
						
						
						out.println("<td class='boldEleven'>"+	type);
						out.println("<td class='boldEleven'>"+	itemname);
						out.println("<td class='boldEleven'>"+	returnData[u][4]);
						out.println("<td class='boldEleven'>"+	com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(returnData[u][5]));
						out.println("<td class='boldEleven'>"+	returnData[u][6]);
						out.println("<td class='boldEleven'>"+	returnData[u][7]);
						out.println("<td class='boldEleven'>"+	returnData[u][8]);
						sql = "GoodsReturnReceivedEntry.jsp?grtno="+grtn+"&pid="+returnData[u][2]+"&rowid="+returnData[u][9];
						if("N".equals(returnData[u][8]))
						{
							out.println("<td class='boldEleven'>&nbsp;--");						
							out.println("<td class='boldEleven'>&nbsp;--");
							out.println("<td class='boldEleven'><a href='"+sql+"'><font class='boldgreen'>Replacement</font></a>");	
						}
						else
						{
							out.println("<td class='boldEleven'>"+returnData[u][10]);						
							out.println("<td class='boldEleven'>"+returnData[u][11]);
							//out.println("<td class='boldEleven'><a href='"+sql+"'><font class='boldgreen'>Modified</font></a>");
							out.println("<td class='boldEleven'><font class='boldgreen'>Replaced</font>");
						}	
					}
					out.println("</table");
				  %>
								</div>
								</td>
							</tr>

							<tr>
								<td height="17" class="boldEleven">
								<table width="100" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td>&nbsp;</td>
										<td><input name="Submit" type="button"
											class="buttonbold13"  value="Close"   accesskey="c" 
											onClick="redirect('Goods Return.jsp')"></td>
									</tr>
								</table>
								</td>
							</tr>
						</tbody>
						<input type="hidden" name="mobileBookingOption" />
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
<%@ include file="../footer.jsp"%>
</body>
</html>
