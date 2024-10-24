<%@ page language="java" import="java.sql.*" errorPage="../error/index.jsp"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="com.my.org.erp.common.*"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
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
	if(checkNull("serial","Enter Serial Number") )
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
									class="boldThirteen">SERIAL NUMBER UPDATE <%
			  String val="";
			  String  spareid="";
			
			  	String branchid=""+session.getAttribute("BRANCHID");
				String rowid =request.getParameter("rowid").trim();
				String sql = "SELECT CHR_SERIALNO,INT_SERIALID,CHR_PURCHASE_WARRANTY,DOU_UNITPRICE FROM inv_t_sparegoodsreceived ";
				sql = sql+" WHERE INT_SERIALID = "+rowid;
				String data[][] =  CommonFunctions.QueryExecute(sql);
				val= data[0][0];
				spareid= data[0][1];
				String w = data[0][2];
				String unitprice = data[0][3];
				out.println("<input type='hidden' name='rowid' value='"+rowid+"'>");
			
			  %>
								</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							<tr>
								 
								<td height="17" colspan="3" class="boldEleven">
								<table width="100%" border="0" align="center">
									<tr>
										<td width="28%" class="boldEleven">Serial Number<span
											class="bolddeepred">*</span></td>
										<td width="39%" class="boldEleven">
<input name="serial" type="text" class="formText135" id="serial" size="25" maxlength="50" value="<%=val%>"										onKeyUp="upperMe(this),LoadUniqueCheckWithData('serial','divserial','inv_t_sparegoodsreceived','CHR_SERIALNO','Submit','<%=val%>')"><div id='divserial'></div></td>
									</tr>
									<tr>
										<td class="boldEleven">Status</td>
										<td class="boldEleven"><select name="good">
											<option value='Y' selected=selected>Good</option>
											<option value='N'>Fault</option>
										</select></td>
									</tr>
									<tr>
										<td class="boldEleven">Warranty</td>
										<td class="boldEleven">
<select name="warranty"	id="warranty" class="formText135">
	<jsp:include page="Warranty.jsp" flush="true" />
</select>(Purchase Warranty :<%=w%> - yrs) 
										<script language="javascript">setOptionValue("warranty","<%=w%>")</script>
										
										</td>
									</tr>
									<tr>
									  <td class="boldEleven">Unit Price </td>
									  <td class="boldEleven"><input name="unitprice" type="text" class="formText135" id="unitprice" maxlength="12" onKeyPress="numericValue('unitprice','12')" value="<%=unitprice%>" style="text-align:right">
								      <input name="dbunitprice" type="hidden" id="dbunitprice" value="<%=unitprice%>"></td>
								  </tr>
								</table>
								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
							<tr>
								<td width="284" height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td width="302" colspan="2" align="left">
								
								
<input name="actionS" type="hidden" value="INVSparePurchaseUpdates" />
<input name="filename" type="hidden" value="SparePurchase" /> 
<input name="rowid"type="hidden" id="rowid" value="<%=rowid%>"> 
<input name="spareid"type="hidden" id="spareid" value="<%=spareid%>"> 
<input name="pwaranty" type="hidden" id="pwaranty" value="<%=w%>">
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
											onClick="redirect('SpareInwardView.jsp')"></td>
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
