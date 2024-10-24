
<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%
try
{
%>
<html>
<head>
<title>:: INVENTORY ::</title><link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
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
<script language="JavaScript">
 
 function valid()
  {
    var Pincode=document.getElementById("pin");  	
  	var Email=document.getElementById("email"); 
    if((Pincode.value)!=0)
  	{
  	if(Pincode.value.length!=6)
  	{
  	 	alert("Please Enter Correct Postal");
  	 	Pincode.value="";
  	 	Pincode.focus();
  	 	return false;  	
  	}
  	}
  
   
	if(
		checkNullSelect('group','Select Group','0')
		 
	&& checkNull("name","Enter Name") 
	&& checkNull("lname","Enter Legal Name")	 
	&& checkNullSelect("group","Select Group","Select")
	
	)
		return true;
	else
		return false;	
	 	
  } 
  function upperMe(field)
  {
  	field.value=field.value.toUpperCase();
  }    
 	
</script>

<body >
<%@ include file="indexinv.jsp"%>
 
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td></td>
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
					<table cellspacing="2" cellpadding="2" width="500" align="center"
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
							<%
                 	int custid = Integer.parseInt(""+request.getParameter("custid").trim());
                 			

                 	String sql2="select  INT_CUSTOMERID,INT_GROUPID,CHR_CUSTOMERNAME,INT_SERVICECENTERID,CHR_STREET,CHR_CITY,CHR_STATE,CHR_POSTAL,CHR_COUNTRY,CHR_PHONE	,CHR_MOBILE,CHR_FAX,CHR_EMAIL,CHR_WEBSITE,INT_ACTIVE,DAT_SINCE,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS,INT_BRANCHID  from inv_m_servicecustomerinfo where INT_CUSTOMERID="+custid;
                 	String Data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql2);
                  %>
							<tr>
							  <td height="20" class="boldEleven">Group</td>
							  <td colspan="2" align="left">
							  <select name="group" class="formText135" id="group" onChange="LoadNoncustomer('this')" >
			  	<option value="0">Select</option>
				<%
				 
				String readData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_GROUPID, CHR_GROUPNAME FROM  inv_m_servicecustomergroup WHERE INT_BRANCHID="+""+Data[0][19] +" ORDER BY CHR_GROUPNAME");
				for(int u=0;u<readData.length;u++)
					out.println("<option value="+readData[u][0]+">"+readData[u][1]+"</option>");
				%>
              </select>  
			  <script language="javascript">setOptionValue('group','<%=Data[0][1]%>')</script>							  </td>
					  </tr>
							<tr>
								<td height="17" class="boldEleven">Customer Name <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="name" type="text"
									class="formText135" id="name"
									onKeyPress="alphaNumeric('name','250')"
									    onBlur="upperMe(this)"      value="<%=Data[0][2]%>" size="60" maxlength="250"></td>
							</tr>
							<tr>
							  <td height="17" class="boldEleven">Service Center </td>
							  <td colspan="2" align="left"><select name="servicecenter" class="formText135"  id="servicecenter"    >
                                <option value="0">Select</option>
                                <%
				String readDatas[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_SERVICECENTERID,CHR_CENTERNAME,CHR_SHORTNAME FROM  inv_m_servicecenter ORDER BY CHR_CENTERNAME");
				for(int u=0;u<readDatas.length;u++)
					out.println("<option value="+readDatas[u][0]+">"+readDatas[u][1]+"</option>");
				%>
                              </select>
						      <script language="javascript">setOptionValue('servicecenter','<%=Data[0][3]%>')</script></td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven">Street</td>
								<td colspan="2" align="left"><input name="street" type="text"
									class="formText135" id="street"
									onKeyPress="isAddress('street','50')" value="<%=Data[0][4] %>" size="60"
									maxlength="150"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">City</td>
								<td colspan="2" align="left"><input name="city" type="text"
									class="formText135" id="city"
									onKeyPress="alphaNumeric('city','50')" value="<%=Data[0][5] %>" size="60"
									maxlength="150"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">State</td>
								<td colspan="2" align="left"><input name="state" type="text"
									class="formText135" id="state"
									onKeyPress="alphaNumeric('state','50')" value="<%=Data[0][6] %>" size="60"
									maxlength="50"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Pin Code</td>
								<td colspan="2" align="left"><input name="pin" type="text"
									class="formText135" id="pin"
									onKeyPress="numericValue('pin','6')" value="<%=Data[0][7] %>" size="60"
									maxlength="6"></td>
							</tr>
							<tr>
								<td width="123" height="17" class="boldEleven">Country</td>
								<td width="363" colspan="2" align="left"><input
									name="country" type="text" class="formText135" id="country"
									onKeyPress="alphaNumeric('country','15')"
									value="<%=Data[0][8] %>" size="60" maxlength="15"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Phone</td>
								<td colspan="2" align="left"><input name="phone"
									type="text" class="formText135" id="phone"
									onKeyPress="phoneValue('phone','30')" value="<%=Data[0][9] %>"
									size="60" maxlength="30"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Mobile</td>
								<td colspan="2" align="left"><input name="mobile"
									type="text" class="formText135" id="mobile"
									onKeyPress="phoneValue('phone','30')" value="<%=Data[0][10] %>"
									size="60" maxlength="13"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Fax</td>
								<td colspan="2" align="left"><input name="fax" type="text" class="formText135"
									id="fax"
									onKeyPress="phoneValue('fax','30')" value="<%=Data[0][11] %>" size="60" maxlength="30"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Email</td>
								<td colspan="2" align="left"><input name="email"
									type="text" class="formText135" id="email"
									onKeyPress="isEmailID('email','30')"
									value="<%=Data[0][12] %>" size="60" maxlength="30"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Website</td>
								<td colspan="2" align="left"><input name="website"
									type="text" class="formText135" id="website"
									onKeyPress="websiteOnly('website','30')"
									value="<%=Data[0][13] %>" size="60" maxlength="30"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Active</td>
								<td colspan="2" align="left">
								<%
	    		   String dis="";
				   if("1".equals(Data[0][14].trim()))
				   {
				   		dis = "checked='checked'";				   		
				   }				   
				  %> <input name="status" type="checkbox" id="status" <%=dis%>></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><input name="filename" type="hidden" value="ServiceCustomerInfo" />
							    <input name="actionS"
									type="hidden" value="INVServiceCustomerInfoUpdate" /> <input
									name="custid" type="hidden" id="custid" value="<%=custid%>" /></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit" type="submit"
											class="buttonbold13" value="Update"></td>
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
						</tbody>
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
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<%@ include file="../footer.jsp"%>
</body>
</html>
<%
}
catch(Exception e)
{
}
%>
