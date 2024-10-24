
<%@ page contentType="text/html; charset=iso-8859-1" language="java"
	import="java.sql.*" errorPage=""%>
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





<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/calendar1.js"> </script>

<script language="javascript"
	src="../JavaScript/common/PermanentSelectChangesCountry.js"></script>
<script language="javascript"
	src="../JavaScript/common/communicationSelectChangesCountry.js"></script>
<script language="javascript">

function resoffval()
{
	if(document.frm.res[0].checked==true)
	{
		document.frm.cadd1.value = document.frm.padd1.value;
		document.frm.cadd2.value = document.frm.padd2.value;
		copyDropdown('pcity','ccity');
		copyDropdown('pstate','cstate');
		copyDropdown('pdistrict','cdistrict');
		document.frm.ccountry.selectedIndex = document.frm.pcountry.selectedIndex;
		document.frm.cstate.selectedIndex = document.frm.pstate.selectedIndex+1;
		document.frm.cdistrict.selectedIndex = document.frm.pdistrict.selectedIndex+1;
		document.frm.ccity.selectedIndex = document.frm.pcity.selectedIndex+1;
		document.frm.cpincode.value = document.frm.ppincode.value;
		document.frm.cphone.value = document.frm.pphone.value;
	}         
	else 
	{
		document.frm.cadd1.value = "";
		document.frm.cadd2.value = "";
		document.frm.ccity.selectedIndex = 0;
		document.frm.cdistrict.selectedIndex = 0;
		document.frm.cstate.selectedIndex = 0;
		document.frm.ccountry.selectedIndex = 0;
		document.frm.cpincode.value = "";
		document.frm.cphone.value = "";
		
	}
	return true;
} 

function validateFields()
{
		 if(
				 checkNull('padd1','Enter Permanent  Address1')
				 && checkNull('padd2','Enter Permanent  Address2')
				 && checkNullSelect('pcity','Select Permanent  City Name','0')
				 && checkNullSelect('pdistrict','Select  Permanent  District  Name','0')
				 && checkNullSelect('pstate','Select  Permanent  State  Name','0')
				 && checkNullSelect('pcountry','Select  Permanent  Country  Name','0')
				 && checkNull('ppincode','Enter Permanent Pincode ')
		)
		   return true;
   	 else
		   return false;	  
}	
   
   
   

 
 </script>
<body onpaste='return false;'>
<%
try
{

%>

<form AUTOCOMPLETE="off" action="../SmartLoginAuth" method="post"
	name="frm" id="frm" onSubmit="return validateFields()"><br>
<br>
<br>
<br>
<table class="BackGround1" cellspacing="0" cellpadding="0" width="424"
	align="center" border="0">
	<tbody>
		<tr>
			<td colspan="2" rowspan="2" valign="top"><img height="7"
				src="../../Image/Smart Inventory/TLCorner.gif" width="7" /></td>
			<td class="BorderLine" height="0"><spacer height="1" width="1"
				type="block" /></td>
			<td colspan="2" rowspan="2" valign="top"><img height="7"
				src="../../Image/Smart Inventory/TRCorner.gif" width="7" /></td>
		</tr>
		<tr>
			<td height="6"><spacer height="1" width="1" type="block" /></td>
		</tr>
		<tr>
			<td class="BorderLine" width="1"><spacer height="1" width="1"
				type="block" /></td>
			<td width="6"><spacer height="1" width="1" type="block" /></td>
			<td width="412">
			<table cellspacing="2" cellpadding="2" width="800" align="center"
				border="0">
				<!--DWLayoutTable-->
				<tbody>
					<tr>
						<td height="16" colspan="3" align="center" valign="top"
							class="boldThirteen">Address Information <%
String sql="";
String SData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("select CHR_ADDRESSSTATUS from com_m_staff where CHR_EMPID='"+session.getAttribute("EMPID")+"'");


boolean f= false; 
if("Y".equals(application.getAttribute("LOGINMAILCHECK").toString()))
{
	if("Y".equals(SData[0][0]))
		f= true; 
}
else
{
 if("Y".equals(SData[0][0]))
		f= true; 
		
}


if(f)
	response.sendRedirect("../"+session.getAttribute("PAGE"));
String dbvalue="";
sql ="SELECT CHR_EMPID,CHR_STAFFNAME,CHR_PADD1,CHR_PADD2,CHR_PCITY,INT_PDISTRICTID, CHR_PSTATE,INT_PCOUNTRYID,CHR_PPIN,CHR_PPHONE,CHR_SADD1, CHR_SADD2,CHR_SCITY,INT_CDISTRICTID,CHR_SSTATE,INT_CCOUNTRY,CHR_SPIN,CHR_SPHONE,CHR_EMAILID, CHR_PERMAILID,CHR_MOBILE,DATE_FORMAT(DT_DOB,'%d-%m-%Y')  FROM com_m_staff WHERE CHR_EMPID='"+session.getAttribute("EMPID")+"'";
String Data[][]= com.my.org.erp.common.CommonFunctions.QueryExecute(sql);

if(Data.length>0)
	for(int u=0;u<18;u++)
		if(Data[0][u].equalsIgnoreCase("null") ||Data[0][u].equalsIgnoreCase("") ||Data[0][u].equalsIgnoreCase("-"))
			Data[0][u]="0";
%>
						</td>
					</tr>
					<tr>
						<td height="19" colspan="3" align="right" valign="top"><span
							class="bolddeepred">* </span><span class="fairyHead">Mandatory
						</span></td>
					</tr>


					<tr>
						<td height="23" colspan="2" class="bolddeepred">
						<div align="center">Hi&nbsp;&nbsp;&nbsp;&nbsp;<font
							class="bolddeepred"><%=Data[0][1] + " / " +Data[0][0] %></font> <br>
						</div>
						</td>
					</tr>
					<tr>
						<td height="23" colspan="2" class="bolddeepred">
						<div align="center">Please verify your address information
						for official ...</div>
						</td>
					</tr>

					<tr>
						<td height="17" colspan="3" class="boldEleven">
						<table width="100%" border="0" align="center" cellpadding="2"
							cellspacing="2">




							<tr>
								<td width="50%" height="210">
								<table width="100%" border="0" align="center" cellpadding="1"
									cellspacing="2">
									<tr>
										<td height="15" colspan="2" class="tabledata">
										<div align="center"><strong>Permanent Address</strong></div>
										</td>
									</tr>
									<tr>
										<td class="boldEleven">&nbsp;</td>
										<td width="161" class="boldEleven">&nbsp;</td>
									</tr>
									<tr>
										<td width="97" class="boldEleven">Address1<font
											class="bolddeepred" align="absmiddle">*</font> <%
									dbvalue=Data[0][2].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>
										</td>
										<td class="boldEleven"><input name="padd1" type="text"
											class="formText135" id="padd1"
											onKeyPress="isAddress('padd1','50')" value="<%=dbvalue%>"
											size="30" maxlength="50" /></td>
									</tr>
									<tr>
										<td class="boldEleven">Address2<font class="bolddeepred"
											align="absmiddle">*</font> <%
									dbvalue=Data[0][3].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>
										</td>
										<td class="boldEleven"><input name="padd2" type="text"
											class="formText135" id="padd2"
											onKeyPress="isAddress('padd2','50')" value="<%=dbvalue%>"
											size="30" maxlength="50" /></td>
									</tr>
									<tr>
										<td class="boldEleven">Country<font class="bolddeepred"
											align="absmiddle">*</font></td>
										<td class="boldEleven"><select name="pcountry"
											id="pcountry" style="width: 170"
											onChange="PLoadSelectState()">
											<option value="0">Select Country</option>
											<%
	 		String creadData[][]= com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_COUNTRYID ,CHR_COUNTRYNAME FROM  com_m_country ORDER BY CHR_COUNTRYNAME");
			for(int i=0;i<creadData.length;i++)
				out.println("<option value='"+creadData[i][0]+"'>"+creadData[i][1]+"</option>");
	 %>
										</select> <script language="javascript">setOptionValue('pcountry','<%=Data[0][7].trim()%>')</script>
										</td>
									</tr>
									<tr>
										<td class="boldEleven">State <font class="bolddeepred"
											align="absmiddle">*</font></td>
										<td class="boldEleven"><select name="pstate" id="pstate"
											style="width: 170" onChange="PLoadSelectDistrict()">
											<option value="0" selected="selected">Select State</option>
											<%
String	stateData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM com_m_state WHERE INT_COUNTRYID ="+Data[0][7].trim()+" ORDER BY CHR_STATENAME");
for(int u=0;u<stateData.length;u++)
	out.println("<option value='"+stateData[u][0]+"'>"+stateData[u][1]+"</option>");
																	%>
										</select> <script language="javascript">setOptionValue('pstate','<%=Data[0][6].trim()%>')</script>
										</td>
									</tr>
									<tr>
										<td class="boldEleven">District<font class="bolddeepred"
											align="absmiddle">*</font></td>
										<td class="boldEleven"><select name="pdistrict"
											id="pdistrict" style="width: 170"
											onChange=" PLoadSelectCity()">
											<option value="0" selected="selected">Select
											District</option>
											<%
String	districtData[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_DISTRICTID,CHR_DISTRICT  FROM com_m_district WHERE  INT_STATEID="+Data[0][6].trim()+"  ORDER BY CHR_DISTRICT  ");
for(int u=0;u<districtData.length;u++)
	out.println("<option value='"+districtData[u][0]+"'>"+districtData[u][1]+"</option>");
															  %>
										</select> <script language="javascript">setOptionValue('pdistrict','<%=Data[0][5].trim()%>')</script>
										</td>
									</tr>
									<tr>
										<td class="boldEleven">City <font class="bolddeepred"
											align="absmiddle">* <%
									dbvalue=Data[0][4].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase("") ||dbvalue.equalsIgnoreCase("-"))
										dbvalue="0";
									%> </font></td>
										<td class="boldEleven"><select name="pcity" id="pcity"
											style="width: 170" onChange="PAssignPincode('ppincode')">
											<option value="0" selected="selected">Select City</option>
											<%


String cityData[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_CITYID,CHR_CITYNAME FROM com_m_city WHERE INT_DISTRICTID=" +Data[0][5].trim());
if(cityData.length>0)
for(int u=0;u<cityData.length;u++)
	out.print("<option value='"+cityData[u][0]+"'>"+cityData[u][1]+"</option>");

%>
										</select> <script language="javascript">setOptionValue('pcity','<%=Data[0][4].trim()%>')</script>
										</td>
									</tr>



									<tr>
										<td class="boldEleven">Pin Code<font class="bolddeepred"
											align="absmiddle">*</font> <%
									dbvalue=Data[0][8].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>
										</td>
										<td class="boldEleven"><input name="ppincode"
											value="<%=dbvalue%>" type="text" class="formText135"
											id="ppincode"
											onKeyPress="return numeric_only(event,'ppincode','6')"
											size="25" maxlength="6" /></td>
									</tr>

									<tr>
										<td class="boldEleven">Phone No<font class="bolddeepred"
											align="absmiddle">*</font> <%
									dbvalue=Data[0][9].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>
										</td>
										<td class="boldEleven"><input name="pphone" type="text"
											class="formText135" id="pphone" value="<%=dbvalue%>"
											onKeyPress="return numeric_only(event,'pphone','10')"
											size="25" maxlength="12" /></td>
									</tr>
									<tr>
										<td class="boldEleven">Per. E-mail</td>
										<td><input name="peremailid" type="text"
											value="<%=Data[0][19]%>" class="formText135" id="peremailid"
											size="50" onKeyPress="isEmailID('peremailid','100')"
											maxlength="100" /></td>
									</tr>
									<tr>
										<td class="boldEleven">Mobile</td>
										<td><input name="mobile" type="text"
											value="<%=Data[0][20]%>" class="formText135" id="mobile"
											onKeyPress="numericValue('mobile','10')" size="50"
											maxlength="12" /></td>
									</tr>

								</table>
								</td>
								<td width="50%">
								<table width="100%" border="0" align="center" cellpadding="1"
									cellspacing="2">
									<tr>
										<td colspan="2" class="boldEleven">
										<div align="center"><span class="tabledata"><strong>Communication
										Address</strong></span></div>
										</td>
									</tr>
									<tr>
										<td class="boldEleven">&nbsp;</td>
										<td width="166" class="boldEleven">

										<table width="56">
											<tr>
												<td><script language="javascript">
					 
function cityWindow(query)
	{  
		/*var width="800", height="400";
  		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
	 	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		newWindow = window.open(query,"subWind",styleStr);
		newWindow.focus( );*/
	}

	
					                                                                                     </script>
												<input name="cityname"
													onClick="javascript:cityWindow('../Common/addCity.jsp')"
													type="button" class="buttonbold13" id="cityname"
													value="Add City"></td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td width="101" class="boldEleven">Address1 <%
									dbvalue=Data[0][10].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>
										</td>
										<td class="boldEleven"><input name="cadd1" type="text"
											class="formText135" id="cadd1"
											onKeyPress="isAddress('cadd1','50')" value="<%=dbvalue%>"
											size="30" maxlength="50" /></td>
									</tr>
									<tr>
										<td class="boldEleven">Address2 <%
									dbvalue=Data[0][11].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>
										</td>
										<td class="boldEleven"><input name="cadd2" type="text"
											class="formText135" id="cadd2"
											onKeyPress="isAddress('cadd2','50')" value="<%=dbvalue%>"
											size="30" maxlength="50" /></td>
									</tr>
									<tr>
										<td class="boldEleven">Country</td>
										<td class="boldEleven"><select name="ccountry"
											id="ccountry" style="width: 170"
											onChange="CLoadSelectState()">
											<option value="0">Select Country</option>
											<%
	 		for(int i=0;i<creadData.length;i++)
				out.println("<option value='"+creadData[i][0]+"'>"+creadData[i][1]+"</option>");
	 %>
										</select> <script language="javascript">setOptionValue('ccountry','<%=Data[0][15].trim()%>')</script>
										</td>
									</tr>
									<tr>
										<td class="boldEleven">State</td>
										<td class="boldEleven"><select name="cstate" id="cstate"
											style="width: 170" onChange="CLoadSelectDistrict()">
											<option value="0" selected="selected">Select State</option>
											<%
String	stateData1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM com_m_state WHERE INT_COUNTRYID ="+Data[0][15].trim()+" ORDER BY CHR_STATENAME");
for(int u=0;u<stateData1.length;u++)
	out.println("<option value='"+stateData1[u][0]+"'>"+stateData1[u][1]+"</option>");
																	%>
										</select> <script language="javascript">setOptionValue('cstate','<%=Data[0][14].trim()%>')</script>
										</td>
									</tr>
									<tr>
										<td class="boldEleven">District</td>
										<td class="boldEleven"><select name="cdistrict"
											id="cdistrict" style="width: 170"
											onChange=" CLoadSelectCity()">
											<option value="0" selected="selected">Select
											District</option>
											<%
String	districtData1[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_DISTRICTID,CHR_DISTRICT  FROM com_m_district WHERE  INT_STATEID="+Data[0][14].trim()+"  ORDER BY CHR_DISTRICT  ");
for(int u=0;u<districtData1.length;u++)
	out.println("<option value='"+districtData1[u][0]+"'>"+districtData1[u][1]+"</option>");
															  %>
										</select> <script language="javascript">setOptionValue('cdistrict','<%=Data[0][13].trim()%>')</script>
										</td>
									</tr>
									<tr>
										<td class="boldEleven">City</td>
										<td class="boldEleven"><select name="ccity" id="ccity"
											style="width: 170" onChange="CAssignPincode('cpincode')">
											<option value="0" selected="selected">Select City</option>
											<%


String cityData1[][] = com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_CITYID,CHR_CITYNAME FROM com_m_city WHERE INT_DISTRICTID=" +Data[0][13].trim());
if(cityData1.length>0)
for(int u=0;u<cityData1.length;u++)
	out.print("<option value='"+cityData1[u][0]+"'>"+cityData1[u][1]+"</option>");

%>
										</select> <script language="javascript">setOptionValue('ccity','<%=Data[0][12].trim()%>')</script>
										</td>
									</tr>




									<tr>
										<td class="boldEleven">Pin Code <%
									dbvalue=Data[0][16].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>
										</td>
										<td class="boldEleven"><input name="cpincode" type="text"
											class="formText135" id="cpincode" value="<%=dbvalue%>"
											onKeyPress="return numeric_only(event,'cpincode','6')"
											size="25" maxlength="6" /></td>
									</tr>
									<tr>
										<td class="boldEleven">Phone No <%
									dbvalue=Data[0][17].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>
										</td>
										<td class="boldEleven"><input name="cphone" type="text"
											class="formText135" id="cphone"
											onKeyPress="return numeric_only(event,'cphone','10')"
											value="<%=dbvalue%>" size="25" maxlength="25" /></td>
									</tr>
									<tr>
										<td class="boldEleven">Off. E.Mail</td>
										<td class="boldEleven"><input name="emailid" type="text"
											value="<%=Data[0][18]%>" class="formText135" id="emailid"
											size="50" onKeyPress="isEmailID('emailid','30')"
											maxlength="100" /></td>
									</tr>
									<tr>
										<td class="boldEleven">Date of Birth</td>
										<td><span class="boldEleven"> <input name="dob"
											class="formText135" id="dob" readonly="readonly"
											value="<%=Data[0][21]%>" size="18" maxlength="12">
										<a href="javascript:cal3.popup();"><img
											src="../JavaScript/img/cal.gif"
											alt="Click here to Pick Up the Date" width="16" height="16"
											border="0" />&nbsp;&nbsp;</a></span><span class="boldred">(dd-mm-yyyy)
										<script language="JavaScript" type="text/javascript">
																 
  	var cal3=new calendar1(document.forms['frm'].elements['dob']);
  	cal3.year_scroll=true;
  	cal3.time_comp=false;
 
	
                        </script> </span></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td height="17" colspan="3" class="boldEleven">
						<div align="center" class="copyright">Copy Permanent to
						Communication Address <input onClick="return resoffval()"
							type="radio" value="yes" name="res"> Yes <input
							name="res" type="radio" onClick="return resoffval()" value="no">
						No</div>
						</td>
					</tr>
					<tr>
						<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						<td colspan="2" align="left"><input name="filename"
							type="hidden" id="filename" value="StaffRegistration"> <input
							name="actionS" type="hidden" id="actionS"
							value="COMADDRESSUPDATION"> <input name="empid"
							type="hidden" id="empid" value="<%=Data[0][0]%>"></td>
					</tr>
					<tr>
						<td height="17" colspan="3" class="boldEleven">
						<table width="112" border="0" align="center" cellpadding="1"
							cellspacing="1">
							<tr>
								<td><input name="Submit" type="submit" class="buttonbold"
									value="Submit"></td>
								<td><input name="close" type="button" id="close"
									value="Close" accesskey="c" class="buttonbold"
									onClick="redirect('../Logout.jsp')"></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
						<td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
					</tr>
				</tbody>
				<input type="hidden" name="mobileBookingOption" />
			</table>
			</td>
			<td nowrap="nowrap" width="4"><spacer height="1" width="1"
				type="block" /></td>
			<td class="BorderLine" width="1"><spacer height="1" width="1"
				type="block" /></td>
		</tr>
		<tr>
			<td colspan="2" rowspan="2"><img height="7"
				src="../../Image/Smart Inventory/BLCorner.gif" width="7" /></td>
			<td height="6"><spacer height="1" width="1" type="block" /></td>
			<td colspan="2" rowspan="2"><img height="7"
				src="../../Image/Smart Inventory/BRCorner.gif" width="7" /></td>
		</tr>
		<tr>
			<td class="BorderLine" height="0"><spacer height="1" width="1"
				type="block" /></td>
		</tr>
	</tbody>
</table>
</form>
<script language="javascript">alert("Please verify your address information for official...");</script>
<%

}
catch(Exception e)
{
	out.println(e.getMessage());
	
	 
}
%>
</body>
</html>
