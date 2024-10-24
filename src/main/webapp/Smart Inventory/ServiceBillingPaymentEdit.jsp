<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>

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
<script language="JavaScript" src="../JavaScript/calendar1.js"	type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/Inventory/InventAJAX.js" type="text/javascript"></script>
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
					<table cellspacing="2" cellpadding="2" width="600" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Service Billing Payment </td>
							</tr>

							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							<tr>
							  <td height="17" colspan="3" valign="top" class="errormessage">

 <%

String invoiceno = request.getParameter("salesid");
String sql="SELECT  CHR_SALESNO, DAT_PAYMENTDATE,DOU_PAIDAMOUNT,INT_PAYMENTID FROM inv_t_servicebillingpayment WHERE CHR_SALESNO='"+invoiceno+"' ORDER BY INT_PAYMENTID";
 String datas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
if(datas.length>0)
{
	out.println("<center><table width='100%' border='0' bgcolor='#9900CC'  class='boldEleven' cellpadding='2' cellspacing='1'>");
	out.println("<tr bgcolor='#ffffff'><td class='boldEleven'><b> S.No");
	out.println("<td class='boldEleven'><b> Invoiceno");
	out.println("<td class='boldEleven'><b> Date");
	out.println("<td class='boldEleven'><b> Amount");
	out.println("<td class='boldEleven'>");
	String link="";
	for(int u=0;u<datas.length;u++)
	{
		if(u%2==0)
			out.println("<tr bgcolor='#ffffff' class='MROW1'><td>"+(u+1));
		else
			out.println("<tr bgcolor='#ffffff' class='MROW2'><td>"+(u+1));
			
		out.println("<td class='boldEleven'>"+datas[u][0]);
		out.println("<td class='boldEleven'>"+datas[u][1]);
		out.println("<td class='boldEleven' align='right'>"+datas[u][2]);
		link = "../SmartLoginAuth?filename=ServiceBilling&actionS=INVServiceBillingPaymentEditDelete&invoiceno="+datas[u][0]+"&row="+datas[u][3];
		if((u+1) == datas.length)
			out.println("<td class='boldEleven' align='center'><a href='"+link+"'><font class='tMLAscreenHead'>&nbsp;&nbsp;Delete&nbsp;&nbsp;</font></a>");
		else
			out.println("<td class='boldEleven' align='center'>&nbsp;</font></a>");
	}
	out.println("</table></center>");
}
%>							  							    </td>
						  </tr>
							 
							<tr>
								<td height="17" colspan="3" class="boldEleven"><div align="center">
								  <input name="Button" type="button" class="tMLAscreenHead"  value="Close"   accesskey="c"  onClick="redirect('ServiceBillingPayment.jsp')">
							    </div></td>
							</tr>
						</tbody>
						<input type="hidden" name="mobileBookingOption" />
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
<script language="JavaScript">

function Validate()
  {

	if(checkNullSelect("divis","Select Division","0")
	&& checkNull( "SaleNo","Enter Invoice Number" )
	&& checkNull( "saleDate","Enter Invoice Date" )
	&& checkNullSelect("customer","Select Customer","0")
	&& checkNull( "ref","Select reference" )
	&& checkNull( "memo","Enter Description" )
	&& checkNull( "totals","Enter Total amount" )
	)
		return true;
	else
		return false;				
		
 } 	
</script> 
<%@ include file="../footer.jsp"%>
</body>
</html>
