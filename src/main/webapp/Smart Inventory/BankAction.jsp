 <%@ page import="java.io.*,java.util.*" isErrorPage="false" errorPage="./error.jsp"%>
<%@ page import="com.my.org.erp.common.*, com.my.org.erp.ServiceLogin.*"%>
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
 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/common/SelectChangesCountry.js"></script>
<script language="JavaScript" src="../JavaScript/ComAJAX.js"></script>
<script language="JavaScript" src="../JavaScript/jquery/jquery-1.7.1.js" type="text/javascript"></script>
<script language="JavaScript" src="../JavaScript/jquery/ui/jquery.ui.core.js" type="text/javascript"></script>
 
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
			checkNullSelect( "bankgroup","Select Bank" ,'0')
			&& checkNull( "branchname","Enter Branch Name - 1" )
			&& checkNull( "branchcode","Enter Branch Code - 1" )
			&& checkNull( "ifsccode","Enter IFSC Code   - 1" )
			&& checkNull( "address1","Enter Address - 1" )
			&& checkNull( "address2","Enter Address - 2" )
			&& checkNullSelect( "country","Select Country" ,'0')
			&& checkNullSelect( "state","Select State" ,'0')
			&& checkNullSelect( "district","Select District" ,'0')
			&& checkNullSelect( "city","Select City" ,'0')
			&& checkNull( "pin","Enter pincode" )
			&& chkemail("email")
			&& check_URL("website")
			 
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
		<table class="BackGround1" cellspacing="0" cellpadding="0" width="412"
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
									class="boldThirteen">BANK INFORMATIONS
									
                                  <%
String action=request.getParameter("action1");
String id="",actionS="INVbankInfoAdd",value="";
String sql="";
String link="";
String bankgroup="",branchname="",branchcode="",ifsccode="",mcrcode="",swiftcode="";
String address1="",address2="",country="0",state="0",district="0",city="0";
String pin="",area="",phone="",mobile="",fax="",email="",website="";

/*bankgroup,branchname,branchcode,ifsccode,mcrcode,swiftcode,
address1,address2,country,state,district,city,
pin,area,phone,mobile,fax,email,website
*/
if("Add".equals(action))
{
	id="";
	bankgroup="0";branchname="";branchcode="";ifsccode="";mcrcode="";swiftcode="";
	address1="";address2="";country="0";state="0";district="0";city="0";
	pin="";area="";phone="";mobile="";fax="";email="";website="";

	actionS="INVbankInfoAdd";
	value="Add";
	link=" onBlur=\" CheckUnique(this,'divunitname','com_m_bank','CHR_BRANCH')\"  onKeyUp=\"upperMe(this),CheckUnique(this,'divunitname','com_m_bank','CHR_BRANCH')\" ";
	
}
else
{
	id=""; 
	id=request.getParameter("rowid");
	bankgroup="0";branchname="";branchcode="";ifsccode="";mcrcode="";swiftcode="";
	address1="";address2="";country="0";state="0";district="0";city="0";
	pin="";area="";phone="";mobile="";fax="";email="";website="";

	sql = " SELECT ";
	sql = sql +" INT_BANKID,INT_BANKGROUPID,CHR_BRANCH,CHR_BRANCHCODE,CHR_IFSCCODE,CHR_MCRCODE,CHR_SWIFTCOSE,  ";
	sql = sql +" CHR_ADDRESS1,CHR_ADDRESS2,INT_CITYID,INT_DISTRICTID,INT_STATEID,INT_COUNTRYID,INT_PINCODE, ";
	sql = sql +" CHR_AREACODE,CHR_PHONE,CHR_MOBILE,CHR_FAX,CHR_EMAIL,CHR_WEBSITE   ";
	sql = sql +"  FROM com_m_bank  WHERE INT_BANKID ="+id;
	String data[][]=CommonFunctions.QueryExecute(sql);
	if(data.length>0)
		for(int u=0;u<18;u++)
			if("-".equals(data[0][u]))
				data[0][u]="";
	id=data[0][0];
	bankgroup=data[0][1];
	branchname=data[0][2];
	branchcode=data[0][3];
	ifsccode=data[0][4];
	mcrcode=data[0][5];
	swiftcode=data[0][6];
	address1=data[0][7];
	address2=data[0][8];
	city=data[0][9];
	district=data[0][10];
	state=data[0][11];
	country=data[0][12];
	pin=data[0][13];
	area=data[0][14];
	phone=data[0][15];
	mobile=data[0][16];
	fax=data[0][17];
	email=data[0][18];
	website=data[0][19];
	actionS="INVbankinfoUpdate";
	value="Update";
	link=" onBlur=\" CheckUnique(this,'divunitname','com_m_bank','CHR_BRANCH')\"  onKeyUp=\"upperMe(this),CheckUnique(this,'divunitname','com_m_bank','CHR_BRANCH')\" ";
}

%>									</td>
							</tr>
							<tr>
								<td height="19" colspan="3" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory
								</span></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Bank Group  <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><select name="bankgroup" id="bankgroup"
									class="formText135" style="width:170px">
                                  <option value="0">Select Bank</option>
                                  <%
				  		
				  		String bankdata[][] = CommonFunctions.QueryExecute("SELECT INT_BANKGROUPID,CHR_BANKGROUPNAME FROM com_m_bankgroup ORDER BY CHR_BANKGROUPNAME");
				  		if(bankdata.length>0)
							for(int u=0; u<bankdata.length; u++)
				  				out.print("<option value ='"+bankdata[u][0]+"'>" +bankdata[u][1]+"</option>");
				  %>
                                </select>
							   
								<script language="javascript">setOptionValue('bankgroup','<%=bankgroup%>')</script>								</td>
							</tr>
							 
							<tr>
								<td height="17" class="boldEleven">Branch Name  <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="branchname"
									type="text" class="formText135" id="branchname"     value="<%=branchname%>"
									size="40" maxlength="50"    onBlur="upperMe(this)"   > <div id=divunitname></div></td>
							</tr>
							 
							<tr>
							  <td height="17" class="boldEleven">Branch Code  <span
									class="bolddeepred">* </span></td>
							  <td colspan="2" align="left"><input name="branchcode"
									type="text" class="formText135" id="branchcode"      value="<%=branchcode%>"
									size="40" maxlength="15"   onBlur="upperMe(this)"    onKeyUp="CheckUnique(this,'branchdiv','com_m_bank','CHR_BRANCHCODE')">
							  <div id="branchdiv"></div></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">IFSC Code <span
									class="bolddeepred">* </span></td>
							  <td colspan="2" align="left"><input name="ifsccode"
									type="text" class="formText135" id="ifsccode"       value="<%=ifsccode%>"
									size="40" maxlength="15"   onBlur="upperMe(this)"     onKeyUp="CheckUnique(this,'ifscdiv','com_m_bank','CHR_IFSCCODE')">
							  <div id="ifscdiv"></div></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">MCR Code </td>
							  <td colspan="2" align="left"><input name="mcrcode"
									type="text" class="formText135" id="mcrcode"  value="<%=mcrcode%>"
									size="40" maxlength="15"   onBlur="upperMe(this)"  ></td>
						  </tr>
							<tr>
							  <td height="17" class="boldEleven">SWIFT Code </td>
							  <td colspan="2" align="left"><input name="swiftcode"
									type="text" class="formText135" id="swiftcode"      value="<%=swiftcode%>"
									size="40" maxlength="15"   onBlur="upperMe(this)"   ></td>
						  </tr>
							<tr>
								<td height="17" class="boldEleven">Address 1 <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="address1"
									type="text" class="formText135" id="address1"      value="<%=address1%>"
									size="40" maxlength="50"   onBlur="upperMe(this)"   ></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Address 2 <span
									class="bolddeepred">* </span></td>
								<td colspan="2" align="left"><input name="address2"
									type="text" class="formText135" id="address2"     value="<%=address2%>"
									size="40" maxlength="50"   onBlur="upperMe(this)"   ></td>
							</tr>
							<tr>
							  <td class="boldEleven">Country<span class="bolddeepred"> * </span></td>
							  <td colspan="2" align="left"><select name="country" id="country" style="width:170" onChange="LoadSelectState()">
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
							  <td colspan="2" align="left"><select name="state" id="state" style="width:170" onChange="LoadSelectDistrict()">
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
							    <select name="district" id="district" style="width:170" onChange=" LoadSelectCity()">
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
							    <select name="city" id="city" style="width:170" onChange="AssignPincode('pin')">
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
							  <td colspan="2" align="left"> 
                              <input name="pin" type="text" class="formText135" id="pin" onKeyPress="return numeric_only(event,'pin','7')" onBlur="fill('0/0/0/0/0/0/0')"    onKeyUp="lookup(this.value);" value="<%=pin%>" size="10" 									maxlength="6" />
                          <br />
                          <div class="suggestionsBox" id="suggestions" style="display: none;width:150%;">
                            <div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:200px" ></div>
                          </div>			
							   
						      </td>
						  </tr>
							 
							<tr>
								<td height="17" class="boldEleven">Phone</td>
								<td colspan="2" align="left"><input name="area" type="text"
									class="formText135" id="area"
									onKeyPress="return numeric_only(event,'area','11')" value="<%=area%>" size="10" maxlength="6"> 
								<input
									name="phone" type="text" class="formText135" id="phone"
									onKeyPress="return numeric_only(event,'phone','21')" value="<%=phone%>"
									size="29" maxlength="12"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Mobile</td>
								<td colspan="2" align="left"><input name="mobile"
									type="text" class="formText135" id="mobile" onKeyPress="return numeric_only(event,'mobile','21')" value="<%=mobile%>"
									size="40" maxlength="12"></td>
							</tr>
							<tr>
								<td height="17" class="boldEleven">Fax</td>
								<td colspan="2" align="left"><input name="fax" type="text"
									class="formText135" id="fax" onKeyPress="return numeric_only(event,'fax','21')" value="<%=fax%>" size="40" maxlength="12"></td>
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
<input name="website" type="url" class="formText135" id="website" value="<%=website%>" size="40" maxlength="50">
								 </td>
							</tr>
							 
							<tr>
								<td height="17" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
							  <td colspan="2" align="left"><input name="filename"
									type="hidden" value="BankInfo" /> <input name="actionS"
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
											onClick="redirect('BankInfo.jsp')"></td>
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
