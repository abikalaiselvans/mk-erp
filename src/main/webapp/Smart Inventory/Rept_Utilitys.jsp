<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%@ page import="org.apache.commons.lang.ArrayUtils"%> <html>
<%

//Do not delete the Content

/*


								*/
%>
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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="300"
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
					<table cellspacing="2" cellpadding="2" width="500" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							
							
							
							<tr>
							  <td height="17" class="boldEleven"><table width="98%" border="0" align="center" cellpadding="5" cellspacing="0">
                                <tr>
                                  <td colspan="5" class="copyright"><div align="center">SALES REPORT </div></td>
                                </tr>
                                 
                                 <tr>
  <td class="boldEleven">1.</td>
  <td class="boldEleven"><div align="left"><a href="Rept_commitmentnotgiven.jsp" target="_blank">Commitment not given</a></div></td>
  <td class="boldEleven">&nbsp;</td>
  <td class="boldEleven">2.</td>
  <td class="boldEleven"><div align="left"><a href='TargetAchieveAvgCollection.jsp' target="_blank">Average Collection </a></div></td>
</tr>
<tr>
  <td class="boldEleven">3.</td>
  <td class="boldEleven"><div align="left"><a href="Rept_DailySalesAllEmployee.jsp" target="_blank">All</a></div></td>
  <td class="boldEleven">&nbsp;</td>
  <td class="boldEleven">4.</td>
  <td class="boldEleven"><a href="Rept_Taxamount.jsp">Tax Amount </a></td>
</tr>
<tr>
  <td class="boldEleven">5.</td>
  <td class="boldEleven"><div align="left"><a href="Rept_CustomerSalesReport.jsp" target="_blank">Employee wise </a></div></td>
  <td class="boldEleven">&nbsp;</td>
  <td class="boldEleven">6.</td>
  <td class="boldEleven"><div align="left"><a href="Rept_CumulativeSales.jsp" target="_blank">Cumulative Sales </a></div></td>
</tr>



<tr>
  <td class="boldEleven">7.</td>
  <td class="boldEleven"><div align="left"><a href='RRept_DailySalesReport.jsp' target="_blank">Daily   Report </a></div></td>
  <td class="boldEleven">&nbsp;</td>
  <td class="boldEleven">8.</td>
  <td class="boldEleven"><a href="Rept_SerialNumberChanged.jsp" target="_blank">Serialnumber change</a></td>
</tr>
								<tr>
								  <td class="boldEleven">9.</td>
								  <td class="boldEleven"><a href="Rept_DeletedInvoice.jsp" target="_blank">Deleted Invoice</a></td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">10.</td>
								  <td class="boldEleven"><a href="FaultMaterial.jsp" target="_blank">Fault goods</a></td>
							    </tr>
								<tr>
								  <td class="boldEleven">11.</td>
								  <td class="boldEleven"><a href="Rept_SalesAnalysis.jsp" target="_blank">Sales Analysis</a></td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">12.</td>
								  <td class="boldEleven"><a href="InvoicenumberagainstContacts.jsp" target="_blank">Invoicenumber against Contacts</a></td>
							    </tr>
								<tr>
								  <td class="boldEleven">13</td>
								  <td class="boldEleven"><a href="getSerialnumberAgainstInvoiceNumber.jsp" target="_blank">Get Serial number against Invoice </a></td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">14.</td>
								  <td class="boldEleven"><a href="getSerialnumberAgainstPO.jsp" target="_blank">Get Serial number against P.O </a></td>
							    </tr>
								<tr>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
								  <td class="boldEleven">&nbsp;</td>
							    </tr>
								 
								<tr>
								  <td colspan="5" class="boldEleven" align="center"><%
								
								 
 
	  if("F".equals(""+session.getAttribute("USRTYPE"))|| ArrayUtils.contains(CommonFunctions.QueryExecute("SELECT CHR_TURNOVERUSER  FROM m_inventorysetting  WHERE INT_ROWID=1")[0][0].split(","), session.getAttribute("USRID").toString()))
	 
								 
								 {
								%>
                                    <table width="100%" align="center">
                                      <tr>
                                        <td colspan="4" class="boldEleven"><div align="center" class="boldElevenPrint">ADMIN REPORT </div></td>
                                      </tr>
                                      <tr>
                                        <td width="18" class="boldEleven"><div align="left">1.</div></td>
                                        <td width="147" class="boldEleven"><div align="left"><a href="Rept_FinancialYearSales.jsp" target="_blank">Financial Year Sales </a></div></td>
                                        <td width="11" class="boldEleven"><div align="left">2.</div></td>
                                        <td width="118" class="boldEleven"><div align="left"><a href="Rept_Turnover.jsp" target="_blank">Turnover </a></div></td>
                                      </tr>
                                      <tr>
                                        <td class="boldEleven"><div align="left">3.</div></td>
                                        <td class="boldEleven"><div align="left"><a href="Rept_FinancialYearMonthSales.jsp" target="_blank">Turnover Month wise </a></div></td>
                                        <td class="boldEleven"><div align="left">4.</div></td>
                                        <td class="boldEleven"><div align="left"><a href="Rept_TurnoverQuarter.jsp" target="_blank">Turnover Quarter wise </a></div></td>
                                      </tr>
                                      <tr>
                                        <td class="boldEleven"><div align="left">5.</div></td>
                                        <td class="boldEleven"><div align="left"><a href="Rept_DivisionQPLCQuarter.jsp" target="_blank">Division QPLC</a></div></td>
                                        <td class="boldEleven"><div align="left">6.</div></td>
                                        <td class="boldEleven"><div align="left"><a href="Rept_Flow.jsp" target="_blank">Flow</a></div></td>
                                      </tr>
                                      <tr>
                                        <td class="boldEleven"><div align="left">7.</div></td>
                                        <td class="boldEleven"><div align="left"><a href="Rept_MPLC.jsp" target="_blank">MPC</a></div></td>
                                        <td class="boldEleven"><div align="left">8.</div></td>
                                        <td class="boldEleven"><div align="left"><a href="Rept_QPLCQuarter.jsp" target="_blank">QPLC</a></div></td>
                                      </tr>
                                      <tr>
                                        <td class="boldEleven"><div align="left">9.</div></td>
                                        <td class="boldEleven"><div align="left"><a href="Rept_YPC.jsp" target="_blank">YPC</a></div></td>
                                        <td class="boldEleven"><div align="left">10.</div></td>
                                        <td class="boldEleven"><div align="left"><a href="Rept_divisionAchieve.jsp" target="_blank">Division Achieve</a></div></td>
                                      </tr>
                                      <tr>
                                        <td class="boldEleven"><div align="left"></div></td>
                                        <td class="boldEleven"><div align="left"></div></td>
                                        <td class="boldEleven"><div align="left"></div></td>
                                        <td class="boldEleven"><div align="left"></div></td>
                                      </tr>
                                    </table>
                                  <%
								}
								%></td>
							    </tr>
								<tr>
								  <td colspan="5" class="boldEleven" align="center">
                                  <table align="center"><tr><td width='50'>
                                  <input class="buttonbold" type="button" onclick="redirect( 'InventoryMains.jsp')" value="Close" name="Button">
                                  </td></tr></table></center></td>
							    </tr>
								<tr>
								  <td colspan="5" class="boldEleven">
								  <!-- ADMIN REPORT --></td>
							    </tr>
                              </table></td>
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
<%@ include file="../footer.jsp"%>
</body>
</html>




