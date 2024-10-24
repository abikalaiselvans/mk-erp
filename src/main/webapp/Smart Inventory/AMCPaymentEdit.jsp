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
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Payment Details</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top">
								<div align="center">
								<%
				String serviceid = request.getParameter("salesid");
				String ids[] = serviceid.split("~");
				String id =ids[0];
				String type = ids[1];
				String mode ="";
				if(type.equals("A"))
					mode= "AMC Mode" ;
				if(type.equals("S"))
					mode= "SERVICE Mode" ;	
				String sql1 ="Select count(*) from inv_t_serviceamount Where CHR_SERVICEID ='"+id+"' AND CHR_FLAG ='"+type+"'"; 
				boolean flag = false;
				if(com.my.org.erp.common.CommonInfo.RecordExist(sql1))
					flag = true;
			%>
								</div>
								</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top">
								<div align="center">
								<%
						try
						{ 
						 out.println("<table border=0  cellpadding='2' cellspacing='2' width='100%'>");
						 if(flag)
						 {
						
							out.println("<tr>");
							out.println("<td class='bold1'>Service Id </td>");
							out.println("<td class='bold1'>Type</td>");
							out.println("<td class='bold1'>Paid Amount </td>");
							out.println("<td class='bold1'>Paid Date </td>");
							out.println("<td class='bold1'>Description</td>");
							out.println("<td class='bold1'>Balance");
							out.println("<td class='bold1'>&nbsp;</td></tr>");
							String s =" INT_SERVICEID,CHR_SERVICEID,CHR_FLAG,DOU_PAIDAMOUNT,DAT_PAYMENTDATE, ";
							s = s+ " CHR_PAYMENTDESC,DOU_BALANCE ";
							String sql="Select "+s+" from inv_t_serviceamount Where CHR_SERVICEID='"+id+"' AND CHR_FLAG='"+type+"' AND INT_SERVICEID";
							String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(sql);
							for(int u=0;u<readData.length;u++)
							{
								if(u%2 == 0)
									out.println("<tr class='MRow1' height='20'>");
								else
									out.println("<tr class='MRow2'  height='20'>");
								
								out.print("<td class='boldEleven'>"+readData[u][1]+"</td>");	
								out.print("<td class='boldEleven'>"+mode+"</td>");	
								out.print("<td class='boldEleven' align='right'>"+readData[u][3]+"</td>");	
								out.print("<td class='boldEleven'>"+readData[u][4]+"</td>");	
								out.print("<td class='boldEleven'>"+readData[u][5]+"</td>");	
								out.print("<td class='boldEleven'  align='right'>"+readData[u][6]+"</td>");	
								if(u == readData.length-1)
								{
								  out.print("<td class='boldEleven'  align='right'>");	
								  String h = "AMCPaymentmodify.jsp?serviceid="+serviceid+"&rowid="+readData[u][0];
								  out.println("<a href='"+h+"'><font class='boldgreen'> Modify </font></a>");
								} 
								else
								 out.print("<td class='boldEleven'  align='right'>&nbsp;");	
								
								out.print("</tr>");	
							}
						 }
						 else
						 {
							out.println("<tr> <td  width='100%' colspan=7 class='errorMessage'> &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;Data not found  clik to add payment" );
							out.println( " &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<a href='AMCPaymentAdd.jsp'> click  </a></td></tr>");
						 }
						 out.println("</table>");
						}
						catch(Exception e)
						{
							out.println(e.getMessage());
						} 
					%>
								</div>
								</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top">
								<table width="56" border="0" align="center" cellpadding="0"
									cellspacing="0">
									<tr>
										<td><input name="Button" type="button"
											class="buttonbold13"  value="Close"   accesskey="c" 
											onClick="redirect('AMCPayment.jsp')"></td>
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
<%@ include file="../footer.jsp"%>
</body>
</html>
