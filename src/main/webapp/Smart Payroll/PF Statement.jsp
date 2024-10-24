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

<style type="text/css">
<!--
.style15 {
	color: #000066;
	font-size: 14px;
}
-->
</style>
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
		<td width="228" height="18"></td>
		<td width="168"></td>
		<td width="58"></td>
		<td width="55"></td>
		<td width="211"></td>
		<td width="256"></td>
	</tr>
	<tr>
		<td height="157"></td>
		<td colspan="4" valign="top" background="../if">
		<table class="BackGround" cellspacing="0" cellpadding="0" width="480"
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

					<table width="480" border="0" align="center" cellpadding="2"
						cellspacing="2"  >
						<!--DWLayoutTable-->
						<tr align="center">
							<td height="30" colspan="2"><span class="style15">PF
							Statement </span></td>
						</tr>
						<tr>
							<td width="193" height="30" valign="middle" class="bolddeepblue"><strong>Year</strong></td>
							<td width="293" valign="top"><select name="year"
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
							<td height="30" valign="middle" class="bolddeepblue"><strong>Month</strong></td>
							<td valign="top"><select name="month" class="tabledata">
								<option value="select">Select</option>
								<option value="january">January</option>
								<option value="february">February</option>
								<option value="march">March</option>
								<option value="april">April</option>
								<option value="may">May</option>
								<option value="june">June</option>
								<option value="july">July</option>
								<option value="august">August</option>
								<option value="september">September</option>
								<option value="october">October</option>
								<option value="november">November</option>
								<option value="december">December</option>
							</select></td>
						</tr>
						<tr>
							<td height="30" colspan="2" valign="middle" class="bolddeepblue">
							<div align="center">
							<table border="0" cellspacing="3" cellpadding="3">
								<tr>
									<td width="56"><input class="buttonbold14" type="submit"
										name="Submit" value="Submit"   accesskey="s"   ></td>
									<td width="56"><input class="buttonbold14" type="submit"
										name="Submit2"  value="Close"   accesskey="c"  onClick="mainPage()"></td>
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
		<td height="5"></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td height="26"></td>
		<td>&nbsp;</td>
		<td width="56"><!--DWLayoutEmptyCell-->&nbsp;</td>
		<td width="56">
		<p>&nbsp;</p>
		</td>
		<td>&nbsp;</td>
		<td></td>
	</tr>
</table>
<p>&nbsp;</p>

<br>
<br>
<%@ include file="../footer.jsp"%>
</body>
</form>
</html>
