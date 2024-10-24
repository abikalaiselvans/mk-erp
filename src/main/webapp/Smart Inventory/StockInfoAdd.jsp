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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript">
 function valid()
  {
   
	if(
	checkNullSelect("branchid","Select Branch","Select") 
	&& checkNull("name","Enter Name") 
	&& checkNull("lname","Enter Legal Name")
	&& checkNull("street","Enter Street") 
	&& checkNull("city","Enter City")
	&& checkNull("state","Enter State") 
	&& checkNull("pin","Enter Pincode")
	&& checkNull("country","Enter Country") 
	&& checkNull("area","Enter Area code")
	&& checkNull("phone","Enter Phone number") 
	&& checkNull("fax","Enter Fax")
	&& checkNull("email","Enter Email")
	&& checkNull("website","Enter website") 
	&& checkNull("doh","Enter Date of Hire")
	&& checkNull("accno","Enter Account Number") 
	&& checkNull("bank","Enter Bank Name")
	
	&& checkNullSelect("group","Select Group","Select")
	
	)
		return true;
	else
		return false;	
	 	
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
		<td bgcolor="#FFFFFF">
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
					<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm"
						onSubmit="return valid()">
					<table cellspacing="2" cellpadding="2" width="388" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Stock Informations</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Branch</td>
								<td colspan="2" align="left"><select name="branchid"
									class="formText135">
									<option value="Select">Select</option>
									<%
				  String query ="SELECT * FROM  com_m_branch ";
				  String branch[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(query);
				  for(int u=0; u<branch.length; u++)
				  	out.print("<option value ='"+branch[u][0]+"'>" +branch[u][2]+"</option>");
				  %>
								</select></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Item Name</td>
								<td colspan="2" align="left"><select name="itemid"
									class="formText135">
									<option value="Select">Select</option>

									<%
				  String query1="SELECT CHR_ITEMID,CHR_ITEMNAME FROM inv_m_item";
				  String stock[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(query1);
				  for(int u=0; u<stock.length; u++)
				  	out.print("<option value ='"+stock[u][0]+"'>" +stock[u][1]+"</option>");
				  %>
								</select></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">PURCHASEORDER ID</td>
								<td colspan="2" align="left"><input name="TxtPurchaseId"
									type="text" class="formText135" id="lname" maxlength="50"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">RECIVED QUANTITY</td>
								<td colspan="2" align="left"><input name="TxtReceivedQty"
									type="text" class="formText135" id="street" maxlength="50"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">SALES ID</td>
								<td colspan="2" align="left"><input name="TxtSalesId"
									type="text" class="formText135" id="city" maxlength="50"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">SALES QUANTITY</td>
								<td colspan="2" align="left"><input name="TxtSalesQty"
									type="text" class="formText135" id="state" maxlength="50"></td>
							</tr>

							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><input name="filename"
									type="hidden" value="StockInfo" /> <input name="actionS"
									type="hidden" value="INVstockAdd" /></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" type="submit" class="buttonbold"
											value="Submit"></td>
										<td><input name="Close" type="Button" class="buttonbold"
											id="Close"  value="Close"   accesskey="c"  onClick="javascript:history.back()"></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
						</tbody>
						<input type="hidden" name="mobileBookingOption" />
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
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>
