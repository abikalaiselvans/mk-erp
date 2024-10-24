<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage=""%>

<%
try
{
%>
<html>
<head>
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>



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

<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='COM' ")[0][0]%></title>
<%@ include file="../JavaScript/dynamicStylesheet.jsp"%>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript"
	src="../JavaScript/common/SelectChangesCountry.js"> </script>

<script language="JavaScript">

function Validate()
  {
	
 
 
	if( 
		checkNullSelect('country','Select Country' ,'0')
		&& checkNullSelect('state','Select State' ,'0')
		&& checkNullSelect('district','Select District' ,'0')
		&& checkNull('cityname','Enter City Name')
		&& checkNull('pincode','Enter Pincode') 
		)
		return true;
	else
		return false;				
		
	
 } 	
</script>

<body onpaste='return false;'>
<table width="100%" border="0" cellspacing="4" cellpadding="3">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>

		<form AUTOCOMPLETE="off" action="../SmartLoginAuth" method="post"
			name="frm" id="frm" onSubmit="return Validate()">

		<table class="BackGround" cellspacing="0" cellpadding="0" width="424"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TLCorner.gif" width="7" /></td>
					<td class="BorderLine" height="0"></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/General/TRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td height="6"></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"></td>
					<td width="6"></td>
					<td width="412">
					<table width="425" border="0" align="center" cellpadding="2"
						cellspacing="2">
						<!--DWLayoutTable-->
						<tr align="center" valign="middle">
							<td height="28" colspan="2" class="BackGround">ADD LOCATION
							( CITY ) <%
	
	String cityname,citypincode,cityid;
	String actionStu;
  	String action=""+request.getParameter("action1");
	String sql="";
	String country="";
	String state="";
	String district="";
	cityid="";
	actionStu="ATTCityAdds";
	country="";
	state="";
	district="";
	cityname="";
	citypincode="";
		 
	
%>
							</td>
						</tr>
						<tr>
							<td height="19" colspan="3" align="right" valign="top"><span
								class="bolddeepred">* </span><span class="fairyHead"><span
								class="changePos">- Mandatory</span> </span></td>
						</tr>
						<tr>
							<td class="boldEleven">Country <font color="#ff0000">*</font></td>
							<td class="bold1"><select name="country" class="formText135"
								id="country" onChange="LoadSelectState()">
								<option value="0">Select</option>
								<%
				
				String	readData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_COUNTRYID, CHR_COUNTRYNAME FROM  com_m_country ORDER BY CHR_COUNTRYNAME");
			for(int u=0;u<readData.length;u++)
				out.println("<option value='"+readData[u][0]+"'>"+readData[u][1]+"</option>");
				
				%>
							</select></td>
						</tr>
						<tr>
							<td class="boldEleven">State <font color="#ff0000">*</font></td>
							<td class="bold1"><select name="state" class="formText135"
								id="state" onChange="LoadSelectDistrict()">
								<option value="0">Select</option>

							</select></td>
						</tr>
						<tr>
							<td class="boldEleven">District <font color="#ff0000">*</font></td>
							<td class="bold1"><select name="district"
								class="formText135" id="district">
								<option value="0">Select</option>

							</select></td>
						</tr>
						<tr>
							<td width="150" height="29" valign="middle" class="boldEleven">City
							Name <font color="#ff0000">*</font></td>
							<td width="246" valign="middle"><input name="cityname"
								type="text" class="tabledata" id="cityname"
								onChange="upperMe(this)" value="" size="35" maxlength="30">
							<div id="UniqueDepart"></div>
							</td>
						</tr>
						<tr>
							<td height="29" valign="top" class="boldEleven">City Pincode
							<font color="#ff0000">*</font></td>
							<td valign="middle"><input name="pincode" type="text"
								class="formText135" id="pincode"
								onKeyPress="numericValue('pincode','6')"
								value="<%=citypincode%>" size="25" maxlength="10" /></td>
						</tr>
						<tr>
							<td height="29" colspan="2" valign="top" class="bolddeepblue"><input
								type="HIDDEN" name="filename" value="City"> <input
								type="HIDDEN" name="actionS" value="<%=actionStu %>">

							<table width="129" border="0" align="center" cellpadding="3"
								cellspacing="3">
								<tr>
									<td width="51"><input type="SUBMIT" class="buttonbold"
										id="submit" name="Submit" value="Submit" accesskey="s"></td>
									<td width="57"><input name="Button" type="button"
										class="buttonbold" value="Close" accesskey="c"
										onClick="window.close()"></td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
					</td>
					<td nowrap="nowrap" width="4"></td>
					<td class="BorderLine" width="1"></td>
				</tr>
				<tr>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BLCorner.gif" width="7" /></td>
					<td height="6"></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/General/BRCorner.gif" width="7" /></td>
				</tr>
				<tr>
					<td class="BorderLine" height="0"></td>
				</tr>
			</tbody>
		</table>
		</form>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
</body>
</html>
<%
	 
}
catch(Exception e)
{
}
%>
