<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> <html>
 
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
<%@ include file="javascriptinclude.jsp"%>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
 </style>
</head>

<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/Numericfunctions.js"></script>
<script language="javascript">
 	
function Validate()
{
	try
	{ 
		return checkAtleastOne();	 
	}
	catch(err)
	{
		alert(err)
		return false;
	}
} 

  
</script>
<body >
<%@ include file="indexinv.jsp"%>
 <form action="ServiceSingleEntryMultipleInvoiceAction.jsp" method="post" name="frm" id="frm"  onSubmit="return Validate()">
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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="800"
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
					<table cellspacing="2" cellpadding="2" width="100%" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							
							
							
							<tr>
							  <td height="17" class="boldEleven">
                             
							    <table width="100%" border="0" cellspacing="0" cellpadding="0">
							      <tr>
							        <td colspan="6" align="center" class="copyright"><span class="bolddeepred">
							          <input name="filename" type="hidden" id="filename" value="SalesPaymentMultipleInvoice">
                                      <input name="actionS"
									type="hidden" value="INVSalesPaymenMultipleinvoice" />
                                    </span>SERVICE BILLING SINGLE ENTRY MULTIPLE INVOICE
                                    <%
									String sql = "";
									int l =0;
									String customergroupid = request.getParameter("Rowid");
									sql = "";
									sql = " SELECT a.CHR_SALESNO ,FIND_A_CUSTOMER_NAME(a.INT_CUSTOMERID),DATE_FORMAT(a.DAT_SALESDATE,'%d-%b-%Y'),";
								    sql = sql + "a.DOU_NETAMOUNT,FUN_INV_GET_SERVICEBALANCEAMOUNT(a.CHR_SALESNO) ";
									sql = sql + " FROM inv_t_servicebilling a ,  inv_m_customerinfo b  ";
									sql = sql + " WHERE  a.INT_CUSTOMERID = b.INT_CUSTOMERID  AND a.CHR_PAYMENTSTATUS <> 'Y'  ";
									sql = sql + " AND a.CHR_CANCEL='N' ";//AND FIND_A_PAYMENTCOMMITMENT(a.CHR_SALESNO,'C') > 0   
									sql = sql + " AND b.INT_CUSTOMERGROUPID =" +customergroupid;
									sql = sql + "  ORDER BY a.DAT_SALESDATE  ";
									//out.println(sql);
									String data[][] = CommonFunctions.QueryExecute(sql);
									
									%>
                                     </td>
						          </tr>
							      <tr>
							        <td colspan="6">&nbsp;</td>
						          </tr>
							      <tr>
							        <td colspan="6" align="center"> </td>
						          </tr>
							      <tr>
							        <td colspan="6">
<%
if(data.length>0)
{
		out.println("<center>");
		out.println("<table width='100%'  class='boldEleven'  id='myTable'     cellpadding=2 cellspacing=1 bgcolor='#9900CC' >");
		out.println("<tr class='MRow1'>");
		out.println("<td class='boldEleven' align='center'><b>S.No</b></td>");
		out.println("<td class='boldEleven' align='center'><b>Invoice</b></td>");
		out.println("<td class='boldEleven' align='center'><b>Customer</b></td>");
		out.println("<td class='boldEleven' align='center'><b>Sale Date</b></td>");
		out.println("<td class='boldEleven' align='center'><b>Sale Amount</b></td>");
		out.println("<td class='boldEleven' align='center'><b>Balance</b></td>");
		out.println("<td class='boldEleven' align='center'><b>&nbsp;</b></td>");
		out.println("</tr>");
		for(int u=0;u<data.length;u++)
		{
			if(u%2 ==0)
				out.println("<tr class='MRow1'>");
			else
				out.println("<tr class='MRow2'>");	
				
			out.println("<td class='boldEleven'>"+(u+1)+".</td>");
			out.println("<td class='boldEleven'>"+data[u][0]+"</td>");
			out.println("<td class='boldEleven'>"+data[u][1]+"</td>");
			out.println("<td class='boldEleven'>"+data[u][2]+"</td>");
			out.println("<td class='boldEleven'>"+data[u][3]+"</td>");
			out.println("<td class='boldEleven'>"+data[u][4]+"</td>");
			out.println("<td class='boldEleven'>");
			out.println("<input name='salesnumber'  id='salesnumber"+u+"' type='checkbox' value='"+data[u][0]+"'>");
			out.println("</td>");
			out.println("</tr>");
		}
		out.println("</table>");
		out.println("<center>");	
}
else
{
		out.println("<center>");
		out.println("<font class='Bolddeepred'> Data not fond </font>");
		out.println("</center>");
}


%>
                                    
 									<input name="total" type="hidden" id="total" value="<%=data.length%>"></td>
						          </tr>
							      <tr>
							        <td colspan="6">&nbsp;</td>
						          </tr>
							      <tr>
							        <td>&nbsp;</td>
							        <td>&nbsp;</td>
							        <td>&nbsp;</td>
							        <td>&nbsp;</td>
							        <td>&nbsp;</td>
							        <td>&nbsp;</td>
						          </tr>
							      <tr>
							        <td colspan="6"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
							          <tr>
							            <td>
                                        
                                        
                                        <%
if(data.length>0)
{
	%>                                    

                                        <input name="Submit11" type="submit" id="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   >
                                            
<%
}
%>
                                            
                                            </td>
							            <td><input name="Close" type="Button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('SingleEntryMultipleInvoice.jsp')"></td>
						              </tr>
							          </table></td>
						          </tr>
						        </table>
						      </td>
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

<script language="javascript">




function checkAtleastOne()
{
	try
	{
		var total = document.getElementById('total').value;
		var f = false;
		for(u=0; u<total;u++)
		{
			if(document.getElementById('salesnumber'+u).checked)
				f = true;
		}
		
		return f;
		
	}
	catch(err)
	{
		alert(err)
	}
}

  

</script>
</form>
<%@ include file="../footer.jsp"%>
</body>
</html>




