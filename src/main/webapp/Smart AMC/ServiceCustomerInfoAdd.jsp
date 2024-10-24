<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.*"%>
<html>
<head>

<title> :: AMC ::</title><style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>


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

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Inventory/InventAJAX.js"></script>
 <script language="JavaScript">
 
 
 
 function valid()
  {
    try
	{
	
		if( 
			 checkNullSelect('group','Select Group','0')
			 && checkNull("name","Enter Customer Name")
			 && checkNullSelect('servicecenter','Select Service Center','0')
			 && checkNull("street","Enter Street Name")
			 && checkNull("city","Enter City Name")
			 && checkNull("state","Enter State Name")
			 && checkNull("pin","Enter Pin Code")
			 && chkemail1("email",'Entert the correct E-mail Address...')
			 
			 
			)
			return true;
		else
			return false;	
	}
	catch(err)
	{
		alert(err);
		return false;
	}			
  } 	
</script>

<body  onpaste='return false;'>
<%@ include file="index.jsp"%>
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#FFFFFF">
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
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
					<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm"
						onSubmit="return valid()">
					<table cellspacing="2" cellpadding="2" width="400" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Service Customer Info</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							<tr>
							  <td height="20" class="boldEleven">Group<span class="bolddeepred">* </span></td>
							  <td colspan="2" align="left">
							  <select name="group" class="formText135" id="group"   style="width:175"> 
			  	<option value="0">Select group</option>
				<%
				String readData[][] = CommonFunctions.QueryExecute("SELECT INT_GROUPID, CHR_GROUPNAME FROM  inv_m_servicecustomergroup WHERE INT_BRANCHID="+""+session.getAttribute("AMCBRANCH") +" ORDER BY CHR_GROUPNAME");
				for(int u=0;u<readData.length;u++)
					out.println("<option value="+readData[u][0]+">"+readData[u][1]+"</option>");
				%>
              </select>							  </td>
					  </tr>
					  <td height="20" class="boldEleven">Customer Name <span
								class="bolddeepred">* </span></td>
							<td colspan="2" align="left"><input name="name" type="text"
								class="formText135" id="name"
								 
								onBlur="upperMe(this)" size="30" maxlength="200">
							<div id="codechk"></div>							</td>
							</tr>
							<tr>
							  <td height="20" class="boldEleven">Service Center <span class="bolddeepred">* </span></td>
							  <td colspan="2" align="left">
							  
							   <select name="servicecenter" class="formText135"  id="servicecenter" style="width:175"    >
			     <option value="0">Select servicecenter</option>
				 <%
				String readDatas[][] =  CommonFunctions.QueryExecute("SELECT INT_SERVICECENTERID,CHR_CENTERNAME,CHR_SHORTNAME FROM  inv_m_servicecenter ORDER BY CHR_CENTERNAME");
				for(int u=0;u<readDatas.length;u++)
					out.println("<option value="+readDatas[u][0]+">"+readDatas[u][1]+"</option>");
				%>
			        </select>							  </td>
					  </tr>
							<tr>
								<td height="20" class="boldEleven">Street <span class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="street"
									type="text" class="formText135" size="30" id="street"
									  maxlength="150"></td>
							</tr>
							<tr>
								<td height="20" class="boldEleven">City <span class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="city" type="text"
									class="formText135" id="city"
									  size="30" maxlength="150"></td>
							</tr>
							<tr>
								<td height="20" class="boldEleven">State <span class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="state"
									type="text" class="formText135" id="state"
									 size="30"
									maxlength="50"></td>
							</tr>
							<tr>
								<td height="20" class="boldEleven">Pin Code <span class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="pin" type="text"
									class="formText135" id="pin" size="30" maxlength="6"
									 onKeyPress="return numeric_only(event,'pin','10')"  ></td>
							</tr>
							<tr>
								<td width="131" height="20" class="boldEleven">Country</td>
							  <td width="255" colspan="2" align="left"><input
									name="country" type="text" class="formText135" id="country"
									 size="30"
									maxlength="15"></td>
							</tr>
						
							<tr>
								<td height="20" class="boldEleven">Phone</td>
								<td colspan="2" align="left"><input name="phone"
									onKeyPress="return numeric_only(event,'phone','15')"  type="text"
									class="formText135" id="phone" size="30" maxlength="30"></td>
							</tr>
							<tr>
								<td height="20" class="boldEleven">Mobile</td>
								<td colspan="2" align="left"><input name="mobile"
									onKeyPress="return numeric_only(event,'mobile','13')"  type="text"
									class="formText135" id="mobile" size="30" maxlength="10"></td>
							</tr>
							<tr>
								<td height="20" class="boldEleven">Fax</td>
								<td colspan="2" align="left"><input name="fax" type="text"
									size="30" class="formText135" id="fax"
									onKeyPress="return numeric_only(event,'fax','13')"  maxlength="10"></td>
							</tr>
							<tr>
								<td height="20" class="boldEleven">Email</td>
								<td colspan="2" align="left"><input name="email"
									type="text" size="30" class="formText135" id="email"
									  maxlength="30"></td>
							</tr>
							<tr>
								<td height="20" class="boldEleven">Website</td>
								<td colspan="2" align="left"><input name="website"
									type="text" size="30" class="formText135" id="website"
									onKeyPress="websiteOnly('website','30')" maxlength="30"></td>
							</tr>
							<tr>
								<td height="20" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="2" align="left"><input name="filename" type="hidden" value="ServiceCustomerInfo" />
							    <input name="actionS"
									type="hidden" value="AMCServiceCustomerInfoAdd" /></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
										<td><input name="Close" type="Button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('ServiceCustomerInfo.jsp')"></td>
									</tr>
								</table>								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>

							<input type="hidden" name="mobileBookingOption" />
					</table>
					</form>
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
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>

</table>
<%@ include file="../footer.jsp"%>
</body>
</html>
