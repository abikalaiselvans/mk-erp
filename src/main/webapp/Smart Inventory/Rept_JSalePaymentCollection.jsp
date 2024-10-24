<%@ page import="java.io.*,java.util.*,com.my.org.erp.common.*"%><%@ page import="java.io.*,java.util.*"%>
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
 <script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js"></script>
<script language="javascript" src="../JavaScript/Inventory/PurchaseRequestDate.js"></script>
<script>
	 

 $(function() {
		var dates = $( "#fromdate, #todate" ).datepicker({
			defaultDate: "+1w",
			changeMonth: true,maxDate: "+0D" ,
			numberOfMonths: 1,
			showOn: "button",
				buttonImage: "../JavaScript/jquery/images/calendar.gif",
				buttonImageOnly: true,
			onSelect: function( selectedDate ) {
				var option = this.id == "fromdate" ? "minDate" : "maxDate",
					instance = $( this ).data( "datepicker" ),
					date = $.datepicker.parseDate(
						instance.settings.dateFormat ||
						$.datepicker._defaults.dateFormat,
						selectedDate, instance.settings );
				dates.not( this ).datepicker( "option", option, date );
			}
		});
	});

	</script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">

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
		<table width="400" border="0"
			align="center" cellpadding="0" cellspacing="0" class="BackGround1">
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
					<td width="410">
					<table cellspacing="2" cellpadding="2" width="100%" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>

							<tr>
							  <td height="19" colspan="2" align="right" valign="top"><div align="center"><strong>Payment Collection </strong><span class="boldEleven">
							    <%
				String branchid=""+session.getAttribute("BRANCHID");
				String usertype=""+session.getAttribute("USRTYPE");
				String user= ""+session.getAttribute("USRID"); 
				%>
							  </span></div></td>
						  </tr>
							<tr>
							  <td height="19" colspan="2" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory</span></td>
						  </tr>
							<tr>
							  <td width="111" height="19" align="right" valign="top" class="boldEleven"><div align="left">Company</div></td>
							  <td width="261" align="right" valign="top" class="boldEleven"><div align="left">
							    <select name="Branch" class="formText135"
							id="Branch" tabindex="6" style="width:200"  >
							      <option value="0">All</option>
							      <%
								
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
								<td height="17" class="boldEleven">Payment</td>
								<td colspan="2" align="left">
								<select name="payType"	id="payType" style="width:200"   >
									<!--<option value="0">All Sale Payment</option>-->
									<option value="Direct">Customer Sale Payment</option>
									<option value="DirectBilling">Direct Billing Payment</option>
									<option value="ServiceBilling">Service Billing Payment</option>
									
									<!--
									<option value="Invoice">Invoice Payment</option>
									<option value="CashPay">Cash Sale Payment</option>
									-->
								</select></td>
							</tr>
							<tr>
							  <td height="19" align="right" valign="top" class="boldEleven"><div align="left">Division</div></td>
							  <td align="right" valign="top" class="boldEleven">
							    <div align="left">
							      <select
										name="division" class="formText135" id="division" tabindex="1"  style="width:200"  >
							        <option value='0'>All</option>
							        <%
								String division[][] =  CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
						          </select>
					            </div></td>
						  </tr>
							<tr>
							  <td height="19" align="right" valign="top" class="boldEleven"><div align="left"><span class="boldEleven">Bank</span></div></td>
							  <td align="right" valign="top" class="boldEleven"><div align="left">
							    <select name="Bank"
									class="formText135" id="Bank" tabindex="1"  style="width:200"  >
							      <option value='0'>All</option>
							      <%
								String bank[][] =  CommonFunctions.QueryExecute("SELECT INT_BANKGROUPID, CHR_BANKGROUPNAME FROM com_m_bankgroup ORDER BY CHR_BANKGROUPNAME");
								for(int u=0; u<bank.length; u++)
									out.print("<option value='"+bank[u][0]+"'>"+bank[u][1]  +"</option>");
							%>
						        </select>
						      </div></td>
						  </tr>
							<tr>
							  <td height="19" align="right" valign="top" class="boldEleven"><div align="left"><span class="boldEleven">Customer</span></div></td>
							  <td align="right" valign="top" class="boldEleven"><div align="left">
							    <select name="customer"
									id="customer" class="formText135"  style="width:200"  >
							      <option value="0">All</option>
							      <jsp:include page="LoadCustomer.jsp" />                              
                                </select>
						      </div></td>
							</tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Payment collected by</td>
							  <td colspan="2" align="left" valign="top">
							  <select name="ref" id="ref" 	class="formText135" size="5"  style="width:200"  >
							  <option value="0" >All</option>
                                  <jsp:include page="Staffload.jsp" flush="true" />                            
						      </select>							  </td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Date</td>
							  <td colspan="2" align="left">
							  <select id="Chequedt" name="Chequedt"  style="width:200"  >
							  	<option value="1">Cheque Datewise
								<option value="2">Cheque Received Datewise
							  </select>							  </td>
						  </tr>
						  <tr>
							  <td height="19" align="right" valign="top" class="boldEleven"><div align="left"><span class="boldEleven">From Date <span
									class="bolddeepred">* </span></span> </div></td>
							  <td align="right" valign="top" class="boldEleven"><div align="left">
							    <input
									tabindex="2" name="fromdate" type="text" class="formText135"
									id="fromdate" size="15" readonly>
							    
							    <script language='JavaScript'
									type="text/javascript">
		 
				setCurrentDate('fromdate'); 
		                 </script>
						      </div></td>
						  </tr>
							<tr>
							  <td height="19" align="right" valign="top" class="boldEleven"><div align="left"><span class="boldEleven">To Date <span
									class="bolddeepred">* </span></span></div></td>
							  <td align="right" valign="top" class="boldEleven"><div align="left">
							    <input tabindex="2"
									name="todate" type="text" class="formText135" id="todate"
									size="15" readonly>
							    
							    <script language='JavaScript'
									type="text/javascript">
		 			
				 
				setCurrentDate('todate'); 
		 
                                </script>
						      </div></td>
						  </tr>
							<tr>
							  <td height="19" align="right" valign="top" class="boldEleven"><div align="left">Export File Type  <span
									class="bolddeepred">*</span></div></td>
							  <td align="right" valign="top" class="boldEleven"><div align="left">
							    <select name="reportType" id="reportType" style="width:100">
							      <option value="0">Select Export File Type</option>
							      <option value="csv">CSV</option>
							      <option value="xls">Excel</option>
							      <option value="html">HTML</option>
							      <option value="pdf" selected="selected">PDF</option>
							      <option value="txt">Text</option>
							      <option value="rtf">Word</option>
							      <option value="xml">XML</option>
						        </select>
						      </div></td>
						  </tr>
							<tr>
							  <td height="19" colspan="2" align="right" valign="top"><input name="filename"
									type="hidden" value="Rept_JSalePaymentCollection" />
                                <input name="actionS"
									type="hidden" value="INVRept_JSalePaymentCollection" />
                                <span class="boldEleven">
                                <input name="rptfilename" type="hidden" id="rptfilename" value="SalePaymentCollection">
                                </span>
                                <table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                                <tr>
                                  <td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                                  <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="javascirpt:window.close()"></td>
                                </tr>
                              </table></td>
						  </tr>
							<tr>
							  <td height="19" align="right" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td align="right" valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
						</tbody>
						<input type="hidden" name="mobileBookingOption" />
					</table>
				  </td>
					<td nowrap="nowrap" width="6"><spacer height="1" width="1"
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
	if(checkNull( "ref","Select Collected by" ))
		return true;
	else
		return false;				
		
 } 	
</script> <%@ include file="../footer.jsp"%></form>
</body>
</html>
