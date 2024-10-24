<%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.*, com.my.org.erp.ServiceLogin.*"%>
<%
try
{
	String dojlock =CommonFunctions.QueryExecute("SELECT CHR_DOJLOCK FROM M_INSTITUTION  WHERE INT_ID=1")[0][0];

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
 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>

<script language="javascript" src="../JavaScript/Inventory/InvenAJAX.js"></script>
<script language="javascript" src="../JavaScript/Inventory/InventAJAX.js"></script>

<script language="javascript" src="../JavaScript/common/SelectChangesCountry.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>

 

<script language="JavaScript" src="../JavaScript/jquery/jquery-1.7.1.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.core.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.widget.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.datepicker.js" type="text/javascript"></script>


<script language="javascript">

var d1=new Date();
var day1=d1.getDate();	
var dojlock= "<%=dojlock%>";
 
	

$(function() {
		$( "#doh" ).datepicker({
			changeMonth: true,
			changeYear: true,
			minDate: -dojlock, 
			maxDate: "+0D" ,
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
	
	 $('#csuggestions').hide();
	//setTimeout("$('#csuggestions').hide();", 200);
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


<script language="JavaScript">
 function valid()
  {

	try
	{   	
		if(
			checkNull( "name","Enter Vendor Name " )
			&& checkNull( "address1","Enter Address - 1" )
			&& checkNull( "address2","Enter Address - 2" )
			&& checkNullSelect( "country","Select Country" ,'0')
			&& checkNullSelect( "state","Select State" ,'0')
			&& checkNullSelect( "district","Select District" ,'0')
			&& checkNullSelect( "city","Select City" ,'0')
			&& checkNull( "pin","Enter pincode" )
			&& chkemail("email")
			&& checkNull( "climit","Enter Credit Limit" )
			&& checkNullSelect("vendorgroup","Select Vendor Group","0")	
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
 	
	
	
	
</script>






<script type="text/javascript">
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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="500"
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
									class="boldThirteen">Vendor Information
									
<%
String action=request.getParameter("action1");
String id="",actionS="INVVendorInfoAdd",value="";
String sql="";
String link="";
String name="",cperson="",address1="",address2="";
String country="0",state="0",district="0",city="0",pin="";
String area="",phone="",mobile="",fax="",email="";
String website="",doh="",bank="0",accno="",vendorgroup="0",tin="",cst="",pan="",gst="";
String climit="200000";
String status=" checked ";
if("Add".equals(action))
{
	id="";status="";
	name="";cperson="";address1="";address2="";
	country="0";state="";district="0";city="0";pin="";
	area="";phone="";mobile="";fax="";email="";
	website="";doh="";bank="1";accno="";vendorgroup="0";tin="";cst="";gst="";pan="";
	climit="200000";status=" checked  ";
	actionS="INVVendorInfoAdd";
	value="Add";
	link=" onBlur=\" CheckUnique(this,'divunitname','inv_m_vendorsinformation','CHR_VENDORNAME') \"  onKeyUp=\"upperMe(this),lookup(this.value),CheckUnique(this,'divunitname','inv_m_vendorsinformation','CHR_VENDORNAME'),fill()\" ";
	
}
else
{
	id="";name=""; 
	id=request.getParameter("rowid");
	sql = " SELECT ";
	sql = sql +"  INT_VENDORID,CHR_VENDORNAME,CHR_CONTACTPERSON,CHR_ADDRESS1,CHR_ADDRESS2, ";
	sql = sql +"  INT_CITYID,INT_DISTRICTID,INT_STATEID,INT_COUNTRYID,INT_PINCODE, ";
	sql = sql +"  CHR_AREACODE,CHR_PHONE,CHR_MOBILE,CHR_FAX,CHR_EMAIL,CHR_WEBSITE, ";
	sql = sql +"  INT_ACTIVE,CHR_ACCNO,INT_BANKGROUPID,DOU_BALANCE, ";
	sql = sql +"  DATE_FORMAT(DAT_BALANCEASOF,'%d-%m-%Y'), ";
	sql = sql +"  INT_GROUPID,CHR_TINNO,CHR_CSTNO,CHR_PANNO,CHR_GSTNO,CHR_USRNAME,DT_UPDATEDATE,CHR_UPDATESTATUS ";
	sql = sql +"  FROM inv_m_vendorsinformation  WHERE INT_VENDORID="+id;
	String data[][]=CommonFunctions.QueryExecute(sql);
	if(data.length>0)
		for(int i=0;i<25;i++)
			if("-".equals(data[0][i]))
				data[0][i] ="";
	id=data[0][0];
	name=data[0][1];
	cperson=data[0][2];
	address1=data[0][3];
	address2=data[0][4];
	city=data[0][5];
	district=data[0][6];
	state=data[0][7];
	country=data[0][8];
	
	
	
	
	pin=data[0][9];
	area=data[0][10];
	phone=data[0][11];
	mobile=data[0][12];
	fax=data[0][13];
	email=data[0][14];
	website=data[0][15];
	if("1".equals(data[0][16]))
		status=" checked ='checked'";

	accno=data[0][17];
	bank=data[0][18];
	climit=data[0][19];
	if(!"-".equals(data[0][20]))
		doh=data[0][20];
	vendorgroup=data[0][21];
	tin=data[0][22];
	cst=data[0][23];
	pan=data[0][24];
	gst=data[0][25];
	actionS="INVVendorInfoUpdate";
	value="Update";
	link=" onBlur=\" CheckUnique(this,'divunitname','inv_m_vendorsinformation','CHR_VENDORNAME') \"  onKeyUp=\" CheckUnique(this,'divunitname','inv_m_vendorsinformation','CHR_VENDORNAME'),cfill()\" ";
	
}

%>									</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							<tr>
								<td width="98" height="17" class="boldEleven">Vendor Name <span
									class="bolddeepred">* </span></td>
								<td width="288" colspan="2" align="left"><input name="name" type="text"
									class="formText135" id="name"
									   onBlur="upperMe(this)"    value="<%=name%>" size="40" onKeyUp="clookup(this.value);"  maxlength="50" <%=link%>   >
						
						 

  <div class="suggestionsBox1" id="csuggestions" style="display: none;width:150%;">
					<div class="suggestionList1" id="cautoSuggestionsList" style="OVERFLOW:auto;width:100%;height:50px" ></div>
</div>				
		
								
			 
				<br>
				<div id='divunitname'></div>								 														</td>
							</tr>
							 
							<tr>
							  <td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="2" align="left"><!--DWLayoutEmptyCell-->&nbsp;</td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven">Contact Person</td>
								<td colspan="2" align="left"><input name="cperson"
									type="text" class="formText135" id="cperson"     onBlur="upperMe(this)"      value="<%=cperson%>"
									size="40" maxlength="50"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Address 1 <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="address1"
									type="text" class="formText135" id="address1"     onBlur="upperMe(this)"      value="<%=address1%>"
									size="40" maxlength="50"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Address 2 <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="address2"
									type="text" class="formText135" id="address2"     onBlur="upperMe(this)"      value="<%=address2%>"
									size="40" maxlength="50"></td>
							</tr>
							<tr>
							  <td class="boldEleven">Country<span class="bolddeepred"> * </span></td>
							  <td colspan="2" align="left"><select name="country" class="formText135" id="country" style="width:300" onChange="LoadSelectState(),resetPincode('pin')">
                                <option value="0">Select Country</option>
                                <%
	 		String readData[][]=  CommonFunctions.QueryExecute("SELECT INT_COUNTRYID ,CHR_COUNTRYNAME FROM  com_m_country ORDER BY CHR_COUNTRYNAME");
			for(int i=0;i<readData.length;i++)
				out.println("<option value='"+readData[i][0]+"'>"+readData[i][1]+"</option>");
	 %>
                              </select></td>
						  </tr>
							<tr>
							  <td class="boldEleven">State<span class="bolddeepred"> * </span></td>
							  <td colspan="2" align="left"><select name="state" class="formText135" id="state" style="width:300" onChange="LoadSelectDistrict(),resetPincode('pin')">
                                <option value="0" selected="selected">Select State</option>
                                <%
						
						if(!"Add".equals(action))
	  					{
							String stateData[][] =  CommonFunctions.QueryExecute("SELECT INT_STATEID,CHR_STATENAME FROM com_m_state WHERE INT_COUNTRYID=" +country);
							if(stateData.length>0)
								for(int u=0;u<stateData.length;u++)
									out.print("<option value='"+stateData[u][0]+"'>"+stateData[u][1]+"</option>");
						}
					%>
                              </select></td>
						  </tr>
							<tr>
							  <td valign="top" class="boldEleven">District<span class="bolddeepred"> * </span></td>
							  <td colspan="2" align="left"><span class="bolddeepblue">
							    <select name="district" class="formText135" id="district" style="width:300" onChange=" LoadSelectCity(),resetPincode('pin')">
                                  <option value="0" selected="selected">Select District</option>
                                  <%
						
						if(!"Add".equals(action))
	  					{
							String districtData[][] =  CommonFunctions.QueryExecute("SELECT INT_DISTRICTID,CHR_DISTRICT FROM com_m_district WHERE INT_STATEID=" +state);
							if(districtData.length>0)
								for(int u=0;u<districtData.length;u++)
									out.print("<option value='"+districtData[u][0]+"'>"+districtData[u][1]+"</option>");
						}
					%>
                                </select>
							  </span></td>
						  </tr>
							<tr>
							  <td valign="top" class="boldEleven">City<span class="bolddeepred"> *</span></td>
							  <td colspan="2" align="left"><span class="bolddeepblue">
							    <select name="city" class="formText135" id="city" style="width:300" onChange="AssignPincode('pin')">
                                  <option value="0" selected="selected">Select City</option>
                                  <%
						
						if(!"Add".equals(action))
	  					{
							String cityData[][] =  CommonFunctions.QueryExecute("SELECT INT_CITYID,CHR_CITYNAME FROM com_m_city WHERE INT_DISTRICTID=" +district);
							if(cityData.length>0)
								for(int u=0;u<cityData.length;u++)
									out.print("<option value='"+cityData[u][0]+"'>"+cityData[u][1]+"</option>");
						}
					%>
                                </select>
							    <%
	 if(!"Add".equals(action))
	  {
	  %>
                                <script language="JavaScript" type="text/javascript">
	   		setOptionValue('country',"<%=country%>");
			setOptionValue('state',"<%=state%>");
			setOptionValue('district',"<%=district%>");
			setOptionValue('city',"<%=city%>");
			
	 
   		                        </script>
                                <%	
	  }
	  %>
</span></td>
						  </tr>
							<tr>
							  <td valign="top" class="boldEleven">Postal<span class="bolddeepred"> * </span></td>
							  <td colspan="2" align="left"><input name="pin" type="text" class="formText135" id="pin" onKeyPress="return numeric_only(event,'pin','7') "    onKeyUp="lookup(this.value);" value="<%=pin%>" size="10" 									maxlength="6" />
                          <br />
                          <div class="suggestionsBox" id="suggestions" style="display: none;width:150%;">
                            <div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:200px" ></div>
                          </div>									  </td>
						  </tr>
							 
							<tr>
								<td height="17" class="boldEleven">Phone</td>
								<td colspan="2" align="left"><input name="area" type="text"
									class="formText135" id="area"
									onKeyPress="return numeric_only(event,'area','12')" value="<%=area%>" size="10" maxlength="6"> 
								<input
									name="phone" type="text" class="formText135" id="phone"
									onKeyPress="return numeric_only(event,'phone','12')" value="<%=phone%>"
									size="26" maxlength="8"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">mobile</td>
								<td colspan="2" align="left"><input name="mobile"
									type="text" class="formText135" id="mobile" onKeyPress="return numeric_only(event,'mobile','12')" value="<%=mobile%>"
									size="40" maxlength="10"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Fax</td>
								<td colspan="2" align="left"><input name="fax" type="text"
									class="formText135" id="fax" onKeyPress="return numeric_only(event,'fax','17')" value="<%=fax%>" size="40" maxlength="10"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Email</td>
								<td colspan="2" align="left"><input name="email"
									type="email" class="formText135" id="email" value="<%=email%>" size="40"
									maxlength="50" ></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Website URL </td>
								<td colspan="2" align="left"><p>
						          <input name="website"
									type="text" class="formText135" id="website" value="<%=website%>" size="40"
									maxlength="45">
								</p>
							    <p>&nbsp;</p></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Date</td>
								<td colspan="2" align="left">
								
<input name="doh" type="text" class="formText135" id="doh"	 readonly="readonly" value="<%=doh%>" maxlength="11">  
<%
if("Add".equals(action))
{
%>
<script language='JavaScript'>setCurrentDate('doh'); </script>
<%
}
%>				</td>
							</tr>
							<tr>
							  <td height="17" class="boldEleven">
							   Credit Limit 				   <span
									class="bolddeepred">*</span></td>
							  <td colspan="2" align="left">
							   <input name='climit' 	type='text' class='formText135' id='climit' 	  onKeyPress=\"return numeric_only(event,'climit','12')\" value='<%=climit%>' size='40' maxlength="12" >  					  </td>
							<tr>
								<td height="17" class="boldEleven">Active</td>
								<td colspan="2" align="left">
								 <input name="status" type="checkbox" id="status" value="1"  <%=status%> ></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Bank Name</td>
								<td colspan="2" align="left"><select name="bank" id="bank"
									class="formText135" style="width:300">
									<option value="0">Select Bank</option>
									<%
				  		
				  		String bankdata[][] = CommonFunctions.QueryExecute("SELECT INT_BANKGROUPID, CHR_BANKGROUPNAME FROM com_m_bankgroup ORDER BY CHR_BANKGROUPNAME ");
				  		if(bankdata.length>0)
							for(int u=0; u<bankdata.length; u++)
								out.print("<option value ='"+bankdata[u][0]+"'>" +bankdata[u][1]+"</option>");
				  %>,
								</select>
								<script language="javascript">setOptionValue('bank','<%=bank%>')</script>								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Account No.</td>
								<td colspan="2" align="left"><input name="accno"
									type="text" class="formText135" id="accno" value="<%=accno%>" size="40"
									maxlength="20"></td>
							</tr>

							<tr>
								<td height="17" class="boldEleven">Group <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><select name="vendorgroup" id="vendorgroup"
									class="formText135" style="width:300">
									<option value="0">Select Vendor Group</option>
									<%
				  		 
				  		String group[][] =  CommonFunctions.QueryExecute("SELECT INT_GROUPID,CHR_NAME FROM inv_m_vendorsgroup");
				  		if(group.length>0)
						for(int u=0; u<group.length; u++)
				  			out.print("<option value ='"+group[u][0]+"'>" +group[u][1]+"</option>");
				  %>
								</select>
								<script language="javascript">setOptionValue('vendorgroup','<%=vendorgroup%>')</script>								</td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">GST Number</td>
								<td colspan="2" align="left"><input
									name="gst" type="text" class="formText135" id="gst"
									  onBlur="upperMe(this)"      value="<%=gst%>" size="40" maxlength="15"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">TIN Number</td>
								<td colspan="2" align="left"><input
									name="tin" type="text" class="formText135" id="tin"
									  onBlur="upperMe(this)"     value="<%=tin%>" size="40" maxlength="25">							  </td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">CST Number</td>
								<td colspan="2" align="left"><input
									name="cst" type="text" class="formText135" id="cst"
									  onBlur="upperMe(this)"      value="<%=cst%>" size="40" maxlength="25"></td>
							</tr>
							<tr>
							  <td height="17" class="boldEleven">PAN Number </td>
							  <td colspan="2" align="left"><input
									name="pan" type="text" class="formText135" id="pan"
									   onBlur="upperMe(this)"    value="<%=pan%>" size="40" maxlength="10"></td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="2" align="left"><input name="filename"
									type="hidden" value="VendorInfo" /> <input name="actionS"
									type="hidden" value="<%=actionS%>" />
							    <input name="rowid" type="hidden" id="rowid" value="<%=id%>"></td>
							</tr>
							<tr>
								<td height="17" colspan="3" class="boldEleven">
								<table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
									<tr>
										<td><input name="Submit"  id="Submit"  type="submit"
											class="buttonbold13" value="<%=value%>"></td>
										<td><input name="Close" type="Button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('VendorInfo.jsp')"></td>
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
	System.out.println(e.getMessage());
}
%>
