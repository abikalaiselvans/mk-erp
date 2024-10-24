<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language="javascript">
function validate()
{
	
return true;				
}
function mainPage()
	{
	    document.payslipfrm.action="Payrollmain.jsp";
		document.payslipfrm.submit();
		return true;
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

</head>
<form  AUTOCOMPLETE = "off"   name="payslipfrm" method="post" action="PaySlipView.jsp"
	onSubmit="return validate()">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%@ include file="index.jsp"%>
<table width="100%" border="0" align="center" cellpadding="0"
	cellspacing="0">
	<tr>
		<td height="50">&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table width="441" border="1" align="center" cellpadding="2"
			cellspacing="2"  >
			<!--DWLayoutTable-->
			<tr align="center">
				<td height="28" colspan="2" class="BackGround" >Pay
				Slip</td>
			</tr>
			<tr>
				<td width="185" height="30" valign="middle" class="bolddeepblue">Year<strong>
				<font color="#ff0000">*</font></strong></td>
				<td width="236" valign="top"><select name="year"
					class="tabledata">
					<option value="select">Select</option>
					<% 
			        int i=1990;
				  while(i<=2020)
			      {
			  %>
					<option value="<%=i%>"><%=i%></option>
					<%
			      i++;
			      }
			  %>
				</select></td>
			</tr>
			<tr>
				<td height="30" valign="middle" class="bolddeepblue">Month<strong>
				<font color="#ff0000">*</font></strong></td>
				<td valign="top"><select name="month" class="tabledata">
					<option value="select">Select</option>
					<option value="January">January</option>
					<option value="February">February</option>
					<option value="March">March</option>
					<option value="April">April</option>
					<option value="May">May</option>
					<option value="June">June</option>
					<option value="July">July</option>
					<option value="August">August</option>
					<option value="September">September</option>
					<option value="October">October</option>
					<option value="November">November</option>
					<option value="December">December</option>
				</select></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="112" border="0" align="center" cellpadding="2"
			cellspacing="2">
			<tr>
				<td width="56"><input class="buttonbold" type="submit"
					name="Submit" value="Submit"   accesskey="s"   ></td>
				<td width="56"><input class="buttonbold" type="button"
					name="Submit2"  value="Close"   accesskey="c"  onClick="mainPage()"></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td height="150">&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</form>
</html>
