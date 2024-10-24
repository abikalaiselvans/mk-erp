<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="./error.jsp"%>
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
<link href="../JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
 <script language="javascript" src="../JavaScript/Numericfunctions.js"></script>

<script language="JavaScript">
  function Validate()
  {
   
	if(
	checkNull("paymentdt","Enter Payment Date") 
	&& checkNull("paidamount","Enter PaidAmount") 
	&& checkNull("paid","Enter Paid Amount") 
	&& checkNull("purchaseamount","Enter Purchase Amount")
	&& checkNull("balance","Enter Balance Amount")
	&& calculateBalance()
	)
		return true;
	else
		return false;	
	
	
	
  } 
 	
</script>

<body >
<%@ include file="indexinv.jsp"%>
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
					<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm"
						onSubmit="return Validate()">
					<table cellspacing="2" cellpadding="2" width="388" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" align="center" valign="top" class="boldThirteen">
								Payment Details <%
                    
					String payment=request.getParameter("payment"); 
				  	String pid = request.getParameter("pid");
					String rowid = request.getParameter("rowid");
					String sql = "SELECT INT_PAYMENTTERMID,CHR_DDNUMBER,DAT_PAYMENTDATE,CHR_PAYMENTDESC,DOU_PURCHASEAMOUNT,DOU_PAIDAMOUNT,DOU_BALANCEAMOUNT ,INT_PAYMENTID,FIND_A_DEPOSIT_NAME(INT_BANKID) FROM  inv_t_vendorpurchasepayment  ";
				  	sql = sql +"WHERE CHR_PURCHASEORDERNO ='"+pid+"' AND INT_PAYMENTID="+rowid;
					String payData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					
					String paidamount="0";
					String lastPaidAmt="0";
					if("Direct".equals(payment))
					{
						sql = "SELECT DOU_PAIDAMOUNT FROM  inv_t_directpurchase  WHERE CHR_PURCHASEORDERNO='"+pid+"'";
						paidamount = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "DOU_PAIDAMOUNT");
						
						sql="SELECT DOU_PAIDAMOUNT FROM  inv_t_vendorpurchasepayment  WHERE INT_PAYMENTID="+rowid;
						lastPaidAmt = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "DOU_PAIDAMOUNT");				
					
					}
					else
					{
						sql = "SELECT DOU_PAIDAMOUNT FROM  inv_t_vendorpurchaseorder  WHERE CHR_PURCHASEORDERNO='"+pid+"'";
						paidamount = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "DOU_PAIDAMOUNT");
						
						sql="SELECT DOU_PAIDAMOUNT FROM  inv_t_vendorpurchasepayment  WHERE INT_PAYMENTID="+rowid;
						lastPaidAmt = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "DOU_PAIDAMOUNT");				
					
					}
					
					
									
					
					paidamount=""+(Double.parseDouble(paidamount)- Double.parseDouble(lastPaidAmt));
					
					String preBalance=""+(Double.parseDouble(lastPaidAmt)+ Double.parseDouble(payData[0][6]));
					 
					 
				  %>
								</td>
							</tr>
							<tr>
								<td height="19" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">
								<%
								 
				  String bankname="";
				  String ddno="";
				  
				  out.println("<table border=0 cellspacing=2 cellpadding=2>");
				  out.println("<tr><td class='boldEleven'>Purchase Order No</td>");
				  out.println("<td class='boldEleven'>"+pid);
				  
				  out.println("<tr><td class='boldEleven'>Payment Mode</td>");
				  out.println("<td class='boldEleven'>"+com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_PAYMENTNAME FROM inv_m_paymentterms WHERE INT_PAYMENTTERMID="+payData[0][0])[0][0]);				  
				   
				
				  out.println("<tr><td class='boldEleven'>Bank Name</td>");
				  out.println("<td class='boldEleven'>"+ payData[0][8] );		
				  
				  out.println("<tr><td class='boldEleven'>Cheque/DD number</td>");
				  out.println("<td class='boldEleven'>"+payData[0][1] );
				  
				  out.println("<tr><td class='boldEleven'>Payment Date  <span class='bolddeepred'>*</span></td>");
				  out.println("<td class='boldEleven'>");
				  out.println("<input class='formText135' type='text' readonly ='readonly' size=20 name='paymentdt' id='paymentdt'  value='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(payData[0][2])+"' />");
				  
				  %> <a href="javascript:cal1.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /> </a> <script language='JavaScript'
									type="text/javascript">
		<!--			
				var cal1 = new calendar1(document.forms['frm'].elements['paymentdt']);
				cal1.year_scroll = true;
				cal1.time_comp = false;
				setCurrentDate('paymentdt'); 
		//-->
                          </script> <%
				  
				  out.println("<tr><td class='boldEleven'>Purchase Amount</td>");
				  out.println("<td class='boldEleven'>"+
				  "<input class='formText135' type='text' size=20 name='purchaseamount' id='purchaseamount' value='"+payData[0][4]+"' readonly='readonly' />");
				  
				  out.println("<tr><td class='boldEleven'>Paid Amount</td>");
				  out.println("<td class='boldEleven'>"+
				  "<input class='formText135' type='text' size=20 name='paidamount'  id='paidamount'value='"+paidamount +"'  readonly='readonly'  />");
				  

				  out.println("<tr><td class='boldEleven'>Balance</td>");
				  out.println("<td class='boldEleven'><input class='formText135' type='text' size=20 name='preBalance' readonly id='preBalance' value='"+preBalance+"' />");

				  out.println("<tr><td class='boldEleven'>Last Paid <span class='bolddeepred'>*</span></td>");
				  out.println("<td class='boldEleven'>"+
				  "<input class='formText135' type='text' size=20 name='paid' id='paid' value='"+payData[0][5]+"'   maxlength='12'   onKeyUp=\"extractNumber(this,2,true),calculateBalance();\" onKeyPress=\"return blockNonNumbers(this, event, true, true);\" />");
 						
						
						 
									   
				  out.println("<tr><td class='boldEleven'>Current Balance</td>");
				  out.println("<td class='boldEleven'><input class='formText135' type='text' size=20 name='balance' readonly id='balance' value='"+payData[0][6] +"' />");
				  out.println("<input type='hidden' name='totalPaid' id='totalPaid'>");			 
				  
				  out.println("</table>");
				  
				  %>
								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><input name="filename"
									type="hidden" value="PurchasePayment" /> <input name="actionS"
									type="hidden" value="INVPurchasePaymentChanges" /> <input
									type="hidden" name="payment" value="<%=payment %>"> <input
									name="rowid" type="hidden" id="rowid" value="<%=rowid%>">
								<input name="pid" type="hidden" id="pid" value="<%=pid%>"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">
								<table border="0" align="center" cellpadding="1" cellspacing="1">
									<tr>
										<td width="56"><input name="Submit" type="Submit"
											class="buttonbold13" value="Update"></td>
										<td width="56"><input name="Button" type="Button"
											class="buttonbold13" onClick="redirect('Payment.jsp')"
											 value="Close"   accesskey="c" ></td>
									</tr>
								</table>
								</td>
							</tr>
						</tbody>
						<input type="hidden" name="mobileBookingOption" />
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
function calculateBalance()
{
	//purchaseamount,paidamount,paid
	var preBalance =parseFloat(document.getElementById('preBalance').value );
	var paid=parseFloat(document.getElementById('paid').value );
	var paidamount=parseFloat(document.getElementById('paidamount').value );
	if(paid <=preBalance)
	{		
		document.getElementById('balance').value = preBalance-paid;	
		document.getElementById('totalPaid').value=paidamount+paid
		return true;
	}	
	else
	{		
		 
		bal=parseFloat(document.getElementById('balance').value);
		document.getElementById('paid').value=preBalance-bal;
		document.getElementById('paid').focus();
		return false;
	}	
}

</script>
<%@ include file="../footer.jsp"%>
</body>
</html>
