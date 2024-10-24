<%@ page import="java.io.*,java.util.*"%>
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
<script language="javascript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript" src="../JavaScript/AJAX.js"></script>
<script language="JavaScript">
 

 function Validate()
  {   
	var saleserial = document.getElementById('saleserial').value;	
	var serial1  = document.getElementById('serial1').value;	
	if(saleserial == serial1)
	{
		alert("Invalid Action...");
		return false;
	}
	
	if(checkNull("serial1","Enter Serial Number") )
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
		<td height="80">&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#FFFFFF">
		<%
	try
		{
  
	%>

		<table class="BackGround1" cellspacing="0" cellpadding="0" width="400"
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
					<form  AUTOCOMPLETE = "off"   action=" ../SmartLoginAuth" method="post" name="frm" id="frm"
						onSubmit=" return Validate()">
					<table cellspacing="2" cellpadding="2" width="400" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">SALES SERIAL NUMBER UPDATE <%
			  String val="";
			   
			
			  	String branchid=""+session.getAttribute("BRANCHID");
				String itype=(""+request.getParameter("itype")).trim();
				String itemid=(""+request.getParameter("item")).trim();
				String salesno=(""+request.getParameter("salesno")).trim();
				String serial=(""+request.getParameter("serial")).trim();
				String saleunitprice=(""+request.getParameter("saleunitprice")).trim();
				
				String sql = "SELECT CHR_SERIALNO  FROM inv_t_swapsalesserialno  ";
				sql = sql+" WHERE CHR_SALESNO = '"+salesno+"'";
				sql = sql +" AND INT_BRANCHID = "+branchid;
				sql = sql +" AND CHR_ITEMID = '"+itemid+"'";
				sql = sql +" AND CHR_TYPE = '"+itype+"'";
				String Data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
				val = Data[0][0];
			  %>
								</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							<tr>
								<!--                   <td height="17" class="boldEleven">ProductId <span class="bolddeepred">* </span></td> -->
								<td height="17" colspan="3" class="boldEleven">
								<table width="312" border="0" align="center">
									<tr>
										<td class="boldEleven">&nbsp;</td>
										<td class="boldEleven">Serial Number<span
											class="bolddeepred">*</span></td>
										<td class="boldEleven">
										<input name="serial1" type="text" class="formText135" id="serial1" size="25" maxlength="50"
											value="<%=serial%>"
											onKeyUp="upperMe(this),LoadUniqueCheckSales('serial1','divserial','inv_t_vendorgoodsreceived','CHR_SERIALNO','Submit','<%=itype%>','<%=itemid%>')">





										</td>


										<td class="boldEleven">
										<div id='divserial'></div>
										<div id='Warranty1'></DIV>
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td width="284" height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td width="302" colspan="2" align="left">
								    <input name="saleserial" type="hidden" id="saleserial" value="<%=serial%>"> 
									<input name="Warrantys1" type="hidden" id="Warrantys1" value="1">
									<input name="filename" type="hidden" id="filename" value="SwapSale" /> 
									<input name="actionS" type="hidden" id="actionS" value="INVSwapSaleserialUpdation" /> 
									<input name="itype"   type="hidden" id="itype" value="<%=itype%>">
								    <input name="itemid"  type="hidden" id="itemid" value="<%=itemid%>"> 
								    <input name="salesno" type="hidden" id="salesno" value="<%=salesno%>">
									<input name="saleunitprice" type="hidden" id="saleunitprice" value="<%=saleunitprice%>">
									
									</td>
							</tr>

							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" id="Submit" type="submit"
											class="buttonbold13" value="Update"></td>
										<td><input name="Close" type="Button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('SwapSaleSerialView.jsp?salno=<%=salesno%>')"></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;
								</td>
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
		<%
	
	}
			catch(Exception e)
			{
			}	
	%>
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
