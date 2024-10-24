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
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
</head>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui.min.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.js"></script>
<script type="text/javascript" src="../JavaScript/jquery/Time/jquery-ui-sliderAccess.js"></script>
<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css">
<script language="javascript">
function validate()
{
	if(
		checkNull('callno','Enter callno','0') 
		&& checkNull('serialno','Enter Serial No') 
		&& checkNMCall()
		&& checkNull('description','Enter Description') 
		&& checkNull('fromdate','Select Raised Date') 
		&& checkNull('despatchlocation','Enter Despatch Location') 
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

<body onLoad="">
<jsp:include page="indexinv.jsp" />
<link href="../JavaScript/jquery/Time/jquery-ui.css" rel="stylesheet" type="text/css">
<link href="../JavaScript/jquery/Time/jquery-ui-timepicker-addon.css" rel="stylesheet" type="text/css">
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
					<td height="6" align="center">&nbsp;</td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
				  <td width="412">
				  <table width="400" height="544" border="0" align="center">
        	 <tr>
                <td height="20" colspan="4" align="left" valign="middle">&nbsp;</td>
             </tr>
			 
              <tr>
                <td height="24" colspan="4" align="center" valign="top"><span class="boldThirteen">
                <spacer height="1" width="1" type="block" />
SPARE DEMAND
<%
String Rowid = request.getParameter("id");
String idd="",pserial="",desc ="",from="",descploca="",callnum="";
String customer="",customeraddress="",partdescription="",calltype="";
String sql="";

sql = " SELECT a.INT_DEMANID,a.CHR_PRODUCT_SERIALNUMBER,a.CHR_CALLNUMBER,a.CHR_DESC, ";
sql = sql + " DATE_FORMAT(a.DAT_DEMAND_RAISED_DATE,'%d-%m-%Y %H:%i'),a.CHR_DESPATCH_LOCATION,   ";
sql = sql + " if(a.CHR_CALLTYPE='Q',  ";
sql = sql + " ( SELECT c .CHR_CUSTOMERNAME FROM inv_ss_sparemaster c    ";
sql = sql + " WHERE  c .CHR_SERIALNO = a.CHR_PRODUCT_SERIALNUMBER),   ";
sql = sql + " a.CHR_CUSTOMER  ";
sql = sql + " ) customer ,  ";
sql = sql + " if(a.CHR_CALLTYPE='Q',  ";
sql = sql + " ( SELECT c2.CHR_CUSTOMERADDRESS FROM inv_ss_sparemaster c2   ";
sql = sql + " WHERE  c2.CHR_SERIALNO = a.CHR_PRODUCT_SERIALNUMBER),   ";
sql = sql + " a.CHR_CUSTOMER_ADDRESS  ";
sql = sql + " ) address ,  ";
sql = sql + " a.CHR_CALLTYPE,";
sql = sql + "   if(a.CHR_CALLTYPE='Q', ( SELECT CONCAT(c3.CHR_UNITTYPE,',',c3.CHR_MODELNUMBER) FROM inv_ss_sparemaster c3 WHERE c3.CHR_SERIALNO = a.CHR_PRODUCT_SERIALNUMBER),  a.CHR_PART_DESC ) partdescription  ";
  
sql = sql + " FROM inv_ss_sparedemand a WHERE  a.INT_DEMANID="+Rowid+"";
//out.println(sql);
String data[][]= CommonFunctions.QueryExecute(sql);
								idd=data[0][0];
								pserial=data[0][1];
								callnum=data[0][2];
								desc=data[0][3];
								from= data[0][4];
								descploca=data[0][5];
								customer=data[0][6];
								customeraddress=data[0][7];
								calltype=data[0][8];
								partdescription=data[0][9];
								
%>
                </span></td>
                </tr>
              <tr>
                <td width="5" height="24">&nbsp;</td>
                <td width="129"><span class="boldEleven">Call Number <span class="bolddeepred">*</span></span></td>
                <td width="242" class="boldEleven" align="left">
				<input type="text" size ="27" class="formText135"  name="callno" value="<%=callnum%>" id="callno" maxlength="12" onKeyPress="return numeric_only(event,'callno','13')" />				</td>
                <td width="6">&nbsp;</td>
              </tr>
			  	 <tr>
                <td width="5" height="24">&nbsp;</td>
                <td width="129"><span class="boldEleven">Product SerialNo <span class="bolddeepred">*</span></span></td>
                <td width="242" class="boldEleven" align="left"><input type="text" size ="27" class="formText135"  onBlur="upperMe(this)" name="serialno" value="<%=pserial%>" id="serialno" maxlength="50" readonly ='readonly' /> </td>
                <td width="6">&nbsp;</td>
              </tr>	
			  
			      <tr>
			       <td>&nbsp;</td>
			       <td align="left" valign="top" class="boldEleven">Customer&nbsp;</td>
			       <td class="boldEleven" align="left"><input name="customer" type="text" class="formText135" id="customer" value="<%=customer%>" size="40" maxlength="50"  ></td>
			       <td>&nbsp;</td>
			       </tr>
			     <tr>
			       <td>&nbsp;</td>
			       <td align="left" valign="top" class="boldEleven">Customer Address</td>
			       <td class="boldEleven" align="left"><textarea onKeyUp="textArea('customeraddress','500')" name="customeraddress" cols="39"    onBlur="upperMe(this)"    rows="5" class="formText135" id="customeraddress" tabindex="9" title="Please enter the customer address"   ><%=customeraddress%></textarea></td>
			       <td>&nbsp;</td>
			       </tr>
			     <tr>
			       <td>&nbsp;</td>
			       <td align="left" valign="top" class="boldEleven">Call type</td>
			       <td class="boldEleven" align="left"><select name="calltype" class="formText135" id="calltype" title="please select call type"   style="width:200"  readonly ='readonly' disabled>
			         <option value="">Select Call type</option>
			         <option value="N">Not Qualified</option>
			         <option value="M">No Machine</option>
			         <option value="Q">Qualified</option>
		            </select><input name="calltype" type="hidden" value="<%=calltype%>">
                    <script language="javascript">setOptionValue('calltype','<%=calltype%>')</script>
                    </td>
			       <td>&nbsp;</td>
			       </tr>
			     <tr>
			       <td>&nbsp;</td>
			       <td align="left" valign="top" class="boldEleven">Part Description</td>
			       <td class="boldEleven" align="left"><textarea onKeyUp="textArea('partdescription','500')" name="partdescription" cols="39"    onBlur="upperMe(this)"    rows="5" class="formText135" id="partdescription" tabindex="9" title="Please enter the part description"   ><%=partdescription%></textarea></td>
			       <td>&nbsp;</td>
			       </tr>
			     <tr>
                <td width="5" height="65">&nbsp;</td>
                <td width="129"><span class="boldEleven">Description<span class="bolddeepred">*</span></span>&nbsp;</td>
                <td width="242" class="boldEleven" align="left"><textarea type="text" name="description"   cols="24" id="description" rows="5" class="formText135"><%=desc%></textarea></td>
                <td width="6">&nbsp;</td>
              </tr>	    
               <tr>
                <td width="5" height="22">&nbsp;</td>
                <td width="129"><span class="boldEleven">Raised Date<span class="bolddeepred">*</span></span>&nbsp;</td>
                <td width="242" class="boldEleven" align="left">
                  <input name="fromdate" type="text" class="formText135" id="fromdate" value="<%=from%>" size="27"  readonly="readonly"/> 
				
				<script language="javascript">
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
                <td width="6">&nbsp;</td>
              </tr>	
			   <tr>
                <td width="5" height="22">&nbsp;</td>
                <td width="129"><span class="boldEleven">Despatch Location<span class="bolddeepred">*</span></span></td>
                <td width="242" class="boldEleven" align="left"><input name="despatchlocation" type="text" class="formText135" id="despatchlocation" value="<%=descploca%>" size="27" maxlength="30" />
	  </td>
                <td width="6">&nbsp;</td>
              </tr>	
              <tr>
                <td height="21" class="boldEleven">&nbsp;</td>
                <td>&nbsp;</td>
                <td><input type="hidden" name="filename" value="SSpareDemand" />
                    <input type="hidden" name="actionS" value="INVSpareDemandEdit"/>
					<input type="hidden" id="id" name="id" value="<%=idd%>"/>
					</td>
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
