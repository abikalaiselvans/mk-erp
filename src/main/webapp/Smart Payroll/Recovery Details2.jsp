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
.style1 {	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
.style12 {color: #FFFFFF}
.style14 {color: #FFFFFF; font-weight: bold; }
-->
</style>
</head>
<form  AUTOCOMPLETE = "off"   name="a" method="post" action="Recovery View2.jsp"
	onSubmit="return validate()">
<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%@ include file="Connection.jsp"%>


<br>
<br>
<br>
<br>
<br>
<table width="1002" border=0>
	<!--DWLayoutTable-->
	<tr>
		<td width="304" height="135">&nbsp;</td>
		<td width="372" valign="top" background="../if">
		<table width="372" border="1" cellspacing="2" cellpadding="2">
			<!--DWLayoutTable-->
			<tr align="center" valign="middle">
				<td height="25" colspan="3">Advance Details</td>
			</tr>
			<tr>
				<td width="147" height="36" valign="middle">Department</td>
				<td width="1" colspan="2" valign="middle"><select name="dept">
					<option value="select">Select</option>
					<%
			    
				 String str="select CHR_DEPARTNAME from m_depart";
				 rs=st.executeQuery(str);
				 while(rs.next())
				 {
				  out.print("to check while");
				 %>
					<option>
					<%out.print(rs.getString("CHR_DEPARTNAME"));%>
					</option>
					<%	
				 }
			   %>
				</select></td>
			</tr>
			<tr>
				<td height="30" valign="middle">Month</td>
				<td colspan="2" valign="middle"><select name="month">
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
			<tr>
				<td height="30" colspan="2" align="right" valign="top"><input
					type="submit" name="Submit" value="Submit"   accesskey="s"   ></td>
				<td width="196" align="left" valign="top"><input type="reset"
					name="Submit2" value="Clear"></td>
			</tr>
		</table>
		</td>
		<td width="312">&nbsp;</td>
	</tr>
	<tr>
		<td height="21">&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>


<table width="1002" border=0>
	<!--DWLayoutTable-->
	<tr>
		<td width="341" height="72">&nbsp;</td>
		<td width="93" valign="top" background="../if"><a
			href="../Smart%20Attendance/Mainscreen.htm"><img
			src="../Image/Smart%20Attendance/Home.gif" width="93" height="70"
			border="0"></a></td>
		<td width="99">&nbsp;</td>
		<td width="92" valign="top" background="../if"><a
			href="Payrollmain.jsp"><img
			src="../Image/Smart%20Attendance/Back.gif" width="92" height="69"
			border="0"></a></td>
		<td width="355">&nbsp;</td>
	</tr>
</table>
<br>
<br>
<br>
<%@ include file="../footer.jsp"%>
</form>
</body>
</html>
