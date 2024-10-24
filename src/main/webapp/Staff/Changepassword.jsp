<html>
<head>
<%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
	 
	
	function validate()
	{
	if(checkNull("TxtOldpass","Enter Old Password") && checkNull('TxtNewPasswd','Enter New Password')&& checkNull("Conpass","Enter Confirm Password"))
		{
			var Oldpasswd=document.getElementById("oldpass").value
			var Oldpass1=document.getElementById("TxtOldpass").value
			 
			
			var Newpasswd=document.getElementById("TxtNewPasswd").value
 			var Conpasswd=document.getElementById("Conpass").value 			 			
 			var result="false";
 			
			Oldpasswd=Oldpasswd.toUpperCase();
 			Oldpass1=Oldpass1.toUpperCase();
 			var newpass=Newpasswd.toUpperCase();
 			
			if(Oldpasswd!=Oldpass1)
 			{
				 alert(" Enter Old Password Correctly")
				 document.a.TxtOldpass.focus()
            }else if(Oldpass1==newpass) {
            	 alert(" New Password is Same as Old Password")
				 document.a.TxtNewPasswd.focus()
            }else if(Newpasswd.toUpperCase()!=Conpasswd.toUpperCase()){
				 alert(" Confirm Password  Same as New Password")
				 document.a.Conpass.focus()				             
            }else if(Newpasswd.length<5){
            	 alert(" Password Length is to Small")
				 document.a.TxtNewPasswd.focus()				             
            }
            else
            {            
            	result="true";
            }
            if(result=="true")
            {
			    document.a.action="ChangePassInsertion.jsp";
				document.a.submit();
            	return true;
            }
            else
            {
            	return false;
            }
		}
		else
		 return false;		
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
.style1 {font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
}
.style14 {font-family: "Times New Roman", Times, serif}
.style15 {font-family: Verdana, Arial, Helvetica, sans-serif; font-size: 10px; font-weight: bold; }
.style8 {font-family: Verdana;
	font-size: 12px;
}
.style20 {
	font-family: Verdana;
	font-size: 12px;
	color: #336666;
	font-weight: bold;
}
.style21 {color: #990000}
.style13 {color: #0000FF}
-->
</style>

<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>


<%@include file="Redirect.jsp" %>

</head>
<form name="a" method="post">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td> </td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>

		<table width="42%" border="0" align="center" cellpadding="0"
			cellspacing="0" bgcolor="#dce4f9" class="BackGround">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="10" colspan="2" rowspan="2"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td valign="top">
					<table width="437" height="172" border="0" align="center"
						 >
						<!--DWLayoutTable-->
						<tr>
							<td height="30" colspan="3" align="center" valign="middle" class="BackGround">PASSWORD CHANGE </td>
						</tr>
						<tr>
							<td width="179" height="29" class="boldEleven">User Name</td>
							<td width="189" class="boldEleven">
							<% 
	    String uname=""+session.getAttribute("USRID");
		out.println(uname); 
		String pass=""+session.getAttribute("USRPWD");
		out.println("<input type='hidden' id='oldpass' name='oldpass' value='"+pass+"'>");
	%>
							</div>
						  </td>
						</tr>
						<tr>
							<td height="32" class="boldEleven">Old Password <span class="boldred">*</span> </td>
							<td class="boldEleven"><input name="TxtOldpass" type="password" id="TxtOldpass" size="15" maxlength="8">
						  </td>
						</tr>
						<tr>
							<td class="boldEleven">New Password <span class="boldred">*</span> </td>
							<td class="boldEleven"><input name="TxtNewPasswd" type="password"
								id="TxtNewPasswd" size="15" maxlength="8"> 
						      <span class="boldred">(max 8 char) </span></td>
						</tr>
						<tr>
							<td class="boldEleven">Confirm Password <span class="boldred">*</span> </td>
						  <td class="boldEleven"><input name="Conpass" type="password" id="Conpass" size="15" maxlength="8">
						    <span class="boldred">(max 8 char)</span></td>
						</tr>
						<tr>
							<td colspan="2" class="tabledata">
							<table align="center">
								<tr>
									<td width="56"><input name="Submit" type="Submit"
										class="buttonbold" value="Submit"   accesskey="s"    onClick="validate()"></td>
									<td width="56"><input class="buttonbold" type="button"
										name="Button"  value="Close"   accesskey="c"  onClick="redirect('Userframe.jsp')"></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="6"><spacer height="1" width="1"
						type="block" /></td>
					<td width="1" class="BorderLine"><spacer height="1" width="1"
						type="block" /></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2" valign="bottom">
					<div align="right"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></div>
					</td>
				</tr>
				<tr>
					<td class="BorderLine" height="1"></td>
				</tr>
			</tbody>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td height="106">&nbsp;</td>
	</tr>
	<tr>
		<td> </td>
	</tr>
</table>
</body>
</form>
</html>
