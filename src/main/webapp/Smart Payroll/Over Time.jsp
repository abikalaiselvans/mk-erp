<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language="javascript">
	
				function validate()
	
					{
				
						var Aname=document.getElementById("an").value
						var Acode=document.getElementById("ac").value
						
						
  					    submitOK="true"

						
                                          
							
						    if (Aname=="")

 							 {

								alert(" Enter Allowance Name")

								document.a.aname.focus()

                 					         submitOK="false"

							 }
							
							else if (Acode=="")

 							 {

								alert(" Enter Allowance Code")

								document.a.acode.focus()

                 					         submitOK="false"

							 }
							 
                        
						    if (submitOK=="false")
	
							 {
			
								 return false

 							 }
 						}	
						function mainPage()
	{
	    document.a.action="Payrollmain.jsp";
		document.a.submit();
		return true;
    }
		
			</script>

<title> :: PAYROLL ::</title>


 
 
<script src="../JavaScript/AJAXFunction.js"></script>
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
.style1 {	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
.style12 {color: #FFFFFF}
.style14 {color: #FFFFFF; font-weight: bold; }
.style8 {	font-family: Verdana;
	font-size: 12px;
}
-->
</style>
</head>
<form  AUTOCOMPLETE = "off"   name="a" method="post" action="PayAllowance.jsp"
	onSubmit="return validate()">
<body  onpaste="return false;" onLoad="init();">
<%@ include file="index.jsp"%>
<center><br>
<br>
<br>
<table width="1002" border=0>
	<!--DWLayoutTable-->
	<tr>
		<td width="273" height="80">&nbsp;</td>
		<td width="119">&nbsp;</td>
		<td width="60">&nbsp;</td>
		<td width="52">&nbsp;</td>
		<td width="183">&nbsp;</td>
		<td width="296">&nbsp;</td>
	</tr>
	<tr>
		<td height="48">&nbsp;</td>
		<td colspan="4" valign="top">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<!--DWLayoutTable-->
			<tr>
				<td width="424" height="46" valign="top"><%@ include
					file="../JavaScript/ajax.jsp"%></td>
			</tr>
		</table>
		</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="27">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="161">&nbsp;</td>
		<td colspan="4" valign="top" background="../if">
		<table width="423" border="1" cellspacing="2" cellpadding="2"
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle">
				<td height="25" colspan="2"  class="tablehead">Over
				Time</td>
			</tr>
			<tr>
				<td width="140" height="30" valign="middle" class="bolddeepblue">Department
				<font color="#ff000">*</font></td>
				<td width="263" valign="top"><select name="select">
					<option>All Employess</option>
				</select></td>
			</tr>
			<tr>
				<td height="30" valign="middle" class="bolddeepblue">Designation
				<font color="#ff0000">*</font></td>
				<td valign="top"><select name="select2">
					<option>All Employess</option>
				</select></td>
			</tr>
			<tr>
				<td height="30" valign="middle" class="bolddeepblue">Year <font
					color="#ff0000">*</font></td>
				<td valign="top"><select name="select3">
					<option>All Employess</option>
				</select></td>
			</tr>
			<tr>
				<td height="30" valign="middle" class="bolddeepblue">Month <font
					color="#ff0000">*</font></td>
				<td valign="top"><select name="select5">
					<option>All Employess</option>
				</select></td>
			</tr>
		</table>
		</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="31">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="26"></td>
		<td>&nbsp;</td>
		<td valign="top"><input class="buttonbold" type="submit"
			name="Submit" value="Submit"   accesskey="s"   ></td>
		<td valign="top"><input class="buttonbold" type="submit"
			name="Submit"  value="Close"   accesskey="c"  onclick="mainPage()"></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>

<br>
<%@ include file="../footer.jsp"%>
<center>
</body>

</form>
</html>
