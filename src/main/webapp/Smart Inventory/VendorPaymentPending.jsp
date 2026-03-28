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
<script language="JavaScript" src="../JavaScript/calendar1.js" 	type="text/javascript"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.core.js"></script>
<script language="javascript" src="../JavaScript/jquery/ui/jquery.ui.widget.js"></script>
<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="VendorPaymentPendingResponse.jsp" onSubmit="return Validate()">
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
								<td height="17" class="boldEleven"><strong>Payment</strong></td>
								<td colspan="2" align="left">
								<select name="Vendortype"	id="Vendortype" >
									<option value="Direct">Direct Purchase Payment</option>
									<option value="Purchase">Purchase Order Payment</option>
								</select>								</td>
							</tr>
							 
							
							<tr>
							  <td height="17" class="boldEleven"><strong>Vendor Name </strong></td>
							  <td colspan="2" align="left">
							  <input type="text" id="searchInput" placeholder="Start typing..." onKeyUp="fetchSuggestions()">
    <select id="suggestionsDropdown" name="suggestionsDropdown"  size="5" style="display: none;"><option value='0'>All</option></select>

    <script>
        function fetchSuggestions() {
            var inputVal = $("#searchInput").val();
            if (inputVal.length === 0) {
                // Hide dropdown if input is empty
                $("#suggestionsDropdown").hide().empty();
                return;
            }

            $.ajax({
                type: "POST",
                url: "../AutocompleteDropDown", // This maps to your server-side servlet
                data: { actionS: "VENDORNAME", query: inputVal },
                dataType: "json", // Expecting JSON data from the server
                success: function(data) {
                    var dropdown = $("#suggestionsDropdown");
                    dropdown.empty(); // Clear previous options
                     dropdown.append($('<option></option>').val('0').text('All'));
                    // Populate dropdown with new suggestions
                    $.each(data, function(key, value) {
                        // Assuming the server returns an array of objects like {id: 1, name: "Item Name"}
                        dropdown.append($('<option></option>').val(value.id).text(value.name));
                    });

                    // Show the dropdown if there are suggestions
                    if (data.length > 0) {
                        dropdown.show();
                    } else {
                        dropdown.hide();
                    }
                },
                error: function(xhr, status, error) {
                    console.error("AJAX error: " + status + error);
                }
            });
        }
    </script>

							  </td>
						  </tr>
							
							<tr>
							  <td height="17" class="boldEleven"><strong>Order by </strong></td>
							  <td colspan="2" align="left">
							  <select name="order" id="order">
							  	<option value="b.DAT_ORDERDATE">Date</option>
							  	<option value="c.CHR_VENDORNAME">Vendor Name</option>
							    </select>							  </td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven"><strong>Days
								Left </strong></td>
								<td colspan="2" align="left">
								<table width="100" border="0" cellspacing="2" cellpadding="2">
									<tr>
										<td class="boldEleven"><strong>&gt;=</strong></td>
										<td class="boldEleven"><input name="From" type="text"
										class="formText135" id="From"  
										style='text-align:right' tabindex="11"
										 onKeyPress="return numeric_only(event,'From','7') "  size="5" maxlength="5" /></td>
										<td class="boldEleven">&lt;=</td>
										<td class="boldEleven"><input name="To" type="text"
										class="formText135" id="To"  
										style='text-align:right' tabindex="11"
										 onKeyPress="return numeric_only(event,'To','7') "  size="5" maxlength="5" /></td>
									</tr>
								</table>								</td>
							</tr>
							
							<tr>
							  <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="2" align="left"><input name="filename"
									type="hidden" value="Reports" /> <input name="actionS"
									type="hidden" value="INVPaymentPending" /></td>
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
											onClick="javascript:window.close()"></td>
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
		checkNull( "From","Enter Starting Date" )
		&& checkNull( "To","Enter Ending Date" )
		&& checkNullSelect( "suggestionsDropdown","Select Vendor",'' )
		
	)
		return true;
	else
		return false;				
		
 } 	
</script> <%@ include file="../footer.jsp"%></form>
</body>
</html>
