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
<script src="../JavaScript/common/StaffloadAjax.js"></script>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript">
function  validate()
{
	try
	{
		if(
		  	checkNull("ename","Select Employee ") 
			&& checkNullSelect('month','Select Month','0')
			&& checkNullSelect('year','Select Year','0')
			
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
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  onLoad="init()">
 <%@ include file="index.jsp"%> 
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
	  <td>&nbsp;</td>
  </tr>
	 
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<form  AUTOCOMPLETE = "off"   name="frm" action="../SmartLoginAuth" onSubmit=" return validate()">
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
					<table width="420" border="0" cellspacing="2" cellpadding="2"
						 >
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="18" colspan="2" class="BackGround">ALLOWANCE AND RECOVERY MIGRATE PROCESS</td>
						</tr>
						 <tr class="bolddeepblue">
						   <td height="35" colspan="2" valign="middle" class="boldEleven">
                           <div align="center"><%@ include file="../JavaScript/ajax.jsp"%></div>
                           </td>
				      </tr>
						 <tr class="bolddeepblue">
						  <td height="35" valign="middle" class="boldEleven">Type</td>
						  <td valign="top" class="bolddeepblue">
						  <select name="type" class="formText135" id="type">
						  <option value="1">Basic</option>
						  <option value="2">Allowance</option>
						  <option value="3">Recovery</option>
						  
						    </select>
						  </td>
					  </tr>
						<tr class="bolddeepblue">
							<td width="132" height="35" valign="middle" class="boldEleven">Month<font
								color='red'>&nbsp;</font></td>
							<td width="268" valign="top" class="bolddeepblue"><select
								name="month" id="month"  class="formText135"  style="width:100">
								<option value="0">Select</option>
								<%@ include file="../JavaScript/months.jsp" %>
							</select></td>
						</tr>
						<tr>
							<td class="boldEleven">Year</td>
							<td><select name="year"  id="year"  class="formText135"  style="width:100">
								<option value="0">Select</option>
								<%@ include file="../JavaScript/years.jsp" %>
							</select> <script language='JavaScript' type="text/javascript">
				<!--			
						var d=new Date()
						var month1=d.getMonth() + 1
						if(month1<10) month1="0"+month1;
						var year1=d.getFullYear();
						setOptionValue('month',month1);
						setOptionValue('year',year1);							
				//-->
                  </script> <input type="hidden" name="filename"
								value="EmployeeWiseAllowanceTransfer">
                  <input type="hidden"
								name="actionS" value="PAYAllowanceTransfer"></td>
						</tr>
						
						 
						<tr>
							<td height="28" colspan="2" valign="middle" class="bolddeepblue">
							<table width="142" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="61"><input name="Submit2" type="submit"
										class="buttonbold14" id="submit" value="Transfer"></td>
									<td width="60"><input class="buttonbold14" type="button"
										name="Submit"  value="Close"   accesskey="c" 
										onClick="redirect('Payrollmain.jsp')"></td>
								</tr>
							</table>							</td>
						</tr>
						<tr>
							<td height="2"></td>
							<td></td>
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
		</form>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<p><%@ include file="../footer.jsp"%></p>
</body>
</html>
