<%@ page import="java.lang.*,java.util.*,java.io.*,java.sql.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
try
{
%>

<%!
  String companyId;	
  String companyName,legalName,street,city,state,postal,country;
  String areacode,phone,fax,email,website,tngstno,cstno,regno,tinno;
  float itemPrice;
  String actionStu;
  String servicetax,shortname,pannumber,pfnumber;
%>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title><%=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT CHR_MODULETITLE FROM m_projectmodule WHERE CHR_SHORTNAME='COM' ")[0][0]%></title>

<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/AJAX.js"></script>


<script language="JavaScript"> 
function validate()
{
	 
	 if(	
		checkNull('compname','Enter Company Name..') 
		&& checkNull('shortname','Enter Company Short Name..')
		&& checkNull('legalname','Enter Legal Name..') 
		&& checkNull('street','Enter Strett Name..') 
		&& checkNullSelect('country','Select Country..', '0')
		&& checkNullSelect('state','Select State..', '0')
		&& checkNull('city','Enter City..') 
		&& checkNull('postal','Enter Postal Code..') 
		&& checkNull('areacode','Enter Area Code..') 
		&& checkNull('phone','Enter Phone..') 
		&& chkemail("email")
		&& checkNull('tngsno','Enter TNGS No..') 
		&& checkNull('cstno','Enter CST No..') 
		&& checkNull('tinno','Enter TIN No..') 
		&& checkNull('servicetaxno','Enter Service Tax No ..') 
		 
		)
	{
		alert("");
			return true;			
	}
	else
	{
		return false;
	}
	 
}      
function Validates()
    {  
  	  
	 alert();
	 return false;
  /* 
	if(	
		checkNull('compname','Enter Company Name..') 
		&& checkNull('shortname','Enter Company Short Name..')
		&& checkNull('legalname','Enter Legal Name..') 
		&& checkNull('street','Enter Strett Name..') 
		&& checkNullSelect('country','Select Country..', '0')
		&& checkNullSelect('state','Select State..', '0')
		&& checkNull('postal','Enter Postal Code..') 
		&& checkNull('areacode','Enter Area Code..') 
		&& checkNull('phone','Enter Phone..') 
		&& chkemail("email")
		)
	{
			return true;			
	}
	else
	{
		return false;
	}*/	
	//tngsno,cstno,tinno,servicetaxno    
 }
  
 
</script>

</head>
<body onpaste="return false;" leftmargin="0" rightmargin="0"
	topmargin="0" onLoad="document.casesheet.compname.focus()">

<%@ include file="insert.jsp"%>

<form AUTOCOMPLETE="off" name="frm" method="post"
	action="../SmartLoginAuth" onSubmit="return validate()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td></td>
	</tr>
	<tr>
		<td height="27">
		<%   
  	String action=request.getParameter("action1");  
	if(action.equals("Edit"))
	{
		 actionStu="COMcompanyEdit";
		 companyId=request.getParameter("companyId");
		 
		 String qry=" SELECT INT_COMPANYID,CHR_COMPANYNAME,CHR_LEGALNAME,CHR_STREET,CHR_CITY,CHR_STATE,CHR_POSTAL,CHR_COUNTRY,CHR_AREACODE,CHR_PHONE,CHR_FAX,CHR_EMAIL,CHR_WEBSITE,CHR_TNGSTNO,CHR_CSTNO,CHR_REGNO,CHR_TINNO,CHR_SERVICETAX,CHR_SHORTNAME,CHR_PANNO,CHR_PFNUMBER , CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS FROM com_m_company WHERE INT_COMPANYID="+companyId;
String data[][] = com.my.org.erp.common.CommonFunctions.QueryExecute(qry);
		 
		companyName=""+data[0][1];
		legalName=""+data[0][2];
		street=""+data[0][3];
		city=""+data[0][4];
		state=""+data[0][5];
		postal=""+data[0][6];
		country=""+data[0][7];
		areacode=""+data[0][8];
		phone=""+data[0][9];
		fax=""+data[0][10];
		email=""+data[0][11];
		website=""+data[0][12];
		tngstno=""+data[0][13];
		cstno=""+data[0][14];
		regno=""+data[0][15];
		tinno=""+data[0][16];
		servicetax=""+data[0][17];
		shortname=""+data[0][18];
		pannumber=""+data[0][19];
		pfnumber=""+data[0][20];	 
	}
	else
	{
		actionStu="COMcompanyAdd";
		companyName="";
		legalName="";
		street="";
		city="";
		state="";
		postal="";
		country="";
		areacode="";
		phone="";
		fax="";
		email="";
		website="";
		tngstno="";
		cstno="";
		regno="";
		tinno="";
		servicetax="";
		shortname="";
		pannumber="";
		pfnumber="";
	
	}   
    
		
%>
		</td>
	</tr>
	<tr>
		<td>
		<table class="BackGround" cellspacing="0" cellpadding="0" width="424"
			align="center" border="0">
			<tbody>
				<tr>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TLCorner.gif" width="7" alt="" /></td>
					<td class="BorderLine" height="0"><spacer height="1" width="1"
						type="block" /></td>
					<td colspan="2" rowspan="2" valign="top"><img height="7"
						src="../Image/Smart Inventory/TRCorner.gif" width="7" alt="" /></td>
				</tr>
				<tr>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
				</tr>
				<tr>
					<td class="BorderLine" width="1"><spacer height="1" width="1"
						type="block" /></td>
					<td width="6"><spacer height="1" width="1" type="block" /></td>
					<td width="412">
					<table cellspacing="2" cellpadding="2" width="388" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">COMPANY INFORMATION</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>

							<tr>
								<td height="17" class="boldEleven">Company Name <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left">
								<%
								
								 if("Edit".equals(action))
								 {
								 
									
								 %> <input type="type" name="compname" id="compname"
									class="formText135" value="<%=companyName%>" maxlength=50
									size='35'> <%
								 }
								 else
								 {
								 %> <input type="type" name="compname" id="compname"
									onKeyUp="upperMe(this), CheckUnique(this,'soValid1','com_m_company','CHR_COMPANYNAME')"
									class="formText135" value="<%=companyName%>"
									onBlur="TxtTrim(this)" maxlength=50 size='35'>
								<div id=soValid1>&nbsp;</div>
								<%
								 }
								%>
								</td>
							</tr>

							<tr>
								<td height="17" class="boldEleven">Short Name <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left">
								<%
							String red="";
							  if("Edit".equals(action))
								 	red=" readonly=readonly ";
							%> <input name="shortname" type="text" class="formText135"
									id="shortname" onKeyPress="charOnly('shortname','5')"
									value="<%=shortname%>" size="35" maxlength="3" <%=red%>
									onKeyUp="upperMe(this), CheckUnique(this,'soValid2','com_m_company','CHR_SHORTNAME')">
								<div id=soValid2></div>
								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Legal Name<span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left"><input type="text"
									name="legalname" id="legalname" class="formText135"
									value="<%=legalName%>" size="35" maxlength="50"
									onKeyPress="alphaNumeric('legalname','50')"></td>
							</tr>

							<tr>
								<td width="118" height="17" valign="top" class="boldEleven">Street<span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left" class="bolddeepblue"><textarea
									name="street" cols="30" rows="5" class="formText135"
									id="street" onKeyPress="alphaNumeric('street','300')"><%=street%></textarea>
								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Country<span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left"><select name="country"
									id="country" style="width: 170">
									<option value="0">Select</option>


									<%
	  String sql1="SELECT INT_COUNTRYID,CHR_COUNTRYNAME FROM com_m_country ORDER BY  CHR_COUNTRYNAME ";
	  String countrydata[][]=com.my.org.erp.common.CommonFunctions.QueryExecute(sql1);
	  for(int i=0;i<countrydata.length;i++)
	  	if(country.equals(countrydata[i][0]))
	    	out.println("<option  selected='selected' value="+countrydata[i][0]+">"+countrydata[i][1]+"</option>");		
		else
			out.println("<option value="+countrydata[i][0]+">"+countrydata[i][1]+"</option>");			
	                                        %>

								</select></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">State<span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left"><select name="state"
									id="state" style="width: 170">
									<option value="0">Select</option>
									<%
String state1data[][]=com.my.org.erp.common.CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM  com_m_state     ORDER BY CHR_STATENAME");
for(int h=0;h<state1data.length;h++)
	if(state.equals(state1data[h][0]))
		out.print("<option  selected='selected' value='"+state1data[h][0]+"'>"+state1data[h][1]+"</option>");
	else
		out.print("<option value='"+state1data[h][0]+"'>"+state1data[h][1]+"</option>");	

%>
								</select></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left" class="bolddeepblue"><!--DWLayoutEmptyCell-->&nbsp;</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">City<span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="city" id="city" class="formText135"
									value="<%=city%>" onKeyPress="alphaNumeric('city','50')"
									size="35" maxlength="50"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Postal<span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="postal" id="postal" class="formText135"
									value="<%=postal%>" maxlength="6" size="35"
									onKeyPress="numericValue('postal','6')"></td>
							</tr>

							<tr>
								<td height="17" class="boldEleven">Area Code<span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="areacode" id="areacode" class="formText135"
									value="<%=areacode%>" maxlength="10"
									onKeyPress="numericValue('areacode','10')" size="35"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Phone<span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="phone" id="phone" class="formText135"
									value="<%=phone%>" size="35" maxlength="30"
									onkeypress="return numeric_only(event,'phone','15');"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Fax</td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									type="text" class="formText135" value="<%=fax%>" name="fax"
									size="35" maxlength="30" onKeyPress="numericValue('fax','30')"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">E-Mail</td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="email" id="email" class="formText135"
									value="<%=email%>" maxlength=50 size="35"
									onKeyPress="isEmailID('email','30')"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Website</td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="website" class="formText135"
									value="<%=website%>" maxlength="50" size="35"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Register No <span
									class="bolddeepred"></span></td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="regno" id="regno" class="formText135"
									value="<%=regno%>" onKeyPress="alphaNumeric('regno','30')"
									maxlength="30" size="35"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">TNGS No<span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="tngsno" id="tngsno" class="formText135"
									value="<%=tngstno%>" onKeyPress="alphaNumeric('tngsno','30')"
									maxlength="30" size="35"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">CST No<span
									class="bolddeepred">*</span></td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="cstno" id="cstno" class="formText135"
									value="<%=cstno%>" onKeyPress="alphaNumeric('cstno','30')"
									maxlength="30" size="35"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Tin No <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="tinno" id="tinno" class="formText135"
									value="<%=tinno%>" onKeyPress="alphaNumeric('tinno','30')"
									maxlength="30" size="35"
									onKeyUp="LoadUniqueCheck('tinno', 'UniqueId1', 'com_m_company', 'CHR_TINNO', 'submit')">
								<div id="UniqueId1"></div>
								</td>
							</tr>
							<tr>
								<td height="17" valign="top" class="boldEleven">Service Tax
								No <span class="bolddeepred">*</span></td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									type="text" name="servicetaxno" id="servicetaxno"
									class="formText135" value="<%=servicetax%>"
									onKeyPress="alphaNumeric('servicetaxno','30')" maxlength="30"
									size="35"
									onKeyUp="LoadUniqueCheck('servicetaxno', 'UniqueId1', 'com_m_company', 'CHR_SERVICETAX', 'submit')"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">PAN Number</td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									name="pannumber" type="text" class="formText135" id="pannumber"
									value="<%=pannumber%>" size=35 maxlength=30></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">PF Number</td>
								<td colspan="2" align="left" class="bolddeepblue"><input
									name="pfnumber" value="<%=pfnumber%>" class="formText135"
									type="text" id="pfnumber" size="35" maxlength="25"></td>
							</tr>



							<tr>
								<td height="30" colspan="4" valign="top"><input
									type="hidden" name="actionS" value="<%=actionStu %>" /> <input
									type="hidden" name="companyId" value="<%=companyId %>" /> <input
									name="qp" type="hidden" value="<%=qp%>"> <input
									type="hidden" name="filename" value="Company" />
							</tr>
							<tr>
								<td height="30" colspan="3" valign="top">
								<table border="0" align="center" cellpadding="1" cellspacing="1">
									<tr>
										<td width="56"><input name="Submit" type="submit"
											id="Submit" class="buttonbold" value="Submit" accesskey="s">
										</td>
										<td width="56"><input name="close" type="button"
											class="buttonbold" value="Close" accesskey="c"
											onClick="redirect('../Common/CompanyMaster.jsp?path=ATT')">
										</td>
									</tr>
								</table>
								<td>
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
						src="../Image/Smart Inventory/BLCorner.gif" width="7" alt="" /></td>
					<td height="6"><spacer height="1" width="1" type="block" /></td>
					<td colspan="2" rowspan="2"><img height="7"
						src="../Image/Smart Inventory/BRCorner.gif" width="7" alt="" /></td>
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
		<td></td>
	</tr>
	<tr>
		<td><%@ include file="../footer.jsp"%></td>
	</tr>
</table>


</form>
</body>
</html>
<%
}
catch(Exception e)
{
	out.println(e.getMessage());
}
%>
