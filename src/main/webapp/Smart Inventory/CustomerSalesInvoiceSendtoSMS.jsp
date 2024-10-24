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
 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
 <script type="text/javascript"> 
function checkmessage(form)
{
	var msg=document.myform.txtMessage.value.toLowerCase();
	var bannedWords= new Array("banda","bia","pela","galei","gand","gheinibi","dudha","gola","chipibi","chipbi","madar","madarchod","bedhei","bando","bedhi","ghyan","fuck","sex");
	var alength=bannedWords.length;
	for(var i=0;i<alength;i++)
	{
		if(msg.indexOf(bannedWords[i])>=0)
		{
			<!--
			window.location = "sending_failed.php"
			//-->
			return false;
		}
	}
 
}

function  validate()
{
	if(
		 checkNull( "txtMobileNo","Enter the mobile number" )
		 && lengthEqualCheck("txtMobileNo","10","Check your mobile number...")
		 &&checkNull( "txtMessage","Enter the Message" )
	 )
	 	checkmessage('myform');
	else
		return false;
}


</script>
<body >
 

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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="600"
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
					<table cellspacing="2" cellpadding="2" width="600" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							
							
							
							<tr>
							  <td height="17" class="boldEleven">
							  
							  <form action="../SmartLoginAuth" method="post" autocomplete="off" name="myform" onSubmit="return validate()">
<table width="100%" id=employee>
<tr>
  <th align="center">&nbsp;</th>
  <th align="center">Send  SMS
  <%
  String sql ="";
sql = " SELECT a.CHR_CONTACTNO,FIND_A_CUSTOMER_NAME(b.INT_CUSTOMERID),a.DOU_TOTALAMOUNT FROM inv_t_directsales a,inv_m_customerinfo b WHERE a.INT_CUSTOMERID=b.INT_CUSTOMERID AND CHR_SALESNO ='"+request.getParameter("saleno")+"' ";
String data[][] =com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
String message = "Invoice Raised for the customer "+data[0][1] +" and The amount is Rs."+data[0][2]+" - Mythra ";
  %>
  
  <input name="filename" type="hidden" value="SwapSale" />
  <input
			name="actionS" type="hidden" value="INVCustomerSalesInvoiceSendtoSMS" /></th></tr>
<tr>
  <td>To :</td>
  <td><input name="txtMobileNo" type="text" id="txtMobileNo" style="width:250px;" maxlength="12" value="<%=data[0][0]%>" onBlur="return numeric_only(event,'txtMobileNo','10')"  /></td></tr>
<tr>
  <td>&nbsp;</td>
  <td>&nbsp;</td>
</tr>
<tr>
  <td align="left" valign="top">Message :</td>
  <td align="left" valign="top"><textarea name="txtMessage" id="txtMessage" cols="0" rows="0" style="width:250px;height:80px;"  onBlur="textArea('txtMessage','120')" ><%=message%></textarea></td>
</tr>
<tr>
  <td align="center">&nbsp;</td>
  <td align="center"><input type="submit" name="btnSendSMS" id="btnSendSMS" value="Send SMS"  ></td>
</tr>
</table>
</form>
							  </td>
						  </tr>
						</tbody>
						 
					</table>					</td>
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
		</table>	  </td>
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
 
</body>
</html>
