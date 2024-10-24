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
<form  AUTOCOMPLETE = "off"   name="a" method="post" action="PayAllowance.jsp"
	onSubmit="return validate()">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%@ include file="index.jsp"%>
<br>
<br>
<br>
<table width="1002" border=0>
	<!--DWLayoutTable-->
	<tr>
		<td width="248" height="22"></td>
		<td width="162"></td>
		<td width="53"></td>
		<td width="53"></td>
		<td width="205"></td>
		<td width="255"></td>
	</tr>
	<tr>
		<td height="135"></td>
		<td colspan="4" valign="top" background="../if">
		<table width="469" border="1" cellspacing="2" cellpadding="2"
			 >
			<!--DWLayoutTable-->
			<tr align="center">
				<td height="28" colspan="2" valign="middle" class="BackGround"
					 >Form 3A</td>
			</tr>
			<tr>
				<td height="28" valign="middle" class="bolddeepblue">Department<strong>
				<font color="#ff0000">*</font></strong></td>
				<td height="28"><select name="select" class="tabledata">
					<option>All Employess</option>
				</select></td>
			</tr>
			<tr>
				<td height="28" valign="middle" class="bolddeepblue">Designation<strong>
				<font color="#ff0000">*</font></strong></td>
				<td height="28"><select name="select2" class="tabledata">
					<option>All Employess</option>
				</select></td>
			</tr>
			<tr>
				<td height="28" valign="middle" class="bolddeepblue">Year<strong>
				<font color="#ff0000">*</font></strong></td>
				<td height="28"><select name="select3" class="tabledata">
					<option>All Employess</option>
				</select></td>
			</tr>
		</table>
		</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="26"></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td></td>
	</tr>
	<tr>
		<td height="26"></td>
		<td>&nbsp;</td>
		<td valign="top"><input class="buttonbold" type="submit"
			name="Submit" value="Submit"   accesskey="s"   ></td>
		<td valign="top"><input class="buttonbold" type="submit"
			name="Submit"  value="Close"   accesskey="c"  onclick="mainPage()"></td>
		<td>&nbsp;</td>
		<td></td>
	</tr>
</table>
<br>
<br>
<br>
<br>
<%@ include file="../footer.jsp"%>
</body>
</form>
</html>
