<%@ page import="java.io.*,java.util.*" errorPage="../error/index.jsp"%>
<%@ page import="java.sql.*,java.io.*,java.util.*,com.my.org.erp.ServiceLogin.*"%>
<%@ page import="com.my.org.erp.common.CommonFunctions"%>
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
<meta name="keywords" content="HRM, Human Resource Management, HR Planning, Job Design, Job Analysing, Applicant, Company, Branch, Division,Model,Color,Office, Qualification, Attendance, Biometric, Finger Print, Forms, Leave, Holiday, Common Holiday, Shift Master, Shift Allocation. Proximity, Smart Card, Manual attendance, personal inforamtion , Basic, Allowance, Payroll, Salary Slab, Allowance, Recovery, Professional Tax, Employee attendance, Promotion, Trainning, Ressigner, Email, Jonners, PF, ESI, CTC, CTC, Take Home, Admin charge, Attendance, Payroll, Inventory, Product, Item, Customer, Vendor, vendor customertype, customer customertype, Purchase, sales, purchase paymeny, vendor payment, Sales return, purchase return, Quotation , Po, Purchase report, sales report, Tax, service tax, vat, c-form, taxes, user, employee id, payslip, consolidation, Attendance, stock, stock book , stock view, stock transfer, consumables, Serial number tracking, " />

 <%@ include file="../JavaScript/dynamicStylesheet.jsp" %>
 
<style type="text/css">
<!--
@import url("../JavaScript/SmartStyles.css");
-->
</style>



</head>
<script language="javascript" src="../JavaScript/comfunction.js"></script>
<script language="javascript" src="../JavaScript/calendar1.js"></script>
<script language="javascript" src="../JavaScript/Inventory/InventAJAX.js"></script>
<script language="javascript" src="../JavaScript/common/SelectChangesCountry.js"></script>

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

function upperMe(field)
  {
  	field.value=field.value.toUpperCase();
  }    
  
  
  
function valid()
{
	try
	{   	
		if(
			checkNullSelect( "customergroup","Select customer group" ,'0')
			&& checkNull( "alias","Enter Alias name" )
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
 	
</script>

<body >
<jsp:include page="indexinv.jsp" />
<table width="100%" border="0" cellspacing="1" cellpadding="1">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
	  <td bgcolor="#FFFFFF"><table class="BackGround1" cellspacing="0" cellpadding="0" width="600"
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
            <td align="center" valign="middle"><form  AUTOCOMPLETE = "off"   action="../SmartLoginAuth" method="post" name="frm" id="frm" onSubmit="return valid()">
                <table cellspacing="2" cellpadding="2" width="100%" align="center"
						border="0">
                  <!--DWLayoutTable-->
                  <tbody>
                    <tr>
                      <td height="16" colspan="4" align="center" valign="top"
									class="boldThirteen">Customer Info</td>
                    </tr>
                    <tr>
                      <td height="19" colspan="4" align="right" valign="top"><span
									class="bolddeepred">* </span><span class="fairyHead">Mandatory </span></td>
                    </tr>
                    <tr>
                      <td width="24%" height="20" class="boldEleven">Customer Name <span
									class="bolddeepred">* </span></td>
                      <td colspan="3" align="left"><select name="customergroup" class="formText135" id="customergroup" style="width:300" title="Select Customer Name">
                          <option value="0">Select Customer Group</option>
                          <%
String group[][] =  CommonFunctions.QueryExecute("SELECT INT_CUSTOMERGROUPID,CHR_NAME FROM inv_m_customergroup ORDER BY CHR_NAME");
for(int u=0; u<group.length; u++)
	out.print("<option value ='"+group[u][0]+"'>" +group[u][1]+"</option>");

%>
                        </select>                      </td>
                    </tr>
                    <tr>
                      <td height="20" valign="top" class="boldEleven">Alias Name <span
									class="bolddeepred">* </span></td>
                      <td colspan="3" align="left"><input name="alias"
									type="text" title="Enter the Alais Name" class="formText135" size="40" id="alias"
									  maxlength="90"     onBlur="upperMe(this)"     ></td>
                    </tr>
                    <tr>
                      <td height="20" valign="top" class="boldEleven">Contact
                        person</td>
                      <td colspan="3" align="left"><input name="cperson"
									type="text" title="Enter the Contact Person" class="formText135" size="40" id="cperson"
									  maxlength="90"     onBlur="upperMe(this)"     > 
                        <span class="boldElevenlink"> </span> </td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Department </td>
                      <td colspan="2" class="boldEleven"><input name="department"
									type="text" title="Enter the Contact Person" class="formText135" size="40" id="department"
									  maxlength="90"     onBlur="upperMe(this)"     ></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Door No <span class="spc">*</span></td>
                      <td colspan="2" class="boldEleven"><input name="address1" type="text" class="formText135" id="address1" size="40" maxlength="100" title="Enter the Door Number"> 
                        <span class="boldElevenlink"> </span></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Floor / Street  <span class="spc">*</span></td>
                      <td colspan="2" class="boldEleven"><input name="address2" type="text" class="formText135" id="address2" size="40" maxlength="100" title="Enter the Floor or Street name" >
                        <span class="boldElevenlink"> </span></td>
                    </tr>
                    <tr>
                      <td class="boldEleven">Address</td>
                      <td colspan="2" class="boldEleven"><input name="address3" type="text" class="formText135" id="address3" size="40" maxlength="100" title="Enter the Street Name"  >
                        <span class="boldElevenlink"> </span></td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="boldEleven">Country<span class="bolddeepred"> * </span></td>
                      <td colspan="2"   align="left"><select name="country" class="formText135" id="country" style="width:300" title="Select the Country" onChange="LoadSelectState(),resetPincode('pin')">
                          <option value="0">Select</option>
                          <%
	 		String readData[][]=  CommonFunctions.QueryExecute("SELECT INT_COUNTRYID ,CHR_COUNTRYNAME FROM  com_m_country ORDER BY CHR_COUNTRYNAME");
			for(int i=0;i<readData.length;i++)
				out.println("<option value='"+readData[i][0]+"'>"+readData[i][1]+"</option>");
	 %>
                        </select>                      </td>
                    </tr>
                    <tr>
                      <td height="17" valign="top" class="boldEleven">State<span class="bolddeepred"> * </span></td>
                      <td colspan="2"   align="left" valign="top"><select name="state" class="formText135" id="state" style="width:300" title="Select the State" onChange="LoadSelectDistrict(),resetPincode('pin')">
                          <option value="0" selected="selected">Select</option>
                        </select>                      </td>
                    </tr>
                    <tr>
                      <td height="17" class="boldEleven">District<span class="bolddeepred"> * </span></td>
                      <td colspan="2"   align="left" class="bolddeepblue"><select name="district" class="formText135" id="district" style="width:300"  title="Select the District" onChange=" LoadSelectCity(),resetPincode('pin')">
                          <option value="0" selected="selected">Select</option>
                        </select>                      </td>
                    </tr>
                    <tr>
                      <td height="17" class="boldEleven"> City <span class="bolddeepred"> * </span></td>
                      <td width="53%"   align="left" class="bolddeepblue"><select name="city" class="formText135" id="city" style="width:300"  title="Enter the City Name" onChange="AssignPincode('pin')">
                          <option value="0" selected="selected">Select</option>
                        </select>
                        &nbsp;&nbsp; </td>
                      <td width="23%"   align="left" class="bolddeepblue">
					  
					  
					  <table align="right">
															<TR>
															  <TD width="56">
                                                                <script language="javascript">
					 
function cityWindow(query)
	{  
		var width="800", height="400";
  		var left = (screen.width/2) - width/2;
		var top = (screen.height/2) - height/2;
	 	var styleStr = 'toolbar=no,location=no,directories=no,status=no,menubar=yes,scrollbars=yes,resizable=yes,copyhistory=yes,width='+width+',height='+height+',left='+left+',top='+top+',screenX='+left+',screenY='+top;
		newWindow = window.open(query,"subWind",styleStr);
		newWindow.focus( );
	}

	
					                                                                                     </script>
<input name="cityname" onClick="javascript:cityWindow('../Smart Common/addCity.jsp')" type="button" class="buttonbold13" id="cityname" value="Add City"></td>
													  </tr>
					    </table>					  </td>
                    </tr>
                    <tr>
                      <td height="20" class="boldEleven">Pin Code <span class="bolddeepred"> * </span></td>
                      <td colspan="3" align="left"><input name="pin" type="text" class="formText135" id="pin" onKeyPress="return numeric_only(event,'pin','7') " size="10" maxlength="6"    onKeyUp="lookup(this.value);" title="Enter the PIN code"/>
                          <br />
                          <div class="suggestionsBox" id="suggestions" style="display: none;width:150%;">
                            <div class="suggestionList" id="autoSuggestionsList" style="OVERFLOW:auto;width:100%;height:200px" ></div>
                          </div>
						  
						  <script language="javascript">
						  function divClear()
						  {
						  	 document.getElementById('suggestionsBox').innerHTML="" ;
						  }
						  </script>						  </td>
                    </tr>
                    <tr>
                      <td height="20" class="boldEleven">Phone</td>
                      <td colspan="3" align="left"><input name="area" type="text"
									class="formText135" id="area" size="10" title="Enter the Area Code"
									 onKeyPress="return numeric_only(event,'area','12')"   maxlength="5">
                          <input
									name="phone"  onKeyPress="return numeric_only(event,'phone','12')"    type="text"
									class="formText135" id="phone" size="26" maxlength="8" title="Enter the Phone Number"></td>
                    </tr>
                    <tr>
                      <td height="20" class="boldEleven">Mobile</td>
                      <td colspan="3" align="left"><input name="mobile" title="Enter the Mobile Number"
									onKeyPress="return numeric_only(event,'mobile','12')"  
									type="text" class="formText135" id="mobile" size="40" maxlength="10" ></td>
                    </tr>
                    <tr>
                      <td height="20" class="boldEleven">Fax</td>
                      <td colspan="3" align="left"><input name="fax" type="text" title="Enter the Fax Number"
									size="40" class="formText135" id="fax" onKeyPress="return numeric_only(event,'fax','16')" 
									  maxlength="12" ></td>
                    </tr>
                    <tr>
                      <td height="20" class="boldEleven">Email</td>
                      <td colspan="3" align="left"><input name="email"  title="Enter the Email"
									type="email" size="40" class="formText135" id="email"
									 maxlength="100"></td>
                    </tr>
                    <tr>
                      <td height="20" class="boldEleven">Website URL </td>
                      <td colspan="3" align="left"><input name="website" title="Enter the Website"
									type="text" size="40" class="formText135" id="website"
									onKeyPress="websiteOnly('website','30')" maxlength="100"></td>
                    </tr>
                    <tr>
                      <td height="20" class="boldEleven">Date</td>
                      <td colspan="3" align="left"><input name="doh" type="text" 
									class="formText135" id="doh" readonly ='readonly'>
                          <script language='JavaScript'>setCurrentDate('doh');</script></td>
                    </tr>
                    <tr>
                      <td height="20" class="boldEleven">Bank Name <span
									class="bolddeepred">* </span></td>
                      <td colspan="3" align="left"><select name="bank" class="formText135" id="bank" style="width:300">
                          <option value="">Select Bank</option>
                          <%
String bdata[][] =  CommonFunctions.QueryExecute("SELECT INT_BANKGROUPID, CHR_BANKGROUPNAME FROM com_m_bankgroup ORDER BY CHR_BANKGROUPNAME");
for(int u=0; u<bdata.length; u++)
	out.print("<option value ='"+bdata[u][0]+"'>" +bdata[u][1]+"</option>");

%>  
                      </select></td>
                    </tr>
                    <tr>
                      <td height="20" class="boldEleven">Account No.</td>
                      <td colspan="3" align="left"><input name="accno"
									type="tel" size="40" class="formText135" id="accno"
									  maxlength="20"></td>
                    </tr>
                    <tr>
                      <td height="17" class="boldEleven">Account Type </td>
                      <td colspan="3" align="left">
					  <select name="accounttype"  id="accounttype">
					  	 <%
				 String accounttype[][] =  CommonFunctions.QueryExecute("SELECT INT_ACCOUNTTYPEID, CHR_ACCOUNTTYPENAME FROM  inv_m_accounttype  ORDER BY CHR_ACCOUNTTYPENAME");
				  for(int u=0; u<accounttype.length; u++)
				  	out.print("<option value ='"+accounttype[u][1]+"'>" +accounttype[u][1]+"</option>");
				  %>
					  </select> 
					  </td>
                    </tr>
                    <tr>
                      <td height="17" class="boldEleven">Customer Type <span
									class="bolddeepred">* </span></td>
                      <td colspan="3" align="left"><select name="customertype" id="customertype"
									class="formText135" style="width:300"  title="Select the Customer type">
                          <option value="0">Select Customer Type</option>
                          <%
				  String query1 ="SELECT INT_CUSTOMERTYPEID,CHR_TYPENAME FROM inv_m_customertype ORDER BY CHR_TYPENAME";
				  String customertype[][] =  CommonFunctions.QueryExecute(query1);
				  for(int u=0; u<customertype.length; u++)
				  	out.print("<option value ='"+customertype[u][0]+"'>" +customertype[u][1]+"</option>");
				  %>
                      </select></td>
                    </tr>
                    <tr>
                      <td height="20" class="boldEleven"><%
							   String usertype=""+session.getAttribute("USRTYPE");
	  							if("F".equals(usertype))
	  								out.println("Credit Limit");
							  %>                      </td>
                      <td colspan="3" align="left"><%
							   
		if("F".equals(usertype))
		{
		
		out.println("<input name='climit'  maxlength='7' value='1000000000' type='text' size='40' class='formText135' id='climit' onKeyPress=\"return numeric_only(event,'climit','10')\" >");
		}
		else
		{
		out.println("<input name='climit'  maxlength='7'		type='text' id='climit'  value='1000000000'>");
		}
			
							  %>                      </td>
                    </tr>
                     <tr>
                      <td height="20" class="boldEleven">GST Number </td>
                      <td colspan="3" align="left"><input name="gst"
									type="text" class="formText135" id="gst" size="40"
									maxlength="30" title="Enter the GST Number"></td>
                    </tr>
                    <tr>
                      <td height="20" class="boldEleven">TIN Number</td>
                      <td colspan="3" align="left"><input name="tinnumber"
									type="text" class="formText135" id="tinnumber" size="40"
									maxlength="30" title="Enter the TIN Number"></td>
                    </tr>
                    <tr>
                      <td height="20" class="boldEleven">CST Number </td>
                      <td colspan="3" align="left"><input name="cstnumber"
									type="text" class="formText135" id="cstnumber" size="40"
									maxlength="15" title="Enter the CST Number"></td>
                    </tr>
                    <tr>
                      <td height="20" class="boldEleven">PAN Number </td>
                      <td colspan="3" align="left"><input name="pannumber"
									type="text" class="formText135" id="pannumber" size="40"
									maxlength="10" title="Enter the CST Number"></td>
                    </tr>
                    <tr>
                      <td height="20" class="boldEleven">Tax Exemption</td>
                      <td colspan="3" align="left"><table width="100%" border="0" cellpadding="0" cellspacing="0" class="boldEleven">
                        <tr>
                          <td width="6%"><input name="taxexamption" type="radio" id="radio2" value="Y"></td>
                          <td width="6%">Yes</td>
                          <td width="6%"><input name="taxexamption" type="radio" id="radio3" value="N" checked></td>
                          <td width="28%">No</td>
                          <td width="11%"> Ref. no</td>
                          <td width="43%"><input name="taxexamptionno" type="text" class="formText135" id="taxexamptionno" maxlength="100"></td>
                        </tr>
                      </table></td>
                    </tr>
                    <tr>
                      <td height="20" class="boldEleven">Billing </td>
                      <td colspan="3" align="left"><table width="100" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td><input name="billing" type="radio" id="radio" value="Y" checked></td>
                          <td class="boldEleven">Same</td>
                          <td class="boldEleven">
                            <input type="radio" name="billing" id="radio" value="N">                          </td>
                          <td class="boldEleven">different</td>
                        </tr>
                      </table></td>
                    </tr>
                    <tr>
                      <td align="left" valign="top"   class="boldEleven">Billing Address</td>
                      <td colspan="3" align="left" valign="top"><textarea name="billingaddress" id="billingaddress" cols="30" rows="5"  onKeyUp="  textArea('billingaddress','500')"></textarea></td>
                    </tr>
                    <tr>
                      <td height="20" class="boldEleven"><!--DWLayoutEmptyCell-->&nbsp;</td>
                      <td colspan="3" align="left"><input name="filename"
									type="hidden" value="CustomerInfo" />
                          <input name="actionS"
									type="hidden" value="INVCustomerInfoAdd" />
                      <input name="status" type="hidden" id="status" value="1"></td>
                    </tr>
                    <tr>
                      <td height="17" colspan="4" class="boldEleven"><table width="112" border="0" align="center" cellpadding="1"
									cellspacing="1">
                          <tr>
                            <td><input name="Submit" type="submit"
											class="buttonbold13" value="Submit"   accesskey="s"   ></td>
                            <td><input name="Close" type="Button"
											class="buttonbold13" id="Close"  value="Close"   accesskey="c" 
											onClick="redirect('CustomerInfo.jsp')"></td>
                          </tr>
                      </table></td>
                    </tr>
                  </tbody>
                  <input type="hidden" name="mobileBookingOption" />
                </table>
            </form></td>
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
      </table></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>

</table>
<jsp:include page="../footer.jsp" />
</body>
</html>

<%
}
catch (Exception e) 
{
	 System.out.println(e.getMessage());
} 
%>
