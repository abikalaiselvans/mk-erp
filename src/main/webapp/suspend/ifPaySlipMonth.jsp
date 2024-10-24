<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

 

 
 
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

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
 
<script language="JavaScript">
function Validate()
  {
  	if(checkNullSelect("Month","Select Month","0")&&(checkNullSelect("Year","Select Year","0"))){
		document.a.submit();
		return true;
	}
	return false;
  }
  
  </script>
</head>
<form  AUTOCOMPLETE = "off"   name="a" method="post" action="ifPaySlipView.jsp" onSubmit="return Validate()">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<table width="62%" border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td height="113" align="center">
		<p class="tablehead">&nbsp;</p>
		<table width="350" border="0" align="center" cellpadding="0"
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
					<td width="6"><spacer height="1" width="1" type="block"></td>
					<td width="577" valign="top">

					<table width="350" align="center" border="0"  >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle" class="tabledata">
							<td height="32" colspan="2" class="BackGround" >PaySlip
							Month Wise</td>
						</tr>
						<tr>
							<td width="135" height="32" valign="middle" class="bolddeepblue"><span
								class="bolddeepblue">Month</span></td>
							<td width="199" align="left" valign="middle"><strong>
							<font size="1"><font size="1"> <%@ include
								file="../JavaScript/month.jsp"%> </font></font> </strong></td>
						</tr>
						<tr>
							<td height="33" valign="middle" class="bolddeepblue">Year</td>
							<td align="left" valign="middle"><strong> <%@ include
								file="../JavaScript/year.jsp"%> <script
								language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('Month',month1);
						setOptionValue('Year',year1);							
				//-->
          </script> <input type="hidden" name="filename" value="Attendance">
							<input type="hidden" name="actionS"
								value="ATTAttendanceMonthList"> </strong></td>
						</tr>
						<tr>
							<td height="71" colspan="2" valign="middle" class="bolddeepblue">
							<table width="100" border="0" align="center" cellpadding="2"
								cellspacing="2">
								<tr>
									<td width="56"><input name="Submit" type="submit"
										class="buttonbold" value="Submit"   accesskey="s"   ></td>
									<td width="56"><input name="Button" type="Button"
										class="buttonbold"  value="Close"   accesskey="c" 
										onClick="redirect('Userframe.jsp')">
									</td>
								</tr>
							</table>
							<p class="bolddeepblue">&nbsp;</p>
							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="6"><spacer height="1" width="1"
						type="block" /></td>
					<td width="1" class="BorderLine"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
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
		<td>&nbsp;</td>
	</tr>
</table>
</body>
</form>
</html>
