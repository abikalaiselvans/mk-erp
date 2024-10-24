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
<form  AUTOCOMPLETE = "off"   name="a" method="post" action="Recovery View3.jsp"
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
		<td width="304" height="167"></td>
		<td width="372" valign="top" background="../if">
		<table width="372" border="1" cellspacing="2" cellpadding="2">
			<!--DWLayoutTable-->
			<tr align="center" valign="middle">
				<td height="25" colspan="3">Recovery Details</td>
			</tr>
			<tr>
				<td width="144" height="36" valign="middle">Designation</td>
				<td width="25" colspan="2" valign="middle"><select name="des">
					<option value="select">Select</option>
					<%
			    
				 String str="select CHR_DESIGNAME from m_desig";
				 rs=st.executeQuery(str);
				 while(rs.next())
				 {
				  out.print("to check while");
				 %>
					<option>
					<%out.print(rs.getString("CHR_DESIGNAME"));%>
					</option>
					<%	
				 }
			   %>
				</select></td>
			</tr>
			<tr>
				<td height="30" valign="middle">Year</td>
				<td colspan="2" valign="middle"><select name="year">
					<option value="select">Select</option>
					<option value="1991">1991</option>
					<option value="1992">1992</option>
					<option value="1993">1993</option>
					<option value="1994">1994</option>
					<option value="1995">1995</option>
					<option value="1996">1996</option>
					<option value="1997">1997</option>
					<option value="1998">1998</option>
					<option value="1999">1999</option>
					<option value="2000">2000</option>
					<option value="2001">2001</option>
					<option value="2002">2002</option>
					<option value="2003">2003</option>
					<option value="2004">2004</option>
					<option value="2005">2005</option>
					<option value="2006">2006</option>
					<option value="2007">2007</option>
					<option value="2008">2008</option>
					<option value="2009">2009</option>
					<option value="2010">2010</option>
					<option value="2011">2011</option>
					<option value="2012">2012</option>
					<option value="2013">2013</option>
					<option value="2014">2014</option>
					<option value="2015">2015</option>
					<option value="2016">2016</option>
					<option value="2017">2017</option>
					<option value="2018">2018</option>
					<option value="2019">2019</option>
					<option value="2020">2020</option>
					<option value="2021">2021</option>
					<option value="2022">2022</option>
					<option value="2023">2023</option>
					<option value="2024">2024</option>
					<option value="2025">2025</option>
					<option value="2026">2026</option>
					<option value="2027">2027</option>
					<option value="2028">2028</option>
					<option value="2029">2029</option>
					<option value="2030">2030</option>
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
				<td width="175" align="left" valign="top"><input type="reset"
					name="Submit2" value="Clear"></td>
			</tr>
		</table>
		</td>
		<td width="312"></td>
	</tr>
	<tr>
		<td height="7"></td>
		<td></td>
		<td></td>
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
