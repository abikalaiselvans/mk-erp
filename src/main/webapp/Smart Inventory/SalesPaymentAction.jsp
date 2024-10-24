<%@ page import="java.io.*,java.util.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
%>
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
 	
	

function Validate()
{
	try
	{
		obj = findObj("checkboxs");
		if(obj == null)
		{
			alert("Kindly select the Invoice number or please tick the payment commitment checkbox");
			return false;
		}
		
		var b =parseFloat(document.getElementById('Balance').value);
		var b1 =parseFloat(document.getElementById('Paid').value);
		if(
			checkNullSelect("salesOrderId","Select Order Id",'Select') 
			&& PaymentCommitmentCheck()
			&& checkNullSelect("salesOrderId","Select Order Id",'Select') 
			&& checkNull("salesDate","Enter Sales Date") 
			&& checkNullSelect("paymentMethod","Select Payment Method",'Select') 
			&& checkBankName()
			&& checkNull("paymentDate","Enter paymentDate")
			&& checkNull("salesAmount","Enter salesAmount")
			&& checkNull("Balance","Enter Balance")
			&& checkNull("Paid","Enter Amount Paid")
			&& checkNull("remarks","Enter the remarks")
			&& checkNull("ref","Select Payment collected by")
			&& checkNullSelect("creditto","Select credited to",'') 
			
			&& (( (b+100)-b1) >= 0)
		)
		{		
			sval=document.getElementById('paymentMethod').value;	
			var its =sval.split(",");
			if(its[1] != "CASH" || its[1] != "CASH")
			{
				if(checkNullSelect("Bank","Select Bank Name ","") && 
				checkNull('Challanno','Enter '+its[1]+' Number'))
				{
					if (confirm("Once again confirm to all the informations are correct")==true)
					 	return true;
					else
						return false;
				}
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
		alert(err)
		return false;
	}
} 

  
 function checkBankName()
 {
 	try
	{
			sval=document.getElementById('paymentMethod').value;	
			var its =sval.split(",");
			if(its[1] != "CASH" || its[1] != "CASH")
			{
				if(checkNullSelect("Bank","Select Bank Name ","") && checkNull('Challanno','Enter '+its[1]+' Number'))
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
  
  
  	function CheckBalance(gctr)
	{
		var bval=document.getElementById('Balance').value;
		var gval=gctr.value;
		bval=parseInt(bval);
		gval=parseInt(gval);
		if(gval<=(bval+100)){
			document.getElementById('Valid').innerHTML="<font class='boldgreen' size='2'>VALID</font>";
			document.getElementById('submit').disabled=false;
		}
		else {
			document.getElementById('Valid').innerHTML="<font class='bolddeepred' size='2'>IN VALID</font>";
			document.getElementById('submit').disabled=true;
		}
	}
 	
</script>
<%
	String pType=request.getParameter("payType");
	String idName="";
%>

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
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="50">
					<table cellspacing="2" cellpadding="2" width="520" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Payment</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">
								Mandatory </span></td>
							</tr>
							<tr>
							  <td width="200" height="17" class="boldEleven"><%=pType %>
						      Invoice Number<span class="bolddeepred"> * </span></td>
								<td width="306" colspan="2" align="left"><input
									type="hidden" value="<%=pType %>" id="payType" name="payType">
								<select name="salesOrderId" id="salesOrderId" style="width: 175"
									class="formText135" onblur='assignValue(this)'  onChange="AssignPaymentCommitment(this,'C')">
									<option value="Select">Select</option>
									<%
			         	String branchId=""+session.getAttribute("BRANCHID");
					 
			         	String sql="";
			         	String salesSQL="";
			         	
					 	if(pType.equals("CashPay"))
					 	{
				         	sql="SELECT CHR_SALESNO FROM inv_t_cashsales "+
				         	 " WHERE INT_BRANCHID="+branchId+" AND CHR_PAYMENTSTATUS<>'Y'  ORDER BY CHR_SALESNO";    
				         	salesSQL="SELECT CHR_SALESNO , DAT_SALESDATE, INT_CUSTOMERID,DOU_TOTALAMOUNT "
				         	 +"FROM inv_t_cashsales  WHERE INT_BRANCHID="+branchId+" AND CHR_PAYMENTSTATUS<>'Y'";
					 	}
					 	else if(pType.equals("Invoice"))
					 	{
					 		sql="SELECT CHR_INVOICENO FROM  inv_t_customersalesorder   "+
				         	 " WHERE INT_BRANCHID="+branchId+" AND CHR_PAYMENTSTATUS<>'Y' AND CHR_INVOICESTATUS='Y'  ORDER BY CHR_SALESNO";    
					 		salesSQL="SELECT CHR_INVOICENO , DAT_SALEDATE, INT_CUSTOMERID,DOU_TOTALAMOUNT "
					 		+" FROM  inv_t_customersalesorder    WHERE INT_BRANCHID="+branchId+" AND CHR_PAYMENTSTATUS<>'Y' AND CHR_INVOICESTATUS='Y'";
					 	}
					 	else if(pType.equals("Direct"))
					 	{
				         	sql="SELECT CHR_SALESNO FROM inv_t_directsales ";
							sql = sql + " WHERE CHR_PAYMENTSTATUS<>'Y'"; //INT_BRANCHID="+branchId+" AND 
							sql = sql + "   AND CHR_CANCEL='N' AND FIND_A_PAYMENTCOMMITMENT(CHR_SALESNO,'C') > 0  ORDER BY INT_SALESID  ";  
							   
				         	salesSQL="SELECT CHR_SALESNO , DATE_FORMAT(DAT_SALESDATE,'%d-%m-%Y'), INT_CUSTOMERID,DOU_TOTALAMOUNT "
				         	 +"FROM inv_t_directsales WHERE   CHR_CANCEL='N'  AND CHR_PAYMENTSTATUS<>'Y'";
							 /*if(!(""+session.getAttribute("USRTYPE")).equals("F"))
							{
								salesSQL = salesSQL +"AND INT_BRANCHID="+branchId+" ";
							}*/
					 	}
			         	 
		            	String salesOrder[][]=CommonFunctions.QueryExecute(sql);
	            	   for(int u=0; u<salesOrder.length; u++)
	            	   {
	            		   out.print("<option value ='"+salesOrder[u][0]+"'>" +salesOrder[u][0]+"</option>");   
	            	   }	
					   
					String salesData[][] =  CommonFunctions.QueryExecute(salesSQL);
				  	String lvalue="";
					for(int x=0; x<salesData.length;x++)
					{
						for(int y=0; y<4;y++)
						{
							lvalue = lvalue+salesData[x][y]+",";
						}
						lvalue = lvalue+"~";	
					}
					
									
			         %>
								</select>
								 
							  </td>
							</tr>
							<tr>
							  <td height="17" colspan="3" class="boldEleven"><div id="AssignPaymentCommitmentDiv"  style="OVERFLOW:auto;width:100%;height:auto" class="boldEleven"></div></td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven">Sales Date<span
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
					  	String payments[][] = CommonFunctions.QueryExecute("SELECT INT_PAYMENTTERMID,CHR_PAYMENTNAME FROM inv_m_paymentterms  ");	
						
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
									<option value="">Select</option>
									<%
					   sql = "SELECT INT_BANKGROUPID, CHR_BANKGROUPNAME FROM com_m_bankgroup ORDER BY CHR_BANKGROUPNAME";
					   String banks[][] = CommonFunctions.QueryExecute(sql);
					  for(int u=0; u<banks.length;u++)
					  		out.println("<option value='"+banks[u][0]+"'>"+banks[u][1]+"</option>");
					  %>
								</select></td>
							</tr>
							<tr id="chk2">
								<td height="17" class="boldEleven">Cheque/ D.D /Credit Card
								/NEFT / RTGS Number <span class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="Challanno"
									type="text" class="formText135"   onBlur="upperMe(this)"    id="Challanno" size="31" maxlength="50"></td>
							</tr>
							<tr id="chk3">
							  <td height="17" class="boldEleven">Cheque/D.D/ /NEFT / RTGS Others Date  [ <span class="headerBackground">Bank Reflect Date</span> ]</td>
							  <td colspan="2" align="left"><input name="chequeDate"
									type="text" class="formText135" id="chequeDate" size="27"
									onKeyPress="dateOnly(this)"  readonly="readonly" />
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
									onKeyPress="dateOnly(this)" readonly /> <a
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
								<td height="17" class="boldEleven">Sales Amount</td>
								<td colspan="2" align="left"><input name="salesAmount"
									value="" size="30" type="text" class="formText135"
									id="salesAmount" maxlength="15"
									onKeyPress="doubleValue('salesAmount','5')" readonly></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Balance Amount <span
									class="bolddeepred">   <input name="customerid" type="hidden" id="customerid">
								</span></td>
								<td colspan="2" align="left"><input name="Balance" value=""
									size="30" type="text" class="formText135" id="Balance"
									maxlength="15" onKeyPress="doubleValue('Balance','5')"
									readonly="readonly"></td>
							</tr>

							<tr>
							  <td height="17" class="boldEleven">Transaction </td>
							  <td colspan="2" align="left">
                              <select name="transactiontype" class="formText135" id="transactiontype"  style="width:200">
                              <%
							 String transactiontypedata[][] = CommonFunctions.QueryExecute("SELECT INT_TRANSACTIONTYPE, CHR_TRANSACTIONTYPE FROM inv_m_transactiontype ORDER BY INT_TRANSACTIONTYPE");
	   for(int tt=0; tt<transactiontypedata.length;tt++)
			out.println("<option value='"+transactiontypedata[tt][0]+"'>"+transactiontypedata[tt][1]+"</option>");
							  %>
							  
						      </select></td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven">Amount Recieved <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left">
<input name="Paid" size="30" type="text" class="formText135" id="Paid" maxlength="15" onKeyUp="extractNumber(this,2,true),CheckBalance(this);" onKeyPress="return blockNonNumbers(this, event, true, true);"
									   >
									
								<div id="Valid"></div>								</td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Remarks  <span
									class="bolddeepred">* </span>
	  						  </td>
							  <td colspan="2" align="left"><textarea name="remarks"
									cols="25" rows="5" class="formText135" id="remarks"></textarea>
						      </td>
							</tr>
							<tr>
							  <td height="17" valign="top" class="boldEleven">Payment collected by   <span
									class="bolddeepred">* </span> </td>
							  <td colspan="2" align="left" valign="top"><select name="ref" id="ref"
										class="formText135" size="5" style="width:200">
                                <jsp:include page="Staffload.jsp" flush="true" />                              
</select></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Credit to   <span
									class="bolddeepred">* </span></td>
							  <td colspan="2" align="left">
                              <select name="creditto" class="formText135" id="creditto" style="width:200">
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
									type="hidden" value="SalesPayment" /> <input name="actionS"
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
											onClick="redirect('Sales Payment.jsp')"></td>
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
<%
	sql = "SELECT a.INT_CUSTOMERID,f.CHR_NAME FROM  inv_m_customerinfo a,inv_m_customergroup f WHERE a.INT_CUSTOMERGROUPID = f.INT_CUSTOMERGROUPID GROUP BY f.CHR_NAME  ORDER BY  f.CHR_NAME ";
    String customerData[][]= CommonFunctions.QueryExecute(sql);
    String customerids="";
	String customernames="";
	for(int x=0; x<customerData.length;x++)
	{
		customerids = customerids+customerData[x][0]+",";
		customernames = customernames+customerData[x][1].replaceAll("&", " AND ")+"98650";
	}  
%> <script language="javascript">
	var cvalue = "<%=lvalue%>";
	var cvalue1 =cvalue.split("~");
	var ids ="<%=customerids%>";
	var names ="<%=customernames%>";
	var customeridArray = ids.split(",");
	var customerNameArray = names.split("98650");
	function assignValue(itm)
	{
		var salesid = itm.value;
		document.getElementById('salesDate').value ="";;
		document.getElementById('salesAmount').value ="";
		document.getElementById('customerid').value ="";
		document.getElementById('customerName').value = "";				
		document.getElementById('Balance').value = "";	
		document.getElementById('Paid').value = "";	
		document.getElementById('remarks').value = "";	
		 
		setOptionValue('paymentMethod','Select');
	 
		for(i=0; i<cvalue1.length-1; i++)
 		{
   			
			 
			var rowvalue = cvalue1[i].split(",");
			if(escape(rowvalue[0]) === escape(salesid))
			{
				 
				document.getElementById('salesDate').value =rowvalue[1];
				document.getElementById('salesAmount').value =rowvalue[3];
				document.getElementById('customerid').value =rowvalue[2];
				var custid = parseInt(escape(rowvalue[2]));
				var position="";
				for(x=0;x<customeridArray.length;x++)
				{
					if(parseInt(escape(customeridArray[x])) == custid )
						position=customerNameArray[x];
					else
						position="";
				}
				document.getElementById('customerName').value = position;				
				callBalanceAmount(salesid);
			}	
		}		
	}	
   		
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
	if((b-b1) < -99)
		{
			alert("The paid amount should be lessthan or equal to balance amount...");
			document.getElementById('Paid').value = "0.0";
		}
	
}
</script></form>
<%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
catch(Exception e)
{
	System.out.println(e.getMessage());
}
%>