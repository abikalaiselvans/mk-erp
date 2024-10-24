<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage=""%>
<html>
<head>
<link rel="icon" type="image/ico" href="images/ERP.ico"></link>
<link rel="shortcut icon" href="images/ERP.ico"></link>



<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='COM' ")[0][0]%></title>
<link rel="icon" type="image/ico" href="images/ERP.ico"></link>
<link rel="shortcut icon" href="images/ERP.ico"></link>
<style type="text/css">
<!--
.style2 {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 9px;
	font-weight: bold;
}
-->
 </style>
</head>
<style type="text/css">
 
.titles {  font-family: Verdana, Arial, Helvetica, sans-serif; font-size: .7pc; font-weight: bold; color: #000066}
.bord1 {  border: #000066; border-style: solid; border-top-width: 1px; border-right-width: 1px; border-bottom-width: 1px; border-left-width: 1px}
.style1 {color: #000066}
.button1{    FONT-WEIGHT: normal;    FONT-SIZE: 0.7pc;    COLOR: #ffffff;    FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif}
.button2{    FONT-WEIGHT: normal;    FONT-SIZE: 0.7pc;    COLOR: #ffffff;    FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif;    BACKGROUND-COLOR: #cc0033}
.button3{    FONT-WEIGHT: normal;    FONT-SIZE: 0.7pc;    COLOR: #ffffff;    FONT-FAMILY: Verdana, Arial, Helvetica, sans-serif;    BACKGROUND-COLOR: #5f9ea0}
 
</style>
</html>
<script language="javascript">
function valid()
{
var drfrm
drfrm = document.frm.email
dobfrm = document.frm.dob;

if(drfrm.value=="") 
		{
			alert("Email Address is Required !");
			drfrm.select()
			return false;
		}
		if((drfrm.value.indexOf("@")<=0) || (drfrm.value.indexOf(".")<=0)  || ((drfrm.value.indexOf(".")-(drfrm.value.indexOf("@")))<=1)||( ( (drfrm.value.length)-(drfrm.value.lastIndexOf(".")))<=2))
		{
			alert("Enter Valid Email Address !");
			drfrm.select()
			return false;
		}
		
		if(dobfrm.value=="")
{
	alert("Date of Birth is Required !");
	dobfrm.focus();
	return false;
}

}

</script>
<body  onpaste='return false;'>
<p>&nbsp;</p>
<p>&nbsp;</p>
<form name="frm" method="post" action="ForgetPasswordResponse.jsp"
	onSubmit="return valid();">
<table style="font-family: arial;" class="bord1" align="center"
	bgcolor="#f0fbff" border="0" bordercolor="#637bad" cellpadding="7"
	cellspacing="2" width="450">
	<tr bgcolor="#f2f8ff">
		<td height="23" colspan="2" bgcolor="#f2f8ff"><div align="center"><span
			class="titles">Enter Email Address to get your Password  </span></div></td>
	</tr>
	<tr bgcolor="#f2f8ff">
	  <td height="22" colspan="2" bgcolor="#f2f8ff"><span class="titles"> </span> <table width="62%" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td><input name="status" type="radio" value="O" checked></td>
          <td class="titles">Office Mail </td>
          <td><input name="status" type="radio" value="P"></td>
          <td class="titles">Personal Mail </td>
        </tr>
      </table></td>
    </tr>
	<tr bgcolor="#f2f8ff">
		<td width="85" height="22" bgcolor="#f2f8ff"><span
			class="titles"> Email </span></td>
	  <td align="left" height="22" width="329"><input name="email"
			type="text" class="bord1" value="info@mythra.in" size="25">
	    <span class="titles">(info@mythra.in) </span></td>
	</tr>
	<tr bgcolor="#f2f8ff">
		<td height="22" bgcolor="#f2f8ff"><span class="titles">Date of Birth</span></td>
		<td align="left" height="22"><input name="dob" type="text"
			class="bord1" id="dob" value="1977-10-21" size="25"> 
		<span class="style1 style2">( yyyy-mm-dd )</span></td>
	</tr>
	<tr bgcolor="#f2f8ff">
		<td colspan="2" align="center" height="13">
		<p align="center"><input value=" GO " id="submit1" name="submit1"
			type="submit" class="button2"> &nbsp; <input name="reset1"
			type="reset" class="button2" id="reset1" value="Clear"></p>		</td>
	</tr>
</table>
</form>
</body>
</html>
