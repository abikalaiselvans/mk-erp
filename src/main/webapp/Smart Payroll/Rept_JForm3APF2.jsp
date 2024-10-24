<%@ page import="java.io.*,java.util.*,com.my.org.erp.common.*"%>
<%@ page import="com.my.org.erp.bean.Attendance.*"%>
<%@ page import="com.my.org.erp.bean.payroll.*"%>
<%@ page import="com.my.org.erp.SmartPayroll.*"%>
<jsp:useBean id="conbean" class="DBConnection.DBCon"></jsp:useBean>

<%@ page import="com.my.org.erp.ServiceLogin.DateUtil"%>
<html>
<head>
 <title> :: PAYROLL ::</title>

 
 
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>
<script language="javascript">
function Validate()
{

   if(  
			checkNullSelect( "reportType","Select Export Type" ,'0') && checkNullSelect( "Year","Select Year" ,'0') 
			
		  )
			return true;
		else
			return false;	
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

<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.style3 {COLOR: #000000; LINE-HEIGHT: 15px; FONT-FAMILY: Verdana, Arial, Helvetica, Sans-Serif; TEXT-DECORATION: none; font-size: 10px;}
-->
</style>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>

<body  onpaste="return false;" onLoad="init()">
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="advance" method="post" action="../SmartLoginAuth" onSubmit="return Validate()">
<table width="100%" border="0" align="center" cellpadding="2"
	cellspacing="2">
	<tr>
		<td></td>
	</tr>

	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="54">
		<table width="565" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="7"><spacer height="1" width="1" type="block"></td>
					<td width="549" valign="top">
					<table width="549" border="0" cellspacing="0" cellpadding="0">
						<tr class="boldEleven">
							<td height="20">
							<div align="center"></div>							</td>
						</tr>
						<tr>
							<td>
							<div align="right"><font color='red'>* </font><span
								class="changePos">Mandatory</span></div>							</td>
						</tr>
						<tr>
							<td></td>
						</tr>
						<tr>
							<td></td>
						</tr>

						<tr>
							<td height="19"><%@ include file="../JavaScript/Rept_JForm3APFajax.jsp"%></td>
						</tr>
						<tr>
							<td height="19">&nbsp;</td>
						</tr>
						<tr>
							<td height="19">
							<div align="center">
							  <input name="filename" type="hidden" id="filename" value="Rept_JPFForm_3A">
							  <input name="actionS" type="hidden" id="actionS" value="PAYRept_JPFForm_3A">
							  <input name="rptfilename" type="hidden" id="rptfilename" value="Rept_JForm_3APF2">
							  <input name="subRptfilename1" type="hidden" id="subRptfilename1" value="Rept_JForm_3APF_subreport3">
							  <input name="subRptfilename2" type="hidden" id="subRptfilename2" value="Rept_JForm_3APF_subreport4">
							  <input name="subRptfilename3" type="hidden" id="subRptfilename3" value="Rept_JForm_3APF_subreport5">
							  <input name="subRptfilename4" type="hidden" id="subRptfilename4" value="Rept_JForm_3APF_subreport6">
							  <input name="subRptfilename5" type="hidden" id="subRptfilename5" value="Rept_JForm_3APF_subreport7">
							  <input name="subRptfilename6" type="hidden" id="subRptfilename6" value="Rept_JForm_3APF_subreport8">
							  <input name="subRptfilename7" type="hidden" id="subRptfilename7" value="Rept_JForm_3APF_subreport9">
							  <input name="subRptfilename8" type="hidden" id="subRptfilename8" value="Rept_JForm_3APF_subreport10">
							  <input name="subRptfilename9" type="hidden" id="subRptfilename9" value="Rept_JForm_3APF_subreport11">
							  <input name="subRptfilename10" type="hidden" id="subRptfilename10" value="Rept_JForm_3APF_subreport12">
							  <input name="subRptfilename11" type="hidden" id="subRptfilename11" value="Rept_JForm_3APF_subreport13">
							  <input name="subRptfilename12" type="hidden" id="subRptfilename12" value="Rept_JForm_3APF_subreport14">
							</div>							</td>
						</tr>
						<tr>
						  <td height="19">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input type="submit" name="Submit"
										id="submit_btn" class="buttonbold14" value="Submit"   accesskey="s"    /></td>
									<td width="56"><input type="button" name="submit"
										class="buttonbold14"  value="Close"   accesskey="c" 
										onClick="redirect('Advance.jsp')" /></td>
								</tr>
							</table>							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="7"><spacer height="1" width="1"
						type="block" /></td>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2">
					<div align="right">
					<div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div>
					</div>
					</td>
					<td height="13"><spacer height="1" width="1" type="block"></td>
					<td colspan="2" rowspan="2" valign="bottom">
					<div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div>
					</td>
				</tr>
				<tr>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
			</tbody>
		</table>
	 </td>
	</tr>
	<tr>
		<td height="23">&nbsp;</td>
	</tr>
	<tr>
		<td height="40">&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%></form>