<%@ page import="java.io.*,java.util.*"  %>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>

<%
try
{
	String sql="";

%>
<html>
<head>
<title>:: INVENTORY ::</title><style type="text/css">
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
<script language="javascript" src="../JavaScript/common/SelectChangesCountry.js"></script>


<script language="JavaScript" src="../JavaScript/jquery/jquery-1.7.1.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.core.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.widget.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js" type="text/javascript"></script>

<script language="javascript">
	
$(function() {
		$( "#doh" ).datepicker({
			changeMonth: true,
			changeYear: true,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true
		});
	}); 
	
$(function() {
		$( "#balanceasof" ).datepicker({
			changeMonth: true,
			changeYear: true,
			showOn: "button",
			buttonImage: "../JavaScript/jquery/images/calendar.gif",
			buttonImageOnly: true
		});
	}); 
	
</script>


<link href="../JavaScript/jquery/themes/base/jquery.ui.all.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
function lookup(inputString) 
{
	if(inputString.length == 0) 
	{
		$('#suggestions').hide();
	} 
	else 
	{
		$.post("../JavaScript/pincodes.jsp", {queryString: ""+inputString+""}, function(data)
		{
			if(data.length >0) 
			{
				$('#suggestions').show();
				$('#autoSuggestionsList').html(data);
			}
		});
	}
}



 
function fill(thisValue) 
{
	var listArray = thisValue.split("/");
	setOptionValue('country',listArray[0]);
	
	var _targ=document.getElementsByName('state')[0];       
	 _targ.options.length=0;
	 _targ.options[0]=new Option(listArray[3],listArray[2]);  
	
	var _targ1=document.getElementsByName('district')[0];       
	 _targ1.options.length=0;
	 _targ1.options[0]=new Option(listArray[5],listArray[4]);  

	var _targ2=document.getElementsByName('city')[0];       
	 _targ2.options.length=0;
	 _targ2.options[0]=new Option(listArray[7],listArray[6]);  
	 
	document.getElementById('pin').value=listArray[8];
	$('#pin').val(listArray[8]);
	$('#suggestions').hide();
	//setTimeout("$('#suggestions').hide();", 200);
}



</script>
<style type="text/css">
body {
font-family: Helvetica;
font-size: 13px;
color: #000;
}
h3 {
margin: 0px;
padding: 0px;
}


.suggestionsBox 
{
	position: relative;
	margin: 0px 0px 0px 0px;
	width: 200px;
	background-color: #ffffff;
	-moz-border-radius: 7px;
	-webkit-border-radius: 7px;
	border: 1px solid #000;
	color: #000;
}
.suggestionList 
{
	margin: 0px;
	padding: 0px;
}
.suggestionList li 
{
	margin: 0px 0px 3px 0px;
	padding: 3px;
	cursor: pointer;
}

.suggestionList li:hover {
background-color: #ffffff;
}


</style>


<script language="JavaScript">
 function valid()
  {
     
   try
	{   	
		if(
			checkNullSelect( "customergroup","Select customer group" ,'0')
			&& checkNull( "alias","Enter Alias Name" )
			&& checkNull( "address1","Enter Address - 1" )
			&& checkNull( "address2","Enter Address - 2" )
			&& checkNullSelect( "country","Select Country" ,'0')
			&& checkNullSelect( "state","Select State" ,'0')
			&& checkNullSelect( "district","Select District" ,'0')
			&& checkNullSelect( "city","Select City" ,'0')
			&& checkNull( "pin","Enter pincode" )
			&& chkemail("email")
			&& checkNullSelect("bank","Select Bank","")
			
			&& checkNullSelect("customertype","Select customer type","0")	
		)
			return true;
		else
			return false;	
	}
	catch(err)
	{
		alert(err);
	}				
	 	
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
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td bgcolor="#FFFFFF">
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="550"
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
					<table cellspacing="2" cellpadding="2" width="100%" align="center"
						border="0">
						<!--DWLayoutTable-->
						<tbody>
							<tr>
								<td height="16" colspan="3" align="center" valign="top"
									class="boldThirteen">Customer Info
									
									
							<%				 
String custid =  (""+request.getParameter("custid").trim());
sql = " SELECT  INT_CUSTOMERID,INT_CUSTOMERGROUPID ,CHR_CONTACTPERSON ,CHR_ADDRESS1 ,  CHR_ADDRESS2 ,CHR_ADDRESS3 , ";
sql = sql+ "INT_CITYID ,INT_DISTRICTID ,INT_STATEID ,  INT_COUNTRYID ,INT_PINCODE , ";
sql = sql+ "CHR_AREACODE ,CHR_PHONE ,CHR_MOBILE ,CHR_FAX ,  CHR_EMAIL ,CHR_WEBSITE , ";
sql = sql+ "INT_ACTIVE ,DATE_FORMAT(DAT_SINCE,'%d-%m-%Y') ,CHR_ACCNO ,INT_BANKGROUPID ,  DOU_BALANCE ,DATE_FORMAT(DAT_BALANCEASOF,'%d-%m-%Y') , ";
sql = sql+ "DOU_CREDITLIMIT ,INT_CUSTOMERTYPEID ,  CHR_TIN ,CHR_CST ,CHR_VERIFIED,CHR_ALIASNAME, CHR_PAN ,CHR_GSTNO,CHR_USRNAME , ";
sql = sql+ "DT_UPDATEDATE ,CHR_UPDATESTATUS,CHR_DEPARTYMENT ,CHR_BILLING,CHR_BILLINGADDRESS ,CHR_TAXEXAMPTION,CHR_TAXEXAMPTIONNO, CHR_ACCOUNTTYPE  ";
sql = sql+ "FROM inv_m_customerinfo   WHERE INT_CUSTOMERID="+custid;
//out.println(sql);
 String Data[][] =  CommonFunctions.QueryExecute(sql);
for(int u=0;u<28;u++)
	if("-".equals(Data[0][u]))
		Data[0][u]="";
					
					 
					
					
				  %>									</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>


							


							<tr>
								<td width="180" height="17" class="boldEleven">Customer Name <span
									class="bolddeepred">* </span></td>
							  <td width="337" colspan="2" align="left"> 
								  <select name="customergroup" class="formText135" id="customergroup" style="width:170">
                                    <option value="0">Select Customer Group</option>
                                    <%
String group[][] =  CommonFunctions.QueryExecute("SELECT INT_CUSTOMERGROUPID,CHR_NAME FROM inv_m_customergroup ORDER BY CHR_NAME");
for(int u=0; u<group.length; u++)
	out.print("<option value ='"+group[u][0]+"'>" +group[u][1]+"</option>");

%>
                                  </select>
								  <script language="javascript">setOptionValue('customergroup','<%=Data[0][1]%>')</script>								  </td>
							</tr>
							 
							<tr>
							  <td height="17" class="boldEleven">Alias Name <span
									class="bolddeepred">* </span></td>
							  <td colspan="2" align="left"><input name="alias"
									type="text" title="Enter the Alais Name" class="formText135" size="30" id="alias"
									  maxlength="90"  value="<%=Data[0][28]%>"    onBlur="upperMe(this)"     ></td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven">Contact person</td>
								<td colspan="2" align="left"><input name="cperson"
									type="text" class="formText135" id="cperson"
									 value="<%=Data[0][2]%>" size="30" maxlength="100"     onBlur="upperMe(this)"     ></td>
							</tr>
							<tr>
							  <td class="boldEleven">Department</td>
							  <td class="boldEleven"><input name="department"
									type="text" class="formText135" id="department" title="Enter the Contact Person"     onBlur="upperMe(this)" value="<%=Data[0][33]%>" size="30"
									  maxlength="90"     ></td>
						  </tr>
							<tr>
							  <td class="boldEleven">Door No <span
									class="bolddeepred">* </span></td>
							  <td class="boldEleven"><input name="address1" type="text" class="formText135" id="address1" value="<%=Data[0][3]%>" size="30" maxlength="100" ></td>
						  </tr>
							<tr>
							  <td class="boldEleven">Floor / Street <span
									class="bolddeepred">* </span></td>
							  <td class="boldEleven"><input name="address2" type="text" class="formText135" id="address2" value="<%=Data[0][4]%>" size="30" maxlength="100" ></td>
						  </tr>
							<tr>
							  <td class="boldEleven">Address</td>
							  <td class="boldEleven"><input name="address3" type="text" class="formText135" id="address3" value="<%=Data[0][5]%>" size="30" maxlength="100"  ></td>
						  </tr>
							<tr>
                      <td height="17" valign="top" class="boldEleven">Country<span class="bolddeepred"> * </span></td>
                      <td   align="left"><select name="country" class="formText135" id="country" style="width:170" onChange="LoadSelectState(),resetPincode('pin')">
                          <option value="0">Select Country</option>
                          <%
	 		String readData[][]=  CommonFunctions.QueryExecute("SELECT INT_COUNTRYID ,CHR_COUNTRYNAME FROM  com_m_country ORDER BY CHR_COUNTRYNAME");
			for(int i=0;i<readData.length;i++)
				out.println("<option value='"+readData[i][0]+"'>"+readData[i][1]+"</option>");
	 %>
                        </select> 
						<script language="javascript">setOptionValue('country','<%=Data[0][9]%>')</script>						                     </td>
                    </tr>
							<tr>
                      <td height="17" valign="top" class="boldEleven">State<span class="bolddeepred"> * </span></td>
                      <td   align="left" valign="top"><select name="state" class="formText135" id="state" style="width:170" onChange="LoadSelectDistrict(),resetPincode('pin')">
                          <option value="0" selected="selected">Select State</option>
						  
						   <%
							
							String stateData[][] =  CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM com_m_state WHERE INT_COUNTRYID=" +Data[0][9]);
								if(stateData.length>0)
									for(int u=0;u<stateData.length;u++)
										out.print("<option value='"+stateData[u][0]+"'>"+stateData[u][1]+"</option>");
						 
					%>
                          </select> 
						  <script language="javascript">setOptionValue('state','<%=Data[0][8]%>')</script>                     </td>
                    </tr>
							<tr>
                      <td height="17" class="boldEleven">District<span class="bolddeepred"> * </span></td>
                      <td   align="left" class="bolddeepblue"><select name="district" class="formText135" id="district" style="width:170" onChange=" LoadSelectCity(),resetPincode('pin')">
                          <option value="0" selected="selected">Select District</option>
						  
						  <%
						    String districtData[][] =  CommonFunctions.QueryExecute("SELECT INT_DISTRICTID,CHR_DISTRICT FROM com_m_district WHERE INT_STATEID=" +Data[0][8]);
								if(districtData.length>0)
									for(int u=0;u<districtData.length;u++)
										out.print("<option value='"+districtData[u][0]+"'>"+districtData[u][1]+"</option>");
						 				
						  %>
                          </select> 
						  <script language="javascript">setOptionValue('district','<%=Data[0][7]%>')</script>                      </td>
                    </tr>
							<tr>
                      <td height="17" class="boldEleven"> City <span class="bolddeepred"> * </span></td>
                      <td   align="left" class="bolddeepblue">
					 
					 
					  <select name="city" class="formText135" id="city" style="width:170" onChange="AssignPincode('pin')">
                          <option value="0" selected="selected">Select City </option>
						   <%
						
						 
							String cityData[][] = CommonFunctions.QueryExecute("SELECT INT_CITYID,CHR_CITYNAME FROM com_m_city WHERE INT_DISTRICTID=" +Data[0][7]);
							if(cityData.length>0)
								for(int u=0;u<cityData.length;u++)
									out.print("<option value='"+cityData[u][0]+"'>"+cityData[u][1]+"</option>");
						 
					%>
                         </select>
						  <script language="javascript">setOptionValue('city','<%=Data[0][6]%>')</script>						 </td>
                    </tr>
							
							<tr>
								<td height="20" class="boldEleven">Pin Code</td>
								<td colspan="2" align="left"> 
									
									<input name="pin" type="text"   value="<%=Data[0][10]%>" class="formText135" id="pin" onKeyPress="return numeric_only(event,'pin','7') " size="10" 									maxlength="6"    onKeyUp="lookup(this.value);" />
	<br />
		<div class="suggestionsBox" id="suggestions" style="display: none;width:150%;">
					<div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:200px" ></div>
		</div>									</td>
							</tr>
							 
							<tr>
							  <td height="17" colspan="3" class="boldred">							  							  </td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven">Phone</td>
								<td colspan="2" align="left"><input name="area" type="text"
									class="formText135"
									id="area"  onKeyPress="return numeric_only(event,'area','12')"   value="<%=Data[0][11]%>" size="10" maxlength="10">
								<input name="phone" type="text" class="formText135" id="phone"
									 onKeyPress="return numeric_only(event,'phone','12')"  value="<%=Data[0][12]%>" size="15" maxlength="10"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Mobile</td>
								<td colspan="2" align="left"><input name="mobile"
									type="text" class="formText135" id="mobile"
									onKeyPress="return numeric_only(event,'mobile','12')"   value="<%=Data[0][13]%>" size="30" maxlength="10"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Fax</td>
								<td colspan="2" align="left"><input name="fax" type="text" class="formText135"
									id="fax"
									 onKeyPress="return numeric_only(event,'fax','16')"  value="<%=Data[0][14]%>" size="30" maxlength="10"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Email</td>
								<td colspan="2" align="left"><input name="email"
									type="email" class="formText135" id="email"
									onKeyPress="isEmailID('email','30')" value="<%=Data[0][15]%>" size="30" maxlength="100"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Website URL </td>
								<td colspan="2" align="left"><input name="website"
									type="text" class="formText135" id="website"
									onKeyPress="websiteOnly('website','30')" value="<%=Data[0][16]%>" size="30" maxlength="100"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Active</td>
								<td colspan="2" align="left">
								<%
	    		   String dis="";
				   if("1".equals(Data[0][17].trim()))
				   		dis = "checked='checked'";				   		
				  %> <input name="status" type="checkbox" id="status" <%=dis%> value="1"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Date</td>
								<td colspan="2" align="left">
								 <input name="doh" type="text" readonly ='readonly' class="formText135" id="doh" value="<%=Data[0][18]%>" size="30">						      </td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Account No.</td>
								<td colspan="2" align="left"><input name="accno"
									type="text" class="formText135" id="accno"
									onKeyPress="numericValue('accno','15')" value="<%=Data[0][19]%>" size="30" maxlength="20"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Bank Name <span class="bolddeepred"> * </span></td>
								<td colspan="2" align="left"><select name="bank" class="formText135" id="bank" style="width:170">
                                  <option value="">Select Bank</option>
                                  <%
String bdata[][] =  CommonFunctions.QueryExecute("SELECT INT_BANKGROUPID, CHR_BANKGROUPNAME FROM com_m_bankgroup ORDER BY CHR_BANKGROUPNAME");
for(int u=0; u<bdata.length; u++)
	out.print("<option value ='"+bdata[u][0]+"'>" +bdata[u][1]+"</option>");

%>
                                </select>
								  <script language="javascript">setOptionValue('bank','<%=Data[0][20]%>')</script>
								  </td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Balance</td>

								 

								<td colspan="2" align="left"><input name="balance"
									type="text" class="formText135" id="balance" value="<%=Data[0][21]%>" size="30" maxlength="8"
									onKeyPress="return numeric_only(event,'balance','9')"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Balance as of</td>
								<td colspan="2" align="left">
								 <input name="balanceasof" type="text" class="formText135"
									id="balanceasof" value="<%=Data[0][22]%>" size="30"
									maxlength="15" readonly  ></td>
							</tr>

							<tr>
                      <td height="17" class="boldEleven">Account Type </td>
                      <td colspan="3" align="left">
					  <select name="accounttype"  id="accounttype"  class="formText135">
					  <%
				 String accounttype[][] =  CommonFunctions.QueryExecute("SELECT INT_ACCOUNTTYPEID, CHR_ACCOUNTTYPENAME FROM  inv_m_accounttype  ORDER BY CHR_ACCOUNTTYPENAME");
				  for(int u=0; u<accounttype.length; u++)
				  	out.print("<option value ='"+accounttype[u][1]+"'>" +accounttype[u][1]+"</option>");
				  %></select>
					  <script language="javascript">setOptionValue('accounttype','<%=Data[0][39]%>')</script>
					  </td>
                    </tr>
							<tr>
								<td height="17" class="boldEleven">Customer Type <span class="bolddeepred"> * </span></td>
								<td colspan="2" align="left"><select name="customertype" id="customertype"
									class="formText135" style="width:170">
                                  <option value="0">Select Customer Type</option>
                                  <%
				  String query1 ="SELECT INT_CUSTOMERTYPEID,CHR_TYPENAME FROM inv_m_customertype ORDER BY CHR_TYPENAME";
				  String customertype[][] =  CommonFunctions.QueryExecute(query1);
				  for(int u=0; u<customertype.length; u++)
				  	out.print("<option value ='"+customertype[u][0]+"'>" +customertype[u][1]+"</option>");
				  %>
                                </select>
								<script language="javascript">setOptionValue('customertype','<%=Data[0][24]%>')</script>								</td>
							</tr>
							<tr>
							  <td height="17" class="boldEleven">
							  
							  
							  <%
							   String usertype=""+session.getAttribute("USRTYPE");
	  							if("F".equals(usertype))
	  								out.println("Credit Limit");
							  %>							  </td>
							  <td colspan="2" align="left">
							  
							  <%
							   
		if("F".equals(usertype))
		{
		
		out.println("<input name='climit' maxlength='9'	type='text' size='30' class='formText135' id='climit' 	onKeyPress=\"return numeric_only(event,'climit','13')\"  value='"+Data[0][23]+"'>");
		}
		else
		{
				out.println("<input name='climit'  maxlength='9' size='30' type='text' id='climit'  value='"+Data[0][23]+"'>");
		}
			
							  %>							  </td>
							<tr>
                              <td height="20" class="boldEleven">GST Number </td>
							  <td colspan="2" align="left"><input name="gst"
									type="text" class="formText135" id="gst" value="<%=Data[0][30]%>" size="30"
									maxlength="30"></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">PAN Number </td>
							  <td colspan="2" align="left"><input name="pannumber"
									type="text" class="formText135" id="pannumber" title="Enter the CST Number" value="<%=Data[0][29]%>" size="30"
									maxlength="30"></td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven">TIN Number</td>
								<td colspan="2" align="left"><input name="tinnumber"
									type="text" class="formText135" id="tinnumber" value="<%=Data[0][25]%>" size="30" maxlength="30"></td>
							</tr>
							<tr>
                              <td height="20" class="boldEleven">CST Number </td>
							  <td colspan="2" align="left"><input name="cstnumber"
									type="text" class="formText135" id="cstnumber" value="<%=Data[0][26]%>" size="30"
									maxlength="30"></td>
						  </tr>
							
							<tr>
							  <td height="17" class="boldEleven">Verified</td>
							  <td colspan="2" align="left">
							  
							  				<%
	    		   dis="";
				   if("Y".equals(Data[0][27].trim()))
				   		dis = "checked='checked'";				   		
				  %> <input name="verified" type="checkbox" id="verified" <%=dis%> value="Y">							  </td>
						  </tr>
							<tr>
							  <td class="boldEleven">Tax Examption
                              
                              <%
							  String s1="";
							  String s2="";
							  if("Y".equals(Data[0][36].trim()))
							  	s1 = " checked = 'checked' ";
							  else
								s2 = " checked = 'checked' ";	
							  %>                              </td>
							  <td colspan="2" align="left"><table width="100%" border="0" cellpadding="0" cellspacing="0">
							    <tr>
							      <td width="6%"><input name="taxexamption" type="radio" id="radio2" value="Y"  <%=s1%>></td>
							      <td width="6%" class="boldEleven">Yes</td>
							      <td width="6%"><input name="taxexamption" type="radio" id="radio3" value="N" <%=s2%>></td>
							      <td width="18%" class="boldEleven">No</td>
							      <td width="14%" class="boldEleven">Ref. no</td>
							      <td width="50%"><input name="taxexamptionno" type="text" class="formText135" id="taxexamptionno" value="<%=Data[0][38]%>" maxlength="100"></td>
						        </tr>
						      </table></td>
						  </tr>
							<tr>
							  <td class="boldEleven">Billing </td>
							  <td colspan="2" align="left"><table width="100" border="0" cellspacing="0" cellpadding="0">
							    <tr> 
							      <td>
                                  <input name="billing" type="radio" id="radio" value="Y" <%=("Y".equals(Data[0][35])?" checked = 'checked' ":"")%>></td>
							      <td class="boldEleven">Same</td>
							      <td class="boldEleven">
                                  <input type="radio" name="billing" id="radio" value="N"<%=("N".equals(Data[0][35])?" checked = 'checked' ":"")%>></td>
							      <td class="boldEleven">different</td>
						        </tr>
						      </table></td>
						  </tr>
							<tr>
							  <td align="left" valign="top" class="boldEleven">Billing Address</td>
							  <td colspan="2" align="left"><textarea name="billingaddress" id="billingaddress" cols="30" rows="5"   onKeyUp="  textArea('billingaddress','500')"><%=Data[0][36]%></textarea></td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
								<td colspan="2" align="left"><input name="filename"
									type="hidden" value="CustomerInfo" /> <input name="actionS"
									type="hidden" value="INVCustomerInfoUpdate" /> <input
									name="custid" type="hidden" id="custid" value="<%=custid%>" /></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit"  id="Submit" type="submit" class="buttonbold"
											value="Update"></td>
										<td><input name="Close" type="Button" class="buttonbold"
											id="Close"  value="Close"   accesskey="c"  onClick="javascript:history.back()"></td>
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
	out.println(e.getMessage());
	System.out.println(e.getMessage());
}
%>
