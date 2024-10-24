<%@ page import="java.io.*,java.util.*"%>
<%@ page import="sun.net.smtp.SmtpClient"%>

<html>
<head>
<title>:: INVENTORY ::</title><style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
 </style>
<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Company, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js" type="text/javascript"></script>
<script language="javascript" src="../JavaScript/Inventory/Loaditemproductgroup.js"></script>
 
<body >
<%@ include file="indexinv.jsp"%>
<form  AUTOCOMPLETE = "off"   name="frm" method="post" action="Rept_StockBookCompanyWiseviewresponse.jsp">
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
					<table cellspacing="2" cellpadding="2" width="500" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Stock Book view </td>
							</tr>

							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory<%
				String branchid=""+session.getAttribute("BRANCHID");
				String usertype=""+session.getAttribute("USRTYPE");
				 	
			%>
								</span></td>
							</tr>
							 
							<tr>
                  <td width="199" height="17" class="boldEleven">Compnay</td>
                  <td width="287" colspan="2" align="left">
				  <select name="Company"
										class="formText135" id="Company" tabindex="6">
										 
										<%
								 
								String seq="  SELECT INT_COMPANYID,CHR_COMPANYNAME FROM  com_m_company ORDER BY CHR_COMPANYNAME ";
 
								String shipidse[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(seq);
								for(int u=0; u<shipidse.length; u++)
									out.print("<option value='"+shipidse[u][0]+"'>"+shipidse[u][1] +"</option>");
							%>
						</select>				  </td>
                </tr>
							<tr>
							  <td height="17" class="boldEleven">Month</td>
							  <td colspan="2" align="left"><span class="boldEleven">
							    <select name="month" id="month"  >
                                  <%@ include file="../JavaScript/Inventory/month.jsp"%>
                                </select>
							  </span></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">Year</td>
							  <td colspan="2" align="left"><span class="boldEleven">
							    <select name="year" id="year" >
                                  <%@ include file="../JavaScript/Inventory/year.jsp"%>
                                </select>
                                <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
                                </script>
							  </span></td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven">Division								</td>
								<td colspan="2" align="left"><select name="division"
									class="formText135" id="division" tabindex="1">
									<option value='0'>All</option>
									<%
								String division[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("Select INT_DIVIID,CHR_DIVICODE from inv_m_division   WHERE INT_DIVIID >0 AND CHR_OFFICEIDS LIKE '%"+session.getAttribute("INVOFFICEID")+"%'  ORDER BY CHR_DIVICODE"); 
								for(int u=0; u<division.length; u++)
									out.print("<option value='"+division[u][0]+"'>"+division[u][1]  +"</option>");
							%>
								</select></td>
							</tr>
							<tr>
							<td height="17" class="boldEleven">Product Type <span class="boldred">*</span></td>
								<td colspan="2" align="left"><select class='formText135'
									name='itype' id='itype' onChange="LoaditemproductGroup(this)"  style="width:150">
									<option value="">Please Select</option>
									<option value='1'>Item</option>
									<option value='2'>Product</option>
								</select></td>
							</tr>
							<tr>
							  <td height="17" class="boldEleven">Item / Product group <span class="boldred">*</span></td>
							  <td colspan="2" align="left"><select class='formText135'
									name='pgroup' id='pgroup'  style="width:150" onChange="LoaditemproductdependsGroup()">
							    <option value="0">All</option>
							     
						      </select></td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven">Item / Product Code <span class="boldred">*</span></td>
								<td colspan="2" align="left"><select class='formText135'
									name='item' id='item'  style="width:150">
								  <option value="0">All</option>
								  </select>
																</td>
	 
							</tr>
							<tr>
								<td width="173" height="17" class="boldEleven">with Zero </td>
								<td width="201" colspan="2" align="left"><input name="Zero" type="checkbox" id="Zero" value="Y"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><input name="filename"
									type="hidden" value="Reports" /> <input name="actionS"
									type="hidden" value="INVStockSerialNumber" /></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   
											onClick="return Validate()"></td>
										<td><input name="Close" type="button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="javascirpt:window.close()"></td>
									</tr>
								</table>								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
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
	if(checkNull( "Company","Select Company" )&& checkNull( "itype","Select Item/Product" ))
		return true;
	else
		return false;				
		
 } 	
</script> <%@ include file="../footer.jsp"%></form>
</body>
</html>
