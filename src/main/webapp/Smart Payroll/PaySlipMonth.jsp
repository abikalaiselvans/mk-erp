<%@ include file="index.jsp"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

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

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript"
	src="../JavaScript/Attendance/ReportAjax.js"></script>
<script language="JavaScript">
function Validate()
  {
  	if(checkNullSelect("Month","Select Month","0")&&(checkNullSelect("Year","Select Year","0"))){
		document.a.submit();
		return true;
	}
	return false;
  }
  function mainPage()
  {
	    document.a.action="AttendanceMain.jsp";
		document.a.submit();
		return true;
  }
  </script>
</head>
<form  AUTOCOMPLETE = "off"   name="a" method="post" action="PaySlipView.jsp"
	onSubmit="return Validate()">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<p class="style8">&nbsp;</p>
<table width="100%" border="0" cellspacing="0" cellpadding="0">

	<tr>
		<td align="center">
		<p class="tablehead">&nbsp;</p>
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

					<table width="390" align="center" border="0"  >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle" class="tabledata">
							<td height="32" colspan="2" class="BackGround" >PaySlip
							Month Wise</td>
						</tr>
						<tr>
							<td width="162" height="28" valign="middle" class="bolddeepblue">
							Company</td>
							<td width="288" class="bolddeepblue"><select name="company"
								id="company" onChange="loadBranch()" class="bolddeepblue"
								style="width:200px">
								<%                  
     					String queryBranch1="SELECT * FROM  com_m_company ";
     					String	branch1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(queryBranch1);
     					for(int i=0;i<branch1.length;i++)
 	 						out.println("<option value='"+branch1[i][0]+"'>"+branch1[i][1]+"</option>");
 			   %>
							</select></td>
						</tr>
						<tr>
							<td width="162" height="28" valign="middle" class="bolddeepblue">
							Branch</td>
							<td width="288" class="tabledata"><select name="branch"
								id="branch" class="bolddeepblue" style="width:200px">
								<option value="-1">All</option>
							</select></td>
						</tr>
						<tr>
							<td width="162" height="32" valign="middle" class="bolddeepblue"><span
								class="bolddeepblue">Month</span></td>
							<td width="288" valign="middle"><strong> <font
								size="1"><font size="1"> <%@ include
								file="../JavaScript/month.jsp"%> </font></font> </strong></td>
						</tr>
						<tr>
							<td height="33" valign="middle" class="bolddeepblue">Year</td>
							<td valign="middle"><strong> <%@ include
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
							<td colspan="2" valign="middle" class="bolddeepblue">
							<div align="center">
							<table border="0" align="center" cellpadding="3" cellspacing="3">
								<tr>
									<td width="56"><input name="Submit" type="submit"
										class="buttonbold14" value="Submit"   accesskey="s"   ></td>
									<td width="56"><input name="Button" type="Button"
										class="buttonbold14"  value="Close"   accesskey="c" 
										onClick="redirect('Payrollmain.jsp')"></td>
								</tr>
							</table>
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
	</tr>
	<tr>
		<td height="75">&nbsp;</td>
	</tr>
	<tr>
		<td height="67"><%@ include file="../footer.jsp"%></td>
	</tr>
</table>
</body>
</form>
</html>
