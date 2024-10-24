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

<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>


<body >
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
								<td height="16" align="center" valign="top" class="boldThirteen">Payment
								Details</td>
							</tr>
							<tr>
								<td height="19" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							<tr>
								<td height="19" align="right" valign="top">
								<div align="center">
								<table width="56%" border="0" cellspacing="1" cellpadding="1">
									<tr>
										<td width="47%" class="boldEleven">AMC / Service Id <%
						  	String serviceid = request.getParameter("serviceid");
							String rowid = request.getParameter("rowid");
							String ids[] = serviceid.split("~");
							String id =ids[0];
							String type = ids[1];
							String mode ="";
							if(type.equals("A"))
								mode= "AMC Mode" ;
							if(type.equals("S"))
								mode= "SERVICE Mode" ;	
							String dbvalue="";
							
						  %>
										</td>
										<td width="53%" class="boldEleven"><%=id%></td>
									</tr>
									<tr>
										<td class="boldEleven">Mode</td>
										<td class="boldEleven"><%=mode%></td>
									</tr>
									<tr>
										<td class="boldEleven">Paid Amount <%
						   	String s =" INT_SERVICEID,CHR_SERVICEID,CHR_FLAG,DOU_PAIDAMOUNT,DAT_PAYMENTDATE, ";
							s = s+ " CHR_PAYMENTDESC,DOU_BALANCE ";
							String sql="Select "+s+" from inv_t_serviceamount Where CHR_SERVICEID='"+id+"' AND CHR_FLAG='"+type+"' AND INT_SERVICEID ="+rowid;
							String readData[][] = com.my.org.erp.common.CommonInfo.doubleRecordSetArray(sql);
							
						   
						   %>
										</td>
										<td class="boldEleven"><input name="paidamount"
											type="text" class="formText135" id="paidamount"
											onKeyPress="priceOnly(this)" size="20" maxlength="8"
											value="<%=readData[0][3]%>" onBlur="callAmountCheck()"></td>
									</tr>
									<tr>
										<td class="boldEleven">Paid Date</td>
										<td class="boldEleven"><input name="paiddate" type="text"
											class="formText135" id="paiddate" onKeyPress="dateOnly(this)"
											size="20" maxlength="10" /> <a
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
										<td valign="top" class="boldEleven">Payment Description <%
						  dbvalue = readData[0][5];
						  if(dbvalue.equals("0.0"))
						  {
						  	dbvalue ="";
						  }
						  %>
										</td>
										<td valign="top" class="boldEleven"><textarea
											name="paymentdesc" cols="20" rows="5" id="paymentdesc"><%=dbvalue%></textarea></td>
									</tr>
									<tr>
										<td class="boldEleven">Balance</td>
										<td class="boldEleven"><%=readData[0][6]%></td>
									</tr>
									<tr>
										<td class="boldEleven">&nbsp;</td>
										<td class="boldEleven"><input name="filename"
											type="hidden" value="AMCPayment" /> <input name="actionS"
											type="hidden" value="INVAMCPaymentUpdate" /> <input
											name="balance" type="hidden" value="<%=readData[0][6]%>">
										<input name="rowid" type="hidden" id="rowid"
											value="<%=rowid%>"> <input name="serviceid"
											type="hidden" id="serviceid" value="<%=id%>"> <input
											name="amount" type="hidden" id="amount"
											value="<%=readData[0][3]%>"></td>
									</tr>
								</table>
								</div>
								</td>
							</tr>
							<tr>
								<td height="19" align="right" valign="top">
								<table border="0" align="center" cellpadding="2" cellspacing="2">
									<tr>
										<td width="56"><label> <input name="Submit"
											type="submit" class="buttonbold13" value="Submit"   accesskey="s"   > </label></td>
										<td width="56"><input name="Button" type="button"
											class="buttonbold13"  value="Close"   accesskey="c" 
											onClick="redirect('AMCPaymentEdit.jsp?salesid=<%=serviceid%>')"></td>
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
function isNumberFloat(inputString)

{

  return (!isNaN(parseFloat(inputString))) ? true : false;

}

function callAmountCheck()
{

	if(! isNumberFloat(document.getElementById('paidamount').value))
	{
		alert("Paid amount should not be empty...");
		document.getElementById('paidamount').focus();
	}
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
function Validate()
   {
		if(	checkNull("paidamount","Enter Paid Amount")	&&	checkNull("paiddate","Enter Paid Date")	)
			return true;	
		else
			return false;			
   } 

</script>

<%@ include file="../footer.jsp"%>
</body>
</html>
