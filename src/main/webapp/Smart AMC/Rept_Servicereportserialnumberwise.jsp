 <%@ page import="java.io.*,java.util.*"%>
 

<html>
<head>

<title> :: AMC ::</title>

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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
function validate()
{
	if(	checkNull("serialnumber","Enter Serialnumber")	)	
		return true;	
	else
		return false;	
}
</script>


<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>

<script type="text/javascript">
function lookup(SerialNumber) 
{
	if(SerialNumber.length == 0) 
	{
		$('#suggestions').hide();
	} 
	else 
	{
		$.post("serialnumberget.jsp", {queryString: ""+SerialNumber+""}, function(data)
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
	document.getElementById('serialnumber').value=thisValue;
	$('#serialnumber').val(thisValue);
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

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>

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
	  <td><form name="form1" method="post" action="Rept_Servicereportserialnumberwiseresponse.jsp" onSubmit="return validate()">
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="250"
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
				  <td width="412"><table width="500" border="0" cellspacing="2" cellpadding="2">
                    <tr>
                      <td colspan="2"><div align="center" class="bigusername">Service Report </div></td>
                    </tr>
                    <tr>
                      <td width="37%" class="boldEleven">Serial Number </td>
                      <td width="63%">
                        <input name="serialnumber" type="text" class="formText135" id="serialnumber" size="50" maxlength="50" onBlur="fill();"   onkeyup="upperMe(this),lookup(this.value);">  <div class="suggestionsBox" id="suggestions" style="display: none;">
											<div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:100px" ></div>
									</div>                    </td>
                    </tr>
                    <tr>
							  <td height="17" colspan="3" class="boldEleven" align="center"><div align="center" class="bolddeepred">Please type the seial number then select.... </div></td>
						  </tr>
                    <tr>
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                    </tr>
                    <tr>
                      <td colspan="2"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                        <tr>
                          <td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                          <td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('AMCmain.jsp')"></td>
                        </tr>
                      </table></td>
                    </tr>
                  </table></td>
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
		</table>	</form>  </td>
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
<%@ include file="../footer.jsp"%>
</body>
</html>
