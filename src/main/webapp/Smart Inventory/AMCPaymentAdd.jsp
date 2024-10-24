<%@ page import="java.io.*,java.util.*" errorPage="../error/index.jsp"%>
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
<script language="javascript"
	src="../JavaScript/Inventory/InventAJAX.js"></script>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript">


function AssignAmount(ctr) 
{
	
	var id=ctr.value;
	var type = document.getElementById('payType').value;    
	var url = "../inventory?actionS=INVServiceAmountAssign&type="+escape(type)+"&id="+escape(id);
	initRequest(url);
	req.onreadystatechange = LoadServiceAmountRequest;
    req.open("GET", url, true);
    req.send(null);
}

function LoadServiceAmountRequest() 
{
    if(req.readyState == 4) 
    {  
    	
		document.getElementById('balance').value=0;
		document.getElementById('serviceamount').value=0; 
    	if (req.status == 200) 
    	{		  	
         	LoadServiceAmountMessages();
        }
    }
}


function LoadServiceAmountMessages() 
{
		var batchs = req.responseXML.getElementsByTagName("ServiceIds")[0];   
    	var str="0"; 
		var str1="0"; 
    	for(loop = 0; loop < batchs.childNodes.length; loop++) 
    	{
	    	var batch = batchs.childNodes[loop];
	    	Serviceamount= batch.getElementsByTagName("Serviceamount")[0];
			Paidamount= batch.getElementsByTagName("Paidamount")[0];
			str = Serviceamount.childNodes[0].nodeValue;
			str1 = Paidamount.childNodes[0].nodeValue;
       }
	   document.getElementById('serviceamount').value=str; 
	   document.getElementById('balance').value=(parseFloat(str) - parseFloat(str1));
	    

}
 //End -Kalaiselvan--------------------------LoadAMCServiceids--------------------
 
 
 function Validate()
  {
	if(	
		checkNull("Serviceids","Select Service Id")
		&&checkNull("serviceamount","Select Service Amount")
		&&checkNull("paiddate","Enter Paid Date")
		&&checkNull("paidamount","Enter Paid Amount")		
		
		)
		{
		return true;	
		}
	else
		return false;			
  } 

</script>

<body    onLoad="LoadAMCServiceids()">
<%@ include file="indexinv.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td></td>
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
					<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm"
						onSubmit="return Validate()">
					<table cellspacing="2" cellpadding="2" width="600" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Payment Details</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>

							<tr>
								<td height="17" class="boldEleven">Payment Type</td>
								<td colspan="2" align="left"><select name="payType"
									id="payType" onChange="LoadAMCServiceids()">

									<option value="Invoice" selected="selected">AMC
									Payment</option>
									<option value="CashPay">Service Payment</option>
								</select></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">AMC/Service
								-ID</td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="75%" height="18" border="0" align="center"
									cellpadding="0" cellspacing="0" class="boldEleven">
									<tr>
										<td width="9%" valign="top" class="boldEleven">Search</td>
										<td width="25%" valign="top" class="boldEleven"><input
											name="idsearch" type="text" class="formText135" id="idsearch"
											size="20" onKeyUp="LoadAMCServiceids()"></td>
										<td width="5%" valign="top" class="boldEleven"></td>
										<td width="61%" valign="top" class="boldEleven">
										<div id="Ams_Service_id"></div>
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Total Amount</td>
								<td colspan="2" align="left"><input name="serviceamount"
									type="text" class="formText135" id="serviceamount" size="20"
									readonly="readonly"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Paid Date</td>
								<td colspan="2" align="left"><input name="paiddate"
									type="text" class="formText135" id="paiddate"
									onKeyPress="dateOnly(this)" size="20" maxlength="10" /> <a
									href="javascript:cal1.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /> </a> <script language='JavaScript'
									type="text/javascript">
						<!--			
							var cal1 = new calendar1(document.forms['frm'].elements['paiddate']);
							cal1.year_scroll = true;
							cal1.time_comp = false;
							setCurrentDate('paiddate'); 
						//-->
                       </script></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Paid Amount <span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left"><input name="paidamount"
									type="text" class="formText135" id="paidamount"
									onKeyPress="priceOnly(this)" size="20" maxlength="10"
									onBlur="callAmountCheck()">
								<div id="Valid"></div>
								</td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Payment
								Desc</td>
								<td colspan="2" align="left"><textarea name="paymentdesc"
									cols="25" rows="5" id="paymentdesc"></textarea></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Balance</td>
								<td colspan="2" align="left"><input name="balance"
									type="text" class="formText135" id="balance" size="20"
									readonly="readonly"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><input name="filename"
									type="hidden" value="AMCPayment" /> <input name="actionS"
									type="hidden" value="INVAMCPaymentAdd" /></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">

								<table border="0" align="center" cellpadding="1" cellspacing="1">
									<tr>
										<td width="56"><input type="Submit" class="buttonbold13"
											value="Submit" id="submit"></td>
										<td width="56"><input type="Button" class="buttonbold13"
											onClick="redirect('AMCPayment.jsp')"  value="Close"   accesskey="c" ></td>
									</tr>
								</table>
								</td>
							</tr>
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
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<script language="javascript">
function callAmountCheck()
{


	var totalamount  = parseFloat(document.getElementById('balance').value);  
	var paidamount  = parseFloat(document.getElementById('paidamount').value);  
	if (paidamount > totalamount)
	{
		alert("Paid amount should not greater than balance amount...");
		document.getElementById('paidamount').value =0;
	}
	if(paidamount == 0)
	{
		alert("Paid amount should not be zero...");
		document.getElementById('paidamount').focus();

	}
	
	
	
}
</script>
<%@ include file="../footer.jsp"%>
</body>
</html>
