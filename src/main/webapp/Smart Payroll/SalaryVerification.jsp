<%@ page import="java.sql.*" isErrorPage="false" errorPage="./InValidSession.jsp"%>
<%@ page import="com.my.org.erp.common.*"%>
<%!
	String sql;
%>
<html>
<head>
<title> :: PAYROLL ::</title>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>
 
 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript">
 	 
function  Validate()
{
	try
	{
		if(
		  	checkNullSelect('Month','Select Month','0')
			&& checkNullSelect('Year','Select Year','0')
			
		  )
		  {
 					return true;
 			} 
		  else
		  	return false;
	}
	catch(err)
	{
		alert(err);
		return false;
	}
}
	
	 
	 
	
	 
</script>
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
<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<form action="../SmartLoginAuth" method="post"   name="salfrm" onSubmit=" return Validate()"  AUTOCOMPLETE = "off">
<p>&nbsp;</p>
<table width="99%" border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="250"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">
					<table width="400" height="95%" align="right" cellpadding="1"
						cellspacing="1"  1>
						<!--DWLayoutTable-->
						<tr>
							<td height="26" colspan="3" align="center" valign="middle"
								class="BackGround" >SALARY VERIFICATION </td>
						</tr>
						<tr>
							<td align=center class="boldgre"></td>
							 
						</tr>
						<tr>
							<td colspan="2" align="center"></td>
						</tr>
						<tr>
							<td colspan="2" align="center">
							<table width="100%" border="0" cellpadding="3" cellspacing="0"
								 >
								 
								
								 
							  
							  
							  <tr>
									<td class="boldEleven">Month<span class="boldred"> *</span> </td>
									<td class="boldEleven"><%@ include file="../JavaScript/month.jsp"%>								  </td>
							  </tr>
								<tr>
									<td class="boldEleven">Year<span class="boldred"> *</span> </td>
									<td class="boldEleven"><%@ include file="../JavaScript/year.jsp"%>								  </td>
								</tr>
							</table>							</td>
						</tr>
						<tr>
							<td colspan="2" align="center">							</td>
						</tr>
						 
						<tr>
							<td colspan="2" align="center"><label>
							<input name="filename" type="hidden" id="filename" value="SalaryVerification">
                            <input name="actionS" type="hidden" id="actionS" value="PAYSalaryVerification">  
							 </label></td>
						</tr>
						<tr>
							<td colspan="2" align="center">
							<table border="0" cellspacing="0" cellpadding="3">
								<tr>
									<td ><input name="Submit" type="submit"
										class="buttonbold" value="Verification"></td>
									<td ><input name="Submit2" type="button"
										class="buttonbold"  value="Close"   accesskey="c" 
										onClick="redirect('Payrollmain.jsp')"></td>
								</tr>
							</table>							</td>
						</tr>
						<tr>
							<td colspan="2" align="center"><!--DWLayoutEmptyCell-->&nbsp;							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="4"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
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
		<td></td>
	</tr>
	<tr>
		<td></td>
	</tr>
</table>
<p>&nbsp;</p>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
