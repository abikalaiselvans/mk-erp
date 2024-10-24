



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
<form  AUTOCOMPLETE = "off"   name="a" method="post" action="Empromotionstore.jsp"
	onSubmit="return validate()">

<body  onpaste="return false;" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<%@ include file="Connection.jsp"%>

<table width="1000" border=0>
	<!--DWLayoutTable-->
	<tr>
		<td width="253" height="364"></td>
		<td width="449" valign="top" background="../if">
		<table width="449" border="1" cellspacing="2" cellpadding="2">
			<!--DWLayoutTable-->
			<tr>
				<td height="27" colspan="4" align="center" valign="middle">
				<p>Employee Promotion</p>
				</td>
			</tr>
			<tr>
				<td height="44" valign="middle">Employee Name</td>
				<td colspan="3" valign="middle"><select name="proid">
					<%
                   String str1="Select CHR_EMPID,CHR_STAFFNAME from m_staff";
                   rs=st.executeQuery(str1);   
                
          while(rs.next())
          {
        %>
					<option value=<%=rs.getString("CHR_EMPID")%>><%=rs.getString("CHR_EMPID")%>&nbsp;&nbsp;<%=rs.getString("CHR_STAFFNAME")%></option>
					<%       
          }
        %>
				</select></td>
			</tr>
			<tr>
				<td height="47" valign="middle">Date of Promotion</td>
				<td colspan="3" valign="middle"><input type="text"
					name="prodate"> DD/MM/YYYY</td>
			</tr>
			<tr>
				<td height="44" valign="middle">Present Designation</td>
				<td colspan="3" valign="middle"><select name="curdes">
					<%
                  str1="select CHR_DESIGNAME from m_desig";
                  rs=st.executeQuery(str1);
                  while(rs.next())
               { 
            %>
					<option value="proname"><%=rs.getString("CHR_DESIGNAME")%></option>
					<%
               }
            %>
					<option></option>
				</select></td>
			</tr>
			<tr>
				<td height="44" valign="middle">Transfer Designation</td>
				<td colspan="3" valign="middle"><select name="trades">
					<%
                  str1="select CHR_DESIGNAME from m_desig";
                  rs=st.executeQuery(str1);
                  while(rs.next())
            { 
            %>
					<option value="designame"><%=rs.getString("CHR_DESIGNAME")%></option>
					<%
               }
            %>
				</select></td>
			</tr>
			<tr>
				<td height="108" valign="top">Reason for Transfer</td>
				<td colspan="3" valign="top"><textarea name="reason" rows="5"
					cols="30"></textarea></td>
			</tr>
			<tr>
				<td width="138" height="30">&nbsp;</td>
				<td width="57" align="center" valign="middle"><input
					type="submit" name="Submit" value="Submit"   accesskey="s"   ></td>
				<td width="46" align="center" valign="middle"><input
					type="reset" name="Submit2" value="Clear"></td>
				<td width="172">&nbsp;</td>
			</tr>
		</table>
		</td>
		<td width="284"></td>
	</tr>
	<tr>
		<td height="6"></td>
		<td></td>
		<td></td>
	</tr>
</table>


<table width="1002" border=0>
	<!--DWLayoutTable-->
	<tr>
		<td width="326" height="72">&nbsp;</td>
		<td width="93" valign="top" background="../if"><a
			href="../Smart%20Attendance/Mainscreen.htm"><img
			src="../Image/Smart%20Attendance/Home.gif" width="93" height="70"
			border="0"></a></td>
		<td width="152">&nbsp;</td>
		<td width="92" valign="top" background="../if"><a
			href="Payrollmain.jsp"><img
			src="../Image/Smart%20Attendance/Back.gif" width="92" height="69"
			border="0"></a></td>
		<td width="317">&nbsp;</td>
	</tr>
</table>
<br>
<br>


<%@ include file="../footer.jsp"%>
</body>
</form>
</html>
