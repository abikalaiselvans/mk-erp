<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%><html>
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
 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
 </style>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"	type="text/javascript"></script>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>

	
<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">
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
					<table cellspacing="2" cellpadding="2" width="388" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Payment Pending</td>
							</tr>

							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							<tr>
							  <td height="17" class="boldEleven"><div align="left"><strong>Company</strong> <span class="boldred">*</span></div></td>
							  <td colspan="2" align="left"><div align="left">
                                <select name="Branch" class="formText135"
							id="Branch" tabindex="6" style="width:200" >
							<option value="0">All</option>
                                  <%
								String usertype=""+session.getAttribute("USRTYPE");
								String branchid=""+session.getAttribute("BRANCHID");
				String shipids[][] =  CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ");
				if(usertype.equals("F") || usertype.equals("B"))
				{
				  for(int u=0; u<shipids.length; u++)
					out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
				}
				else
				{
					 for(int u=0; u<shipids.length; u++)
						if(shipids[u][0].equals(branchid))
							out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
				}
						
							%>
                                </select>
                                <script language="javascript">
						  	setOptionValue("Branch","<%=branchid%>") 
						      </script>
                              </div></td>
						  </tr>
							<tr>
								<td width="153" height="17" class="boldEleven"><strong>Division <span class="boldred">*</span></strong></td>
								<td width="221" colspan="2" align="left"><span
									class="boldThirteen"> <select name="divis"
									class="formText135" id="divis"  style="width:200" tabindex="1"
									 >
									<option value='0'>All</option>
									<%
								String division[][] = CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
								</select> </span></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><strong>Payment <span class="boldred">*</span></strong></td>
								<td colspan="2" align="left"><select name="payType"
									id="payType"  style="width:200" >
									<option value="ALL" selected="selected">All Sale Payment</option>
									<option value="Direct" >Customer Sale Payment</option>
									<option value="DirectBilling" >Direct Billing Payment</option>
									<option value="ServiceBilling">Service Billing Payment</option>
									
									<!--
									<option value="Invoice">Invoice Payment</option>
									<option value="CashPay">Cash Sale Payment</option>
									-->
								</select></td>
							</tr>
							<tr>
							  <td height="17" class="boldEleven"><strong>Marketing Executive <span class="boldred">*</span></strong></td>
							  <td colspan="2" align="left">
							  <select name="ref" id="ref" class="formText135" size="5" style="width:200" >
							  	  <option value="0">All</option>	
							  	  <jsp:include page="Staffload.jsp" flush="true" />
							  </select>							  </td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven"><strong>Order by <span class="boldred">*</span></strong></td>
							  <td colspan="2" align="left">
							  <select name="order" id="order" style="width:200" >
							  	<option value="a.DAT_SALESDATE">Date</option>
							  	<option value="FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID)">Customername</option>
							    </select>							  </td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven"><strong>Days
								Left <span class="boldred">*</span></strong></td>
								<td colspan="2" align="left">
								<table width="100" border="0" cellspacing="2" cellpadding="2">
									<tr>
										<td class="boldEleven"><strong>&gt;=</strong></td>
										<td class="boldEleven"><input name="From" type="text" value="0"
										class="formText135" id="From"  
										style='text-align:right' tabindex="11"
										 onKeyPress="return numeric_only(event,'From','6')" size="5" maxlength="5" /></td>
										<td class="boldEleven">&lt;=</td>
										<td class="boldEleven"><input name="To" type="text"
										class="formText135" id="To" value="999"
										style='text-align:right' tabindex="11"
										 onKeyPress="return numeric_only(event,'To','6')" size="5" maxlength="5" /></td>
									</tr>
								</table>								</td>
							</tr>
							
							<tr>
							  <td height="17" class="boldEleven"><strong>Export File Type <span class="boldred">*</span></strong></td>
							  <td colspan="2" align="left"> <jsp:include page="loadJasperReportType.jsp" flush="true" /></td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="2" align="left"><input name="filename" type="hidden" id="filename"
										value="Rept_JPaymentPending">
                                <input name="actionS"
										type="hidden" id="actionS"
										value="INVRept_JPaymentPending">
                                <input name="rptfilename" type="hidden" id="rptfilename" value="paymentPending"></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
										<td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="javascirpt:window.close()"></td>
									</tr>
								</table>								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
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
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<script language="JavaScript">

function Validate()
  {
	if(
		checkNull( "ref","Enter M.E. Name" )
		&& checkNull( "From","Enter Starting Date" )
		&& checkNull( "To","Enter Ending Date" )
	)
		return true;
	else
		return false;				
		
 } 	
</script> <%@ include file="../footer.jsp"%></form>
</body>
</html>
