<%@ page contentType="text/html; " language="java" import="java.sql.*" 	errorPage="../error/index.jsp"%>
<%@include file="Redirect.jsp" %>	
<%
try
{
%>  
<html>
<head>

<title> :: UTILITY :: </title>


 
<link rel="icon" type="image/ico" href="../images/ERP.ico"></link>
<link rel="shortcut icon" href="../images/ERP.ico"></link>

<script language="javascript" src="../JavaScript/jquery/jquery-1.7.1.js"></script>
<script language="javascript" src="../JavaScript/JTime/jquery.timePicker.js"></script>
<link href="../JavaScript/JTime/timePicker.css" rel="stylesheet" type="text/css">


<meta name="resource-type" content="document" />
<meta http-equiv="content-type" content="text/html; charset=US-ASCII" />
<meta http-equiv="content-language" content="en-us" />
<meta name="author" content="KALAISELVAN K" />
<meta name="contact" content="abikalaiselvan@yahoo.co.in" />
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript">         
function  Valid()
{
	var name=confirm("Want to update the settings")
	if (name==true)
	{ 
		if(
			checkNull('name','Enter company name')
			&& checkNull('address1','Enter the address1')
			&& checkNull('address2','Enter the address2')
			&& checkNullSelect('city','Select the city ','0')
			&& checkNullSelect('district','Select the District ','0')
			&& checkNullSelect('state','Select the State ','0')
			&& checkNullSelect('country','Select the country ','0')
			&& checkNull('pin','Enter the pincode')
			&& checkNull('phone','Enter the phone')
		  )
		   	return true;			
		 else
		 	return false; 
	}
	else
		return false;
}		 
</script>


 <style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
 </style>
</head>
 
<script language="JavaScript" src="../JavaScript/jquery/jquery-1.7.1.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.core.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.widget.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js" type="text/javascript"></script>

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
	setTimeout("$('#suggestions').hide();", 200);
}






function clookup(inputString) 
{
	if(inputString.length == 0) 
	{
		$('#csuggestions').hide();
	} 
	else 
	{
		$.post("Search_Vendorgroup.jsp", {queryString: ""+inputString+""}, function(data)
		{
			if(data.length >0) 
			{
				$('#csuggestions').show();
				$('#cautoSuggestionsList').html(data);
			}
		});
	}
}

  
function cfill(thisValue) 
{
	var listArray = thisValue.split("/");
	document.getElementById('name').value= listArray[0];
	
	 
	setTimeout("$('#csuggestions').hide();", 200);
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
	padding: 1px;
	cursor: pointer;
}

.suggestionList li:hover {
background-color: #99cc99;
}


.suggestionsBox1 
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
.suggestionList1 
{
	margin: 0px;
	padding: 0px;
}
.suggestionList1 li 
{
	margin: 0px 0px 3px 0px;
	padding: 3px;
	cursor: pointer;
}

.suggestionList1 li:hover {
background-color: #ffffff;
}
</style>

<body  onpaste='return false;'>
<form name="frm" action=" ../SmartLoginAuth" method="post" >
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<!--DWLayoutTable-->
	<tr>
	  <td height="34" align="center"><!--DWLayoutEmptyCell-->&nbsp;</td>
    </tr>
	<tr>
	  <td height="19" align="center"><!--DWLayoutEmptyCell-->&nbsp;</td>
    </tr>
	<tr>
		<td height="170" align="center"> <div align="center">
		  <table width="500"   border="0" align="center" cellpadding="1"
			cellspacing="1">
		    <tr>
		      <td  align="center" valign="middle">
			  <div align="center">
		        <table width="100%" border="0" align="center" cellpadding="0"
					cellspacing="0" bgcolor="#dce4f9" class="BackGround">
		          <tbody>
		            <tr>
		              <td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/TLCorner.gif" width="7" /></td>
                        <td class="BorderLine" height="1"><spacer height="1"
								width="1" type="block" /></td>
                        <td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/TRCorner.gif" width="7" /></td>
                      </tr>
		            <tr>
		              <td height="6"><spacer height="1" width="1" type="block" /></td>
                      </tr>
		            <tr>
		              <td class="BorderLine" width="1"><spacer height="1"
								width="1" type="block" /></td>
                        <td width="6"><spacer height="1" width="1" type="block" /></td>
                        <td width="350" valign="top"><table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                          <tr>
                            <td width="100%"><div align="center" class="copyright">COMPANY SETTINGS 
<%

String rowid="" , name="",address1="",address2="", city="";
String district="", state="",country="",pin="";
String phone="",fax="", email="",website="",googlelocation="";;
String sql ="";
sql = sql+ " SELECT  ";
sql = sql+ " INT_CPYID,CHR_NAME,CHR_ADDRESS1,CHR_ADDRESS2,INT_CITYID,INT_DISTRICTID,INT_STATEID, ";
sql = sql+ " INT_COUNTRYID,INT_PINCODE,CHR_PHONE,CHR_FAX,CHR_EMAIL,CHR_WEBSITE,CHR_USRNAME, ";
sql = sql+ " DT_UPDATEDATE,CHR_UPDATESTATUS,CHR_GOOGLELOCATION ";
sql = sql+ " FROM m_company WHERE INT_CPYID=1 ";
//out.println(sql);
String Data[][] =  CommonFunctions.QueryExecute(sql);
if(Data.length>0)
{
	rowid = Data[0][0];
	name = Data[0][1];
	address1 = Data[0][2];
	address2 = Data[0][3];
	city = Data[0][4];
	district = Data[0][5];
	state = Data[0][6];
	country = Data[0][7];
	pin = Data[0][8];
	phone = Data[0][9];
	fax = Data[0][10];
	email = Data[0][11];
	website = Data[0][12];
	googlelocation = Data[0][16]; 
}

%>
							
							</div></td>
                            </tr>
                          <tr>
                            <td><%= (session.getAttribute("COPYPAST").equals("Y") )?" ":" onpaste='return false;' "%>&nbsp;</td>
                            </tr>
                          <tr>
                            <td><div align="center">
                              <table width="100%" border="0" cellpadding="2" cellspacing="2" class="boldEleven">
                                <tr>
                                  <td width="25%" class="boldEleven">Name<font
																class="bolddeepred" align="absmiddle"> *</font></td>
                                  <td width="75%"><input name="name" type="text" class="formText135" id="name" value="<%=name%>" size="40" maxlength="50"></td>
                                  </tr>
                                <tr>
                                  <td class="boldEleven">Address 1 <font
																class="bolddeepred" align="absmiddle"> *</font></td>
                                  <td><input name="address1" type="text" class="formText135" id="address1" value="<%=address1%>" size="40" maxlength="50"></td>
                                  </tr>
                                <tr>
                                  <td class="boldEleven">Address 2 <font
																class="bolddeepred" align="absmiddle"> *</font></td>
                                  <td><input name="address2" type="text" class="formText135" id="address2" value="<%=address2%>" size="40" maxlength="50"></td>
                                  </tr>
                                <tr>
                                  <td class="boldEleven">City<font
																class="bolddeepred" align="absmiddle"> *</font></td>
                                  <td><span class="bolddeepblue">
                                    <select name="city" class="formText135" id="city" style="width:200" onChange="AssignPincode('pin')">
                                      <option value="0" selected="selected">Select City</option>
                                      <%
						
						 
							String cityData[][] =  CommonFunctions.QueryExecute("SELECT INT_CITYID,CHR_CITYNAME FROM com_m_city WHERE INT_DISTRICTID=" +district);
							if(cityData.length>0)
								for(int u=0;u<cityData.length;u++)
									out.print("<option value='"+cityData[u][0]+"'>"+cityData[u][1]+"</option>");
						 
					%>
                                    </select>
                                  </span></td>
                                  </tr>
                                <tr>
                                  <td class="boldEleven">District<font
																class="bolddeepred" align="absmiddle"> *</font></td>
                                  <td><span class="bolddeepblue">
                                    <select name="district" class="formText135" id="district" style="width:200" onChange=" LoadSelectCity(),resetPincode('pin')">
                                      <option value="0" selected="selected">Select District</option>
                                      <%
						
						 
							String districtData[][] =  CommonFunctions.QueryExecute("SELECT INT_DISTRICTID,CHR_DISTRICT FROM com_m_district WHERE INT_STATEID=" +state);
							if(districtData.length>0)
								for(int u=0;u<districtData.length;u++)
									out.print("<option value='"+districtData[u][0]+"'>"+districtData[u][1]+"</option>");
					 
					%>
                                    </select>
                                  </span></td>
                                  </tr>
                                <tr>
                                  <td class="boldEleven">State<font
																class="bolddeepred" align="absmiddle"> *</font></td>
                                  <td><select name="state" class="formText135" id="state" style="width:200" onChange="LoadSelectDistrict(),resetPincode('pin')">
                                    <option value="0" selected="selected">Select State</option>
                                    <%
						
						 
							String stateData[][] =  CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM com_m_state WHERE INT_COUNTRYID=" +country);
							if(stateData.length>0)
								for(int u=0;u<stateData.length;u++)
									out.print("<option value='"+stateData[u][0]+"'>"+stateData[u][1]+"</option>");
						 
					%>
                                  </select></td>
                                  </tr>
                                <tr>
                                  <td class="boldEleven">Country</td>
                                  <td><select name="country" class="formText135" id="country" style="width:200" onChange="LoadSelectState(),resetPincode('pin')">
                                    <option value="0">Select Country</option>
                                    <%
	 		String readData[][]=  CommonFunctions.QueryExecute("SELECT INT_COUNTRYID ,CHR_COUNTRYNAME FROM  com_m_country ORDER BY CHR_COUNTRYNAME");
			for(int i=0;i<readData.length;i++)
				out.println("<option value='"+readData[i][0]+"'>"+readData[i][1]+"</option>");
	 %>
                                  </select></td>
                                  </tr>
                                <tr>
                                  <td class="boldEleven">Pin Code<font
																class="bolddeepred" align="absmiddle"> *</font></td>
                                  <td>
								  <input name="pin" type="text" class="formText135" id="pin" onKeyPress="return numeric_only(event,'pin','7') "    onKeyUp="lookup(this.value);" value="<%=pin%>" size="10" 									maxlength="6" />
                          <br />
                          <div class="suggestionsBox" id="suggestions" style="display: none;width:150%;">
                            <div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:200px" ></div>
                          </div>								  </td>
                                  </tr>
                                <tr>
                                  <td class="boldEleven">Phone<font
																class="bolddeepred" align="absmiddle"> *</font></td>
                                  <td><input
									name="phone" type="text" class="formText135" id="phone"
									onKeyPress="return numeric_only(event,'phone','12')" value="<%=phone%>"
									size="26" maxlength="14"></td>
                                  </tr>
                                <tr>
                                  <td class="boldEleven">Fax</td>
                                  <td><input name="fax" type="text"
									class="formText135" id="fax" onKeyPress="return numeric_only(event,'fax','17')" value="<%=fax%>" size="40" maxlength="14"></td>
                                  </tr>
                                <tr>
                                  <td class="boldEleven">Mail id </td>
                                  <td><input name="email"
									type="email" class="formText135" id="email" value="<%=email%>" size="40"
									maxlength="50" ></td>
                                  </tr>
                                <tr>
                                  <td class="boldEleven">Website</td>
                                  <td><input name="website"
									type="text" class="formText135" id="website" value="<%=website%>" size="40"
									maxlength="45"></td>
                                  </tr>
                                <tr>
                                  <td class="boldEleven">google Location </td>
                                  <td><input name="googlelocation"
									type="text" class="formText135" id="googlelocation" value="<%=googlelocation%>" size="40"
									maxlength="45"></td>
                                </tr>
                                <tr>
                                  <td class="boldEleven">&nbsp;</td>
                                  <td>
								  
<script language="javascript">
 	setOptionValue('city','<%=city%>');
	setOptionValue('district','<%=district%>');
	setOptionValue('state','<%=state%>');
	setOptionValue('country','<%=country%>');
	 
	
</script> 

								  <input name="filename"
									type="hidden" value="Company" />
                                  <input name="actionS"
									type="hidden" value="UTICompany" />
                                  <input name="rowid" type="hidden" id="rowid" value="<%=rowid%>"></td>
                                  </tr>
                              </table>
                              </div></td>
                            </tr>
                          <tr>
                            <td></td>
                            </tr>
                          <tr>
                            <td height="28">
                              <center>
                                <table border="0" align="center" cellpadding="1"
										cellspacing="1">
                                  <tr>
                                    <td width="56"><input name="Submit2" type="submit"
												class="buttonbold" value="Submit"   accesskey="s"   ></td>
                                      <td width="56"><input class="buttonbold" type="button"
												name="Submit2"  value="Close"   accesskey="c"  onClick="redirect('Userframe.jsp')"></td>
                                    </tr>
                                  </table>
					          </center>						  </td>
                            </tr>
                        </table></td>
                        <td nowrap="nowrap" width="6"><spacer height="1" width="1"
								type="block" /></td>
                        <td width="1" class="BorderLine"><spacer height="1"
								width="1" type="block" /></td>
                      </tr>
		            <tr>
		              <td colspan="2" rowspan="2"><img height="7"
								src="../Image/General/BLCorner.gif" width="7" /></td>
                        <td height="6"><spacer height="1" width="1" type="block" /></td>
                        <td colspan="2" rowspan="2" valign="bottom"><div align="right"><img height="7"
								src="../Image/General/BRCorner.gif" width="7" /></div></td>
                      </tr>
		            <tr>
		              <td class="BorderLine" height="1"></td>
                      </tr>
		            </tbody>
		          </table>
              </div></td>
            </tr>
          </table>
	  </div></td>
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