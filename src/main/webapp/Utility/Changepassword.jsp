<html>
<head>
<%@include file="Redirect.jsp" %>	
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">
/*
<p>Password: <input type="password" required pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])\w{6,}" name="pwd1" onchange="
  this.setCustomValidity(this.validity.patternMismatch ? 'Password must contain at least 6 characters, including UPPER/lowercase and numbers' : '');
  if(this.checkValidity()) form.pwd2.pattern = this.value;
"></p>
<p>Confirm Password: <input type="password" required pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z])\w{6,}" name="pwd2" onchange="
  this.setCustomValidity(this.validity.patternMismatch ? 'Please enter the same Password as above' : '');
"></p>

*/


function validate()
{
	if(	checkNull("TxtOldpass","Enter Old Password") 
		&& checkNull('TxtNewPasswd','Enter New Password')
		&& checkNull("Conpass","Enter Confirm Password")
		 
		&& lengthMninimum('TxtNewPasswd','8')
		&& lengthMninimum('Conpass','8')
		&& checkForm()
	 )
	 {
			var Oldpasswd = document.getElementById("oldpass").value
			var Oldpass1 = document.getElementById("TxtOldpass").value
			var Newpasswd = document.getElementById("TxtNewPasswd").value
			var Conpasswd = document.getElementById("Conpass").value 			 			
			 
			Oldpasswd=Oldpasswd;
			Oldpass1=Oldpass1;
			var newpass=Newpasswd;
		
			if(Oldpasswd!=Oldpass1)
			{
			 	alert(" Enter Old Password Correctly");
			 	document.a.TxtOldpass.focus();
				return false;
			}
			else if(Oldpass1==newpass) 
			{
			 	alert(" New Password is Same as Old Password");
			 	document.a.TxtNewPasswd.focus();
				return false;
			}
			else if(Newpasswd!=Conpasswd)
			{
			 	alert(" Confirm Password  Same as New Password");
			 	document.a.Conpass.focus();
				return false;				             
			}
			else if(Newpasswd.length<5)
			{
			 alert(" Password Length is to Small");
			 document.a.TxtNewPasswd.focus();
			 	return false;				             
			}	
			else
			 	return true;
		
			 
	}
	else
	 	return false;		
}

	 
function lengthMaximum(ctr,len)
{
	try
	{
		var name = document.getElementById(ctr).value;
        if(name.length>=len)	
        {
        	alert("Maximum character reached");
        	document.getElementById(ctr).focus();
        }
	}
	catch(err)
	{
		alert(err);
		
	}
}


function lengthMninimum(ctr,len)
{
	try
	{
		var name = document.getElementById(ctr).value;
        if(name.length<len)	
        {
        	alert("at least six characters required");
        	document.getElementById(ctr).focus();
			return false;
        }
		else
			return true;
	}
	catch(err)
	{
		alert(err);
		
	}
}
</script>

<title> :: UTILITY :: </title>


 
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
@import url("../JavaScript/SmartStyles.css");

 
.strength0
{
 width:250px;
 background:#cccccc;
}

.strength1
{
 width:50px;
 background:#ff0000;
}

.strength2
{
 width:100px; 
 background:#ff5f5f;
}

.strength3
{
 width:150px;
 background:#56e500;
}

.strength4
{
 background:#4dcd00;
 width:200px;
}

.strength5
{
 background:#399800;
 width:250px;
} 
</style>

<script language="javascript">
	
	function passwordStrength(password,passwordStrength,errorField)
	{
	 var desc = new Array();
	 desc[0] = "Very Weak";
	 desc[1] = "Weak";
	 desc[2] = "Better";
	 desc[3] = "Medium";
	 desc[4] = "Strong";
	 desc[5] = "Strongest";
	
	 var score   = 0;
	
	 //if password bigger than 6 give 1 point
	 if (password.length > 6) score++;
	
	 //if password has both lower and uppercase characters give 1 point 
	 if ( ( password.match(/[a-z]/) ) && ( password.match(/[A-Z]/) ) ) score++;
	
	 //if password has at least one number give 1 point
	 if (password.match(/\d+/)) score++;
	
	 //if password has at least one special caracther give 1 point
	 if ( password.match(/.[!,@,#,$,%,^,&,*,?,_,~,-,(,)]/) ) score++;
	
	 //if password bigger than 12 give another 1 point
	 if (password.length > 12) score++;
	
	  passwordStrength.innerHTML = desc[score];
	  passwordStrength.className = "strength" + score;
	}
	

function checkPassword(str)
{
	var re = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])\w{6,}$/;
	return re.test(str);
}


function checkForm()
{
    var Newpasswd = document.getElementById("TxtNewPasswd").value
    var Conpasswd = document.getElementById("Conpass").value 			 			
			
    var re = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])\w{6,}$/;
    if(!re.test(Newpasswd)) 
	{
      alert("Error: New Password must contain at least one number, one lowercase and one uppercase letter");
      document.getElementById("TxtNewPasswd").focus();
      return false;
    }
	
	if(!re.test(Conpasswd)) 
	{
      alert("Error: Confirm password must contain at least one number, one lowercase and one uppercase letter");
      document.getElementById("Conpass").focus();
      return false;
    }
    return true;
  }

</script>



</head>
 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<form name="a" method="post" action="ChangePassInsertion.jsp" onSubmit=" return validate()">
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td> </td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
	  <td><span class="style1"> </span></td>
    </tr>
	<tr>
	  <td>&nbsp;</td>
    </tr>
	<tr>
		<td>

		<table width="500" border="0" align="center" cellpadding="0"
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
					<table width="100%" height="157" border="0" align="center" cellpadding="3" cellspacing="3"
						 >
						<!--DWLayoutTable-->
						<tr>
							<td height="30" colspan="3" align="center" valign="middle"
								  class="BackGround">PASSWORD CHANGE <br></td>
						</tr>
						<tr>
							<td width="105" height="20" class="boldEleven">User Name</td>
							<td width="291" class="boldEleven">
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
							<td height="19" class="boldEleven">Old Password</td>
							<td><input name="TxtOldpass" type="password" class="formText135" id="TxtOldpass" title="Maximum 8 character only " required>
							</td>
						</tr>
						<tr>
							<td class="boldEleven">New Password</td>
						  <td><input name="TxtNewPasswd" type="password" class="formText135"    id="TxtNewPasswd" maxlength="12" title="Maximum 12 character only "  onKeyUp="passwordStrength(this.value,document.getElementById('strendth'),document.getElementById('passError')),lengthMaximum('TxtNewPasswd','12')" required> 
							<span class="boldred">( max 12 char ) </span><br>
							<span id="passError"></span><span id="strendth"></span><br></td>
						</tr>
						<tr>
							<td class="boldEleven">Confirm Password</td>
						  <td><input name="Conpass" type="password"  class="formText135" id="Conpass" maxlength="12" title="Maximum 12 character only "  onKeyUp="passwordStrength(this.value,document.getElementById('strendth1'),document.getElementById('passError1'))" required>
						    <span class="boldred">( max 12 char ) </span><br>
							<span id="passError1"></span><span id="strendth1"></span><br></td>
						</tr>
						<tr>
						  <td colspan="2" class="boldEleven"><span class="errormessage"> Note * Atleast one number, one lowercase and one uppercase letter </span></td>
					  </tr>
						<tr>
							<td colspan="2" class="boldEleven">
							<table align="center">
								<tr>
									<td width="56"><input name="Submit" type="Submit"
										class="buttonbold" value="Submit"   accesskey="s"     ></td>
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
