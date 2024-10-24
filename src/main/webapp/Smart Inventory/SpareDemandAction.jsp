 <%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
String dojlock= CommonFunctions.QueryExecute(" SELECT INT_DATLOCK FROM M_INSTITUTION WHERE INT_ID=1 ")[0][0];
%>
<%
try
{
%>
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>


<html>
<head>
<title><%= CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='INV' ")[0][0]%></title>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
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
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui.min.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-sliderAccess.js"></script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">
<link href="../JavaScript/jquery/Time/jquery-ui.css" rel="stylesheet" type="text/css">
<link href="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.css" rel="stylesheet" type="text/css">


<script language="javascript">
function validate()
{
	if(
		checkNull('callno','Enter callno') 
		&& checkNull('serialno','Enter Serial No') 
		&& checkNMCall()
		&& checkNull('description','Enter Description') 
		&& checkNull('fromdate','Select Raised Date') 
		&& checkNull('despatchlocation','Enter DespatchLocation') 
		
	)
		return true;
	else
		return false;
}

function checkNMCall()
{
	try
	{
		
		var calltype = document.getElementById('calltype').value;
		if(calltype != "Q")
		{
			if(
				checkNull('customer','Enter customer') 
				&& checkNull('customeraddress','Enter customeraddress') 
				&& checkNull('partdescription','Enter part description') 
				 
				)	
				return true;
			else
				return false;
		}
		else
		{
			document.getElementById('customer').value ="";
			document.getElementById('customeraddress').value ="";
			document.getElementById('partdescription').value ="";
			
			return true;
		}
	}
	catch(err)
	{
			alert(err);
			return false;
	}
}


</script>

<script type="text/javascript">
function lookup(serialNo) 
{
	if(serialNo.length == 0) 
	{
		$('#suggestions').hide();
	} 
	else 
	{
		$.post("spareserialnumberget.jsp", {queryString: ""+serialNo+""}, function(data)
		{
			 
			if(data.length >0) 
			{
				$('#suggestions').show();
				$('#autoSuggestionsList').html(data);
			}
		});
	}
}

function fill(thisValue) 
{
	var v = thisValue.split("~");
	 
	document.getElementById('serialno').value=v[0];
	document.getElementById('customer').value=v[1];
	document.getElementById('customeraddress').value=v[1];
	document.getElementById('partdescription').value=v[2];
	
	$('#serialno').val(v[0]);
	setTimeout("$('#suggestions').hide();", 200);
}

function fill0(thisValue) 
{
	var v = thisValue.split("~"); 
	document.getElementById('serialno').value=v[0];
	$('#serialno').val(v[0]);
	setTimeout("$('#suggestions').hide();", 200);
}


</script>
<style type="text/css">
body {
font-family: Helvetica;
font-size: 13px;
color: #000;
}
h3 {
margin: 0px;
padding: 0px;
}


.suggestionsBox 
{
	position: relative;
	margin: 0px 0px 0px 0px;
	width: 200px;
	background-color: #ffffff;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	border: 1px solid #000;
	color: #000;
}
.suggestionList 
{
	margin: 0px;
	padding: 0px;
}
.suggestionList li 
{
	margin: 0px 0px 3px 0px;
	padding: 1px;
	cursor: pointer;
}

.suggestionList li:hover {
background-color: #99cc99;
}
</style>


<body onLoad="">
<jsp:include page="indexinv.jsp" />
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
		<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="../SmartLoginAuth" onSubmit="return validate()">
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="500"
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
					<td height="6" align="center">&nbsp;</td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
				  <td>
				  <table width="100%" height="362" border="0" align="center">
        	 <tr>
                <td colspan="4" height="20"><span class="boldThirteen"></span></td>
             </tr>
			 
              <tr>
                <td height="24" colspan="4" align="center" class="boldgre"> 
                  <center>
                    <span class="boldThirteen">SPARE DEMAND</span>
                  </center></td>
                </tr>
              <tr>
                <td width="15" height="24">&nbsp;</td>
                <td width="126" class="boldEleven">Call Number <span class="bolddeepred">*</span></td>
                <td width="221" class="boldEleven" align="left">
				<input type="text" size ="40" class="formText135"  name="callno" value="" id="callno" maxlength="12" onKeyPress="return numeric_only(event,'callno','13')" required />				</td>
                <td width="20">&nbsp;</td>
              </tr>
			  	 <tr>
                <td width="15" height="24">&nbsp;</td>
                <td width="126" class="boldEleven">Product SerialNo <span class="bolddeepred">*</span></td>
                <td colspan="2" align="left" class="boldEleven">
                  
                  <input name="serialno" type="text" class="formText135" id="serialno" tabindex="2" size="40" maxlength="30"   onkeyup=" lookup(this.value);" required>
                  <br>
                  <div class="suggestionsBox" id="suggestions" style="display: none;">
                    <div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:100px" ></div>
                    </div> 
                  
                  
                </td>
                </tr>	
			     <tr>
			       <td>&nbsp;</td>
			       <td align="left" valign="top" class="boldEleven">Customer&nbsp;</td>
			       <td class="boldEleven" align="left"><input name="customer" type="text" class="formText135" id="customer" size="40" maxlength="50"  ></td>
			       <td>&nbsp;</td>
			       </tr>
			     <tr>
			       <td>&nbsp;</td>
			       <td align="left" valign="top" class="boldEleven">Customer Address</td>
			       <td class="boldEleven" align="left"><textarea onKeyUp="textArea('customeraddress','500')" name="customeraddress" cols="39"    onBlur="upperMe(this)"    rows="5" class="formText135" id="customeraddress" tabindex="9" title="Please enter the customer address"   ></textarea></td>
			       <td>&nbsp;</td>
			       </tr>
			     <tr>
			       <td>&nbsp;</td>
			       <td align="left" valign="top" class="boldEleven">Call type</td>
			       <td class="boldEleven" align="left"><select name="calltype" class="formText135" id="calltype" title="please select call type"   style="width:200"  readonly ='readonly'>
			         <option value="">Select Call type</option>
			         <option value="N">Not Qualified</option>
			         <option value="M">No Machine</option>
			         <option value="Q">Qualified</option>
		            </select></td>
			       <td>&nbsp;</td>
			       </tr>
			     <tr>
			       <td>&nbsp;</td>
			       <td align="left" valign="top" class="boldEleven">Part Description</td>
			       <td class="boldEleven" align="left"><textarea onKeyUp="textArea('partdescription','500')" name="partdescription" cols="39"    onBlur="upperMe(this)"    rows="5" class="formText135" id="partdescription" tabindex="9" title="Please enter the part description"   ></textarea></td>
			       <td>&nbsp;</td>
			       </tr>
			     <tr>
			       <td>&nbsp;</td>
			       <td align="left" valign="top" class="boldEleven">&nbsp;</td>
			       <td class="boldEleven" align="left">&nbsp;</td>
			       <td>&nbsp;</td>
			       </tr>
			     <tr>
                <td width="15" height="65">&nbsp;</td>
                <td width="126" align="left" valign="top" class="boldEleven">Description<span class="bolddeepred">*</span>&nbsp;</td>
                <td width="221" class="boldEleven" align="left"><textarea type="text" name="description"   cols="39" id="description" rows="5" class="formText135"></textarea></td>
                <td width="20">&nbsp;</td>
              </tr>	    
               <tr>
                <td width="15" height="22">&nbsp;</td>
                <td width="126" class="boldEleven">Raised Date<span class="bolddeepred">*</span>&nbsp;</td>
                <td width="221" class="boldEleven" align="left">
                  <input name="fromdate" type="text" class="formText135" id="fromdate" value="" size="25"  readonly="readonly"/> 
				
				<script language="javascript">
						setCurrentDateandTime('fromdate');
						$('#fromdate').datetimepicker({
							
							showSecond: true,
							timeFormat: 'hh:mm:ss',
							stepHour: 1,
							stepMinute: 1,
							stepSecond: 10,
							showOn: "button",
							buttonImage: "../JavaScript/jquery/images/calendar.gif",
							buttonImageOnly: true,
							changeMonth: true,
							numberOfMonths: 1,minDate: -2, maxDate: "+2D" ,
	
							onClose: function(dateText, inst) {
								var startDateTextBox = $('#fromdate');
								if (startDateTextBox.val() != '') {
									var testStartDate = new Date(startDateTextBox.val());
									var testEndDate = new Date(dateText);
									if (testStartDate > testEndDate)
										startDateTextBox.val(dateText);
								}
								else {
									startDateTextBox.val(dateText);
								}
							},
							
						});
				</script>				
</td>
                <td width="20">&nbsp;</td>
              </tr>	
			   <tr>
                <td width="15" height="22">&nbsp;</td>
                <td width="126" class="boldEleven">Despatch Location<span class="bolddeepred">*</span></td>
                <td width="221" class="boldEleven" align="left"><input name="despatchlocation" type="text" class="formText135" id="despatchlocation" size="40"  maxlength="30" required value="<%=CommonFunctions.QueryExecute("SELECT UPPER(CHR_BRANCHNAME) FROM com_m_branch  WHERE INT_BRANCHID="+session.getAttribute("INVBRANCH"))[0][0]%>"/>
			   </td>
			  
                <td width="20">&nbsp;</td>
              </tr>	
              <tr>
                <td height="21" class="boldEleven">&nbsp;</td>
                <td>&nbsp;</td>
                <td><input type="hidden" name="filename" value="SSpareDemand" />
                    <input type="hidden" name="actionS" value="INVSpareDemandAdd"/></td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td height="34" colspan="4"><table border="0" align="center" cellpadding="2"
										cellspacing="2">
                    <tr>
                      <td width="56"><input type="submit" name="Submit"	id="submit_btn" class="buttonbold" value="Submit"   accesskey="s"    /></td>
                      <td width="56"><input type="button" name="submit" class="buttonbold"  value="Close"   accesskey="c" 	onClick="redirect('SSpareDemand.jsp')" /></td>
                    </tr>
                </table></td>
              </tr>
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
					<td class="BorderLine" height="0"><spacer height="1" width="1" type="block" /></td>
				</tr>
			</tbody>
		</table>
		</form>
		</td>
	</tr>
	<tr>
		<td height="65">&nbsp;</td>
	</tr>
</table>
<jsp:include page="../footer.jsp" />
</body>
</html>
<%
}
catch(Exception e)
{
}
%>
