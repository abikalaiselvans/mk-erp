<%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<jsp:directive.page import="com.my.org.erp.SmartInventory.Product" />
<html>
<head>
<title>:: INVENTORY ::</title><style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
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
 <script language="javascript" src="../JavaScript/Numericfunctions.js"></script>

<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Inventory/AssignPaymentCommitment.js"></script>
 
<script language="JavaScript">
 	function PageBack()
	{
	     //future enhancement
    }
 	
	
	
  function Validate()
  {
   		try
		{
	
			var b =parseFloat(document.getElementById('Balance').value);
			var b1 =parseFloat(document.getElementById('Paid').value);
			 
			if(
				
				checkNullSelect("salesOrderId","Select Service Billing...",'Select') 
				&& PaymentCommitmentCheck()
				&& checkNull("salesDate","Enter Sales Date...") 
				&& checkNullSelect("paymentMethod","Select Payment Method...",'Select') 
				&& checkNull("paymentDate","Enter paymentDate...")
				&& checkNull("salesAmount","Enter salesAmount...")
				&& checkNull("Balance","Enter Balance...")
				&& checkNull("Paid","Enter Amount Paid...")
				&& checkNull("ref","Select Payment collected by...")
				&& checkNullSelect("creditto","Select credited to",'') 
				&& ((b-b1) >= 0)
			)
			{		
				sval=document.getElementById('paymentMethod').value;	
				var its =sval.split(",");
				if(its[1] != "CASH" || its[1] != "CASH")
				{
					if(checkNullSelect("Bank","Select Bank Name ","Select") && 
					checkNull('Challanno','Cheque/ D.D /Credit Card Number'))
						return true;
					else
						return false;
				}
				else
					return true;	
			}		
			else
				return false;	
		}
		catch(err)
		{
			alert(err);
			return false;
		}
				
  } 
  
  
  	function CheckBalance(gctr)
	{
		var gval=gctr.value;
		if(gval!="")
		{
			var bval=document.getElementById('Balance').value;
			
			bval=parseInt(bval);
			gval=parseInt(gval);
			if(gval<=bval){
				document.getElementById('Valid').innerHTML="<font  class='boldgreen'>VALID</font>";
				document.getElementById('submit').disabled=false;
			}
			else 
			{
				document.getElementById('Valid').innerHTML="<font class='bolddeepred'>IN VALID</font>";
				document.getElementById('submit').disabled=true;
			}
		}
		else
		{
				document.getElementById('Valid').innerHTML="";
				document.getElementById('submit').disabled=false;
		
		}
		
	}
 	
</script>
 

<body    onLoad="disable()">

<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" action="../SmartLoginAuth" method="post" onSubmit="return Validate()">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
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
					<td width="50">
					<table cellspacing="2" cellpadding="2" width="510" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Service Billing Payment</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">
								Mandatory </span></td>
							</tr>
							<tr>
								<td width="193" height="17" class="boldEleven">
								Service Bill Number <span class="bolddeepred"> * </span></td>
								<td width="285" colspan="2" align="left"> 
<select name="salesOrderId" id="salesOrderId" style="width: 175" class="formText135" onblur='assignServiceBillingValue(this)' onChange="AssignPaymentCommitment(this,'S')">
<option value="Select">Select</option>
	<%
		String Branch = request.getParameter("Branch");
		String sql="SELECT CHR_SALESNO FROM inv_t_servicebilling WHERE INT_BRANCHID="+Branch+" AND CHR_PAYMENTSTATUS!='Y' " ;
		sql = sql +" ORDER BY INT_ID";
		out.println(sql);
		String invoicedata[][] = CommonFunctions.QueryExecute(sql);
		for(int u=0;u<invoicedata.length;u++)
			out.println("<option value="+invoicedata[u][0]+">"+invoicedata[u][0]+"</option>");
 %>
</select>								</td>
							</tr>
							<tr>
							  <td height="17" colspan="3" class="boldEleven"><div id="AssignPaymentCommitmentDiv"  style="OVERFLOW:auto;width:100%;height:auto" class="boldEleven"></div></td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven">Service Bill  Date<span
									class="bolddeepred"> * </span></td>
								<td colspan="2" align="left"><input
									onKeyPress="dateOnly(this)" name="salesDate" size="31"
									type="text" class="formText135" id="salesDate" maxlength="15"
									readonly="readonly"></td>
							</tr>

							<tr>
								<td height="17" class="boldEleven">Customer Name</td>
								<td colspan="2" align="left"><input name="customerName"
									readonly="readonly" value="" size="31" type="text"
									class="formText135" id="customerName" maxlength="15"
									onKeyPress="" ></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Payment Method <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><select name="paymentMethod"
									id="paymentMethod" style="width: 175" class="formText135"
									onblur='assignNumber(this)'>
									<option value="Select">Select</option>
									<%
					  	String payments[][] =   CommonFunctions.QueryExecute("SELECT INT_PAYMENTTERMID,CHR_PAYMENTNAME FROM inv_m_paymentterms  ");	
						
					  for(int u=0; u<payments.length;u++)
					  		out.println("<option value='"+payments[u][0]+","+payments[u][1]+"'>"+payments[u][1]+"</option>");
					  %>
								</select></td>
							</tr>
							<tr id="chk1">
								<td height="17" class="boldEleven">Bank Name <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><select name="Bank" id="Bank"
									style="width: 175">
									<option value="Select">Select</option>
									<%
					   sql = "SELECT INT_BANKGROUPID, CHR_BANKGROUPNAME FROM com_m_bankgroup ORDER BY CHR_BANKGROUPNAME";
					   String banks[][] =  com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					  for(int u=0; u<banks.length;u++)
					  		out.println("<option value='"+banks[u][0]+"'>"+banks[u][1]+"</option>");
					  %>
								</select></td>
							</tr>
							<tr id="chk2">
								<td height="17" class="boldEleven">Cheque/ D.D /Credit Card
								Number<span class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="Challanno"
									type="text" class="formText135" id="Challanno" size="31" maxlength="30"></td>
							</tr>
							<tr id="chk3">
							  <td height="17" class="boldEleven">Cheque/ D.D  / Date</td>
							  <td colspan="2" align="left"><input name="chequeDate"
									type="text" class="formText135" id="chequeDate" size="27"
									 readonly="readonly" />
                                <a
									href="javascript:ccal1.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /> </a>
                                <script language='JavaScript'
									type="text/javascript">
						<!--			
							var ccal1 = new calendar1(document.forms['frm'].elements['chequeDate']);
							ccal1.year_scroll = true;
							ccal1.time_comp = false;
							setCurrentDate('chequeDate'); 
						//-->
                                </script></td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven">Payment Received Date <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="paymentDate"
									type="text" class="formText135" id="paymentDate" size="27"
									readonly="readonly"  /> <a
									href="javascript:cal1.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /> </a> <script language='JavaScript'
									type="text/javascript">
						<!--			
							var cal1 = new calendar1(document.forms['frm'].elements['paymentDate']);
							cal1.year_scroll = true;
							cal1.time_comp = false;
							setCurrentDate('paymentDate'); 
						//-->
                       </script></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Invoice Amount</td>
								<td colspan="2" align="left"><input name="salesAmount"
									value="" size="30" type="text" class="formText135"
									id="salesAmount" maxlength="15"
									onKeyPress="doubleValue('salesAmount','12')" readonly></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Balance Amount <span
									class="bolddeepred"> <%
				  
				  %> <input name="customerid" type="hidden" id="customerid">
								</span></td>
								<td colspan="2" align="left"><input name="Balance" value=""
									size="30" type="text" class="formText135" id="Balance"
									maxlength="15"  
									readonly="readonly"></td>
							</tr>

							<tr>
								<td height="17" class="boldEleven">Amount Paid <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="Paid" size="30"
									type="text" class="formText135" id="Paid" maxlength="15" onKeyUp="extractNumber(this,2,true),CheckBalance(this);" onKeyPress="return blockNonNumbers(this, event, true, true);"
									   >
								<div id="Valid"></div>								</td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Remarks  							</td>
								<td colspan="2" align="left"><textarea name="remarks" onKeyPress="textArea('remarks','400')"
									cols="25" rows="5" class="formText135" id="remarks"></textarea></td>
							</tr>
							<tr>
                              <td height="17" valign="top" class="boldEleven">Payment collected by </td>
							  <td colspan="2" align="left" valign="top"><select name="ref" id="ref"
										class="formText135" size="5" style="width:200">
                                  <jsp:include page="Staffload.jsp" flush="true" />                            
						      </select></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Credit to <span
									class="bolddeepred">* </span></td>
							  <td colspan="2" align="left"><select name="creditto" class="formText135" id="creditto" style="width:200">
							    <option value="">Select</option>
							    <%
					   sql = "SELECT INT_DEPOSITID, CHR_DEPOSITNAME FROM com_m_deposit_to WHERE CHR_STATUS !='N' ORDER BY CHR_DEPOSITNAME";
					   String deposit[][] = CommonFunctions.QueryExecute(sql);
					  for(int u=0; u<deposit.length;u++)
					  		out.println("<option value='"+deposit[u][0]+"'>"+deposit[u][1]+"</option>");
					  %>
						      </select></td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="2" align="left"><input name="filename"
									type="hidden" value="ServiceBilling" /> 
								<input name="actionS"
									type="hidden" value="INVSalesPaymen" />
								<input name="count" type="hidden" id="count" value="0"></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit11" type="submit" id="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
										<td><input name="Close" type="Button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('ServiceBillingPayment.jsp')"></td>
									</tr>
								</table>								</td>
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
</table>
  <script language="javascript">
	 
   		
	function assignNumber(itm)
	{
		var its = itm.value.split(",");
		if(its[1] != "CASH" || its[1] != "CASH")
			enable();
		else
			disable();
	}
	
	function enable()
	{
		chk1.style.visibility="Visible";
		chk2.style.visibility="Visible";
		chk3.style.visibility="Visible";
	}
	function disable()
	{
		 chk1.style.visibility="hidden";
		 chk2.style.visibility="hidden";
		 chk3.style.visibility="hidden";
	}

var isIE;
var req;
var names;

function getElementY(element)
{
	var target1Top = 0;
	if (element.offsetParent) {
		while (element.offsetParent) {
			target1Top += element.offsetTop;
            element = element.offsetParent;
		}
	} else if (element.y) {
		target1Top += element.y;
    }
	return target1Top;
}
function initRequest(url) 
{
    if (window.XMLHttpRequest) {
        req = new XMLHttpRequest();
    } else if (window.ActiveXObject) {
        isIE = true;
        req = new ActiveXObject("Microsoft.XMLHTTP");
    }
}

function callBalanceAmount(salesid)
{
	var ptype=document.getElementById('payType').value;
	var url = "../inventory?actionS=INVSalesPayamounts&salesid="+escape(salesid)+"&payType="+escape(ptype);
	initRequest(url);
	req.onreadystatechange = SalesPaymentRequest;
    req.open("GET", url, true);
    req.send(null);	
}

function SalesPaymentRequest() {
    if(req.readyState == 4) {      
        if (req.status == 200) {
          SalesPaymentMessages();
        }
    }
}
function SalesPaymentMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Amounts")[0];       
	var Balance="";
	var Customer="";
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
		Balance = batch.getElementsByTagName("Balance")[0];
		Customer = batch.getElementsByTagName("Customer")[0];
		Balance=Balance.childNodes[0].nodeValue;
		Customer=Customer.childNodes[0].nodeValue;
    }  
    document.getElementById('customerName').value=Customer;
	document.getElementById('Balance').value= Math.round(parseFloat(document.getElementById('salesAmount').value) -parseFloat(Balance));
}
function checkAmount()
{
	var b =parseFloat(document.getElementById('Balance').value);
	var b1 =parseFloat(document.getElementById('Paid').value);
	if((b-b1) < 0)
		{
			alert("The paid amount should be lessthan or equal to balance amount...");
			document.getElementById('Paid').value = "0.0";
		}
	
}


//Assign a value 

function assignServiceBillingValue(ctr)
{
	var invno= ctr.value;
	var url = "../inventory?actionS=INVServiceBillingValue&invno="+escape(invno)+"&Branch=<%=Branch%>";
	document.getElementById('customerName').value="";
	document.getElementById('salesDate').value="";
	document.getElementById('salesAmount').value="";
	document.getElementById('Balance').value="";
	document.getElementById('Paid').value="";
	initRequest(url);
	req.onreadystatechange = ServicePaymentRequest;
    req.open("GET", url, true);
    req.send(null);	
}

function ServicePaymentRequest() {
    if(req.readyState == 4) {      
        if (req.status == 200) {
          ServicePaymentMessages();
        }
    }
}
function ServicePaymentMessages() 
{	 
    var batchs = req.responseXML.getElementsByTagName("Amounts")[0];       
	var Balance="";
	var Customer="";
	var Invoiceamount="";
	var paid="";
	
	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    {
	    var batch = batchs.childNodes[loop];
		
		Invoiceamount = batch.getElementsByTagName("Invoiceamount")[0];
		Paid = batch.getElementsByTagName("Paid")[0];
		Balance = batch.getElementsByTagName("Balance")[0];
		Customer = batch.getElementsByTagName("Customer")[0];
		Invoicedate = batch.getElementsByTagName("Invoicedate")[0];
		
		
		Invoiceamount=Invoiceamount.childNodes[0].nodeValue;
		Paid=Paid.childNodes[0].nodeValue;
		Balance=Balance.childNodes[0].nodeValue;
		Customer=Customer.childNodes[0].nodeValue;
		Invoicedate=Invoicedate.childNodes[0].nodeValue;
		
    }  
    document.getElementById('customerName').value=Customer;
	document.getElementById('salesDate').value=Invoicedate;
	document.getElementById('salesAmount').value=""+Invoiceamount;
	document.getElementById('Balance').value=""+parseFloat(Balance);
	document.getElementById('Paid').value=""+parseFloat(Balance);
	
}
</script></form>
<%@ include file="../footer.jsp"%>
</body>
</html>
