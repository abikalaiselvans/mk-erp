
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
<meta name="copyright"
	content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords"
	content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

<title>:: Properties File Intialization ::</title>

<script language="javascript" src="JavaScript/comfunction.js"></script>
<script type="text/javascript" language="javascript">
	function validate()
	{
		 
		if( 
			checkNull('company','Enter Company') 
			&& checkNull('address','Enter Address') 
			&& checkNull('city','Enter City') 
		    && checkNull('state','Enter State')
			&& checkNull('pincode','Enter Pincode')
			&& checkNull('phone','Enter Phone')
			&& checkNull('pf','Enter PF')
			&& checkNull('esi','Enter ESI')
			&& checkNull('cpypf','Enter Employer PF')
			&& checkNull('cpypension','Enter Employer Pension')
			&& checkNull('cpyesi','Enter Employer ESI')
			) 
			return true;
		else
			return false;
			

	}
</script>
<link href="resources/css/erp_smart.css" rel="stylesheet"
	type="text/css">
<%@ include file="JavaScript/dynamicStylesheet.jsp"%>
<link href="JavaScript/SmartStyles.css" rel="stylesheet" type="text/css">
</head>

<body onpaste='return false;'>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			id="header">
			<tr class="headerImgBackground">
				<td>
				<div align="right"><img src="images/top_banner.png"
					height="62" /></div>
				</td>
			</tr>
			<tr>
				<td>
				<table width="100%" height="25" border="0" cellpadding="0"
					cellspacing="0">
					<tr class="headerBackground">
						<td width="183" height="25" align="center" valign="middle"><span
							class="menu_H">ERP </span></td>
						<td width="287" class="text_0"></td>
						<td width="360" align="right" class="headerBackground">
						<div align="center"><span class="bold1"> </span></div>
						</td>
						<td width="170" align="right"></a><strong></strong>&nbsp; <a
							href="Logout.jsp" target="_parent"><font class="boldEleven"><b>Logout</b></font></a>
						</td>
					</tr>
				</table>
				</td>
			</tr>

		</table>
		</td>
	</tr>
	<tr>
		<td></td>
	</tr>
	<tr>
		<td height="480">
		<form name="frm" AUTOCOMPLETE="off" method="post"
			action="CompanyIntializationResponse.jsp"
			onSubmit="return validate()">
		<table width="550" border="0" align="center" cellpadding="5"
			cellspacing="5">
			<tr>
				<td colspan="2" valign="middle" class="bolddeepblue" align="center">COMPANY
				INFORMATIONS</td>
			</tr>
			<tr>
				<td width="167" valign="middle" class="bolddeepblue">Name <span
					class="boldred">*</span></td>
				<td width="201" valign="top"><input name="company"
					type="text" class="formText135" id="company"
					value="JAVA TECHNOLOGY" size="30" maxlength="100"></td>
			</tr>
			<tr>
				<td valign="middle" class="bolddeepblue">Address <span
					class="boldred">*</span></td>
				<td valign="top"><input name="address" type="text"
					class="formText135" id="address" value="No 6 , Devakiammal Street"
					size="30" maxlength="100"></td>
			</tr>
			<tr>
				<td valign="middle" class="bolddeepblue">City <span
					class="boldred">*</span></td>
				<td valign="top"><input name="city" type="text"
					class="formText135" id="city" value="ShenoyNagar, Chennai"
					size="30" maxlength="100" /></td>
			</tr>
			<tr>
				<td valign="middle" class="bolddeepblue">State <span
					class="boldred">*</span></td>
				<td valign="top"><input name="state" type="text"
					class="formText135" id="state" value="Tamilnadu" size="30"
					maxlength="100" /></td>
			</tr>
			<tr>
				<td valign="middle" class="bolddeepblue">Pin <span
					class="boldred">*</span></td>
				<td valign="top"><input name="pincode" type="text"
					class="formText135" id="pincode"
					onKeyPress="return numeric_only(event,'pincode','6')"
					value="600030" size="10" maxlength="6" /></td>
			</tr>
			<tr>
				<td valign="middle" class="bolddeepblue">Phone <span
					class="boldred">*</span></td>
				<td valign="top"><input name="phone" type="text"
					class="formText135" id="phone"
					onKeyPress="return numeric_only(event,'phone','10')"
					value="04426640644" size="30" maxlength="11" /></td>
			</tr>
			<tr>
				<td width="167" valign="top"><span class="bolddeepblue">PF
				<span class="boldred">*</span></span></td>
				<td width="201" valign="top"><input name="pf" type="text"
					class="formText135" id="pf" value="12" size="10" maxlength="7" /></td>
			</tr>
			<tr>
				<td valign="top"><span class="bolddeepblue">ESI <span
					class="boldred">*</span></span></td>
				<td valign="top"><input name="esi" type="text"
					class="formText135" id="esi" value="1.75" size="10" maxlength="7" /></td>
			</tr>
			<tr>
				<td valign="top"><span class="bolddeepblue"> Employer
				PF<span class="boldred">*</span></span></td>
				<td valign="top"><input name="cpypf" type="text"
					class="formText135" id="cpypf" value="3.67" size="10" maxlength="7" /></td>
			</tr>
			<tr>
				<td valign="top"><span class="bolddeepblue">Employer
				Pension Fund <span class="boldred">*</span></span></td>
				<td valign="top"><input name="cpypension" type="text"
					class="formText135" id="cpypension" value="8.33" size="10"
					maxlength="7" /></td>
			</tr>
			<tr>
				<td valign="top"><span class="bolddeepblue">Employer
				ESI <span class="boldred">*</span></span></td>
				<td valign="top"><input name="cpyesi" type="text"
					class="formText135" id="cpyesi" value="4.75" size="10"
					maxlength="7" /></td>
			</tr>
			<tr>
				<td class="menu_H">&nbsp;</td>
				<td class="menu_H">&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2" class="menu_H">
				<div align="center"><input name="image" type="image"
					src="images/submit_btn.gif" /></div>
				</td>
			</tr>

		</table>
		</form>
		</td>
	</tr>
	<tr>
		<td><%@ include file="footer.jsp"%></td>
	</tr>
</table>

</body>
</html>
