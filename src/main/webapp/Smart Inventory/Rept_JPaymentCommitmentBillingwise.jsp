<%@ page import="java.io.*,java.util.*"%>
<%@ page import="java.io.*,java.util.*,com.my.org.erp.common.*"%> 
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
	  <td></td>
  </tr>
  <tr>
	  <td>
		<form name="frm" method="post" action="../SmartLoginAuth" onSubmit=" return Validate()">
      
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="431"
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
					<table cellspacing="2" cellpadding="2" width="427" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen"> PAYMENT COMMITMENT <%
				String branchid=""+session.getAttribute("BRANCHID");
				String usertype=""+session.getAttribute("USRTYPE");
				String user= ""+session.getAttribute("USRID"); 
				%></td>
							</tr>

							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							 
						
							<tr>
							  <td height="17" class="boldEleven"><strong>Sales Type </strong></td>
							  <td colspan="2" align="left">  
							  <select name="salestype" class="formText135" id="salestype" style="width:250" >
                        <option value="0">Select </option>
						<option value="A">All</option>
						<option value="C">Customer Sales</option>
                        <option value="D">Direct Billing</option>
                        <option value="S">Service Billing</option>
                      </select></td>
						  </tr>
							<tr>
							  <td height="19" align="right" valign="top" class="boldEleven"><div align="left"><strong>Branch</strong></div></td>
							  <td align="right" valign="top" class="boldEleven"><div align="left">
                                  <select name="Branch" class="formText135"
							id="Branch" tabindex="6"  style="width:250"  >
                                   <option value="0">All </option>
								    <%
								
				String shipids[][] =  CommonFunctions.QueryExecute("Select a.INT_BRANCHID,a.CHR_BRANCHNAME ,b.CHR_COMPANYNAME from  com_m_branch  a  ,com_m_company b where  a.INT_COMPANYID = b.INT_COMPANYID ");
				if(usertype.equals("F") || usertype.equals("B"))
				{
				  for(int u=0; u<shipids.length; u++)
					out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
				}
				else
				{
					for(int u=0; u<shipids.length; u++)
						if(shipids[u][0].equals(branchid))
							out.print("<option value='"+shipids[u][0]+"'>"+shipids[u][2]+" @ "+shipids[u][1]+"</option>");
												
				}
						
							%>
                                  </select>
                                  <script language="javascript">
						  	setOptionValue("Branch","<%=branchid%>") 
						      </script>
                              </div></td>
						  </tr>
							<tr>
							  <td height="19" align="right" valign="top" class="boldEleven"><div align="left"><strong>Division</strong></div></td>
							  <td align="right" valign="top" class="boldEleven"><div align="left">
                                  <select
										name="division" class="formText135" id="division" tabindex="1" style="width:250" >
                                    <option value='0'>All</option>
                                    <%
								String division[][] = CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
                                  </select>
                              </div></td>
						  </tr>
								<tr>
								<td width="117" height="17" class="boldEleven"><strong>Status</strong></td>
								<td width="296" colspan="2" align="left">
								<select name="status"  id="status" class="formText135" style="width:100" >
								<option value="Y">Received</option>
								<option value="N">Not-Received</option>
							    </select></td>
							</tr>
								<tr>
								  <td height="17" class="boldEleven"><strong>Export File Type  <span
									class="bolddeepred">*</span></strong></td>
								  <td colspan="2" align="left"><span class="boldEleven">
								    <select name="reportType" id="reportType" style="width:100">
                                      <option value="0">Select Export File Type</option>
                                      <option value="csv">CSV</option>
                                      <option value="xls">Excel</option>
                                      <option value="html">HTML</option>
                                      <option value="pdf" selected="selected">PDF</option>
                                      <option value="txt">Text</option>
                                      <option value="rtf">Word</option>
                                      <option value="xml">XML</option>
                                    </select>
								  </span></td>
						  </tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								  <input name="filename"
									type="hidden" value="Rept_JPaymentCommitmentBillingwise" />
                                  <input name="actionS"
									type="hidden" value="INVRept_JPaymentCommitmentBillingwise" />
                                  <input name="rptfilename" type="hidden" id="rptfilename" value="paymentCommitment">
<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" type="submit"
											class="buttonbold13" id="Submit" value="Submit"   accesskey="s"   
											 ></td>
										<td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('Rept_PaymentCommitment.jsp')"></td>
									</tr>
							  </table>								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
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
	</table>
	  </form>
		  </td>
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
	if(checkNullSelect( "salestype","Select salestype",'0' )     )
		return true;
	else
		return false;				
		
 } 	
</script> 
<%@ include file="../footer.jsp"%>
</body>
</html>
