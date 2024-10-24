<%@ page import="com.my.org.erp.common.CommonFunctions"%>
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
			changeMonth: true,changeYear: true,maxDate: "+0D" ,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			numberOfMonths: 1,
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

<script language="javascript" >
 function validate()
{
 	if(checkNull('fromdate','Enter From Date ...')
		&& checkNull('todate','Enter TO Date ...')
		)
		return true;
	else
		return false;
}
</script>
<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="VendorPaymentresponse.jsp" onSubmit="return validate()">
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
		<table width="500" border="0"
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
					<table width="100%"
						border="0" align="center" cellpadding="2" cellspacing="2">
						<!--DWLayoutTable-->
						<tbody>

							<tr>
							  <td height="19" colspan="2" align="right" valign="top"><div align="center"><strong>Vendor Payment  </strong><span class="boldEleven">
							    <%
				String branchid=""+session.getAttribute("BRANCHID");
				String usertype=""+session.getAttribute("USRTYPE");
				String user= ""+session.getAttribute("USRID"); 
				%>
							  </span></div></td>
						  </tr>
							<tr>
							  <td width="99" height="19" align="right" valign="top" class="boldEleven"><div align="left">Vendor</div></td>
							  <td width="179" align="right" valign="top" class="boldEleven"><div align="left">
							    <select name="vendorid" class="formText135" id="vendorid" style="width:200"  >
						<option value=0>All</option>
						<%
						String vendordata[][] = CommonFunctions.QueryExecute("SELECT INT_VENDORID,CHR_VENDORNAME FROM  inv_m_vendorsinformation  ORDER BY CHR_VENDORNAME");
								for(int u=0; u<vendordata.length; u++)
									out.print("<option value='"+vendordata[u][0]+"'>"+vendordata[u][1]  +"</option>");
						%>			
						</select>
						      </div></td>
						  </tr>
							
							<tr>
								<td height="17" class="boldEleven">Payment</td>
								<td colspan="2" align="left">
								<select name="Vendortype"	id="Vendortype" style="width:200"  >
									<option value="Direct">Direct Purchase Payment</option>
									<option value="Purchase">Purchase Order Payment</option>
									
								</select></td>
							</tr>
							 
							<tr>
							  <td height="17" class="boldEleven">Date</td>
							  <td colspan="2" align="left">
							  <select id="Chequedt" name="Chequedt"  style="width:200" >
							  	<option value="1">Cheque dt
								<option value="2">Entry dt
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
							  <td height="19" colspan="2" align="right" valign="top"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                                <tr>
                                  <td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                                  <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="javascript:window.close()"></td>
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
<%@ include file="../footer.jsp"%></form>
</body>
</html>
