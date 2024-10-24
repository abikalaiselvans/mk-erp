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
<table width="100%" height="65%" border=0>
	<!--DWLayoutTable-->
	<tr>
		<td width="242" height="21">&nbsp;</td>
		<td width="134">&nbsp;</td>
		<td width="55">&nbsp;</td>
		<td width="55">&nbsp;</td>
		<td width="258">&nbsp;</td>
		<td width="208">&nbsp;</td>
	</tr>
	<tr>
		<td height="68">&nbsp;</td>
		<td colspan="4" valign="top" background="../if">
		<table width="507" border="1" cellspacing="2" cellpadding="2"
			 >
			<!--DWLayoutTable-->
			<tr align="center" valign="middle">
				<td height="28" colspan="2" valign="middle" class="BackGround"
					 >Form 6A</td>
			</tr>
			<tr>
				<td width="206" height="28" valign="middle" class="bolddeepblue">Year<strong>
				<font color="#ff0000">*</font></strong></td>
				<td width="281" height="28" valign="top"><select name="year"
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
		</table>
		</td>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="14"></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td height="27"></td>
		<td>&nbsp;</td>
		<td width="55" valign="top"><input class="buttonbold"
			type="submit" name="Submit" value="Submit"   accesskey="s"   ></td>
		<td width="55" valign="top"><input class="buttonbold"
			type="submit" name="Submit"  value="Close"   accesskey="c"  onclick="mainPage()">
		</td>
		<td>&nbsp;</td>
		<td></td>
	</tr>
	<tr>
		<td height="153"></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td></td>
	</tr>
</table>

<%@ include file="../footer.jsp"%>


</body>
</form>
</html>
