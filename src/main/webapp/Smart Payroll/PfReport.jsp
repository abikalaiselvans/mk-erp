<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript"
	src="../JavaScript/Attendance/ReportAjax.js"></script>
<script language="javascript">	
	function validate()
	{	  
	  if(checkNullSelect("Month","Select Month","0") && checkNullSelect("Year","Select Year","Select"))
  	  	return true;
      else
        return false;
	}
</script>

<title> :: PAYROLL ::</title>


 
 
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
.style16 {font-size: 14px}
-->
</style>
</head>
<form  AUTOCOMPLETE = "off"   name="a" method="post" action="../SmartLoginAuth">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%@ include file="index.jsp"%>
<br>
<br>
<br>
<table width="1002" border=0>
	<!--DWLayoutTable-->
	<tr>
		<td width="230" height="18"></td>
		<td width="165"></td>
		<td width="53"></td>
		<td width="52"></td>
		<td width="226"></td>
		<td width="250"></td>
	</tr>
	<tr>
		<td height="106"></td>
		<td colspan="4" valign="top" background="../if">
		<table class="BackGround" cellspacing="0" cellpadding="0" width="390"
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

					<table width="390" border="0" align="center" cellpadding="2"
						cellspacing="2"  >
						<!--DWLayoutTable-->
						<tr align="center">
							<td height="28" colspan="2"><span class="tablehead1 style16">PF
							Report </span></td>
						</tr>
						<tr>
							<td width="193" height="28" valign="middle" class="bolddeepblue"><strong>Company</strong></td>
							<td width="293" valign="middle"><select name="company"
								id="company" onChange="loadBranch()" class="bolddeepblue"
								style="width:200px">
								<%                  
     					String queryBranch1="SELECT * FROM  com_m_company ";
     					String	branch1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(queryBranch1);
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
							</select></td>
						<tr>
							<td width="193" height="28" valign="middle" class="bolddeepblue"><strong>Branch</strong></td>
							<td width="293" valign="middle"><select name="branch"
								id="branch" class="bolddeepblue" style="width:200px">
								<option value="-1">All</option>
							</select></td>
						<tr>
							<td width="193" height="28" valign="middle" class="bolddeepblue"><strong>Month</strong></td>
							<td width="293" valign="middle"><%@ include
								file="../JavaScript/month.jsp"%></td>
						</tr>
						<tr>
							<td height="30" valign="middle" class="bolddeepblue"><strong>Year</strong></td>
							<td valign="middle"><%@ include
								file="../JavaScript/year.jsp"%></td>
						</tr>
						<tr>
							<td height="30" colspan="2" valign="middle" class="bolddeepblue">
							<div align="center">
							<table border="0" cellspacing="3" cellpadding="3">
								<tr>
									<td width="56"><input class="buttonbold14" type="submit"
										name="Submit" value="Submit"   accesskey="s"    onClick="return validate()"></td>
									<td width="56"><input class="buttonbold14" type="button"
										name="Submit2"  value="Close"   accesskey="c" 
										onClick="redirect('Payrollmain.jsp')"></td>
								</tr>
							</table>
							</div>
							</td>
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
		<td height="18"></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td height="26"><input type="hidden" name="actionS"
			value="PAYPFREPORT"> <input type="hidden" name="filename"
			value="PfEsiTrans"></td>
		<td>&nbsp;</td>
		<td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
		<td valign="top"><!--DWLayoutEmptyCell-->&nbsp;</td>
		<td>&nbsp;</td>
		<td></td>
	</tr>
</table>
<br>
<br>
<br>
<%@ include file="../footer.jsp"%>
</body>
</form>
</html>
