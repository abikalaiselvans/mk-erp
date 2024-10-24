<%@ page import="java.sql.*,java.util.*,java.io.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
<html>
<head>
<title>:: INVENTORY ::</title>
<style type="text/css">
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
<script language="javascript" src="../JavaScript/calendar1.js"></script>
 <script language="javascript" src="../JavaScript/Numericfunctions.js"></script>

<script language="JavaScript">
  
  function Validate()
  {
	try
	{
		if(	
			checkNullSelect("purchaseid","Select Purchase number...","")
			&&checkNullSelect("paymentmode","Select Payment Mode...","")
			&& checkBankName()
			&&checkNull("paymentdt","Enter Payment Date...")
			&&checkNull("paymentdesc","Enter the Payment description...")	
			&&checkNull("given","Enter Amount")	
			
		)
			{
				sval=document.getElementById('paymentmode').value;	
				var its =sval.split(",");
				if(its[1] != "CASH" || its[1] != "CASH")
				{
					if(checkNullSelect("Bank","Select Bank Name ","0") && checkNull('Challanno','Enter '+its[1]+' NO'))
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
	}		
		
  } 
 	
	
	
function checkBankName()
{
 	try
	{
			sval=document.getElementById('paymentmode').value;	
			var its =sval.split(",");
			if(its[1] != "CASH" || its[1] != "CASH")
			{
				if(checkNullSelect("Bank","Select Bank Name ","0") && 
				checkNull('Challanno','Enter '+its[1]+' NO'))
					return true;
				else
					return false;
			}
			else
				return true;	
	}
	catch(err)
	{
		alert(err)
	}
}
</script>

<body    onLoad="disable()">
<%@ include file="indexinv.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>
		<%
    	String payment=request.getParameter("payment"); 
		String month=request.getParameter("month"); 
		String year=request.getParameter("year");
		String vendorid=request.getParameter("vendorid"); 
		//out.println(vendorid);
   	%>
		</td>
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
					<table cellspacing="2" cellpadding="2" width="100%" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen"><%=payment %> Payment Details <%				  
String sql="";
if("Purchase".equals(payment))	{
	sql="SELECT CHR_PURCHASEORDERNO,DOU_TOTALAMOUNT,DOU_PAIDAMOUNT,INT_VENDORID,CHR_PURCHASEORDERNO,CONCAT(CHR_PURCHASEORDERNO,',',DOU_TOTALAMOUNT,',',DOU_PAIDAMOUNT,',',INT_VENDORID,',',CHR_PURCHASEORDERNO),,CHR_VENDORPO FROM   inv_t_vendorpurchaseorder  WHERE CHR_PAYMENTSTATUS <>'Y' AND month(DAT_ORDERDATE)='"+month+"' and year(DAT_ORDERDATE)='"+year+"' ORDER BY CHR_PURCHASEORDERNO ";
	}
else {
	sql="SELECT a.CHR_PURCHASEORDERNO, a.DOU_TOTALAMOUNT, a.DOU_PAIDAMOUNT, a.INT_VENDORID, a.CHR_VENDORPO,CONCAT(a.CHR_PURCHASEORDERNO,',',a.DOU_TOTALAMOUNT,',',a.DOU_PAIDAMOUNT,',',a.INT_VENDORID,',', a.CHR_VENDORPO), a.CHR_VENDORPO FROM  inv_t_directpurchase a WHERE a.CHR_PAYMENTSTATUS <> 'Y' ";
		if(!vendorid.equals("0"))
			sql = sql+" AND a.INT_VENDORID ="+vendorid;
		sql = sql+"  and (a.DOU_TOTALAMOUNT-FUN_INV_GET_VENDORPAYMENT(a.CHR_PURCHASEORDERNO))>0 ORDER BY CHR_PURCHASEORDERNO ";
	}
	

//and (a.DOU_TOTALAMOUNT-FUN_INV_GET_VENDORPAYMENT(a.CHR_PURCHASEORDERNO))>0
//out.print(sql);
String purchaseids[][] =  CommonFunctions.QueryExecute(sql);
String lvalue="";
for(int x=0; x<purchaseids.length;x++)
	lvalue = lvalue+purchaseids[x][5]+",~";


				/*
				for(int x=0; x<purchaseids.length;x++)
				{
					for(int y=0; y<4;y++)
					{
						lvalue = lvalue+purchaseids[x][y]+",";
					}
					lvalue = lvalue+"~";	
				}*/
				
				sql = "SELECT INT_VENDORID,CHR_VENDORNAME FROM  inv_m_vendorsinformation  ";
    	     	String vendorData[][]=  CommonFunctions.QueryExecute(sql);
    	     	String vendorids="";
				String vendornames="";
				for(int x=0; x<vendorData.length;x++)
				{
						vendorids = vendorids+vendorData[x][0]+",";
						vendornames = vendornames+vendorData[x][1]+"98650";
				}  
				  %>								</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Purchase Id <span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left">
								 <select name="purchaseid" id="purchaseid" onblur='assignValue(this)' style="width: 150">
									<option value="">Select</option>
									<%
									 
					   
					  for(int u=0; u<purchaseids.length;u++)
					  		out.println("<option value='"+purchaseids[u][0]+"'> " +purchaseids[u][0]+"&nbsp;&nbsp;[&nbsp;"+purchaseids[u][6]+"&nbsp;]&nbsp;"+"</option>");
					  %>
								</select></td>
							</tr>

							<tr>
								<td height="17" class="boldEleven">Vendor Name</td>
								<td colspan="2" align="left"><input size="26"
									name="vendorname" id="vendorname" type="text" class="formText135"
									readonly="readonly"></td>
							</tr>
							<tr>
								<td width="167" height="17" class="boldEleven">Payment Mode
								<span class="bolddeepred">*</span></td>
								<td width="207" colspan="2" align="left"><select
									style="width: 150" name="paymentmode" id="paymentmode"
									onblur='assignNumber(this)'>
									<option selected value="">Select</option>
									<%
					  	String payments[][] =   CommonFunctions.QueryExecute("SELECT INT_PAYMENTTERMID,CHR_PAYMENTNAME FROM inv_m_paymentterms  ");	
						
					  for(int u=0; u<payments.length;u++)
					  		out.println("<option value='"+payments[u][0]+","+payments[u][1]+"'>"+payments[u][1]+" / "+payments[u][0]+"</option>");
					  %>
								</select></td>
							</tr>
							<tr id="chk1">
								<td height="17" class="boldEleven">Bank Name <span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left">
                                <select name="Bank" id="Bank" style="width: 150">
								 <option value="0">Select Bank</option>
                            	 <%
                                  sql = "SELECT INT_DEPOSITID, CHR_DEPOSITNAME FROM com_m_deposit_to WHERE CHR_STATUS !='N' ORDER BY CHR_DEPOSITNAME";
					   String banks[][] = CommonFunctions.QueryExecute(sql);
					  for(int u=0; u<banks.length;u++)
					  		out.println("<option value='"+banks[u][0]+"'>"+banks[u][1]+"</option>");
                            %> </select></td>
							</tr>
							<tr id="chk2">
								<td height="17" class="boldEleven">Cheque/ D.D/NEFT / RTGS Number <span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left"><input name="Challanno"
									type="text" class="formText135" id="Challanno"   onBlur="upperMe(this)"    size="26" maxlength="50"></td>
							</tr>
							<tr id="chk3">
							  <td height="17" class="boldEleven">Cheque/D.D/ /NEFT / RTGS Others Date  [ <span class="headerBackground">Bank Reflect Date</span> ]</td>
							  <td colspan="2" align="left"><input tabindex="2"
									name="chequedate" type="text" class="formText135" id="chequedate"
									size="22" readonly />
                                <a
									href="javascript:cal2.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /> </a>
                                <script language='JavaScript'
									type="text/javascript">
		<!--			
				var cal2 = new calendar1(document.forms['frm'].elements['chequedate']);
				cal2.year_scroll = true;
				cal2.time_comp = false;
				setCurrentDate('chequedate'); 
		//-->
                                </script></td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven">Payment Date <span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left"><input tabindex="2"
									name="paymentdt" type="text" class="formText135" id="paymentdt"
									size="22" readonly /> <a
									href="javascript:cal1.popup();"> <img
									src="../JavaScript/img/cal.gif" width="16" height="16"
									border="0" /> </a> <script language='JavaScript'
									type="text/javascript">
		<!--			
				var cal1 = new calendar1(document.forms['frm'].elements['paymentdt']);
				cal1.year_scroll = true;
				cal1.time_comp = false;
				setCurrentDate('paymentdt'); 
		//-->
                          </script></td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Payment
								Description <span class="bolddeepred">*</span></td>
								<td colspan="2" align="left"><textarea name="paymentdesc"
									cols="25" rows="5" class="formText135" id="paymentdesc"></textarea></td>
							</tr>
							<tr>
							  <td height="17" class="boldEleven">Transaction</td>
							  <td colspan="2" align="left"><select name="transactiontype" class="formText135" id="transactiontype"  style="width:200">
                             <!-- <option value="1">Payments</option>
                              <option value="2">TDS</option>
                              <option value="3">Freight</option>
                              <option value="4">CashDiscount</option>-->
							  <%
							  
					   String transactiontypedata[][] = CommonFunctions.QueryExecute("SELECT INT_TRANSACTIONTYPE, CHR_TRANSACTIONTYPE FROM inv_m_transactiontype ORDER BY INT_TRANSACTIONTYPE");
	   for(int tt=0; tt<transactiontypedata.length;tt++)
			out.println("<option value='"+transactiontypedata[tt][0]+"'>"+transactiontypedata[tt][1]+"</option>");
							  %>
						      </select></td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven">Purchase Amount</td>
								<td colspan="2" align="left"><input name="amount"
									type="text" class="formText135" id="amount" maxlength="15" readonly></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Paid Amount</td>
								<td colspan="2" align="left"><input name="paid" type="text"
									class="formText135" id="paid" maxlength="15" readonly></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Paid <span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left"> 
								 
									
									<input name="given"
									type="text" class="formText135" id="given" maxlength="15" onKeyUp="extractNumber(this,2,true),CheckBalance(this);" onKeyPress="return blockNonNumbers(this, event, true, true);"
									   >
									   
								<div id="Valid"></div>																</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Balance</td>
								<td colspan="2" align="left"><input name="balance"
									type="text" class="formText135" id="balance"
									readonly="readonly"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><input name="filename"
									type="hidden" value="PurchasePayment" /> <input name="actionS"
									type="hidden" value="INVPurchasePaymentAdd" /> <input
									type="hidden" name="payment" value="<%=payment %>"></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">

								<table border="0" align="center" cellpadding="1" cellspacing="1">
									<tr>
										<td width="56"><input type="Submit" class="buttonbold13"
											value="Submit" id="submit"></td>
										<td width="56"><input type="Button" class="buttonbold13"
											onClick="redirect('Payment.jsp')"  value="Close"   accesskey="c" ></td>
									</tr>
								</table>								</td>
							</tr>
						</tbody>
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
	var cvalue = "<%=lvalue%>";
	 
 	var cvalue1 =cvalue.split("~");
	 
	var ids ="<%=vendorids%>";
	 
	var names ="<%=vendornames%>";
	 
	var VendoridArray = ids.split(",");
	 
	var VendorNameArray = names.split("98650");
	 
	function assignValue(itm)
	{
		try
		{
			var purchaseid=itm.value;
			document.getElementById('vendorname').value = "";
			document.getElementById('amount').value = "";
			document.getElementById('paid').value = "";
			document.getElementById('balance').value = "";	
			document.getElementById('paymentdesc').value = "";	
			setOptionValue('Bank','0');
			setOptionValue('paymentmode','');
			
			for(i=0; i<cvalue1.length-1; i++)
			{
				var rowvalue = cvalue1[i].split(",")
				
				if(escape(rowvalue[0])=== escape(purchaseid))
				{
					var position="";
					for(x=0;x<VendoridArray.length-1;x++)
						if(escape(VendoridArray[x])=== escape(rowvalue[3]) )
							position=VendorNameArray[x];
					document.getElementById('vendorname').value = position;
					document.getElementById('amount').value = rowvalue[1];
					if(rowvalue[2] === "")
						document.getElementById('paid').value = "0.0";
					else
						document.getElementById('paid').value = rowvalue[2];
					
					var v =parseFloat(document.getElementById('amount').value)-parseFloat(document.getElementById('paid').value);
					document.getElementById('balance').value = v;
				}	
			}
		}
		catch(err) {
			alert(err);
		}
	}
	
	function assignNumber(itm)
	{
		
		var its = itm.value.split(",");
		if(its[1] != "CASH" || its[1] != "CASH" || its[1] != "TDS")
			enable();
		else
			disable();
	}
	
	function CheckBalance(gctr)
	{
		var bval=document.getElementById('balance').value;
		var gval=gctr.value;
		bval=parseInt(bval);
		gval=parseInt(gval);
		if(gval<=(bval+100))
		{
			document.getElementById('Valid').innerHTML="<font class='boldgreen'>VALID</font>";
			document.getElementById('submit').disabled=false;
		}
		else 
		{
			document.getElementById('Valid').innerHTML="<font  class='bolddeepred'> IN VALID</font>";
			document.getElementById('submit').disabled=true;
		}
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
	
	
	 
</script>
<%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
