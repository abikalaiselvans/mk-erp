 <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
<%
try
{
	CommonFunctions.lockCheckDOB(request);
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
<meta name="copyright" content="Copyright (c)2006-2011 KALAISELVAN K. All Rights Reserved." />
<meta name="description" content="Office Automation ERP Products." />
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor group, customer group, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />


<title> :: COMMON ::</title>







<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<script language="JavaScript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/common/PermanentSelectChangesCountry.js"></script>
<script language="javascript" src="../JavaScript/common/communicationSelectChangesCountry.js"></script>

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
				 && checkNull('cadd1','Enter communication  Address1')
				 && checkNull('cadd2','Enter communication  Address2')
				 && checkNullSelect('ccity','Select communication  City Name','0')
				 && checkNullSelect('cdistrict','Select  communication  District  Name','0')
				 && checkNullSelect('cstate','Select  communication  State  Name','0')
				 && checkNullSelect('ccountry','Select  communication  Country  Name','0')
				 && checkNull('cpincode','Enter communication Pincode ')
				 
				 
		)
		  {
		  	alert("Please confirm your name & Address must match with your proof of address document.");
			var name=confirm("Confirm, All the informations are correct") 
		  	if (name==true) 
				return true;
		  	else
		  		return false;	   
		  }
   	 else
		   return false;	  
}	
   
   
   

 
 </script>
 
 

 
<body  onpaste='return false;'>
<%
try
{

%>

<form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return validateFields()">
<br>
<br><br><br>
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
									class="boldThirteen">Address Information
									
<%
String sql="";
String SData[][]= CommonFunctions.QueryExecute("select CHR_ADDRESSSTATUS from com_m_staff where CHR_EMPID='"+session.getAttribute("EMPID")+"'");


boolean f= false; 
if("Y".equals(application.getAttribute("LOGINMAILCHECKED").toString()))
{
	if("Y".equals(SData[0][0]))
		f= true; 
}
else
{
 if("Y".equals(SData[0][0]))
		f= true; 
		
}

String redirect = "../"+session.getAttribute("PAGE");
 

if(f)
{
	 response.sendRedirect(""+redirect);
}



String dbvalue="";
sql = "SELECT a.CHR_EMPID,a.CHR_STAFFNAME,a.CHR_PADD1,a.CHR_PADD2,a.CHR_PCITY,a.INT_PDISTRICTID, a.CHR_PSTATE, ";
sql = sql + " a.INT_PCOUNTRYID,a.CHR_PPIN,a.CHR_PPHONE,a.CHR_SADD1, a.CHR_SADD2,a.CHR_SCITY,a.INT_CDISTRICTID, ";
sql = sql + " a.CHR_SSTATE,a.INT_CCOUNTRY,a.CHR_SPIN,a.CHR_SPHONE,a.CHR_EMAILID, a.CHR_PERMAILID,a.CHR_MOBILE, ";
sql = sql + " DATE_FORMAT(a.DT_ACTUAL_DOB,'%d-%m-%Y'),a.INT_CCOUNTRY, ";
sql = sql + " b.CHR_GROUPNAME,FIND_A_BANKGROUP_NAME(a.CHR_BANK),a.CHR_ACCNO,a.CHR_IFSC,DATE_FORMAT(a.DT_DOB,'%d-%m-%Y') ";
sql = sql + " FROM com_m_staff a , com_m_bloodgroup b ";
sql = sql + " WHERE  a.CHR_BG  = b.INT_BLOODGROUPID ";
sql = sql + " AND  a.CHR_EMPID = '"+session.getAttribute("EMPID")+"'";
//out.println(sql);
String Data[][]=  CommonFunctions.QueryExecute(sql);

if(Data.length>0)
	for(int u=0;u<21;u++)
		if("null".equals(Data[0][u].trim()) || "".equals(Data[0][u].trim()) || "-".equals(Data[0][u].trim()))
			Data[0][u]="0";
			
			
%> 			</td>
            </tr>
            <tr>
              <td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory </span>
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
                                    
<script language="JavaScript" src="../JavaScript/jquery/jquery-1.7.1.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.core.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.widget.js" type="text/javascript"></script>
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
		$.post("pincodes.jsp", {queryString: ""+inputString+""}, function(data)
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
	setOptionValue('pcountry',listArray[0]);
	
	var _targ=document.getElementsByName('pstate')[0];       
	 _targ.options.length=0;
	 _targ.options[0]=new Option(listArray[3],listArray[2]);  

	var _targ1=document.getElementsByName('pdistrict')[0];       
	 _targ1.options.length=0;
	 _targ1.options[0]=new Option(listArray[5],listArray[4]);  
	 
	 
	var _targ2=document.getElementsByName('pcity')[0];       
	 _targ2.options.length=0;
	 _targ2.options[0]=new Option(listArray[7],listArray[6]);  
	 
	 
	document.getElementById('ppincode').value=listArray[8];
	
	$('#ppincode').val(listArray[8]);
	setTimeout("$('#suggestions').hide();", 200);
}




function cfill(thisValue) 
{
	var listArray = thisValue.split("/");
	setOptionValue('ccountry',listArray[0]);
	
	var _targ=document.getElementsByName('cstate')[0];       
	 _targ.options.length=0;
	 _targ.options[0]=new Option(listArray[3],listArray[2]);  

	var _targ1=document.getElementsByName('cdistrict')[0];       
	 _targ1.options.length=0;
	 _targ1.options[0]=new Option(listArray[5],listArray[4]);  
	 
	 
	var _targ2=document.getElementsByName('ccity')[0];       
	 _targ2.options.length=0;
	 _targ2.options[0]=new Option(listArray[7],listArray[6]);  
	 
	 
	document.getElementById('cpincode').value=listArray[8];
	
	$('#cpincode').val(listArray[8]);
	setTimeout("$('#suggestions1').hide();", 200);
}

function clookup(inputString) 
{
	if(inputString.length == 0) 
	{
		$('#suggestions1').hide();
	} 
	else 
	{
		$.post("cpincodes.jsp", {queryString: ""+inputString+""}, function(data)
		{
			if(data.length >0) 
			{
				$('#suggestions1').show();
				$('#autoSuggestionsList1').html(data);
			}
		});
	}
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
</style>                                    </td>
            </tr>
             
             
             <tr>
               <td height="23" colspan="2" class="bolddeepred"><div align="center">
                  
                 Hi&nbsp;&nbsp;&nbsp;&nbsp;<font class="bolddeepred"><%=Data[0][1] + " / " +Data[0][0] %></font> <br>
                 </div></td>
             </tr>
             <tr>
                  <td height="23" colspan="2" class="bolddeepred"> <div align="center">Please confirm your name & Address must match with your proof of address document....</div></td>
              </tr>
             
            <tr>
              <td height="17" colspan="3" class="boldEleven"><table width="100%" border="0" align="center" cellpadding="2"
												cellspacing="2">
                 
				
				
				
                <tr>
                  <td width="50%" height="210"><table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
                      <tr>
                        <td height="15" colspan="2"><div align="center" class="bold1">Permanent
                          Address</div></td>
                      </tr>
                      <tr>
                        <td class="boldEleven">&nbsp;</td>
                        <td width="161" class="boldEleven">&nbsp;</td>
                      </tr>
                      <tr>
                        <td width="97" class="boldEleven">Address1<font class="bolddeepred"
																align="absmiddle">*</font>
                            <%
									dbvalue=Data[0][2].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>                        </td>
                        <td class="boldEleven"><input name="padd1" 
																type="text" class="formText135" id="padd1"
																onKeyPress="isAddress('padd1','50')" value="<%=dbvalue%>"
																size="30" maxlength="50" /></td>
                      </tr>
                      <tr>
                        <td class="boldEleven">Address2<font class="bolddeepred"
																align="absmiddle">*</font>
                            <%
									dbvalue=Data[0][3].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>                        </td>
                        <td class="boldEleven"><input name="padd2"
																type="text" class="formText135" id="padd2"
																onKeyPress="isAddress('padd2','50')" value="<%=dbvalue%>"
																size="30" maxlength="50" /></td>
                      </tr>
                      <tr>
                        <td class="boldEleven">Country<font class="bolddeepred"
																align="absmiddle">*</font></td>
                        <td class="boldEleven"><select class="formText135" name="pcountry" id="pcountry" style="width:170" onChange="PLoadSelectState()">
                            <option value="0">Select Country</option>
                            <%
	 		String creadData[][]=  CommonFunctions.QueryExecute("SELECT INT_COUNTRYID ,CHR_COUNTRYNAME FROM  com_m_country ORDER BY CHR_COUNTRYNAME");
			for(int i=0;i<creadData.length;i++)
				out.println("<option value='"+creadData[i][0]+"'>"+creadData[i][1]+"</option>");
	 %>
                          </select>
                            <script language="javascript">setOptionValue('pcountry','<%=Data[0][7].trim()%>')</script>                        </td>
                      </tr>
                      <tr>
                        <td class="boldEleven">State <font class="bolddeepred"
																align="absmiddle">*</font></td>
                        <td class="boldEleven"><select  class="formText135" name="pstate" id="pstate" style="width:170" onChange="PLoadSelectDistrict()">
                            <option value="0" selected="selected">Select State</option>
                            <%
String	stateData[][]= CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM com_m_state WHERE INT_COUNTRYID ="+Data[0][7].trim()+" ORDER BY CHR_STATENAME");
for(int u=0;u<stateData.length;u++)
	out.println("<option value='"+stateData[u][0]+"'>"+stateData[u][1]+"</option>");
																	%>
                          </select>
                            <script language="javascript">setOptionValue('pstate','<%=Data[0][6].trim()%>')</script>                        </td>
                      </tr>
                       <tr>
                        <td class="boldEleven">District<font class="bolddeepred"
																align="absmiddle">*</font></td>
                        <td class="boldEleven"><select name="pdistrict" id="pdistrict"  class="formText135" style="width:170" onChange=" PLoadSelectCity()">
                            <option value="0" selected="selected">Select District</option>
                            <%
String	districtData[][]= CommonFunctions.QueryExecute("SELECT INT_DISTRICTID,CHR_DISTRICT  FROM com_m_district WHERE  INT_STATEID="+Data[0][6].trim()+"  ORDER BY CHR_DISTRICT  ");
for(int u=0;u<districtData.length;u++)
	out.println("<option value='"+districtData[u][0]+"'>"+districtData[u][1]+"</option>");
															  %>
                          </select>
                            <script language="javascript">setOptionValue('pdistrict','<%=Data[0][5].trim()%>')</script>                        </td>
                      </tr>
                      <tr>
                        <td class="boldEleven">City <font class="bolddeepred"
																align="absmiddle">*
                          <%
									dbvalue=Data[0][4].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase("") ||dbvalue.equalsIgnoreCase("-"))
										dbvalue="0";
									%>
                        </font></td>
                        <td class="boldEleven"><select name="pcity" id="pcity"  class="formText135" style="width:170" onChange="PAssignPincode('ppincode')">
                            <option value="0" selected="selected">Select City</option>
                            <%


String cityData[][] =  CommonFunctions.QueryExecute("SELECT INT_CITYID,CHR_CITYNAME FROM com_m_city WHERE INT_DISTRICTID=" +Data[0][5].trim());
if(cityData.length>0)
for(int u=0;u<cityData.length;u++)
	out.print("<option value='"+cityData[u][0]+"'>"+cityData[u][1]+"</option>");

%>
                          </select>
                            <script language="javascript">setOptionValue('pcity','<%=Data[0][4].trim()%>')</script>                        </td>
                      </tr>
                      
                      
                      
                      <tr>
                        <td class="boldEleven">Pin Code<font class="bolddeepred"
																align="absmiddle">*</font>
                            <%
									dbvalue=Data[0][8].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>                        </td>
                        <td class="boldEleven"> 
                                              <input name="ppincode" type="text" class="formText135" id="ppincode" onKeyPress="return numeric_only(event,'ppincode','8'),fill()" size="30" 	 value="<%=dbvalue%>" 	 maxlength="7"    onKeyUp="lookup(this.value);"  tabindex="34" required/>
	<br />
		<div class="suggestionsBox" id="suggestions" style="display: none;width:150%;">
					<div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:200px" ></div>
		</div>                  
                            <td class="boldEleven">                            </td>
                      </tr>
                      
                      <tr>
                        <td class="boldEleven">Phone No<font class="bolddeepred"
																align="absmiddle">*</font>
                            <%
									dbvalue=Data[0][9].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>                        </td>
                        <td class="boldEleven"><input name="pphone"
																type="text" class="formText135" id="pphone" value="<%=dbvalue%>" 
																onKeyPress="return numeric_only(event,'pphone','10')" size="30"
																maxlength="12" />                        </td>
                      </tr>
                      <tr>
                        <td class="boldEleven">Per. E-mail</td>
                        <td><input name="peremailid" type="email" value="<%=Data[0][19]%>"
																class="formText135" id="peremailid" size="30"
																  maxlength="100" /></td>
                      </tr>
					  <tr>
                        <td class="boldEleven">&nbsp;</td>
					    <td>&nbsp;</td>
					    </tr>
					   
                  </table></td>
                  <td width="50%"><table width="100%" border="0" align="center"
														cellpadding="1" cellspacing="2">
                      <tr>
                        <td colspan="2" class="bold1"><div align="center">Communication
                          Address</div></td>
                      </tr>
                      <tr>
                        <td class="boldEleven">&nbsp;</td>
                        <td width="166" class="boldEleven">						 																</td>
                      </tr>
                      <tr>
                        <td width="101" class="boldEleven">Address1
                          <%
									dbvalue=Data[0][10].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>                        </td>
                        <td class="boldEleven"><input name="cadd1"
																type="text" class="formText135" id="cadd1"
																onKeyPress="isAddress('cadd1','50')" value="<%=dbvalue%>"
																size="30" maxlength="50" /></td>
                      </tr>
                      <tr>
                        <td class="boldEleven">Address2
                          <%
									dbvalue=Data[0][11].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>                        </td>
                        <td class="boldEleven"><input name="cadd2"
																type="text" class="formText135" id="cadd2"
																onKeyPress="isAddress('cadd2','50')" value="<%=dbvalue%>"
																size="30" maxlength="50" /></td>
                      </tr>
                     <tr>
                        <td class="boldEleven">Country</td>
                        <td class="boldEleven"><select name="ccountry"  class="formText135" id="ccountry" style="width:170" onChange="CLoadSelectState()">
                            <option value="0">Select Country</option>
                            <%
	 		for(int i=0;i<creadData.length;i++)
				out.println("<option value='"+creadData[i][0]+"'>"+creadData[i][1]+"</option>");
	 %>
                          </select>
                            <script language="javascript">setOptionValue('ccountry','<%=Data[0][15].trim()%>')</script>                        </td>
                      </tr>
                      <tr>
                        <td class="boldEleven">State </td>
                        <td class="boldEleven"><select  class="formText135" name="cstate" id="cstate" style="width:170" onChange="CLoadSelectDistrict()">
                            <option value="0" selected="selected">Select State</option>
                            <%
String	stateData1[][]= CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM com_m_state WHERE INT_COUNTRYID ="+Data[0][15].trim()+" ORDER BY CHR_STATENAME");
for(int u=0;u<stateData1.length;u++)
	out.println("<option value='"+stateData1[u][0]+"'>"+stateData1[u][1]+"</option>");
																	%>
                          </select>
                            <script language="javascript">setOptionValue('cstate','<%=Data[0][14].trim()%>')</script>                        </td>
                      </tr>
                      <tr>
                        <td class="boldEleven">District</td>
                        <td class="boldEleven"><select  class="formText135" name="cdistrict" id="cdistrict" style="width:170" onChange=" CLoadSelectCity()">
                            <option value="0" selected="selected">Select District</option>
                            <%
String	districtData1[][]= CommonFunctions.QueryExecute("SELECT INT_DISTRICTID,CHR_DISTRICT  FROM com_m_district WHERE  INT_STATEID="+Data[0][14].trim()+"  ORDER BY CHR_DISTRICT  ");
for(int u=0;u<districtData1.length;u++)
	out.println("<option value='"+districtData1[u][0]+"'>"+districtData1[u][1]+"</option>");
															  %>
                          </select>
                            <script language="javascript">setOptionValue('cdistrict','<%=Data[0][13].trim()%>')</script>                        </td>
                      </tr>
                      <tr>
                        <td class="boldEleven">City </td>
                        <td class="boldEleven"><select  class="formText135" name="ccity" id="ccity" style="width:170" onChange="CAssignPincode('cpincode')">
                            <option value="0" selected="selected">Select City</option>
                            <%


String cityData1[][] =  CommonFunctions.QueryExecute("SELECT INT_CITYID,CHR_CITYNAME FROM com_m_city WHERE INT_DISTRICTID=" +Data[0][13].trim());
if(cityData1.length>0)
for(int u=0;u<cityData1.length;u++)
	out.print("<option value='"+cityData1[u][0]+"'>"+cityData1[u][1]+"</option>");

%>
                          </select>
                            <script language="javascript">setOptionValue('ccity','<%=Data[0][12].trim()%>')</script>                        </td>
                      </tr>
                      
                      
                      
                      
                      <tr>
                        <td class="boldEleven">Pin Code
                          <%
									dbvalue=Data[0][16].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>                        </td>
                        <td class="boldEleven"> 

<input name="cpincode" type="text" class="formText135" id="cpincode" onKeyPress="return numeric_only(event,'cpincode','8'),cfill()" size="30" maxlength="7"  onKeyUp="clookup(this.value);"  tabindex="43" value="<%=dbvalue%>" required/>

  <div class="suggestionsBox1" id="suggestions1" style="display: none;width:150%;">
					<div class="suggestionList1" id="autoSuggestionsList1" style="OVERFLOW:auto;width:100%;height:200px" ></div>
</div>                            </td>
                      </tr>
                      <tr>
                        <td class="boldEleven">Phone No
                          <%
									dbvalue=Data[0][17].trim();
									if (dbvalue.equalsIgnoreCase("null") ||dbvalue.equalsIgnoreCase(""))
										dbvalue="";
									%>                        </td>
                        <td class="boldEleven"><input name="cphone"
																type="text" class="formText135" id="cphone"
																onKeyPress="return numeric_only(event,'cphone','10')"
																value="<%=dbvalue%>" size="30" maxlength="25" /></td>
                      </tr>
					  <tr>
                        <td class="boldEleven">&nbsp;</td>
                        <td class="boldEleven">&nbsp;</td>
                      </tr>
					  <tr>
                        <td class="boldEleven">Actual Date of Birth </td>
					    <td> <%=Data[0][21]%> </td>
					    </tr>
                  </table></td>
                </tr>
              </table></td>
              </tr>
            <tr>
              <td height="17" colspan="3" class="boldEleven"><table width="100%" border="0" class="boldEleven">
                <tr>
                  <td width="13%">Off. E.Mail</td>
                  <td width="37%"><input name="emailid" type="text" value="<%=Data[0][18]%>"
																class="formText135" id="emailid" size="30"
																 maxlength="100" /></td>
                  <td width="15%">Mobile</td>
                  <td width="35%"><input name="mobile" type="text" value="<%=Data[0][20]%>" class="formText135" id="mobile"  onKeyPress=" return numeric_only(event,'mobile','12')"  size="30"
																maxlength="10" /></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td height="17" colspan="3" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
            </tr>
            <tr>
              <td height="17" colspan="3" class="boldEleven"><table width="508" border="0" align="center" cellpadding="0" cellspacing="8" class="formTableOuterDesign">
                 
                <tr>
                  <td width="166" class="whiteHead"><div align="left">Blood Group </div></td>
                  <td width="117" class="whiteMedium"><%=Data[0][23]%></td>
                  <td width="90" class="whiteHead"><div align="left">Bank</div></td>
                  <td width="251" class="whiteMedium"><%=Data[0][24]%></td>
                </tr>
                <tr>
                  <td class="whiteHead"><div align="left">IFSC Code </div></td>
                  <td class="whiteMedium"><%=Data[0][26]%></td>
                  <td class="whiteHead"><div align="left">A/c No </div></td>
                  <td class="whiteMedium"><%=Data[0][25]%></td>
                </tr>
              </table></td>
            </tr>
            <tr>
              <td height="17" colspan="3" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
            </tr>
            <tr>
              <td height="17" colspan="3" class="boldEleven"><div align="center" class="copyright">Copy
                    Permanent to Communication Address
                    <input onClick="return resoffval()" type="radio"
														value="yes" name="res">
                    Yes
                    <input name="res"
														type="radio" onClick="return resoffval()" value="no">
                    No </div></td>
              </tr>
            <tr>
              <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
              <td colspan="2" align="left"> <input name="filename" type="hidden" id="filename"
										value="StaffRegistration">
                <input name="actionS"
										type="hidden" id="actionS" value="GENADDRESSUPDATION">
                <input name="empid" type="hidden" id="empid" value="<%=Data[0][0]%>"></td>
            </tr>
            <tr>
              <td height="17" colspan="3" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                <tr>
                  <td> <input name="Submit" type="submit" class="buttonbold"
											value="Submit"  ></td>
                  <td><input name="close" type="button" id="close"  value="Close"   accesskey="c"  class="buttonbold" onClick="redirect('../Logout.jsp')"></td>
                  </tr>
              </table></td>
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
	System.out.println(e.getMessage());
	
	 
}
%>
</body>
</html>
<%

}
catch(Exception e)
{
	out.println(e.getMessage());
	
	 
}
%>
