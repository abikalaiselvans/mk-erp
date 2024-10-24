
<%@ page import="java.sql.*,java.io.*,java.util.*"%>
<%@ include file="index.jsp"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title> :: PAYROLL ::</title>


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
 
 
 <script language="javascript" src="../JavaScript/comfunction.js"></script>

</head>
<form  AUTOCOMPLETE = "off"   method="post" name="a"
	action="PersonalDeptViPersonal Info. Departmentwise.jsp">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" height="60%" border="0" cellpadding="0"
	cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
		<td width="271" height="19">&nbsp;</td>
		<td width="442">&nbsp;</td>
		<td width="265">&nbsp;</td>
	</tr>
	<tr>
		<td height="113">&nbsp;</td>
		<td valign="middle">
		<table class="BackGround" cellspacing="0" cellpadding="0" width="600"
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
					<td width="376">

					<table width="100%" height="164" border="0" align="center"
						cellpadding="2" cellspacing="2"  >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="28" colspan="4" 
								class="BackGround style9">REPORTS</td>
						</tr>
						<tr align="left" valign="middle">
						  <td height="25" colspan="2" align="center" valign="middle"><div align="center" class="bold1"> 
						    <div align="center">PF  </div>
						  </div></td>
						  <td colspan="2" align="left" valign="middle"> <div align="center" class="bold1"> 
						    <div align="center">ESI  </div>
						  </div></td>
					  </tr>
						 
						<tr align="left" valign="middle">
						  <td align="center" valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
							<td height="25" align="center" valign="middle" class="boldEleven"><div align="left"><a href="Rept_JMonthlypfreport.jsp?filename=Designation&actionS=COM_PAYREPdesigList&view=MessBill" target="_blank">PF Monthly </a></div></td>
							<td align="left" valign="middle" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							<td width="101" class="boldEleven"><div align="left"><a href="Rept_JMonthlyESIreport.jsp?filename=Designation&actionS=COM_PAYREPdesigList&view=MessBill" target="_blank">ESI Monthly&nbsp;</a></div></td>
						</tr>
						<tr align="left" valign="middle">
						  <td align="center" valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  <td height="23" align="center" valign="middle" class="boldEleven"><div align="left"><a href="Rept_JPF-FORM5.jsp" target="_blank"  >FORM -5</a></div></td>
						  <td align="left" valign="middle" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  <td class="boldEleven"><div align="left"><a href="Rept_JESIForm6-1.jsp" target="_blank">Form 6-1</a></div></td>
					  </tr>
						<tr align="left" valign="middle">
						  <td align="center" valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  <td height="23" align="center" valign="middle" class="boldEleven"><div align="left"><a
								href="Rept_JPF-FORM10.jsp?filename=Department&actionS=COM_PAYREPdepartList&view=MessBill" target="_blank"  >FORM -10 </a></div></td>
						  <td align="left" valign="middle" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  <td class="boldEleven"><div align="left"><a href="Rept_JESIForm6-2.jsp" target="_blank">Form 6-2</a></div></td>
					  </tr>
						<tr align="left" valign="middle">
						  <td align="center" valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  <td height="23" align="center" valign="middle" class="boldEleven"><div align="left"><a href="Rept_JPF-FROM6A.jsp" target="_blank">FORM 6A </a></div></td>
						  <td align="left" valign="middle" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  <td class="boldEleven"><div align="left"><a href="Rept_JESIForm6-3.jsp" target="_blank">Form 6 -3</a></div></td>
						</tr>
						<tr align="left" valign="middle">
						  <td width="19" align="center" valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
							<td width="135" height="23" align="center" valign="middle" class="boldEleven"><div align="left"><a href="Rept_JForm12A.jsp" target="_blank">FORM 12A </a></div></td>
							<td width="22" align="left" valign="middle" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
							<td class="boldEleven"><div align="left"><a href="Rept_JESIFormQ.jsp" target="_blank">Form - Q Register of Employment</a></div></td>
						</tr>
						<tr align="center" valign="middle">
						  <td align="center" valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
							<td height="25" align="center" valign="middle" class="boldEleven"><div align="left"><a href="Rept_JForm3APF.jsp" target="_blank">PF FORM 3A </a></div></td>
							<td align="left" valign="middle" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp; </td>
							<td align="left" class="boldEleven"><a href="#">Form - P Register </a></td>
						</tr>
						 
						<tr align="center" valign="middle">
						  <td align="center" valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  <td height="25" align="left" valign="middle" class="boldEleven"><a href="Rept_JPF_AnnualReturns.jsp" target="_blank">PF ANNUAL RETURNS</a></td>
						  <td align="left" valign="middle" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  <td align="left" valign="middle" class="boldEleven"><a href="#">Form - T Wage Slip / Leave Card</a></td>
					  </tr>
						<tr align="center" valign="middle">
						  <td align="center" valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  <td height="25" align="left" valign="top" class="boldEleven"><a href="Rept_JPFOrganisation_Challan.jsp" target="_blank">PF ORGANIZATION CHALLAN</a></td>
						  <td align="left" valign="middle" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  <td align="left" valign="middle" class="boldEleven"><a href="#">Form - R Register of salary</a></td>
					  </tr>
						<tr align="center" valign="middle">
						  <td align="center" valign="middle"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  <td height="25" align="left" valign="middle" class="boldEleven"><a href="Rept_Forms.jsp" target="_blank">PF Forms</a></td>
						  <td align="left" valign="middle" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  <td align="left" valign="middle" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
					  </tr>
						<tr>
							<td colspan="4">
							<table border="0" align="center" cellpadding="2" cellspacing="2">
								<tr>
									<td width="56"><input class="buttonbold14" type="button"
										name="Submit2"  value="Close"   accesskey="c"  onClick="redirect('Payrollmain.jsp')"></td>
								</tr>
							</table>							</td>
						</tr>
					</table>
				  </td>
					<td nowrap="nowrap" width="6"><spacer height="1" width="1"
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
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="65">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</form>
</html>
