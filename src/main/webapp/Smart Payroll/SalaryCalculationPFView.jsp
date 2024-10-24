<%@ page import="java.sql.*" isErrorPage="false"
	errorPage="./InValidSession.jsp"%>
<%!
	String sql;
%>
<html>
<head>
 

<title> :: PAYROLL ::</title>


 
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"></script>
<script language="javascript">
function UpdateAllowance()
{
	var r=confirm("Update Allowance ")
	var mnth=document.getElementById("Month").value;
	var yr =document.getElementById("Year").value;
		
	if (r==true)
	{
		document.salfrm.action="PayrollAllowanceUpdate.jsp";
		document.salfrm.submit();
		return true;
	}
	else
	{
		document.salfrm.action="../SmartLoginAuth";
		document.salfrm.submit();
		return true;
	}
	
}
	function disableMonthWise()
	{
		document.salfrm.Year.disabled=false;
		document.salfrm.Month.disabled=false;
		document.salfrm.frmdate.disabled=true;
		document.salfrm.todate.disabled=true;		
	}
	function disableYearWise()
	{
		document.salfrm.Year.disabled=true;
		document.salfrm.Month.disabled=true;
		document.salfrm.frmdate.disabled=false;
		document.salfrm.todate.disabled=false;
	}
	function validate()
	{
		var val=document.getElementById("month1").checked;
		if(val==true)
		{
			if(checkNullSelect("Month","Select Month","0") && checkNullSelect("Year","Select Year","0"))
				return true;
			else
				return false;
		}
		else
		{
			if(checkNull('frmdate','Select From Date') && checkNull('todate','Select From Date'))
				return true;
			else
				return false;
		}
		return false;
	}
	function mainPage()
	{
	    document.salfrm.action="Payrollmain.jsp";
		document.salfrm.submit();
		return true;
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
.style3 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>
</head>
<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<form  AUTOCOMPLETE = "off"   name="salfrm" action="../SmartLoginAuth" onSubmit="return validate()">
<br>
<br>
<br>
<br>
<table width="41%" height="197" border="0" align="center"
	cellpadding="0" cellspacing="0"  >
	<!--DWLayoutTable-->
	<tr>
		<td width="451" height="195" valign="top">
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

					<table width="455" height="95%" align="right" cellpadding="1"
						cellspacing="1"  1>
						<!--DWLayoutTable-->
						<tr>
							<td height="26" colspan="3" align="center" valign="middle"
								class="BackGround" >Salary Calculation</td>
						</tr>
						<tr>
							<td align=center class="boldgre"></td>
							<!--<td width="242" align=center class="boldgre"><div align="center" class="bolddeepblue">
            <input type="radio" id="date1" name="reportType" value="Date" onClick="disableYearWise()" >
            DateWise</div></td>-->
						</tr>
						<tr>
							<td colspan="2" align="center">
							<div align="center" class="bolddeepblue">

							<div align="center"><input type="radio" id="month1"
								name="reportType" value="Month" onClick="disableMonthWise()"
								checked> MonthWise</div>
							</div>
							</td>
						</tr>
						<tr>
							<td colspan="2" align="center">
							<table border="1" cellspacing="1" cellpadding="3"
								 >
								<tr>
									<td class="bolddeepblue">Select Month</td>
									<td><%@ include file="../JavaScript/month.jsp"%>
									</td>
								</tr>
								<tr>
									<td class="bolddeepblue">Select Year</td>
									<td><%@ include file="../JavaScript/year.jsp"%>
									</td>
								</tr>
							</table>
							</td>
						</tr>
						<tr>
							<td align="center"><!--DWLayoutEmptyCell-->&nbsp;</td>
							<td align="center"><!--<table border="1" cellspacing="1" cellpadding="1"  >
              <tr>
                <td class="bolddeepblue">Form </td>
                <td><input name="frmdate" type="text" class="bolddeepblue" id="frmdate" onKeyPress="dateOnly('frmdate')" size="18">
                    <a href="javascript:cal1.popup();" > <img src="../JavaScript/img/cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date"></a> </td>
              <tr>
                <td class="bolddeepblue">To </td>
                <td><input name="todate" type="text" class="bolddeepblue" id="todate" onKeyPress="dateOnly('todate')" size="18">
                    <a href="javascript:call1.popup();"> <img src="../JavaScript/img/cal.gif" width="16" height="16" border="0" alt="Click Here to Pick up the date"></a>
					
					<script language="JavaScript">			
 
			var cal1 = new calendar1(document.forms['salfrm'].elements['frmdate']);
			cal1.year_scroll = true;
			cal1.time_comp = false;
			var call1 = new calendar1(document.forms['salfrm'].elements['todate']);
			cal1.year_scroll = true;
			cal1.time_comp = false;		
			setCurrentDate('frmdate');
			setCurrentDate('todate');			
			
 	
</script>
					 </td>
              </tr>
          </table>--></td>
						</tr>
						<tr>
							<td height="50" align="right" class="bolddeepblue">
							<div align="right">Department</div>
							</td>
							<td><select name="Department" class="bolddeepblue"
								id="Department">
								<option value="-1">All</option>
								<%	
              ArrayList departmentList=(ArrayList) session.getAttribute("departmentList");
  			  for(int i=0;i<departmentList.size();i++)
  			  {
  				com.my.org.erp.bean.Department depart= (com.my.org.erp.bean.Department)departmentList.get(i);
		%>
								<option value="<%= depart.getDepartId() %>">
								<%    	out.println(depart.getDepartName()); 	  %>
								</option>
								<%
			  }
		%>
							</select> <input type="hidden" name="filename" value="SalaryCalculation">
							<input type="hidden" name="actionS"
								value="PAYSalaryCalculationNPF"></td>
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

		<br>
</table>

<br>

<table align="center">
	<tr>

		<td width="56"><input name="CalculationNPF" type="submit"
			class="buttonbold14" id="CalculationNPF" accesskey="C"
			value="Calculate"></td>
		<!--<td width="56">
            <input type="submit" name="CalculationNPF" class="buttonbold14"  value="View" accesskey="V" >-->
		<td width="76"><input name="CalculationNPF" type="submit"
			class="buttonbold14" id="CalculationNPF" value="Detailed View"
			onClick=" return UpdateAllowance()">
		<td width="56"><input class="buttonbold14" type="button"
			name="Submit"  value="Close"   accesskey="c"  onClick="mainPage()"
			onsubmit="return validate()"></td>
	</tr>
</table>

<br>
<br>
<br>
<%@ include file="../footer.jsp"%></form>
</body>
</html>
