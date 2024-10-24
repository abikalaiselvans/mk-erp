<%@ page import="java.io.*,java.util.*" isErrorPage="false"
	errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.CommonInfo"%>
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
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="JavaScript">
  function Validate()
  {   
	if(
	checkNull("paymentdt","Enter Payment Date") 
	&& checkNull("paidamount","Enter PaidAmount") 
	&& checkNull("paid","Enter Paid Amount") 
	&& checkNull("purchaseamount","Enter Purchase Amount")
	&& checkNull("balance","Enter Balance Amount")
	)
		return true;
	else
		return false;	
  }
	function CheckBalance(gctr)
	{
		var bval=document.getElementById('Balance').value;
		var gval=gctr.value;
		bval=parseInt(bval);
		gval=parseInt(gval);
		if(gval<=bval){
			document.getElementById('Valid').innerHTML="<font  color='green' size='2'   >VALID</font>";
			document.getElementById('submit').disabled=false;
		}
		else {
			document.getElementById('Valid').innerHTML="<font color='red'  size='2' > IN VALID</font>";
			document.getElementById('submit').disabled=true;
		}
	} 	
</script>
<%
	try{
%>
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
                    String pType=request.getParameter("payType");
				  	String sid = request.getParameter("sid");
					String rowid = request.getParameter("rowid");
					String sql = "SELECT INT_PAYMENTID,INT_PAYMENTTERMID,CHR_BANKNAME,CHR_PAYNO,"
					+" DAT_PAYMENTDATE,DOU_OPENDEBIT,DOU_PAIDAMOUNT,DOU_BALANCEAMOUNT "
					+" FROM   inv_t_customersalespayment   "
					+" WHERE  INT_PAYMENTID="+Integer.parseInt(rowid);
				  	String payData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					sql = "SELECT sum(DOU_PAIDAMOUNT) FROM   inv_t_customersalespayment   WHERE CHR_SALESORDERNO='"+sid+"'";							
					String valPaid[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					String paidamount = valPaid[0][0];
					sql="SELECT CHR_PAYMENTNAME FROM inv_m_paymentterms where INT_PAYMENTTERMID="+payData[0][1];
					String payMode = com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql, "CHR_PAYMENTNAME");					
				  %> <input type="hidden" name="payType" id="payType" value="<%=pType %>"></td>
							</tr>
							<tr>
								<td height="19" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">
								<%
				  //System.out.println("SQL :Enter");
				  String bankname="";
				  String ddno="";
				  
				  out.println("<table border=0 cellspacing=2 cellpadding=2>");
				  out.println("<tr><td class='boldEleven'>Purchase Order No</td>");
				  out.println("<td class='boldEleven'>"+sid);
				  
				  out.println("<tr><td class='boldEleven'>Payment Mode</td>");
				  out.println("<td class='boldEleven'>"+payMode );
				  
				  
				  out.println("<tr><td class='boldEleven'>Bank Name</td>");
				  //System.out.println("SQL :One"+ payData[0][2]);
				  if (("Select".equals(payData[0][1]) ) || ("null".equals(payData[0][1]))
						||("".equals(payData[0][2]))  )
					{	
						bankname="-";
						ddno="-";
						out.println("<td class='boldEleven'><input name='Bank' id='Bank' type='hidden' value='1'>"+ bankname);
					}
					else
					{
						String bank=payData[0][2];
						sql = "SELECT CHR_BANKNAME FROM com_m_bank WHERE INT_BANKID ="+Integer.parseInt(bank);
   	     				bankname= com.my.org.erp.common.CommonInfo.stringGetAnySelectField(sql,"CHR_BANKNAME");
						ddno=payData[0][3];
						out.println("<td class='boldEleven'>" );
						%>
						<select name="Bank"   id="Bank" > <option value="1">No Bank</option>
						<%
					   			sql = "SELECT INT_BANKGROUPID, CHR_BANKGROUPNAME FROM com_m_bankgroup ORDER BY CHR_BANKGROUPNAME";
					   			String banks[][] =  com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
					  					for(int u=0; u<banks.length;u++)
					  				out.println("<option value='"+banks[u][0]+"'>"+banks[u][1]+"</option>");
					  	%>
						</select>
						<script language="javascript">setOptionValue('Bank','<%=bank%>')</script>
						<%
					}
				  //System.out.println("SQL :One TWO ");				  
				  
				  
				  
				  out.println("<tr><td class='boldEleven'>Cheque/DD number</td>");
				  out.println("<td class='boldEleven'><input class='formText135' maxlength=15  type='text' size=20 name='chkno' id='chkno' value='"+ddno+"'   id='chkno'/>");
				  
				  out.println("<tr><td class='boldEleven'>Payment Date</td>");
				  out.println("<td class='boldEleven'>");
				  out.println("<input class='formText135' readonly type='text' size=20 name=paymentdt  id='paymentdt'  value='"+com.my.org.erp.ServiceLogin.DateUtil.FormateDateSys(payData[0][4])+"' />");				  
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
				//  double totPaid=
				  out.println("<tr><td class='boldEleven'>Purchase Amount</td>");
				  out.println("<td class='boldEleven'><input class='formText135' type='text' size=20 name='purchaseamount' id='purchaseamount' value='"+payData[0][5]+"' readonly='readonly' />");
				  out.println("<tr><td class='boldEleven'>Paid Amount</td>");
				  out.println("<td class='boldEleven'><input class='formText135' type='text' size=20 name='paidamount'  id='paidamount'value='"+paidamount +"'  readonly='readonly'  />");
				  out.println("<tr><td class='boldEleven'>Last Paid </td>");
				  out.println("<td class='boldEleven'><input class='formText135' type='text' size=20 name='paid' id='paid' value='"+payData[0][6]+"' onkeypress='priceOnly(this)' onkeyup='calculateBalance(this)' />");
				  out.println("<input type='hidden' name='lastpaid' id='lastpaid' value='"+payData[0][6]+"'/>");
				  out.println("<tr><td class='boldEleven'>Balance</td>");				  
				  out.println("<td class='boldEleven'><input class='formText135' type='text' size=20 readonly name='balance' id='balance' value='"+payData[0][7] +"'/>");
				  out.println("<input class='formText135' type='hidden' size=20 readonly name='oldBalance' id='oldBalance' value='"+payData[0][7] +"'/>");						  
				  out.println("</table>");
				  %>
								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">
								<input name="filename" type="hidden" value="SalesPayment" /> 
								<input name="actionS"  type="hidden" value="INVSalesPaymenUpdate" />
								<input name="rowid" type="hidden" id="rowid" value="<%=rowid%>">
								<input name="sid" type="hidden" id="sid" value="<%=sid%>">
								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">
								<table border="0" align="center" cellpadding="1" cellspacing="1">
									<tr>
										<td width="56"><input name="Submit" type="Submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
										<td width="56"><input name="Button" type="Button"
											class="buttonbold13" onClick="redirect('Sales Payment.jsp')"
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
	var puamt =parseFloat(document.getElementById('purchaseamount').value );
	var bpaid=parseFloat(document.getElementById('paidamount').value );
	var paid =parseFloat(document.getElementById('paid').value );
	var lastPaid =parseFloat(document.getElementById('lastpaid').value );
	var ckamt = parseFloat(document.getElementById('oldBalance').value)+lastPaid;
	if(paid >ckamt)
	{
		alert("Illegal Inputs..");
		document.getElementById('paid').value =lastPaid;		
		document.getElementById('balance').value=document.getElementById('oldBalance').value
		document.getElementById('paid').focus();
	}	
	else
	{		
		document.getElementById('balance').value = ckamt-paid;
		//document.getElementById('paidamount').value  = paidamt;
	}	
}
</script>
<%@ include file="../footer.jsp"%>
</body>
<%
	}
	catch(Exception e)
	{
		//System.out.println("Error :"+e.getMessage());
		//e.printStackTrace();
	}
%>
</html>
